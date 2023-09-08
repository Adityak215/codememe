import 'package:codememe/Providers/myproviders.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

  final ScrollController scrollController = ScrollController(); // Create a ScrollController

   bool handleVerticalSwipeEnd(DragEndDetails details, context) {
    final boolprov = Provider.of<Boolprovider>(context, listen:false);
    if (boolprov.ispageend) {
         
        boolprov.setendboo(false);
        boolprov.settopboo(true);
        return true;
      }
    else {
    // Scroll the page when the gesture is not handled by GestureDetector
    if (details.primaryVelocity! > 0) {
      // Swipe down, scroll up
      scrollController.animateTo(
        scrollController.offset - 500.0, // Adjust the value as needed
        curve: Curves.easeOut, // Use a different curve for smoother animation
        duration: Duration(milliseconds: 300), // Increase the duration for smoother scrolling
      );
    } else if (details.primaryVelocity! < 0) {
      // Swipe up, scroll down
      scrollController.animateTo(
        scrollController.offset + 500.0, // Adjust the value as needed
        curve: Curves.easeOut, // Use a different curve for smoother animation
        duration: Duration(milliseconds: 300), // Increase the duration for smoother scrolling
      );
    }
      print('Swipe not handled by GestureDetector');
      return false;
    }
  }

  

  bool handleVerticalSwipeTop(DragEndDetails details, context) {
    final boolprov = Provider.of<Boolprovider>(context, listen:false);
    if (boolprov.ispagetop) { 
        boolprov.setendboo(false);
        boolprov.settopboo(true);
        return true; 
      }
      else {
    // Scroll the page when the gesture is not handled by GestureDetector
    if (details.primaryVelocity! > 0) {
      // Swipe down, scroll up
      scrollController.animateTo(
        scrollController.offset - 500.0, // Adjust the value as needed
        curve: Curves.easeOut, // Use a different curve for smoother animation
        duration: Duration(milliseconds: 300), // Increase the duration for smoother scrolling
      );
    } else if (details.primaryVelocity! < 0) {
      // Swipe up, scroll down
      scrollController.animateTo(
        scrollController.offset + 500.0, // Adjust the value as needed
        curve: Curves.easeOut, // Use a different curve for smoother animation
        duration: Duration(milliseconds: 300), // Increase the duration for smoother scrolling
      );
    }
      print('Swipe not handled by GestureDetector');
      return false;
    }
    }
    

    // Future<double> gethigh(url)
    // async {
    //   final ByteData data =
    //   await NetworkAssetBundle(Uri.parse(url)).load(url);
    //   final Uint8List bytes = data.buffer.asUint8List();

    //   final decodedImage = await decodeImageFromList(bytes);
    //   double high= decodedImage.height as double;
    //   return high;
    // }
