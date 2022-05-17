import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ignore: deprecated_member_use
  CollectionReference users =
      FirebaseFirestore.instance.collection('coinsData');

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(100.0),
            child: FutureBuilder<User?>(
              future: readUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                } else if (snapshot.hasData) {
                  final user = snapshot.data;

                  return user == null
                      ? Center(child: Text("No user"))
                      : buildUser(user);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  Future<User?> readUser() async {
    final user1 = FirebaseAuth.instance.currentUser!;
    final email = user1.email!;
    print(email);
    final doc = FirebaseFirestore.instance.collection('coinsData').doc(email);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  Widget buildUser(User user) {
    final user1 = FirebaseAuth.instance.currentUser!;
    final email = user1.email!;
    var num = user.coins.toString();
    return Container(
        child: Column(
      children: [
        Text("Email : $email"),
        Text("Coins available : $num"),
      ],
    ));
  }
}

class User {
  String id;
  final int coins;

  User({
    this.id = '',
    required this.coins,
  });

  Map<String, dynamic> toJson() => {
        'coins': coins,
      };

  static User fromJson(Map<String, dynamic> json) => User(coins: json['coins']);
}
