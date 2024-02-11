import 'dart:developer';

import 'package:commet_sheet/screens/sheet_slider_controller.dart';
import 'package:flutter/material.dart';

class SheetSlider extends StatefulWidget {
  const SheetSlider(
      {super.key,
      this.controller,
      required this.content,
      required this.sheet,
      this.maxSheetHeight});

  final SheetSliderController? controller;
  final double? maxSheetHeight;
  final Widget content;
  final Widget sheet;

  @override
  State<SheetSlider> createState() => SheetSliderState();
}

class SheetSliderState extends State<SheetSlider> {
  double sheetHeight = 0.0;

  late double maxSheetHeight;
  late double dragCancelVelocity;
  double dragFastVelocity = 1000;

  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.state = this;
    maxSheetHeight = widget.maxSheetHeight ?? 300;
    dragCancelVelocity = maxSheetHeight * 0.4;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double minContentSize =
        MediaQuery.of(context).size.height - (widget.maxSheetHeight ?? 300);
    double position;
    return GestureDetector(
      onTap: () {
        log('tap');
      },
      onVerticalDragDown: (details) {
        setState(() {
          isDragging = true;
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        position = details.globalPosition.dy;

        if (position > minContentSize) {
          double newH = screenHeight - position;
          if (newH < 0) return;
          setState(() {
            sheetHeight = newH;
          });
        }
      },
      onVerticalDragEnd: (details) {
        log('drag end');
        // log('vel ${details.velocity.pixelsPerSecond}');
        setState(() {
          isDragging = false;
          if (sheetHeight < dragCancelVelocity ||
              details.velocity.pixelsPerSecond.dy > dragFastVelocity) {
            collapse();
          } else {
            expand();
          }
        });
      },
      onVerticalDragCancel: () {
        log('drag cancel');
        setState(() {
          isDragging = false;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: FittedBox(child: widget.content),
          ),
          TweenAnimationBuilder(
              duration: Duration(milliseconds: isDragging ? 0 : 200),
              tween: Tween<double>(begin: 0, end: sheetHeight),
              builder: (context, value, child) {
                return SizedBox(height: value, child: widget.sheet);
              })
        ],
      ),
    );
  }

  void expand() {
    setState(() {
      sheetHeight = maxSheetHeight;
    });
  }

  void collapse() {
    setState(() {
      sheetHeight = 0;
    });
  }

  void toggle() {
    if (sheetHeight > 0) {
      setState(() {
        sheetHeight = 0;
      });
    } else {
      setState(() {
        sheetHeight = maxSheetHeight;
      });
    }
  }
}
