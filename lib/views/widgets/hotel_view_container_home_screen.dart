import 'package:flutter/cupertino.dart';

class HotelContainer extends StatelessWidget {
  const HotelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        border: Border(),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
