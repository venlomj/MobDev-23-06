import 'package:beverage_manager/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beverage Management App'),
        backgroundColor: Colors.blue, // Customize the color as desired
      ),
      drawer: const NavDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/drinklogo.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: Text(
                'Welcome to the Beverage Management App!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the horizontal padding as needed
              child: Text(
                'This app helps you manage beverage data from the beverage database. Through the use of the AR scanner, you are able to track the drinks that you have drank before as well as give them a rating for future reference. Additionally through the use of the database you are able to track the sugar content of each beverage and make more informed nutritional decisions',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0), // Adjust the padding on each side as needed
              child: Text(
                'Management App and Augmented Reality app created by Felix Morenc and Murrel Venlo',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            // Add more widgets based on your app requirements
          ],
        ),
      ),
    );
  }
}
