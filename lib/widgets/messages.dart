import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data.docs;
        //print('Rohit..... $docs');
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            docs[index]['text'],
            docs[index]['username'],
            docs[index]['userImage'],
            docs[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
          ),
        );
      },
    );
  }
}
