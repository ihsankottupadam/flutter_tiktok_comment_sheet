import 'package:commet_sheet/screens/sheet_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderSheet extends StatefulWidget {
  const SliderSheet(
      {super.key,
      this.controller,
      required this.content,
      required this.sheet,
      this.maxSheetHeight,
      this.onExpand,
      this.onCollapse,
      this.backgroundColor});

  final SliderSheetController? controller;
  final double? maxSheetHeight;
  final Widget content;
  final Widget sheet;
  final VoidCallback? onExpand;
  final VoidCallback? onCollapse;
  final Color? backgroundColor;

  @override
  State<SliderSheet> createState() => SliderSheetState();
}

class SliderSheetState extends State<SliderSheet> {
  double sheetHeight = 0.0;

  bool isExpanded = false;

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

    return WillPopScope(
      onWillPop: () async {
        if (isExpanded) {
          collapse();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragDown: isExpanded
            ? (details) {
                setState(() {
                  isDragging = true;
                });
              }
            : null,
        onVerticalDragUpdate: isExpanded
            ? (DragUpdateDetails details) {
                position = details.globalPosition.dy;

                if (position > minContentSize) {
                  double newH = screenHeight - position;
                  if (newH < 0) return;
                  setState(() {
                    sheetHeight = newH;
                  });
                }
              }
            : null,
        onVerticalDragEnd: isExpanded
            ? (details) {
                setState(() {
                  isDragging = false;
                  if (sheetHeight < dragCancelVelocity ||
                      details.velocity.pixelsPerSecond.dy > dragFastVelocity) {
                    collapse();
                  } else {
                    expand();
                  }
                });
              }
            : null,
        onVerticalDragCancel: isExpanded
            ? () {
                setState(() {
                  isDragging = false;
                });
              }
            : null,
        onHorizontalDragDown: isExpanded ? (details) {} : null,
        onHorizontalDragUpdate: isExpanded ? (details) {} : null,
        onHorizontalDragEnd: isExpanded ? (details) {} : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: isExpanded ? widget.backgroundColor : null,
            ),
            Column(
              children: [
                Expanded(
                  child:
                      FittedBox(child: RepaintBoundary(child: widget.content)),
                ),
                TweenAnimationBuilder(
                    duration: Duration(milliseconds: isDragging ? 0 : 200),
                    tween: Tween<double>(begin: 0, end: sheetHeight),
                    builder: (bContext, value, child) {
                      return LayoutBuilder(builder: (innerContext, constrains) {
                        return SizedBox(
                            height: value -
                                ((Get.mediaQuery.viewInsets.bottom / 2)
                                    .clamp(0, value)),
                            child:
                                isExpanded ? widget.sheet : const SizedBox());
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  void expand() {
    setState(() {
      sheetHeight = maxSheetHeight;
      isExpanded = true;
    });
    widget.onExpand?.call();
  }

  void collapse() {
    setState(() {
      sheetHeight = 0;
      isExpanded = false;
    });
    widget.onCollapse?.call();
  }

  void toggle() {
    if (sheetHeight > 0) {
      collapse();
    } else {
      expand();
    }
  }
}
