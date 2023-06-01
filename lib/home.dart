import 'package:flutter/material.dart';
import 'api_service.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Mainscreenstate();
}

class _Mainscreenstate extends State<Mainscreen> {
  final APIService apiService = APIService();
  dynamic memeData;

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
                  const SizedBox(height: 20.0),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          fetchRandomMeme();
        },
        label: const Text('Next Meme plis'),
        elevation: 2,
        hoverColor: Theme.of(context).colorScheme.onPrimary,
        tooltip: 'Next Meme hehe',
        icon: const Icon(Icons.arrow_forward_outlined),
        //enableFeedback: await HapticFeedback.lightImpact(),
      ),
    );
  }
}
