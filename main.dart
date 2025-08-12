import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق أذونات',
      home: PermissionScreen(),
    );
  }
}

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _hasPermissions = false;
  String _message = "";

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.sms,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    setState(() {
      _hasPermissions = allGranted;
    });

    if (!allGranted) {
      setState(() {
        _message = "الرجاء منح الأذونات المطلوبة";
      });
    } else {
      setState(() {
        _message = "";
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
      appBar: AppBar(
        title: Text('تطبيق أذونات'),
      ),
      body: Center(
        child: _hasPermissions
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: Text("دخول"),
                    onPressed: () {
                      setState(() {
                        _message = "مرحبا";
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "يرجى منح الأذونات",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: requestPermissions,
                    child: Text("طلب الأذونات"),
                  ),
                ],
              ),
      ),
    );
  }
}