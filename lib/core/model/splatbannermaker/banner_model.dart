import 'dart:convert';

class BannerModel {
  BannerModel({
    required this.name,
    required this.fileName,
    required this.rareLevel,
  });

  final String name;
  final String fileName;
  final String rareLevel;


  factory BannerModel.fromMap(Map<String, dynamic> map) => BannerModel(
    name: map["name"],
    fileName: map["fileName"],
    rareLevel: map["rareLevel"],
  );
}