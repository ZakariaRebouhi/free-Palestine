import 'package:flutter/material.dart';
import 'package:free_palastine/screens/get_freedom_screen.dart';
import 'package:free_palastine/screens/request_freedom_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Do you want the FREEDOM?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "select one of thoses",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RequestFreedom()));
                },
                icon: Image.asset(
                  "assets/images/paper.png",
                  width: 50,
                ),
                label: const Text("Request your freedom"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GetFreedom()));
                },
                icon: Image.asset(
                  "assets/images/gun.png",
                  width: 50,
                ),
                label: const Text("Get your freedom"),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              backgroundColor: Colors.amber.shade100,
                              title: const Text(
                                "Hint",
                                style: TextStyle(color: Colors.black54),
                              ),
                              content: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Freedom is taken, not given",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "الحرية تؤخذ ولا تعطى",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.brown.shade400,
                    size: 40,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
