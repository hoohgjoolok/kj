# مشروع Flutter جاهز لطلب أذونات الملفات و SMS

هذا المشروع يحتوي على كود Flutter بسيط يعرض زر **"دخول"**. عند الضغط:
- يطلب إذن **الوصول للملفات (Storage)**
- يطلب إذن **الرسائل القصيرة (SMS)**
- إذا تم منح الأذونات، يظهر النص **"مرحباً"** ✅

> **ملاحظة مهمة**: على Android 13+ قد تختلف أذونات التخزين (قد تحتاج READ_MEDIA_*). المثال يعمل بشكل تعليمي وبسيط.

## المتطلبات
- تثبيت Flutter و Dart على جهازك.
- Android SDK و ADB.

## خطوات الإعداد والبناء (APK)
1) فك ضغط الملف، ثم افتح الطرفية داخل مجلد المشروع:
   ```bash
   cd permission_app
   ```

2) أنشئ ملفات المنصّات (Android/iOS/Web) عبر:
   ```bash
   flutter create .
   ```

3) استبدل ملف AndroidManifest بالملف الجاهز لدينا:
   - انسخ الملف:
     ```
     android_manifest/AndroidManifest.xml
     ```
     إلى:
     ```
     android/app/src/main/AndroidManifest.xml
     ```

4) جلب الحزم:
   ```bash
   flutter pub get
   ```

5) ابْنِ الـ APK (وضع الإصدار):
   ```bash
   flutter build apk --release
   ```
   سيظهر الملف في:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

## تشغيل مباشر على جهاز متصل (اختياري)
```bash
flutter run
```

## ملفات مهمّة
- `lib/main.dart`: واجهة التطبيق وطلب الأذونات وعرض "مرحباً".
- `pubspec.yaml`: تعريف المشروع واعتماد `permission_handler`.
- `android_manifest/AndroidManifest.xml`: أذونات Android المطلوبة.

بالتوفيق! وإذا احتجت تعديلات إضافية (تنقل لصفحة ثانية بعد "دخول"، أو دعم أذونات أحدث)، أخبرني.
