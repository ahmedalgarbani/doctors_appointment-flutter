import 'package:uuid/uuid.dart';
// import 'dart:io';

// Future<String?> getDeviceId() async {
//   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     print("-------------------");
//     print("$Platform");
//     print("hi : ${androidInfo.id}");
//     print("-------------------");
//     return androidInfo.id;
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     return iosInfo.identifierForVendor;
//   }
//   return null;
// }


String getUUIDv4(){
  return Uuid().v4();  
}


