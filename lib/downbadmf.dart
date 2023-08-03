import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

Future<void> downloadFile(String url, String fileName) async {
  try {

    // Request permissions explicitly before file download
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print('Error: Storage permission granted.');
    }
    else if(status.isPermanentlyDenied)
    {
      await openAppSettings();
      print('Error: Storage permission Permanently denied.');
      return;
    }
    else if(status.isDenied)
    {
      await openAppSettings();
      print('Error: Storage permission denied.');
      return;
    }
    else if(status.isRestricted)
    {
      await openAppSettings();
      print('Error: Storage permission restricted.');
      return;
    }

    String getFileExtension(String urlext) {
        try {
          return ".${urlext.split('.').last}";
        } catch(e){
          return '.';
        }
      }
    // Get the downloads directory path
    Directory? downloadsDirectory = await getExternalStorageDirectory();
    String? downloadsPath = downloadsDirectory?.path;

    // Create a folder inside the downloads directory with the name of the app
    String appName = 'Axolotl'; // Replace with your app's name
    String customDirectory = '$downloadsPath/$appName';
    Directory(customDirectory).createSync();
    String ext = getFileExtension(url);
    // Create the file path inside the custom directory
    String filePath = '$customDirectory/$fileName$ext';

    // Create a http.Response object
    http.Response response = await http.get(Uri.parse(url));

    // Write the file to the custom directory
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    print('File downloaded to: $filePath');
  } catch (e) {
    print('Error while downloading file: $e');
  }
}