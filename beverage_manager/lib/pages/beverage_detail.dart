import 'dart:io';

import 'package:beverage_manager/apis/beverage_api.dart';
import 'package:beverage_manager/models/beverage.dart';
import 'package:beverage_manager/utils/beverage_logger.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const List<String> choices = <String>[
  'Save and Return to List',
  'Delete Drink',
  'Return to List'
];

class BeverageDetailPage extends StatefulWidget {
  final String id;

  const BeverageDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BeverageDetailPageState();
}

// implicitly specify the StatefulWidget to extend (BeverageDetailPage)
// if you use the generic StatefulWidget class, you can't retrieve the id attribute further on
class _BeverageDetailPageState extends State<BeverageDetailPage> {
  Beverage? beverage;

  File? _image;

  Future<void> _addImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        BeverageLogger.log('No image selected.');
      }
    });
  }

  // we will use this page to update the beverage info as well, therefore we use TextEditingController's
  TextEditingController nameController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController rateratingController = TextEditingController();
  TextEditingController scanController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id.isEmpty) {
      beverage = Beverage(
          id: "",
          beveragename: "",
          sugar: 0,
          rating: 0,
          scanned: false,
          beverageImage: "");
    }
    // this is the id parameter you declared in the StatefulWidget class (BeverageDetailPage)
    _getBeverage(widget.id); // get the beverage info using the api
  }

  void _getBeverage(String id) {
    BeverageApi.fetchBeverage(id).then((result) {
      setState(() {
        beverage = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCreatingBeverage =
        widget.id.isEmpty; //Id is empty if beverage is being created
    String appBarTitle = isCreatingBeverage
        ? "Add Beverage"
        : "Beverage Details"; // adjust the title to either read or create
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuSelected,
            itemBuilder: (BuildContext context) {
              return choices.asMap().entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key.toString(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.value),
                      _getIcon(entry.key), // Add this line for the icon
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: _beverageDetails(),
      ),
    );
  }

  _beverageDetails() {
    String imageUrl = beverage?.beverageImage ?? '';
    String result = imageUrl.replaceAll("api/beverages", "assets");
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    if (nameController.text.isEmpty) {
      nameController.text = beverage!.beveragename;
    }
    if (sugarController.text.isEmpty) {
      sugarController.text = beverage!.sugar.toString();
    }
    if (rateratingController.text.isEmpty) {
      rateratingController.text = beverage!.rating.toString();
    }
    if (scanController.text.isEmpty) {
      scanController.text = beverage!.scanned ? "Yes" : "No";
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _addImage();
            },
            child: _image == null
                ? (beverage!.id.isEmpty
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                        child: const Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : Image.network(
                        result,
                        // Use the image URL from the API
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ))
                : GestureDetector(
                    onTap: () {
                      _addImage();
                    },
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            style: textStyle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: sugarController,
            style: textStyle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Sugar",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: rateratingController,
            style: textStyle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Rate",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: scanController,
            style: textStyle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Scanned",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Icons for the operations and to return to the list
  Icon _getIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(
          Icons.save,
          color: Colors.blue,
        );
      case 1:
        return const Icon(Icons.delete, color: Colors.red);
      case 2:
        return const Icon(Icons.arrow_back, color: Colors.green);
      default:
        return const Icon(Icons.error, color: Colors.orange);
    }
  }

  void _menuSelected(String index) {
    switch (index) {
      case "0": //save the beverage
        _saveBeverage();
        break;
      case "1": //delete beverage
        _deleteBeverage();
        break;
      case "2": //back to list
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void _saveBeverage() {
    beverage!.beveragename = nameController.text;
    beverage!.sugar = int.parse(sugarController.text);
    beverage!.rating = int.parse(rateratingController.text);
    beverage!.scanned = scanController.text.toLowerCase() == 'yes';

    if (beverage!.id.isEmpty) {
      if (_image != null) {
        try {
          BeverageApi.createBeverage(beverage!, _image!).then((result) {
            Navigator.pop(context, true);
          }).catchError((e) {
            BeverageLogger.log('Error saving beverage: $e');
          });
        } catch (e) {
          BeverageLogger.log('Error saving beverage: $e');
        }
      } else {
        BeverageLogger.log('Image is required for creating a new beverage.');
      }
    } else {
      try {
        BeverageApi.updateBeverage(widget.id, beverage!, _image).then((result) {
          setState(() {
            beverage = result;
          });
          Navigator.pop(context, true);
        }).catchError((e) {
          BeverageLogger.log('Error updating beverage: $e');
        });
      } catch (e) {
        BeverageLogger.log('Error updating beverage: $e');
      }
    }
  }

  void _deleteBeverage() {
    BeverageApi.deleteBeverage(widget.id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
