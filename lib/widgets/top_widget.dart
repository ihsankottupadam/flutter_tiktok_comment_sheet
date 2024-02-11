import 'package:commet_sheet/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopWidget extends GetWidget<HomeScreenController> {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 400,
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 500,
            color: Colors.blue,
          ),
          Positioned(
              bottom: 200,
              right: 10,
              child: IconButton(
                  onPressed: () {
                    controller.sheetSliderController.toggle();
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
