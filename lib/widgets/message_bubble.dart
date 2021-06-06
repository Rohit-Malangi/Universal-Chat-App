import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.username, this.userImage, this.isMe,
      {Key? key})
      : super(key: key);

  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 220,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Text(username),
                  Text(
                    message,
                    softWrap: true,
                    style: TextStyle(color: Theme.of(context).highlightColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 200,
          right: isMe ? 200 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage)),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}
