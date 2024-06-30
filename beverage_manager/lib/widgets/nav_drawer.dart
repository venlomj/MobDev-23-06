import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkBlue = Color(0xFF00008B);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: darkBlue,
            ),
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            duration: Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            child: Text(
              'Beverage Manager',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Homepage'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Beverage List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/beverageList');
            },
          ),
          ListTile(
            leading: const Icon(Icons.barcode_reader),
            title: const Text('Scanned Beverages'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/beverageScanned');
            },
          ),
        ],
      ),
    );
  }
}
