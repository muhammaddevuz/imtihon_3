import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/views/screens/profile_screen.dart';
import 'package:imtihon3/views/widgets/search_view_delegate.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;
  HomeScreen({super.key, required this.themChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HotelController hotelController = HotelController();
  List<Hotel> hotelList = [];
  Future<void> getHotels() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getHotels();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hotels",
          style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
        ),
        leadingWidth: 120.w,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          themChanged: widget.themChanged,
                        ),
                      ));
                });
              },
              icon: Icon(
                CupertinoIcons.person_crop_circle,
                size: 30.sp,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                    context: context, delegate: SearchViewDelegate(hotelList));
              },
              icon: Icon(
                Icons.search,
                size: 30.sp,
              )),
          SizedBox(
            width: 6.w,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
