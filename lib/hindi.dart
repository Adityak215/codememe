import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:share_plus/share_plus.dart';
import 'downbadmf.dart';

class Hindiscreen extends StatefulWidget {
  const Hindiscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Hindiscreenstate();
}

class _Hindiscreenstate extends State<Hindiscreen> {
  final APIService apiService = APIService();
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;

  void fetchHindiMeme() {
    apiService.fetchHindiMeme().then((data) {
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
    fetchHindiMeme();
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
        title: Text(widget.title),
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
        if(memeData==prevdata&&memeData!=currdata)
        {
          setState(() {
            memeData=currdata;
          });
        }
        else
        {
        prevdata=memeData;
        fetchHindiMeme();
        }
      },
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.arrow_forward_outlined),
      ),    

    FloatingActionButton(
      onPressed: (){
          downloadFile(memeData['url'], memeData['author']);
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
