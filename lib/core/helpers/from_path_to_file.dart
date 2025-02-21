import 'dart:io';

File? convertPathToFile(String? filePath) {
  if (filePath == null || filePath.isEmpty) return null;
  return  File(filePath);
}
