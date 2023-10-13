// Import necessary libraries and packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:free_palastine/painter.dart';
import 'package:widget_mask/widget_mask.dart';

// Create a Flutter widget class called RequestFreedom that extends StatefulWidget
class RequestFreedom extends StatefulWidget {
  // Constructor for RequestFreedom
  const RequestFreedom({super.key});

  @override
  // Create and return the state for the RequestFreedom widget
  State<RequestFreedom> createState() => _RequestFreedomState();
}

// Create the state class for the RequestFreedom widget
class _RequestFreedomState extends State<RequestFreedom> {
  // List to store points (coordinates) for drawing
  List<Offset> points = [];

  // Current offset for tracking the user's touch position
  Offset currentOffest = const Offset(100, 100);

  // Variable to indicate whether points are currently being used
  bool pointsIsUsing = false;

  // Timer for periodic point removal
  Timer? timer;

  // Asynchronously remove old drawing points
  Future<void> removeOldPoints() async {
    // Set up a periodic timer that runs every 30 milliseconds
    timer = Timer.periodic(const Duration(milliseconds: 30), (t) async {
      if (pointsIsUsing == false) {
        pointsIsUsing = true;
        if (points.isEmpty) {
          t.cancel(); // Cancel the timer if there are no points left
        } else {
          setState(() {
            points.remove(points[0]); // Remove the oldest point
          });
        }
        pointsIsUsing = false;
      } else {
        await removeOldPoints(); // Continue trying to remove points if currently in use
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  // Build the UI for the RequestFreedom widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar title
        title: const Text(
          "Request your freedom",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.amber.shade100, // Background color

      body: GestureDetector(
        // GestureDetector for capturing user touch input
        onPanUpdate: (details) async {
          setState(() {
            currentOffest =
                details.localPosition; // Update the current touch position
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(renderBox
                .globalToLocal(currentOffest)); // Add the point to the list
          });
        },
        onPanEnd: (details) async {
          await removeOldPoints(); // Remove old points when the touch ends
        },
        child: Stack(
          // A stack to overlay multiple UI elements
          alignment: Alignment.center,
          children: [
            Positioned(child: Image.asset("assets/images/palastine map.png")),
            WidgetMask(
              // WidgetMask to apply a mask to a child widget
              blendMode: BlendMode.srcOut,
              childSaveLayer: true,
              mask:
                  Image.asset("assets/images/no country map.png"), // Mask image
              child: CustomPaint(
                painter: MyPainter(
                    points), // Custom painting with the captured points
                size: Size.infinite,
              ),
            ),
            Positioned(
              // Position a paper image based on the current touch offset
              left: currentOffest.dx - 50,
              top: currentOffest.dy - 50,
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
