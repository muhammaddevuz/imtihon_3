import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/controllers/user_controller.dart';
import 'package:imtihon3/models/user.dart';
import 'package:imtihon3/utils/app_constans.dart';

class ProfileScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;
  ProfileScreen({super.key, required this.themChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserController userController = UserController();
  TextEditingController nameEditingController = TextEditingController();
  User? user;
  DateTime? birthday;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    user = await userController.getUser();
    setState(() {
      birthday = user!.birthday;
      userEmail = user!.email;
      nameEditingController.text = user!.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.w500),
          ),
        ),
        body: user == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: AppConstans.themeCheck,
                      onChanged: widget.themChanged,
                      title: Text(
                        "Tungi holat",
                        style: TextStyle(
                          fontSize: 15.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: nameEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: "Name",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Birthday:",
                          style: TextStyle(
                            fontSize: 15.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        date()
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email:",
                          style: TextStyle(
                            fontSize: 15.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userEmail!,
                          style: TextStyle(
                            fontSize: 11.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () async {
                if (user != null) {
                  userController.editUser(user!.id, nameEditingController.text,
                      birthday.toString());
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("O'zgarishlar muvaffaqiyatli saqlandi"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "O'zgartirishlarni saqlash",
                  style: TextStyle(color: Colors.white, fontSize: 13.h),
                ),
              )),
        ));
  }

  Widget date() {
    return InkWell(
        onTap: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: birthday ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
          if (newDate != null) {
            setState(() {
              birthday = newDate;
            });
          }
        },
        child: Text(
          birthday == null
              ? "Sanani tanlang"
              : "${birthday.toString().split(" ")[0]}",
          style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
        ));
  }
}
