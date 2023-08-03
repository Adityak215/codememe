import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart'
    as permInterface;

Future<void> downloadinterface(String url, String fileName) async {
  try {
    // Request permissions explicitly before file download
    if (Platform.isAndroid || Platform.isIOS) {
      permInterface.PermissionStatus status = await permInterface.Permission.storage.request();
      if (status != permInterface.PermissionStatus.granted) {
        print('Error: Storage permission not granted.');
        return;
      }
    }

    // Send an HTTP GET request to the URL
    var response = await http.get(Uri.parse(url));

    // Get the application support directory
    Directory appSupportDir = await getApplicationSupportDirectory();
    String localPath = appSupportDir.path;

    // Create a custom directory with the app's name inside the application support directory
    String appName = 'Axolotl'; // Replace with your app's name
    String customDirectory = '$localPath/$appName';
    Directory(customDirectory).createSync();

    // Create the file path inside the custom directory
    String filePath = '$customDirectory/$fileName';

    // Write the file to the custom directory
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    print('File downloaded to: $filePath');
  } catch (e) {
    print('Error while downloading file: $e');
  }
}
