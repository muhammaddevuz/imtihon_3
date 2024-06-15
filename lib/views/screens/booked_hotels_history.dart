import 'package:flutter/material.dart';
import 'package:imtihon3/services/user_http_services.dart';

class BookedHotels extends StatelessWidget {
  const BookedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    UserHttpServices userController = UserHttpServices();
    userController.fetchUser('');
    return Scaffold(
      appBar: AppBar(
        title: Text("booked hotels widget"),
      ),
      body: Container(
      ),
    );
  }
}
