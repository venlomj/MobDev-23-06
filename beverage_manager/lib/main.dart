import 'package:beverage_manager/pages/beverages_list.dart';
import 'package:beverage_manager/pages/homepage.dart';
import 'package:beverage_manager/pages/beverages_scanned.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BeverageManagerApp());
}

class BeverageManagerApp extends StatelessWidget {
  const BeverageManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beverage Manager',
        theme: ThemeData(primaryColor: const Color.fromARGB(255, 54, 33, 243)),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/beverageList': (context) => const BeveragesListPage(),
          '/beverageScanned': (context) =>
              const BeveragesScannedPage(), // Define the beverages list route
        });
  }
}
