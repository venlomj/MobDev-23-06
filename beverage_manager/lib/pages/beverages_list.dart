// beverages_list_page.dart
import 'package:beverage_manager/pages/beverage_detail.dart';
import 'package:beverage_manager/widgets/beverage_skeleton.dart';
import 'package:beverage_manager/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:beverage_manager/models/beverage.dart';
import 'package:beverage_manager/widgets/beverage_title.dart';
import '../apis/beverage_api.dart';
import 'package:shimmer/shimmer.dart';

class BeveragesListPage extends StatefulWidget {
  const BeveragesListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BeveragesListPageState();
}

class _BeveragesListPageState extends State<BeveragesListPage> {
  List<Beverage> beverageList = [];
  int count = 0;
  String section = 'homepagina';
  bool isLoading = true; // Boolean to track if the data is being loaded

  @override
  void initState() {
    super.initState();
    _getBeverages();
  }

  void _getBeverages() async {
    try {
      List<Beverage> fetchedBeverages = await BeverageApi.fetchBeverages();
      setState(() {
        beverageList = fetchedBeverages;
        count = fetchedBeverages.length;
        isLoading = false; // Set isLoading to false once the data is fetched
      });
    } catch (e) {
      // Handle error appropriately
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beverages"),
      ),
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToDetail(""),
        tooltip: "Add new beverage",
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const BeverageSkeleton(
                key: ValueKey(
                    'skeleton')) // Display the BeverageSkeleton widget when data is being loaded
            : Column(
                children: <Widget>[
                  Expanded(
                    child: _beveragesListItems(),
                  ),
                ],
              ),
      ),
    );
  }

  ListView _beveragesListItems() {
    return ListView.builder(
      itemCount: beverageList.length,
      itemBuilder: (context, position) {
        if (beverageList[position].beveragename == null ||
            beverageList[position].beverageImage == null) {
          return const BeverageSkeleton(); // Show the skeleton when the data is not available
        }
        return BeverageTile(
          beveragename: beverageList[position].beveragename,
          beverageImage: beverageList[position].beverageImage,
          onTapped: () {
            // Perform an action
            _navigateToDetail(beverageList[position].id);
          },
        );
      },
    );
  }

  void _navigateToDetail(String id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BeverageDetailPage(id: id)),
    );

    _getBeverages();
  }
}
