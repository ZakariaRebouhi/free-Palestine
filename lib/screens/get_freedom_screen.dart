import 'package:flutter/material.dart';
import 'package:free_palastine/painter.dart';
import 'package:widget_mask/widget_mask.dart';

class GetFreedom extends StatefulWidget {
  const GetFreedom({super.key});

  @override
  State<GetFreedom> createState() => _GetFreedomState();
}

class _GetFreedomState extends State<GetFreedom> {
  List<Offset> points = [];
  Offset defaultOffest = const Offset(100, 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Get your freedom",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.amber.shade100,
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              defaultOffest = details.localPosition;
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              points.add(renderBox.globalToLocal(defaultOffest));
            });
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
                  left: defaultOffest.dx,
                  top: defaultOffest.dy,
                  child: Image.asset(
                    "assets/images/gun.png",
                    width: 90,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
