class ReceiptModel {
  ReceiptModel({
    required this.receiptNo,
    required this.bannerNo,
    required this.badge1No,
    required this.badge2No,
    required this.badge3No,
    required this.nickname,
    required this.tag,
    required this.motto,
    required this.fontColor,
    required this.fontSizeRatio,
    required this.badgeSizeRatio,
    this.updatedAt,
    this.createdAt,
  });

  final int receiptNo;
  final int bannerNo;
  final int badge1No;
  final int badge2No;
  final int badge3No;
  final String nickname;
  final String tag;
  final String motto;
  final int fontColor;
  final double fontSizeRatio;
  final double badgeSizeRatio;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  factory ReceiptModel.fromMap(Map<String, dynamic> json) => ReceiptModel(
    receiptNo: json["receiptNo"],
    bannerNo: json["bannerNo"],
    badge1No: json["badge1No"],
    badge2No: json["badge2No"],
    badge3No: json["badge3No"],
    nickname: json["nickname"],
    tag: json["tag"],
    motto: json["motto"],
    fontColor: json["fontColor"],
    fontSizeRatio: json["fontSizeRatio"]?.toDouble(),
    badgeSizeRatio: json["badgeSizeRatio"]?.toDouble(),
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toMap() => {
    "receiptNo": receiptNo,
    "bannerNo": bannerNo,
    "badge1No": badge1No,
    "badge2No": badge2No,
    "badge3No": badge3No,
    "nickname": nickname,
    "tag": tag,
    "motto": motto,
    "fontColor": fontColor,
    "fontSizeRatio": fontSizeRatio,
    "badgeSizeRatio": badgeSizeRatio,
  };
}