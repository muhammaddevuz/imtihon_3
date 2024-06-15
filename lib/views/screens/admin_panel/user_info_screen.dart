import 'package:flutter/material.dart';
import 'package:imtihon3/controllers/user_controller.dart';

import 'admin_panel.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserController _userController = UserController();

  Future<void> getUsers() async {
    var x = await _userController.getUser();
    print(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User info"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("Menu")],
            )),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPanel(
                      themChanged: (value) {},
                      edited: () {},
                      mainEdited: () {},
                    ),
                  ),
                );
              },
              title: Text("Admin Panel"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(),
                  ),
                );
              },
              title: Text("User Info"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
