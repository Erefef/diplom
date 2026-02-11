import 'package:flutter/services.dart';
class Article {
  final String id;
  final String title;
  final String contentPath; // Путь к файлу
  final String imagePath;
  final String excerpt;

  Article({
    required this.id,
    required this.title,
    required this.contentPath,
    required this.imagePath,
    required this.excerpt,
  });

  Future<String> loadContent() async {
    try {
      return await rootBundle.loadString(contentPath);
    } catch (e) {
      return "Содержимое статьи временно недоступно";
    }
  }
}