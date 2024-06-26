import 'package:chat_app/service/chat_service.dart';
import 'package:chat_app/widgets/CustomTextField.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  final String receiverId;
  final String receiverName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
      scrollToBottom();
    }
  }

  void editMessage(String messageId, String currentMessage) {
    messageController.text = currentMessage;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Message'),
        content: TextField(
          controller: messageController,
          decoration: InputDecoration(hintText: "Enter new message"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (messageController.text.isNotEmpty) {
                await chatService.editMessage(
                  chatService.getChatRoomId(firebaseAuth.currentUser!.uid, widget.receiverId),
                  messageId,
                  messageController.text,
                );
                messageController.clear();
                Navigator.of(context).pop();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteMessage(String messageId) async {
    await chatService.deleteMessage(
      chatService.getChatRoomId(firebaseAuth.currentUser!.uid, widget.receiverId),
      messageId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text(widget.receiverName),
          backgroundColor: Colors.blue[200],
        ),
        body: Column(
          children: [
            Expanded(
              child: buildMessageList(),
            ),
            buildInputMessage(),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessage(firebaseAuth.currentUser!.uid, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((e) => buildMessageItem(e))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return GestureDetector(
      onLongPress: () {
        if (data['senderId'] == firebaseAuth.currentUser!.uid) {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.all(16),
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.of(context).pop();
                      editMessage(document.id, data['message']);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    onTap: () {
                      Navigator.of(context).pop();
                      deleteMessage(document.id);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderId'] == firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBubble(message: data['message'],),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTextfield(
              hintText: 'Enter Message',
              controller: messageController,
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send, color: Colors.blueAccent, size: 40),
          ),
        ],
      ),
    );
  }
}
