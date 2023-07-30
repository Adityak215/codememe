import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Rick extends StatefulWidget{
  const Rick({super.key});

  @override
  State<StatefulWidget> createState() => _Rickstate();
}


class _Rickstate extends State<Rick>
{

  late VideoPlayerController controller;
  
  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer(){
     controller = VideoPlayerController.asset('assets/rick.mp4');
     controller.addListener(() {
        setState(() {});
     });

    controller.initialize().then((value){
        setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.play();
  });

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
            AspectRatio( 
                    aspectRatio: controller.value.aspectRatio,
                     child: VideoPlayer(controller),
                  ),

                  Text(
                    "Total Duration: ${controller.value.duration}",
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      ),
                    ),

                  VideoProgressIndicator(
                    controller, 
                    allowScrubbing: true,
                    colors:const VideoProgressColors(
                        backgroundColor: Colors.white,
                        playedColor: Colors.redAccent,
                        bufferedColor: Colors.grey,
                    )
                  ),

                Row(
                  
                  children: [
                            IconButton(
                                onPressed: (){
                                  if(controller.value.isPlaying){
                                    controller.pause();
                                  }else{
                                    controller.play();
                                  }

                                  setState(() {
                                    
                                  });
                                }, 
                                icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
                           ),
                         ],
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