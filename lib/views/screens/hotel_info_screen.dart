import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/functions/review_calculator.dart';
import 'package:imtihon3/models/hotel.dart';

class HotelInfoScreen extends StatefulWidget {
  Hotel hotel;
  HotelInfoScreen({super.key, required this.hotel});

  @override
  State<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends State<HotelInfoScreen> {
  int i = 0;
  void toggleImage() {
    if (i + 1 < widget.hotel.imageUrl.length - 1) {
      i++;
    } else {
      i = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel detail',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                toggleImage();
              },
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.sp),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.hotel.imageUrl[i],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFFC3C7CA),
                            borderRadius: BorderRadius.circular(13.sp)),
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Text(
                              "${i + 1}/${widget.hotel.imageUrl.length - 1}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotel.hotelName,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "USA/Washington",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.sp),
                      ),
                      Row(
                        children: [
                          Text(
                            "${(ReviewCalculator(hotel: widget.hotel).reviewCalculate).toStringAsFixed(2)} / (${widget.hotel.rating.length - 1} Reviews)",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 200.w,
                    child: Row(
                      children: [
                        Text(
                            "${widget.hotel.spaceRooms.length} Rooms are avaliable")
                      ],
                    ),
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp),
                      ),
                      Text(
                        widget.hotel.description,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "What this place offers",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      GridView.builder(
                          itemCount: widget.hotel.amenities.length - 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (_, index) {
                            List.generate(
                                widget.hotel.amenities.length - 1,
                                (int i) => Container(
                                      padding: EdgeInsets.all(20.sp),
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        widget.hotel.amenities[index],
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ));
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
