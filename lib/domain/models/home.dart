class Home {
  final String description;
  final Map<String, String> urls;
  final String userName;
  final String userProfileImage;
  final int likes;

  Home({
    required this.description,
    required this.urls,
    required this.userName,
    required this.userProfileImage,
    required this.likes,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      description: json['description'] ?? "",
      urls: Map<String, String>.from(json['urls'] ?? {}),
      userName: json['user']['name'] ?? "",
      userProfileImage: json['user']['profile_image']['large'] ?? "",
      likes: json['likes'] ?? 0,
    );
  }
}
