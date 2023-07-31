import 'package:flutter/material.dart';
import 'api_service.dart';
import 'downbadmf.dart';
import 'rick.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Mainscreenstate();
}

class _Mainscreenstate extends State<Mainscreen> {
  final APIService apiService = APIService();
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;

  void fetchRandomMeme() {
    apiService.fetchRandomMeme().then((data) {
      setState(() {
        memeData = data;
      });
    }).catchError((e) {
      const Text(
        'I Donno man the MF jus went and died',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRandomMeme();
  }

  int _counter=0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void prevmeme()
  {
    setState(() {
      currdata=memeData;
      memeData=prevdata;
    });
  }

  void _sharememe()
  {
    Share.share(memeData['url']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: <Widget>[
            Visibility(
              visible: _counter<10,
              child: Text(widget.title)
              ),
            Visibility(
              visible: _counter>=10,
              child: const Text('Alright!! you found it.')
              ),
            const Spacer(),
            Visibility(
              visible: _counter<10,
              child: TextButton(
                onPressed: (){
                  _incrementCounter();
                  if(_counter<5)
                  {
                    Fluttertoast.showToast(
                    msg: 'What are you doing?',
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  }
                  else if(_counter>=5&&_counter<10)
                  {
                    Fluttertoast.showToast(
                    msg: 'Bruh there is nothing there!',
                    toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                child: const Text(''),
              )
            ),
            Visibility(
              visible: _counter>=10,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const Rick()
                      )
                  );
                },
                child: const Text('-_-'),
                ),
              ),
          ],
        )
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            if (memeData != null)
              Column(
                children: [
                  Text(
                    memeData['title'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  InteractiveViewer(
                    child: Image.network(memeData['url']),
                  ),
                  //Image.network(memeData['url']),

                  const SizedBox(height: 10.0),
                  Text('Author: ${memeData['author']}',
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                  const SizedBox(height: 60.0),
                ],
              ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       side: BorderSide(
            //         width: 4,
            //         color: Theme.of(context).colorScheme.primary,
            //       ), //border width and color
            //       elevation: 5, //elevation of button
            //       padding: const EdgeInsets.all(15)),
            //   onPressed: fetchRandomMeme,
            //   child: const Text('More Content Plis'),
            // ),
          ],
        ),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
      onPressed: () {
        prevmeme();
      },
      heroTag: 'prv',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_back_outlined),
      ),    

        FloatingActionButton(
      onPressed: () {
        if(memeData==prevdata)
        {
          setState(() {
            memeData=currdata;
          });
        }
        else
        {
        prevdata=memeData;
        fetchRandomMeme();
        }
      },
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_forward_outlined),
      ),    

      FloatingActionButton(
      onPressed: (){
          //download functionality
      },
      heroTag: 'dld',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.downloading_rounded),
        ),
      FloatingActionButton(
            onPressed: (){
          _sharememe();
      },
      heroTag: 'shr',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.share),
      ),
    
    ],
  ),

    );
  }
}




// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           fetchRandomMeme();
//         },
//         label: const Text('Next Meme plis'),
//         elevation: 2,
//         hoverColor: Theme.of(context).colorScheme.onPrimary,
//         tooltip: 'Next Meme hehe',
//         icon: const Icon(Icons.arrow_forward_outlined),
//         //enableFeedback: await HapticFeedback.lightImpact(),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
//       floatingActionButton: FloatingActionButton(
//         //label: Text('Save'), for FloatingActionButton.extended
//         onPressed: () async {
//           String imageUrl = (memeData['url']);
//                   downloadImage(imageUrl).then((taskId) {
//                     FlutterDownloader.registerCallback((id, status, _) {
//                 if (taskId == id && status == DownloadTaskStatus.complete.value) {
//                   // Once the download is complete, get the file path
//                   FlutterDownloader.open(taskId: taskId!).then((path) {
//                     setState(() {
//                       imagePath = path.toString();
//                     });
//                   });
//                 }
//               });
//             final snackBar = SnackBar(
//               content: const Text('Image downloaded'),
//               action: SnackBarAction(
//                 label: 'Undo',
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                 },
//               ),
//             );
//             // Find the ScaffoldMessenger in the widget tree
//             // and use it to show a SnackBar.
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             //print('Image downloaded with taskId: $taskId');
//           });
//         },
//         child: const Icon(Icons.downloading_outlined),
//       ),