import 'package:flutter/material.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 500,
      decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade900,
            height: 50,
          ),
          Expanded(
              child: ListView.separated(
            itemCount: 20,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Container(
                height: 30,
                color: Colors.grey.shade700,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
          ))
        ],
      ),
    );
  }
}
