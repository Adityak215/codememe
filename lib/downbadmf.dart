// ignore_for_file: non_constant_identifier_names

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
    // Get the external directory path
    Directory? extDirectory = await getExternalStorageDirectory();
    String? OriginPath = extDirectory?.path;


    String DownDirectory = DownloadsDir(OriginPath);
    Directory(DownDirectory).createSync();
    String ext = getFileExtension(url);
    // Create the file path inside the custom directory
    String filePath = '$DownDirectory/$fileName$ext';

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


String DownloadsDir(String? dirpath )
{
  String DownPath='';
  List<String>? paths = dirpath?.split("/");
          for (int x = 1; x < paths!.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              DownPath += "/$folder";
            } else {
              break;
            }
          }
          DownPath = "$DownPath/Download/Axolotl";
          return DownPath;
          //directory = Directory(DownPath);
}