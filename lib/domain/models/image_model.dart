class ImageModel {
  final String description;
  final Map<String, String> urls;
  final String userName;
  final String userProfileImage;
  final int likes;

  ImageModel({
    required this.description,
    required this.urls,
    required this.userName,
    required this.userProfileImage,
    required this.likes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      description: json['description'] ?? "",
      urls: Map<String, String>.from(json['urls'] ?? {}),
      userName: json['user']['name'] ?? "",
      userProfileImage: json['user']['profile_image']['large'] ?? "",
      likes: json['likes'] ?? 0,
    );
  }
}
