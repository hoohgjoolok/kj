import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PermissionPage(),
    );
  }
}

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  bool granted = false;

  Future<void> requestPermissions() async {
    var storageStatus = await Permission.storage.request();
    var smsStatus = await Permission.sms.request();

    if (storageStatus.isGranted && smsStatus.isGranted) {
      setState(() {
        granted = true;
      });
    } else {
      setState(() {
        granted = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلب الأذونات")),
      body: Center(
        child: granted
            ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomePage()),
                  );
                },
                child: const Text("دخول"),
              )
            : const Text("يرجى منح الأذونات أولاً"),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الصفحة الرئيسية")),
      body: const Center(
        child: Text(
          "مرحبا",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}