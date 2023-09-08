// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('ListView Scroll Detection'),
// //         ),
// //         body: MyListView(),
// //       ),
// //     );
// //   }
// // }

// // class MyListView extends StatefulWidget {
// //   @override
// //   _MyListViewState createState() => _MyListViewState();
// // }

// // class _MyListViewState extends State<MyListView> {

// //   @override
// //   Widget build(BuildContext context) {
// //     return NotificationListener(
// //   onNotification: (ScrollNotification scrollInfo) {
// //     if (scrollInfo is ScrollEndNotification) {
// //       // Determine whether the scroll gesture should be handled by ListView or GestureDetector.
// //       if (_scrollController.position.extentAfter == 0) {
// //         // You have reached the end of the list. Handle it here.
// //         // For example, load more items.
// //       } else {
// //         // Pass the gesture to the GestureDetector for image scrolling.
// //         return false;
// //       }
// //     }
// //     return true; // Continue handling the notification by ListView.
// //   },
// //   child: PageView.builder(
// //     controller: _pageController,
// //     itemCount: 1,
// //     itemBuilder: (BuildContext context, int index) {
// //       return GestureDetector(
// //         onVerticalDragEnd: (details) {
// //           if (details.primaryVelocity! < 0) {
// //             // Swipe up
// //             randomprov.nextmeme();
// //             print('Swipe up');
// //           } else if (details.primaryVelocity! > 0) {
// //             // Swipe down
// //             randomprov.prevmeme();
// //             print('Swipe down');
// //           }
// //         },
// //         child: Column(
// //           children: [
// //             Text(
// //               value.memeData['title'],
// //               style: const TextStyle(
// //                 fontSize: 20.0,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.white,
// //               ),
// //             ),
// //             const SizedBox(height: 20.0),
// //             InteractiveViewer(
// //               child: Image.network(value.memeData['url']),
// //             ),
// //             const SizedBox(height: 10.0),
// //             Text('Author: ${value.memeData['author']}',
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                 )),
// //             const SizedBox(height: 60.0),
// //           ],
// //         ),
// //       );
// //     },
// //   ),
// // );

// //   }

  
// // Import the scroll controller package
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'downbadmf.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:codememe/Providers/custompro.dart';
// import 'package:codememe/Providers/myproviders.dart';

// class Customscreen extends StatefulWidget {
//   const Customscreen({Key? key, required this.title, required this.cust}) : super(key: key);

//   final String title;
//   final String cust;

//   @override
//   State<StatefulWidget> createState() => _Customscreenstate();
// }

// class _Customscreenstate extends State<Customscreen> {
//   final ScrollController _scrollController = ScrollController(); // Create a ScrollController

//   @override
//   void initState() {
//     final customprov = Provider.of<Custompro>(context, listen: false);
//     super.initState();
//     customprov.cust = widget.cust;
//     customprov.fetchCustomMeme();
//   }

//   void _handleVerticalSwipeEnd(DragEndDetails details) {
//     final boolprov = Provider.of<Boolprovider>(context, listen: false);
//     final customprov = Provider.of<Custompro>(context, listen: false);
//     if (boolprov.ispageend) {
//       customprov.nextmeme();
//       print('swipe in endfunc');
//     } else {
//       // Scroll the page when the gesture is not handled by GestureDetector
//       if (details.primaryVelocity! > 0) {
//         // Swipe down, scroll up
//         _scrollController.animateTo(
//           _scrollController.offset - 100.0, // Adjust the value as needed
//           curve: Curves.linear,
//           duration: Duration(milliseconds: 500),
//         );
//       } else if (details.primaryVelocity! < 0) {
//         // Swipe up, scroll down
//         _scrollController.animateTo(
//           _scrollController.offset + 100.0, // Adjust the value as needed
//           curve: Curves.linear,
//           duration: Duration(milliseconds: 500),
//         );
//       }
//       print('Swipe not handled by GestureDetector');
//     }
//   }

//   void _handleVerticalSwipeTop(DragEndDetails details) {
//     final boolprov = Provider.of<Boolprovider>(context, listen: false);
//     final customprov = Provider.of<Custompro>(context, listen: false);
//     if (boolprov.ispagetop) {
//       customprov.prevmeme();
//       print('swipe in toppppppppfunc');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final customprov = Provider.of<Custompro>(context, listen: false);
//     final boolprov = Provider.of<Boolprovider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         titleTextStyle: const TextStyle(
//           fontSize: 20.0,
//           color: Colors.white,
//         ),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Consumer<Custompro>(builder: (context, value, child) {
//           return NotificationListener<ScrollNotification>(
//             onNotification: (notification) {
//               if (notification is ScrollEndNotification &&
//                   notification.metrics.pixels == notification.metrics.maxScrollExtent) {
//                 // PageView is scrolled to the end
//                 boolprov.setendboo(true);
//                 boolprov.settopboo(false);
//                 print(boolprov.ispageend);
//               } else if (notification is ScrollEndNotification &&
//                   notification.metrics.pixels == notification.metrics.minScrollExtent) {
//                 boolprov.setendboo(false);
//                 boolprov.settopboo(true);
//                 print(boolprov.ispageend);
//               } else {
//                 print(boolprov.ispageend);
//               }
//               return true;
//             },
//             child: ListView.builder(
//               controller: _scrollController, // Assign the ScrollController
//               itemCount: 1,
//               scrollDirection: Axis.vertical,
//               physics: !boolprov.ispageend
//                   ? const AlwaysScrollableScrollPhysics()
//                   : const NeverScrollableScrollPhysics(),
//               itemBuilder: (BuildContext context, int index) {
//                 if (value.memeData != null) {
//                   return GestureDetector(
//                     onVerticalDragEnd: (details) {
//                       if (details.primaryVelocity! < 0) {
//                         _handleVerticalSwipeEnd(details);
//                         print('Swipe up');
//                       } else if (details.primaryVelocity! > 0) {
//                         _handleVerticalSwipeTop(details);
//                         print('Swipe down');
//                       }
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           value.memeData['title'],
//                           style: const TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
                       

//  const SizedBox(height: 20.0),
//                         InteractiveViewer(
//                           child: Image.network(value.memeData['url']),
//                         ),
//                         const SizedBox(height: 10.0),
//                         Text(
//                           'Author: ${value.memeData['author']}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 60.0),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//           );
//         }),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               customprov.prevmeme();
//             },
//             heroTag: 'prv',
//             elevation: 2,
//             hoverColor: Theme.of(context).colorScheme.onPrimary,
//             child: const Icon(Icons.arrow_back_outlined),
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               customprov.nextmeme();
//             },
//             heroTag: 'nxt',
//             elevation: 2,
//             hoverColor: Theme.of(context).colorScheme.onPrimary,
//             child: const Icon(Icons.arrow_forward_outlined),
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               downloadFile(customprov.memeData['url'], customprov.memeData['author']);
//               Fluttertoast.showToast(
//                 msg: 'File Downloading',
//                 toastLength: Toast.LENGTH_SHORT,
//               );
//             },
//             heroTag: 'dld',
//             elevation: 2,
//             hoverColor: Theme.of(context).colorScheme.onPrimary,
//             child: const Icon(Icons.downloading_rounded),
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               Share.share(customprov.memeData['url']);
//             },
//             heroTag: 'shr',
//             elevation: 2,
//             hoverColor: Theme.of(context).colorScheme.onPrimary,
//             child: const Icon(Icons.share),
//           ),
//         ],
//       ),
//     );
//   }
// }
