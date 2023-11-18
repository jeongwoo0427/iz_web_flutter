class UserModel {
  static const String CN_userId = 'userId';
  static const String CN_userName = 'userName';

  String userId;
  String userName;

  UserModel({required this.userId, required this.userName});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      userId: map[CN_userId] ?? 'unknown_id',
      userName: map[CN_userName] ?? 'unknown_name');

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map[CN_userId] = this.userId;
    map[CN_userName] = this.userName;

    return map;
  }
}
