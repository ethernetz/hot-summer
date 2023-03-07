import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text("this works!"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/4K08x0809YgBzdcaed37/messages')
              .snapshots()
              .listen((data) {
            // print(data.docs[0]['text']);
          });
        },
      ),
    );
  }
}
