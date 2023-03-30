import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/services/auth_service.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hotuser = context.watch<HotUser?>();
    return Scaffold(
      body: Column(
        children: [
          Text(hotuser?.displayName ?? "no user"),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats/4K08x0809YgBzdcaed37/messages')
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final docs = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(docs?[index]['text']),
                    ),
                  );
                }),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthService>().signOut();
            },
            child: const Text("sign out"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/4K08x0809YgBzdcaed37/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
