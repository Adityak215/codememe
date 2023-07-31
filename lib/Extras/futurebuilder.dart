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
  late Future<void> _initializeVideoPlayerFuture;
  
  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer(){
     controller = VideoPlayerController.networkUrl(Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ',),);
     controller.addListener(() {
        setState(() {});
     });

    controller.initialize().then((value){
        setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.play();
    controller.setLooping(true);
    });
     _initializeVideoPlayerFuture = controller.initialize();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();
    super.dispose();
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

      body:Center(
      child: Column(
        children: <Widget>[
      FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
        )
      )
    );
  }
}