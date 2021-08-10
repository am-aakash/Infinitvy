import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 15, 5, 0),
        leading: Text(
          '${post.id}',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        title: Text(
          post.title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        isThreeLine: true,
        subtitle: Text(
          post.body,
          style: TextStyle(color: Colors.grey[800], fontSize: 13),
        ),
        dense: true,
      ),
    );
  }
}
