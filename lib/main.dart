import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Send to Whatsapp"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Column(
                            children: [
                              Text("Developed with love in India"),
                              Text("Developer: Nandan Wewhare"),
                              ElevatedButton(
                                  onPressed: () {},
                                  child:
                                      const FaIcon(FontAwesomeIcons.linkedin))
                            ],
                          ),
                        )),
                icon: const Icon(Icons.info_outline))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                prefixIcon: const FaIcon(FontAwesomeIcons.whatsapp),
                labelText: "Enter Whatsapp Number",
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              onPressed: () {
                var number = "91${phoneController.text}";
                var url = "http://wa.me/$number";
                // call url launcher
              },
              label: const Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}
