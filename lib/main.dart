import 'package:flutter/material.dart';
import 'package:nexus_app/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "CentraNo1",
        primarySwatch: customColor,
        scaffoldBackgroundColor: Color(0XFFFFFFFF),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0XFF232728),
            fontSize: 16,
            fontFamily: "CentraNo1",
          )),
          iconTheme: IconThemeData(
            color: Color(0XFF4E5253),
          ),
          color: Color(0XFFFFFFFF),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

const MaterialColor customColor =
    const MaterialColor(0XFF31C8AE, const <int, Color>{
  50: Color(0XFF31C8AE),
  100: Color(0XFF31C8AE),
  200: Color(0XFF31C8AE),
  300: Color(0XFF31C8AE),
  400: Color(0XFF31C8AE),
  500: Color(0XFF31C8AE),
  600: Color(0XFF31C8AE),
  700: Color(0XFF31C8AE),
  800: Color(0XFF31C8AE),
  900: Color(0XFF31C8AE),
});
