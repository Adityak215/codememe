import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'downbadmf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:codememe/Providers/custompro.dart';

class Customscreen extends StatefulWidget {
  const Customscreen({super.key, required this.title, required this.cust});

  final String title;
  final String cust;

  @override
  State<StatefulWidget> createState() => _Customscreenstate();
}

class _Customscreenstate extends State<Customscreen> {
  

  @override
  void initState() {
    final customprov= Provider.of<Custompro>(context, listen:false);
    super.initState();
    customprov.cust=widget.cust;
    customprov.fetchCustomMeme();
  }


  @override
  Widget build(BuildContext context) {
    final customprov= Provider.of<Custompro>(context,listen: false);
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
        child: Consumer<Custompro>(builder: (context, value, child) {
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
        customprov.prevmeme();
      },
      heroTag: 'prv',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_back_outlined),
      ),    

        FloatingActionButton(
      onPressed: () {
        customprov.nextmeme();
      },
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_forward_outlined),
      ),    

    FloatingActionButton(
      onPressed: (){
          downloadFile(customprov.memeData['url'], customprov.memeData['author']);
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
          Share.share(customprov.memeData['url']);
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
