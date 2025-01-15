import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageToSystemFile({File? imageFile}) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png';
  final saveImage = await imageFile!.copy(path);
  return saveImage.path;
}
