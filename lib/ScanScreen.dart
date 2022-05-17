import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScanScreen extends StatefulWidget {
  @override
  State createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              cameraFacing: CameraFacing.back, // Use the rear camera
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      var value = scanData.code;
      final user1 = FirebaseAuth.instance.currentUser!;
      final email = user1.email!;
      final boxes = FirebaseFirestore.instance.collection('boxes');
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      final String documentId = scanData.code! + email + formatted;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User detected $email")));
      final doc =
          FirebaseFirestore.instance.collection('usersDay').doc(documentId);
      final snapshot = await doc.get();
      if (snapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Already used the app for today!")));
      } else {
        await doc.set({'used': 1});
        final doc2 =
            FirebaseFirestore.instance.collection('coinsData').doc(email);
        final snapshot1 = await doc2.get();
        if (snapshot1.exists) {
          var userdata = User.fromJson(snapshot1.data()!);
          var newcoins = userdata.coins + 10;
          await doc2.update({'coins': newcoins});

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Coins Deposited!!")));
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ExpectedScanResult {
  final String code;

  ExpectedScanResult(
    this.code,
  );
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
