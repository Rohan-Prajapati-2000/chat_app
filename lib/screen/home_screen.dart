import 'package:chat_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('Home Screen'),
          backgroundColor: Colors.blue[200],
          actions: [
            IconButton(
              onPressed: () => controller.logOut(),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!.docs
                    .map<Widget>((e) => buildUserListItem(e))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return Container();
    }

    String name = data['Name'] ?? 'No Name';
    String email = data['Email'] ?? 'No Email';
    String receiverId = document.id;

    /// Display all users except current user
    if (FirebaseAuth.instance.currentUser?.email != email) {
      return Container(
        color: Colors.lightBlue[200],
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          title: Text(name),
          subtitle: Text(email),
          onTap: () {
            Get.to(() => ChatScreen(
              receiverId: receiverId,
              receiverName: name,
            ));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
