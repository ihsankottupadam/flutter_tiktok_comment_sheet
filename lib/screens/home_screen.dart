import 'package:commet_sheet/controller/home_screen_controller.dart';
import 'package:commet_sheet/screens/sheet_slider.dart';
import 'package:commet_sheet/widgets/comment_sheet.dart';
import 'package:commet_sheet/widgets/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderSheet(
          controller: controller.sheetSliderController,
          maxSheetHeight: MediaQuery.of(context).size.height * 0.75,
          content: const TopWidget(),
          sheet: const CommentSheet()),
    );
  }
}
