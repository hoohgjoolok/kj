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
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
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
  String message = '';
  bool grantedAll = false;

  Future<void> requestPermissions() async {
    // اطلب إذونات التخزين و SMS
    final storage = await Permission.storage.request();
    final sms = await Permission.sms.request();

    setState(() {
      grantedAll = storage.isGranted && sms.isGranted;
      message = grantedAll ? 'مرحباً' : 'يجب منح جميع الأذونات';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب أذونات')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: requestPermissions,
              child: const Text('دخول'),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            if (grantedAll) ...[
              const SizedBox(height: 24),
              const Icon(Icons.check_circle_outline, size: 48),
            ]
          ],
        ),
      ),
    );
  }
}
