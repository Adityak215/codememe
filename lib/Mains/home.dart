import 'package:codememe/Providers/myproviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'downbadmf.dart';
import 'rick.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:codememe/Providers/randompro.dart';
//import 'dowloadinterface.dart';


class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Mainscreenstate();
}

class _Mainscreenstate extends State<Mainscreen> {
  
  final APIService apiService = APIService();
  //dynamic memeData;
  //dynamic prevdata;
  //dynamic currdata;

  // void fetchRandomMeme() {
  //   apiService.fetchRandomMeme().then((data) {
  //     setState(() {
  //       memeData = data;
  //     });
  //   }).catchError((e) {
  //     const Text(
  //       'I Donno man the MF jus went and died',
  //       style: TextStyle(
  //         fontSize: 20.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //     );
  //     print(e);
  //   });
  // }

  @override
  void initState() {
    final randomprov= Provider.of<Randompro>(context, listen:false);
    super.initState();
    randomprov.fetchRandomMeme();
  }

  // int value.count=0;

  // void _incrementCounter() {
  //   setState(() {
  //     value.count++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final randomprov= Provider.of<Randompro>(context, listen:false);
    print('wholeassthing built again');
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: <Widget>[
            Consumer<Countprovider>(builder: (context, value, child) {
              return Visibility(
                visible: value.count<10,
                child: Text(widget.title)
                );
              },),
            Consumer<Countprovider>(builder: (context, value, child) {
              return Visibility(
                visible: value.count>=10,
                child: const Text('Alright!! you found it.')
                );
              },),
            const Spacer(),
            Consumer<Countprovider>(builder: (context, value, child) {
              return Visibility(
                visible: value.count<10,
                child: TextButton(
                  onPressed: (){
                    value.increcount();
                    if(value.count<5)
                    {
                      Fluttertoast.showToast(
                      msg: 'What are you doing?',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                    }
                    else if(value.count>=5&&value.count<10)
                    {
                      Fluttertoast.showToast(
                      msg: 'Bruh there is nothing there!',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  child: const Text(''),
                )
              );
            },),
            Consumer<Countprovider>(builder: (context, value, child) {
              return Visibility(
                visible: value.count>=10,
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => const Rick()
                        )
                    );
                  },
                  child: const Text('-_-'),
                  ),
                );
              },),
          ],
        )
      ),
      body: Center(
        child: Consumer<Randompro>(builder: (context, value, child) {
          return ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              if (value.memeData != null)
                Column(
                  children: [
                    Text(
                      value.memeData['title'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),
        
                    InteractiveViewer(
                      child: Image.network(value.memeData['url']),
                    ),
                    //Image.network(memeData['url']),
        
                    const SizedBox(height: 10.0),
                    Text('Author: ${value.memeData['author']}',
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
          );
        },),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
      onPressed: () {
        randomprov.prevmeme();
      },
      heroTag: 'prv',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_back_outlined),
      ),    

      FloatingActionButton(
      onPressed: () {
          randomprov.nextmeme();
        },
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_forward_outlined),
      ),    

      FloatingActionButton(
      onPressed: (){
          downloadFile(randomprov.memeData['url'], randomprov.memeData['author']);
          Fluttertoast.showToast(
                msg: 'File Downloading',
                toastLength: Toast.LENGTH_SHORT,
          );
          HapticFeedback.mediumImpact();
      },
      heroTag: 'dld',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.downloading_rounded),
        ),
      FloatingActionButton(
            onPressed: (){
          Share.share(randomprov.memeData['url']);
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
