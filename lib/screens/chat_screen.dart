import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/new_message.dart';
import '../widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: const Text(
              'EXIT',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Expanded(child: Messages()),
          const NewMessage(),
        ],
      ),
    );
  }
}
