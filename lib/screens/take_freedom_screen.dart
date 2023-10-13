import 'package:flutter/material.dart';
import 'package:free_palastine/painter.dart';
import 'package:widget_mask/widget_mask.dart';

class GetFreedom extends StatefulWidget {
  const GetFreedom({super.key});

  @override
  State<GetFreedom> createState() => _GetFreedomState();
}

class _GetFreedomState extends State<GetFreedom> {
  List<Offset> points = []; // List to store drawing points
  Offset currentOffest = const Offset(100, 100); // Initial pen position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Take your freedom", // App bar title
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.amber.shade100, // Background color

      body: Center(
        child: GestureDetector(
          // GestureDetector for capturing user touch input
          onPanUpdate: (details) {
            // Track pen position and update the points list
            setState(() {
              currentOffest = details.localPosition; // Update the pen position
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              // Update the position to the points list
              points.add(renderBox.globalToLocal(currentOffest));
            });
          },
          child: Stack(
            // A stack to overlay multiple UI elements
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Image.asset(
                      "assets/images/palastine map.png")), // Display an image

              // Mask the image using WidgetMask
              WidgetMask(
                blendMode: BlendMode.srcOut,
                childSaveLayer: true,
                mask: Image.asset(
                    "assets/images/no country map.png"), // Mask image
                child: CustomPaint(
                  painter: MyPainter(
                      points), // Custom painting with the captured points
                  size: Size.infinite,
                ),
              ),

              Positioned(
                // Position an image (a gun icon) based on the current pen position
                left: currentOffest.dx,
                top: currentOffest.dy,
                child: Image.asset(
                  "assets/images/gun.png",
                  width: 90,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
