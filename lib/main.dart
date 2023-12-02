import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> _notifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Send to Whatsapp"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => _notifier.value = mode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    icon: _notifier.value == ThemeMode.light
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          ),
                        ),
                        labelText: "Enter Whatsapp Number",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (phoneController.text.trim().isNotEmpty) {
                        var number = "91${phoneController.text}";
                        var url = Uri.parse("https://wa.me/$number");
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    label: const Text("Send"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.paste),
                    onPressed: () async {
                      ClipboardData? data =
                          await Clipboard.getData('text/plain');
                      if (data != null) {
                        phoneController.text = data.text!.replaceAll(' ', '');
                      }
                    },
                    label: const Text("Paste from clipboard"),
                  ),
                  const Spacer(),
                  const Text(
                    "Developed with ❤️ in 🇮🇳 ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () async => await launchUrl(Uri.parse(
                          "https://www.linkedin.com/in/nandanwewhare/")),
                      label: const Text("Contact developer",
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
