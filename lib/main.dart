import 'package:flutter/material.dart';
import 'package:your_friends/db_helper/database_helper.dart';
import 'package:your_friends/screen/home_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(DatabaseHelper().pathDatabase);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black)
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
