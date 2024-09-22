import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('John Doe'),
        //add shadow
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  //chat bubble
                  ChatBubble(isMe: true),
                  ChatBubble(isMe: true),
                  ChatBubble(isMe: false),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Type in your text",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
