import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/controllers/hotel_controller.dart';
import 'package:imtihon3/controllers/user_controller.dart';
import 'package:imtihon3/functions/review_calculator.dart';
import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/views/screens/hotel_info_screen.dart';
import 'package:imtihon3/views/screens/profile_screen.dart';
import 'package:imtihon3/views/widgets/search_view_delegate.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;

  const HomeScreen({super.key, required this.themChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HotelController hotelController = HotelController();
  UserController userController = UserController();
  List<Hotel> hotelList = [];
  List<Hotel> filteredHotelList = [];
  bool isDataCame = false;
  bool flag = true;
  String selectedFilter = 'Rating';
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  List<String> allAminities = [];

  double averageRating(List<int> ratings) {
    var sum = 0;
    for (var rating in ratings) {
      sum += rating;
    }
    return sum / ratings.length;
  }

  void refresh() {
    setState(() {});
  }

  // List<String> aminitiesList = [];

  // void toggleAminitiesList(int index) {
  //   aminitiesList.add(allAminities[index]);
  //   setState(() {});
  // }

  // void toggleRemoveAminitiesList(int index) {
  //   aminitiesList.remove(allAminities[index]);
  //   setState(() {});
  // }

  // Future<void> getAllAminities() async {
  //   allAminities = await hotelController.getAllAminities();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    getHotels();
    // getAllAminities();
  }

  void isScroll() {
    setState(() {
      flag = !flag;
    });
  }

  Future<void> getHotels() async {
    hotelList = await hotelController.getHotels();
    filteredHotelList = List.from(hotelList);
    isDataCame = true;
    setState(() {});
  }

  Future<void> getUser() async {
    await userController.getUser();
  }

  void showAllHotels() async {
    filteredHotelList = await hotelController.getHotels();
    setState(() {});
  }

  void filterHotels(String filter) {
    setState(() {
      if (filter == 'Rating') {
        filteredHotelList.sort((a, b) =>
            averageRating(b.rating).compareTo(averageRating(a.rating)));
      } else if (filter == 'Price') {
        filteredHotelList.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  List<Hotel> propers = [];

  void reshreshPropers() {
    setState(() {
      propers.clear();
    });
  }

  Future<void> onSubmit(String maxPrice, minPrice) async {
    propers.clear();
    List<Hotel> properHotels =
        await hotelController.getHotelByPrice(maxPrice, minPrice);
    if (properHotels.isNotEmpty) {
      for (var hotel in properHotels) {
        propers.add(hotel);
      }
    }
    minPriceController.clear();
    maxPriceController.clear();
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
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
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedFilter,
                  items: <String>['Rating', 'Price'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                      filterHotels(selectedFilter);
                    });
                  },
                ),
                IconButton(
                    onPressed: () {
                      reshreshPropers();
                      // hotelController.getAllAminities();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Price of place',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Min',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            TextField(
                                              controller: minPriceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: '\$0',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Max',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            TextField(
                                              controller: maxPriceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: '\$0',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Center(
                                      child: InkWell(
                                    onTap: () {
                                      onSubmit(
                                          maxPriceController.text.isEmpty
                                              ? '0'
                                              : maxPriceController.text,
                                          minPriceController.text.isEmpty
                                              ? '0'
                                              : minPriceController.text);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      child: const Text('Seach hotel'),
                                    ),
                                  )),
                                  // SizedBox(
                                  //   height: 100,
                                  //   child: aminitiesList.isNotEmpty
                                  //       ? SingleChildScrollView(
                                  //           scrollDirection: Axis.horizontal,
                                  //           child: Row(
                                  //             children: List.generate(
                                  //               aminitiesList.length,
                                  //               (int index) {
                                  //                 return TextButton(
                                  //                   onPressed: () {
                                  //                     toggleRemoveAminitiesList(
                                  //                         index);
                                  //                   },
                                  //                   child: Padding(
                                  //                     padding:
                                  //                         const EdgeInsets.all(
                                  //                             10),
                                  //                     child: Text(
                                  //                         aminitiesList[index]),
                                  //                   ),
                                  //                 );
                                  //               },
                                  //             ),
                                  //           ),
                                  //         )
                                  //       : const Center(
                                  //           child: Text(
                                  //               'empty choice of amenities')),
                                  // ),
                                  // SizedBox(height: 10.h),
                                  // SizedBox(
                                  //   height: 1.sh,
                                  //   child: GridView.builder(
                                  //     physics: const BouncingScrollPhysics(),
                                  //     itemCount: allAminities.length,
                                  //     gridDelegate:
                                  //         SliverGridDelegateWithFixedCrossAxisCount(
                                  //       mainAxisSpacing: 10.sp,
                                  //       crossAxisSpacing: 10.sp,
                                  //       crossAxisCount: 3,
                                  //     ),
                                  //     itemBuilder: (_, index) {
                                  //       return InkWell(
                                  //         onTap: () {
                                  //           toggleAminitiesList(index);
                                  //         },
                                  //         child: Container(
                                  //           alignment: Alignment.center,
                                  //           padding: EdgeInsets.all(12.sp),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.grey.shade100,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10.sp),
                                  //             border: Border.all(
                                  //                 color: Colors.grey),
                                  //           ),
                                  //           child: Text(
                                  //             allAminities[index],
                                  //             style: TextStyle(fontSize: 15.sp),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const CircleAvatar(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    )),
                ZoomTapAnimation(
                  onTap: () => isScroll(),
                  child: flag
                      ? const Text("Show All")
                      : const Icon(Icons.exit_to_app_sharp),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Hotel>>(
              future: hotelController.getHotels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
                final List<Hotel> data = filteredHotelList;
                return flag == true
                    ? Column(
                        children: [
                          propers.isNotEmpty
                              ? const Text('Search result')
                              : const SizedBox(),
                          propers.isNotEmpty
                              ? Expanded(
                                  child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: propers.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.55,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HotelInfoScreen(
                                              hotel: propers[index]);
                                        })),
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              5, 10, 5, 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        data[index]
                                                            .imageUrl[0]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          propers[index]
                                                              .hotelName,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 19,
                                                          ),
                                                        ),
                                                        Text(
                                                          propers[index]
                                                              .location,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star_half,
                                                          color: Colors.amber,
                                                          size: 15.sp,
                                                        ),
                                                        Text(
                                                          "${(ReviewCalculator(hotel: propers[index]).reviewCalculate).toStringAsFixed(2)} (${propers[index].rating.length} Reviews)",
                                                          style: TextStyle(
                                                              fontSize: 12.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons
                                                              .money_dollar,
                                                          size: 14,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                          "${propers[index].price}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Text(
                                                          "/night ",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.55,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HotelInfoScreen(hotel: data[index]);
                                  })),
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  data[index].imageUrl[0]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data[index].hotelName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                  Text(
                                                    data[index].location,
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_half,
                                                    color: Colors.amber,
                                                    size: 15.sp,
                                                  ),
                                                  Text(
                                                    "${(ReviewCalculator(hotel: data[index]).reviewCalculate).toStringAsFixed(2)} (${data[index].rating.length} Reviews)",
                                                    style: TextStyle(
                                                        fontSize: 12.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.money_dollar,
                                                    size: 14,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    "${data[index].price}",
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "/night ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HotelInfoScreen(hotel: data[index]);
                            })),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 170.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              data[index].imageUrl[0]),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        )),
                                  ),
                                  Container(
                                    height: 170.h,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hotel name: ${data[index].hotelName}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/location.png',
                                              height: 12.h,
                                            ),
                                            SizedBox(width: 3.w),
                                            Text(
                                              "Location: ${data[index].location}",
                                              style: TextStyle(
                                                  fontSize: 15.h,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade900),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_half,
                                                  size: 17,
                                                  color: Colors.amber,
                                                ),
                                                Text(
                                                  "${(ReviewCalculator(hotel: data[index]).reviewCalculate).toStringAsFixed(2)} (${data[index].rating.length} Reviews)",
                                                  style: TextStyle(
                                                      fontSize: 12.sp),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.money_dollar,
                                                  color: Colors.green,
                                                  size: 14,
                                                ),
                                                Text(
                                                  "${data[index].price}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                const Text(
                                                  "/night",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
