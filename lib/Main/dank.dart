import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'downbadmf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:codememe/Providers/dankpro.dart';


class Dankscreen extends StatefulWidget {
  const Dankscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Dankscreenstate();
}

class _Dankscreenstate extends State<Dankscreen> {

  @override
  void initState() {
    final dankpro= Provider.of<Dankpro>(context,listen: false);
    super.initState();
    dankpro.fetchDankMeme();
  }


  @override
  Widget build(BuildContext context) {
    final dankpro= Provider.of<Dankpro>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<Dankpro>(builder: (context, value, child) {
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
                    //Image.network(dankpro.memeData['url']),
        
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
        dankpro.prevmeme();
      },
      heroTag: 'prv',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_back_outlined),
      ),    

        FloatingActionButton(
      onPressed: () {
        dankpro.nextmeme();
      },
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_forward_outlined),
      ),    

    FloatingActionButton(
      onPressed: (){
          downloadFile(dankpro.memeData['url'], dankpro.memeData['author']);
          Fluttertoast.showToast(
                msg: 'File Downloading',
                toastLength: Toast.LENGTH_SHORT,
          );
      },
      heroTag: 'dld',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.downloading_rounded),
      ),
      FloatingActionButton(
            onPressed: (){
          Share.share(dankpro.memeData['url']);
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
