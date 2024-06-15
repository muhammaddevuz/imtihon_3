import 'package:flutter/material.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title: ${widget.hotels[widget.index].hotelName}',
                  ),

                ],
              ),
            ],
          ),
          SizedBox(
            width: 50,
            child: Text(widget.hotels[widget.index].description),
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: widget.onEditPressed,
                icon: const Icon(Icons.edit,color: Colors.blue,),
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
    );
  }
}
