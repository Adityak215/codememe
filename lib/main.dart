import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddit Meme',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent).copyWith(background: Colors.black),
      ),
      home: const MyHomePage(title: 'Get your Random Reddit MEMES'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
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

                  InteractiveViewer(child:Image.network(memeData['url']), ),
                  //Image.network(memeData['url']),

                  const SizedBox(height: 10.0),
                  Text('Author: ${memeData['author']}',
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                  const SizedBox(height: 20.0),
                ],
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width:4, color:Theme.of(context).colorScheme.primary,), //border width and color
                  elevation: 5, //elevation of button
                  padding: const EdgeInsets.all(15)
                ),
              onPressed: fetchRandomMeme,
              child: const Text('More Content Plis'),
            ),
          ],
        ),
      ),
    );
  }
}
