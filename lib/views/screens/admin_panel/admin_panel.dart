import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imtihon3/controllers/admin/admin_controller.dart';
import 'package:imtihon3/views/screens/admin_panel/user_info_screen.dart';
import 'package:imtihon3/views/widgets/admin_hotels_widget.dart';

import '../../../models/hotel.dart';
import '../../../services/admin_panel_http_service.dart';
import '../../widgets/manage_hotel_dialog.dart';

class AdminPanel extends StatefulWidget {
  final ValueChanged<void> themChanged;
  final Function() edited;

  AdminPanel({super.key, required this.themChanged, required this.edited});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final AdminController _adminController = AdminController();
  List<Hotel> _hotels = [];

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  Future<void> _loadHotels() async {
    final hotels = await _adminController.hotelsList;
    setState(() {
      _hotels = hotels;
    });
  }

  void onAddPressed() async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => ManageHotelDialog(
        edited: widget.edited,
        isEdit: false,
      ),
    );
    if (data.isNotEmpty) {
      await _adminController.addHotel(
          amenities: data['amenities'],
          comment: data['comment'],
          hotelName: data['hotelName'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          price: data['price'],
          rating: data['rating'],
          rooms: data['rooms'],
          location: data['location'],
          );
      _loadHotels();
    }
  }

  void onEditPressed(Hotel hotel) async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => ManageHotelDialog(
        edited: widget.edited,
        isEdit: false,
      ),
    );
    if (data.isNotEmpty) {
      await _adminController.editHotels(
          hotelId: hotel.hotelId,
          newAmenities: data['newAmenities'],
          newComment: data['newComment'],
          newHotelName: data['newHotelName'],
          newDescription: data['newDescription'],
          newImageUrl: data['newImageUrl'],
          newPrice: data['newPrice'],
          newRating: data['newRating'],
          newSpaceRooms: data['newSpaceRooms'],
          newLocation: data['newLocation']);
      _loadHotels();
    }
  }

  void onDeletePressed({required String hotelId}) async {
    await _adminController.deleteHotel(hotelId: hotelId);
    _loadHotels();
  }

  AdminHttpService _hotelHttpService = AdminHttpService();

  Future<void> test() async {
    await _hotelHttpService.addHotel(
        amenities: ['wi-fi', 'pool'],
        comment: ['amazing'],
        hotelName: 'Vanilla',
        description: 'Hava a nice day',
        imageUrl: ['image'],
        price: 1000,
        rating: [5],
        rooms: [7],
        location: '');
  }

  // void refresh(){
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //test();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Admin",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: onAddPressed,
            icon: Icon(
              CupertinoIcons.add,
              size: 30,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
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
                      edited: widget.edited,
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
              future: _adminController.hotelsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Add hotels'),
                  );
                }

                final data = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HotelsWidget(
                            onDeletePressed: () {
                              onDeletePressed(hotelId: data[index].hotelId);
                            },
                            onEditPressed: () {
                              onEditPressed(data[index]);
                            },
                            hotels: data,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
