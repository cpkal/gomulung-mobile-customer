import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;

  ChatBubble({required this.isMe});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: isMe ? _buildChatBubbleMe() : _buildChatBubbleReply(),
    );
  }
}

Widget _buildChatBubbleMe() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
            bottomLeft: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          'Hello, how can I help you?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      SizedBox(width: 8),
      //my avatar
      CircleAvatar(
        radius: 24,
      ),
    ],
  );
}

Widget _buildChatBubbleReply() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      //my avatar
      CircleAvatar(
        radius: 24,
      ),
      SizedBox(width: 8),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          'Hello, how can I help you?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
