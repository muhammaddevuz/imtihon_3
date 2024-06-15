import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imtihon3/controllers/admin/admin_controller.dart';
import 'package:imtihon3/views/screens/admin_panel/user_info_screen.dart';
import 'package:imtihon3/views/widgets/admin_hotels_widget.dart';
import 'package:imtihon3/views/widgets/edit_hotel_dialog.dart';

import '../../../models/hotel.dart';
import '../../../services/admin_panel_http_service.dart';
import '../../widgets/add_hotel_dialog.dart';

class AdminPanel extends StatefulWidget {
  final ValueChanged<void> themChanged;
  final Function() edited;
  final Function() mainEdited;

  const AdminPanel({super.key, required this.themChanged, required this.edited,required this.mainEdited});

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

  Future<void> addHotelFunc(data) async{
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
  void refresh(){
    setState(() {

    });
  }


  void onAddPressed() async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => AddHotelDialog(
        mainEdited: widget.mainEdited,
        edited: widget.edited,
        isEdit: false,
        refresh: refresh,
      ),
    );
  }

 void editFunc(Map<String, dynamic> response, hotelId) async{
    _hotelHttpService.editHotels(hotelId: hotelId, newAmenities: response['newAmenities'], newComment: response['newComment'], newHotelName: response['newHotelName'], newDescription: response['newDescription'], newImageUrl: response['newImageUrl'], newPrice: response['newPrice'], newRating: response['newRating'], newSpaceRooms: response['newSpaceRooms'], newLocation: response['newLocation']);
 }


  void onDeletePressed({required String hotelId}) async {
    await _adminController.deleteHotel(hotelId: hotelId);
    refresh();
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
                      edited: widget.edited,
                      mainEdited: widget.mainEdited,
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
                  return const Center(
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
                            onEditPressed: ()async {

                              final Map<String, dynamic> response = await showDialog(
                                context: context,
                                builder: (BuildContext context) => EditHotelDialog(
                                  hotel: data[index],
                                  refresh: refresh,
                                ),
                              );
                              editFunc(response, data[index].hotelId);

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
