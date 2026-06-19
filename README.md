# Elite

Elite is a Flutter technical assignment project built with a clean folder structure, Firebase phone authentication, Firestore user storage, push notification setup, and API integration for game listing.

## Main Features

- Splash screen and onboarding flow
- Phone number login with OTP
- New user registration with name and avatar selection
- Session handling until logout
- Home dashboard with custom UI sections
- Games screen with FreeToGame API integration
- Individual game details screen
- Profile screen with logout
- Firebase Authentication
- Firestore user data storage
- FCM notification setup

## Project Structure

The project is split feature-wise:

- `lib/app`
  app setup, theme, routes
- `lib/core`
  shared constants, validators, widgets, network helpers
- `lib/features/auth`
  login, otp, registration, user profile flow
- `lib/features/dashboard`
  home dashboard UI sections
- `lib/features/game`
  game API models, repository, provider, details screen
- `lib/features/home`
  bottom navigation and tab screens
- `lib/services`
  Firebase init, notifications, local storage

## Packages Used

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_messaging`
- `flutter_local_notifications`
- `dio`
- `json_annotation`
- `json_serializable`

## API Used

- FreeToGame API
  `https://www.freetogame.com/api/games`

## Setup

1. Run `flutter pub get`
2. Make sure Firebase is configured for Android and iOS
3. Run `flutter pub run build_runner build`
4. Start the app with `flutter run`

## Notes

- OTP login needs correct Firebase phone auth setup and SHA keys in Firebase Console.
- Games list uses API data and shows 10 items per page with local pagination.
- Dashboard content is mostly static UI based on the given design.
