import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/controllers/hotel_controller.dart';
import 'package:imtihon3/functions/review_calculator.dart';
import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/services/auth_http_services.dart';
import 'package:imtihon3/views/screens/profile_screen.dart';
import 'package:imtihon3/views/widgets/search_view_delegate.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;

  HomeScreen({super.key, required this.themChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HotelController hotelController = HotelController();
  List<Hotel> hotelList = [];
  bool isDataCame = false;

  @override
  void initState() {
    super.initState();
    // getHotels();
  }

  Future<void> getHotels() async {
    hotelList = await hotelController.getHotels();
    isDataCame = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: hotelController.getHotels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Data"),
              );
            }
            final List<Hotel> data = snapshot.data!;
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        child: Image(
                          image:NetworkImage(data[index].imageUrl.toString()),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(data[index].hotelName, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Location: "),
                          Text(
                            "${(ReviewCalculator(hotel: data[index]).reviewCalculate).toStringAsFixed(2)} / (${data[index].rating.length} Reviews)",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      )
                    ],
                  )
                );
              },
            );
          },
        ),
      ),
    );
  }
}
