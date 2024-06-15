import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/utils/app_constans.dart';
import 'package:imtihon3/views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeMode(void a) {
    AppConstans.themeCheck = !AppConstans.themeCheck;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppConstans.themeCheck ? ThemeData.dark() : ThemeData.light(),
          home:  SplashScreen(themChanged: changeMode,),
        ));
  }
}



