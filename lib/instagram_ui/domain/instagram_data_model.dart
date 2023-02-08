import 'dart:convert';

class InstagramDataModel {
  Profile profile;
  List<Highlights> highlights;
  List<String> userPost;

  InstagramDataModel({
    required this.profile,
    required this.highlights,
    required this.userPost,
  });

  Map<String, dynamic> toMap() {
    return {
      'profile': profile.toMap(),
      'highlights': highlights.map((x) => x.toMap()).toList(),
      'user_post': userPost,
    };
  }

  factory InstagramDataModel.fromMap(Map<String, dynamic> map) {
    return InstagramDataModel(
      profile: Profile.fromMap(map['profile']),
      highlights: List<Highlights>.from(
          map['highlights']?.map((x) => Highlights.fromMap(x))),
      userPost: List<String>.from(map['user_post']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InstagramDataModel.fromJson(String source) =>
      InstagramDataModel.fromMap(json.decode(source));
}

class Profile {
  String image;
  int postCount;
  int followerCount;
  int followingCount;
  String username;
  String profileName;
  String bio;
  String website;

  Profile({
    required this.image,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    required this.username,
    required this.profileName,
    required this.bio,
    required this.website,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'post_count': postCount,
      'follower_count': followerCount,
      'following_count': followingCount,
      'username': username,
      'profile_name': profileName,
      'bio': bio,
      'website': website,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      image: map['image'] ?? '',
      postCount: map['post_count']?.toInt() ?? 0,
      followerCount: map['follower_count']?.toInt() ?? 0,
      followingCount: map['following_count']?.toInt() ?? 0,
      username: map['username'] ?? '',
      profileName: map['profile_name'] ?? '',
      bio: map['bio'] ?? '',
      website: map['website'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}

class Highlights {
  String image;
  String title;

  Highlights({required this.image, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
    };
  }

  factory Highlights.fromMap(Map<String, dynamic> map) {
    return Highlights(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Highlights.fromJson(String source) =>
      Highlights.fromMap(json.decode(source));

  Highlights copyWith({
    String? image,
    String? title,
  }) {
    return Highlights(
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }
}
