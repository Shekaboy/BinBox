import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  State createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 100) {
                      var newcoins = userdata.coins - 100;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Classmate notebook\n 100 points'),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 10) {
                      var newcoins = userdata.coins - 10;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Cello Pen\n 10 points'),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 50) {
                      var newcoins = userdata.coins - 50;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Classmate notebook\n 50 points'),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 10) {
                      var newcoins = userdata.coins - 10;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Butterflow Pen\n 10 points'),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 5) {
                      var newcoins = userdata.coins - 5;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Classmate Pencil\n 5 points'),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  final user1 = FirebaseAuth.instance.currentUser!;
                  final email = user1.email!;
                  print(email);
                  final doc = FirebaseFirestore.instance
                      .collection('coinsData')
                      .doc(email);
                  final snapshot = await doc.get();

                  if (snapshot.exists) {
                    var userdata = User.fromJson(snapshot.data()!);
                    if (userdata.coins >= 10) {
                      var newcoins = userdata.coins - 10;
                      await doc.update({'coins': newcoins});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not enough Coins")));
                    }
                  } else {
                    print("No user found");
                  }
                },
                child: const Text('Cello Pen\n 10 points'),
              ),
            ],
          ),
        ],
      )),
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
