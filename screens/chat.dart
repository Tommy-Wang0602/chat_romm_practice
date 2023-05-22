import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_new_chat_app/widgets/chat_message.dart';
import 'package:my_new_chat_app/widgets/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluttercaht'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage()
        ],
      ),
    );
  }
}
