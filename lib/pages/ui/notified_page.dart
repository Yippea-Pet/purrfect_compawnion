import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purrfect_compawnion/shared/constants.dart';

class NotifiedPage extends StatelessWidget {
  final String label;

  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = label.split("|")[0];
    final String note = label.split("|")[1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ),
      body: Card(
        child: Center(
          child: Text(
            note,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
