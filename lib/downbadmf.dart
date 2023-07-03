import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:http/http.dart' as http;
//import 'package:permission_handler/permission_handler.dart';

Future<String?> downloadImage(String imageUrl) async {
  final Directory appDirectory = await getApplicationSupportDirectory();
  final String downloadPath = '${appDirectory.path}/images';

  final savedDir = Directory(downloadPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }

  final taskId = await FlutterDownloader.enqueue(
    url: imageUrl,
    savedDir: downloadPath,
    showNotification: true,
    openFileFromNotification: true,
  );

  return taskId;
}



// Declare a variable to hold the file path of the downloaded image
// String imagePath;

// GestureDetector(
//   onTap: () {
//     String imageUrl = 'https://example.com/image.jpg';
//     _downloadImage(imageUrl).then((taskId) {
      
//     });
//   },
//   child: Text('Download Image'),
// ),

// // Display the downloaded image
// if (imagePath != null)
//   Image.file(File(imagePath)),
