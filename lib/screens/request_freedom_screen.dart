import 'dart:async';

import 'package:flutter/material.dart';
import 'package:free_palastine/painter.dart';
import 'package:widget_mask/widget_mask.dart';

class RequestFreedom extends StatefulWidget {
  const RequestFreedom({super.key});

  @override
  State<RequestFreedom> createState() => _RequestFreedomState();
}

class _RequestFreedomState extends State<RequestFreedom> {
  List<Offset> points = [];
  Offset defaultOffest = const Offset(100, 100);
  bool usePointsFlag = false;
  Timer? timer;
  Future<void> removeOldPointsV2() async {
    timer = Timer.periodic(const Duration(milliseconds: 30), (t) async {
      if (usePointsFlag == false) {
        usePointsFlag = true;
        if (points.isEmpty) {
          t.cancel();
        } else {
          setState(() {
            points.remove(points[0]);
          });
        }
        usePointsFlag = false;
      } else {
        await removeOldPointsV2();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request your freedom",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.amber.shade100,
      body: GestureDetector(
        onPanUpdate: (details) async {
          setState(() {
            defaultOffest = details.localPosition;
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(renderBox.globalToLocal(details.localPosition));
          });
        },
        onPanEnd: (details) async {
          await removeOldPointsV2();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(child: Image.asset("assets/images/palastine map.png")),
            WidgetMask(
              blendMode: BlendMode.srcOut,
              childSaveLayer: true,
              mask: Image.asset("assets/images/no contry map.png"),
              child: CustomPaint(
                painter: MyPainter(points),
                size: Size.infinite,
              ),
            ),
            Positioned(
              left: defaultOffest.dx - 50,
              top: defaultOffest.dy - 50,
              child: Center(
                child: Image.asset(
                  "assets/images/paper.png",
                  width: 90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
