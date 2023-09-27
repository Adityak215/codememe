import 'package:codememe/Providers/myproviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'downbadmf.dart';
import 'rick.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:codememe/Providers/randompro.dart';
import 'scroller.dart';


class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Mainscreenstate();
}

class _Mainscreenstate extends State<Mainscreen> {
  
  
  @override
  void initState() {
    final randomprov= Provider.of<Randompro>(context, listen:false);
    final countpro= Provider.of<Countprovider>(context, listen:false);
    super.initState();
    countpro.reset();
    randomprov.fetchRandomMeme();
  }


  @override
  Widget build(BuildContext context) {
    final randomprov= Provider.of<Randompro>(context, listen:false);
    final boolprov = Provider.of<Boolprovider>(context, listen:false);
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
          return  NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                  // PageView is scrolled to the end
                  boolprov.setendboo(true);
                  boolprov.settopboo(false);
                  print(boolprov.ispageend);
                } else if(notification is ScrollEndNotification &&
                    notification.metrics.pixels == notification.metrics.minScrollExtent){
                  boolprov.setendboo(false);
                  boolprov.settopboo(true);
                  print(boolprov.ispagetop);
                }
                else{
                  boolprov.setendboo(false);
                  boolprov.settopboo(false);
                  print(boolprov.ispageend);
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                itemCount: 1,
                scrollDirection: Axis.vertical,
                physics: !boolprov.ispageend
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                //mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.all(10),
                //shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {  
                  if (value.memeData != null) {
                    return GestureDetector(
                      onVerticalDragEnd:(details) {
                                if (details.primaryVelocity! < 0) {
                                  if(handleVerticalSwipeEnd(details, context))
                                  {
                                    randomprov.nextmeme();
                                  }
                                  print('Swipe up');
                                }
                                else if (details.primaryVelocity! > 0) {
                                  if(handleVerticalSwipeTop(details, context))
                                  {
                                    randomprov.prevmeme();
                                  }
                                  print('Swipe down');
                                }
                     }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    );
                  }
                  else {
                    return null;
                  }
          
                  
                  },
              ),
          );
          
        },),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        
      FloatingActionButton(
      onPressed: () {
          randomprov.nextmeme();
        },
      heroTag: 'nxt',
      elevation: 2,
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.refresh_outlined),
      ),    
        const SizedBox(height: 10.0),
      FloatingActionButton(
      onPressed: (){
          downloadFile(randomprov.memeData['url'], randomprov.memeData['author']);
          Fluttertoast.showToast(
                msg: 'File Downloading',
                toastLength: Toast.LENGTH_SHORT,
          );
          HapticFeedback.mediumImpact();
      },
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      heroTag: 'dld',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.downloading_rounded),
        ),
        const SizedBox(height: 10.0),
      FloatingActionButton(
            onPressed: (){
          Share.share(randomprov.memeData['url']);
      },
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
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
