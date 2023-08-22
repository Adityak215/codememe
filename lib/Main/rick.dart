import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Rick extends StatefulWidget{
  const Rick({super.key});

  @override
  State<StatefulWidget> createState() => _Rickstate();
}


class _Rickstate extends State<Rick>
{
   late YoutubePlayerController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
    initialVideoId: 'dQw4w9WgXcQ',
    flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('You Know The Rules'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                    YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.deepOrange,
                          handleColor: Colors.deepOrangeAccent,
                        ),

                        onReady: () {
                          _controller.addListener(() {});
                        },
                      ),

              const Text('Never Gonna Give You Up',
              style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const Text('by Rick Astley',
              style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const Text('27 July 1987',
              style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 30.0),
              const Text('GOTCHA SUCKER!',
              style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
              ),

          ]
        ),
      ),
    );
  }
}