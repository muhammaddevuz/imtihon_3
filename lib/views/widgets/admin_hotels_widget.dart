import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/models/hotel.dart';

class HotelsWidget extends StatefulWidget {
  final Function() onDeletePressed;
  final Function() onEditPressed;
  final List<Hotel> hotels;
  final int index;

  const HotelsWidget({
    super.key,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.hotels,
    required this.index,
  });

  @override
  State<HotelsWidget> createState() => _HotelsWidgetState();
}

class _HotelsWidgetState extends State<HotelsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: widget.index == 0 ? 15 : 0),
      padding: const EdgeInsets.all(5),
      width: 343.w,
      height: 172.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 114.w,
            height: double.infinity,
            child: Image(
              image: NetworkImage(widget.hotels[widget.index].imageUrl[0]),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hotels[widget.index].hotelName,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.hotels[widget.index].location,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    widget.hotels[widget.index].rating[0].toString(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '(${widget.hotels[widget.index].description})',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),Row(children: [...List.generate(widget.hotels[widget.index].amenities.length, (int index){
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.hotels[widget.index].amenities[index],
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                );
              }),],),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: widget.onEditPressed,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onDeletePressed,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
