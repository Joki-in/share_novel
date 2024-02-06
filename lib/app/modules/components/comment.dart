// comment_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentWidget extends StatelessWidget {
  final String comment;
  final Function onDelete;
  final String userPhotoUrl;

  const CommentWidget(
      {Key? key,
      required this.comment,
      required this.onDelete,
      required this.userPhotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userPhotoUrl),
      ),
      title: Text(comment),
    );
  }
}
