import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/providers/auth_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
              context.read<AuthProvider>().signOut();
            },
            child: const Text("sign oout"),
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
