import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/data/models/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}/////


class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = widget.article.loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.article.title)),
      body: FutureBuilder<String>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  widget.article.imagePath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    snapshot.data ?? "Ошибка загрузки контента",
                    style: const TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}