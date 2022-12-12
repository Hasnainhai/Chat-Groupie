import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  String? messagesText;
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      getCurrentUser();
    });
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser!.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groupie\'s'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamMessages(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                  onChanged: (value) {
                    messagesText = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  textController.clear();
                  _firestore.collection('messages').add(
                    {'text': messagesText, 'sender': loggedInUser!.email},
                  );
                },
                child: const Text('Send'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StreamMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];

          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');

            final currentUser = loggedInUser!.email;
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isBool: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        }
        return const Text('loading...');
      }),
    );
  }
}

class MessageBubble extends StatelessWidget {
  String? sender;
  String? text;
  bool isBool;
  MessageBubble(
      {required this.sender, required this.text, required this.isBool});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isBool ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              color: isBool ? Colors.blueAccent : Colors.grey,
              borderRadius: isBool
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text!,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
