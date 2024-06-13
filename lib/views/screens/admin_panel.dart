import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  final ValueChanged<void> themChanged;
   AdminPanel({super.key, required this.themChanged});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
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
            },
            icon: Icon(
              CupertinoIcons.add,
              size: 40,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
