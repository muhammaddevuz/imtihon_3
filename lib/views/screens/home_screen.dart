import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imtihon3/views/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;
   HomeScreen({super.key, required this.themChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hotels",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Future.delayed(Duration(milliseconds: 400), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(themChanged: widget.themChanged,),
                    ));
              });
            },
            icon: Icon(
              CupertinoIcons.person_crop_circle,
              size: 40,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
              ],
            )
          ],
        )
      ),
    );
  }
}