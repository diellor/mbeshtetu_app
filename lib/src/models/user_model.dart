class User {
  final String deviceId;
  final bool isSubscribedToQuotes;

  User({this.deviceId, this.isSubscribedToQuotes});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      deviceId: json['deviceId'],
      isSubscribedToQuotes: json['isSubscribedToQuotes'],
    );
  }
}
