import 'package:binbox/ProfileScreen.dart';
import 'package:binbox/PurchaseScreen.dart';
import 'package:binbox/ScanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _MainPageState();
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.video_library),
                    ),
                    Tab(
                      icon: Icon(Icons.insert_drive_file),
                    ),
                    Tab(
                      icon: Icon(Icons.account_circle),
                    ),
                  ],
                  labelColor: Color(0xff8c52ff),
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Color(0xff8c52ff), width: 4.0),
                    insets: EdgeInsets.only(bottom: 44),
                  ),
                  unselectedLabelColor: Colors.grey,
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  PurchaseScreen(),
                  ProfileScreen(),
                  ScanScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
