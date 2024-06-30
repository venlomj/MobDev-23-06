// beverages_list_page.dart
import 'package:beverage_manager/pages/beverage_detail.dart';
import 'package:beverage_manager/utils/beverage_logger.dart';
import 'package:beverage_manager/widgets/beverage_skeleton.dart';
import 'package:beverage_manager/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:beverage_manager/models/beverage.dart';
import 'package:beverage_manager/widgets/beverage_title.dart';
import '../apis/beverage_api.dart';

class BeveragesScannedPage extends StatefulWidget {
  const BeveragesScannedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BeveragesScannedPageState();
}

class _BeveragesScannedPageState extends State<BeveragesScannedPage> {
  List<Beverage> beverageList = [];
  List<Beverage> filteredList = [];
  int count = 0;
  int filteredCount = 0;
  String section = 'scanned';
  bool isLoading = true; // Add a boolean to track if the data is being loaded

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
        for (Beverage b in beverageList) {
          if (b.scanned == true) {
            filteredList.add(b);
          }
        }
        filteredCount = filteredList.length;
        isLoading = false; // Set isLoading to false once the data is fetched
      });
    } catch (e) {
      // Handle error appropriately
      BeverageLogger.log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gescande frisdranken"),
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
      itemCount: filteredList.length,
      itemBuilder: (context, position) {
        return BeverageTile(
          beveragename: filteredList[position].beveragename,
          beverageImage: filteredList[position].beverageImage,
          onTapped: () {
            // Perform an action
            _navigateToDetail(filteredList[position].id);
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
