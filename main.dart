import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الترحيب',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionRequestScreen(),
    );
  }
}

class PermissionRequestScreen extends StatefulWidget {
  @override
  _PermissionRequestScreenState createState() => _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  bool _permissionsGranted = false;
  String _statusMessage = 'الرجاء منح الأذونات المطلوبة';

  Future<void> _requestPermissions() async {
    // طلب إذن الوصول إلى الملفات
    var storageStatus = await Permission.storage.request();
    
    // طلب إذن قراءة رسائل SMS
    var smsStatus = await Permission.sms.request();

    if (storageStatus.isGranted && smsStatus.isGranted) {
      setState(() {
        _permissionsGranted = true;
        _statusMessage = 'تم منح جميع الأذونات';
      });
    } else {
      setState(() {
        _statusMessage = 'لم يتم منح جميع الأذونات';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلب الأذونات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusMessage,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermissions,
              child: Text('طلب الأذونات'),
            ),
            SizedBox(height: 20),
            if (_permissionsGranted)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                child: Text('دخول'),
              ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً بك'),
      ),
      body: Center(
        child: Text(
          'مرحبا',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
