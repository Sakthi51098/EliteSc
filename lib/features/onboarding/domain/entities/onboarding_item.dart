enum OnboardingImageType { collage, single }

class OnboardingItem {
  const OnboardingItem({
    required this.imageType,
    required this.title,
    required this.description,
    this.imagePath,
  });

  final OnboardingImageType imageType;
  final String title;
  final String description;
  final String? imagePath;
}
