import 'package:flutter/material.dart';
import '../widgets/armultipletargets.dart';

class DrinkScannerPage extends StatefulWidget {
  const DrinkScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrinkScannerPageState();
}

class _DrinkScannerPageState extends State<DrinkScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Drinks"),
        ),
        body: Container(
          child: const Center(
              // Here we load the Widget with the Drink experience
              child: ArMultipleTargetsWidget()),
        ));
  }
}
