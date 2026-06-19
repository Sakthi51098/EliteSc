import '../../domain/entities/onboarding_item.dart';

class OnboardingItemModel extends OnboardingItem {
  const OnboardingItemModel({
    required super.imageType,
    required super.title,
    required super.description,
    super.imagePath,
  });
}
