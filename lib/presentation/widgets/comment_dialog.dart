import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/local_data_source.dart';

class CommentDialog extends StatefulWidget {
  final DateTime day;
  final LocalDataSource dataSource;
  final VoidCallback onCommentSaved;

  const CommentDialog({
    Key? key,
    required this.day,
    required this.dataSource,
    required this.onCommentSaved,
  }) : super(key: key);

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _loadComment();
  }

  Future<void> _loadComment() async {
    final comment = await widget.dataSource.getComment(widget.day);
    _controller = TextEditingController(text: comment ?? '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Комментарий за ${DateFormat('dd.MM.yyyy').format(widget.day)}'),
      content: TextField(
        controller: _controller,
        maxLines: 3,
        decoration: InputDecoration(hintText: 'Введите заметку'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
        TextButton(
          onPressed: () async {
            await widget.dataSource.saveComment(widget.day, _controller.text);
            widget.onCommentSaved();
            Navigator.pop(context);
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}