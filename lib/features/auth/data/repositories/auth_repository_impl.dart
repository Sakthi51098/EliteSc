import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_result.dart';
import '../../domain/entities/otp_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  CollectionReference<Map<String, dynamic>> get usersCollection {
    return firestore.collection('users');
  }

  @override
  Future<OtpSession> sendOtp({required String phoneNumber}) async {
    final completer = Completer<OtpSession>();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (error) {
        if (completer.isCompleted) {
          return;
        }

        if (error.code == 'network-request-failed') {
          completer.completeError(Exception('No internet connection'));
          return;
        }

        completer.completeError(
          Exception(error.message ?? 'Failed to send OTP'),
        );
      },
      codeSent: (verificationId, _) {
        if (completer.isCompleted) {
          return;
        }

        completer.complete(
          OtpSession(verificationId: verificationId, phoneNumber: phoneNumber),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (completer.isCompleted) {
          return;
        }

        completer.complete(
          OtpSession(verificationId: verificationId, phoneNumber: phoneNumber),
        );
      },
    );

    return completer.future;
  }

  @override
  Future<AuthResult> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final result = await firebaseAuth.signInWithCredential(credential);
      final user = result.user;

      if (user == null) {
        throw Exception('Unable to verify OTP');
      }

      final userDoc = await usersCollection.doc(user.uid).get();

      if (!userDoc.exists || userDoc.data() == null) {
        return AuthResult(
          userId: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          isExistingUser: false,
        );
      }

      final userModel = UserModel.fromMap(userDoc.data()!, user.uid);

      return AuthResult(
        userId: userModel.id,
        phoneNumber: userModel.phoneNumber,
        isExistingUser: true,
        name: userModel.name,
        avatarPath: userModel.avatarPath,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'network-request-failed') {
        throw Exception('No internet connection');
      }

      throw Exception(error.message ?? 'Unable to verify OTP');
    }
  }

  @override
  Future<void> saveUserProfile({
    required String userId,
    required String name,
    required String phoneNumber,
    required String avatarPath,
  }) async {
    try {
      final userModel = UserModel(
        id: userId,
        name: name,
        phoneNumber: phoneNumber,
        avatarPath: avatarPath,
      );

      await usersCollection.doc(userId).set({
        ...userModel.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (error) {
      if (error.code == 'unavailable') {
        throw Exception('No internet connection');
      }

      throw Exception(error.message ?? 'Unable to save user data');
    }
  }

  @override
  Future<UserModel> getUserProfile(String userId) async {
    try {
      final userDoc = await usersCollection.doc(userId).get();

      if (!userDoc.exists || userDoc.data() == null) {
        throw Exception('User data not found');
      }

      return UserModel.fromMap(userDoc.data()!, userId);
    } on FirebaseException catch (error) {
      if (error.code == 'unavailable') {
        throw Exception('No internet connection');
      }

      throw Exception(error.message ?? 'Unable to get user data');
    }
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
