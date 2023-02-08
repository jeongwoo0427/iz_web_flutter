import 'dart:convert';

class BadgeModel {
  BadgeModel({
    required this.no,
    required this.name,
    required this.fileName,
    required this.rareLevel,
  });

  final int no;
  final String name;
  final String fileName;
  final String rareLevel;


  factory BadgeModel.fromMap(Map<String, dynamic> map) => BadgeModel(
    no : map["no"],
    name: map["name"],
    fileName: map["fileName"],
    rareLevel: map["rareLevel"],
  );
}