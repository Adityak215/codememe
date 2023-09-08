import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'downbadmf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:codememe/Providers/custompro.dart';
import 'package:codememe/Providers/myproviders.dart';
import 'scroller.dart';

class Customscreen extends StatefulWidget {
  const Customscreen({super.key, required this.title, required this.cust});

  final String title;
  final String cust;

  @override
  State<StatefulWidget> createState() => _Customscreenstate();
}

class _Customscreenstate extends State<Customscreen> {
  //final GlobalKey _pageViewKey = GlobalKey();
  

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
    final boolprov = Provider.of<Boolprovider>(context, listen:false);
    // double height = MediaQuery.of(context).size.height;
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
          return NotificationListener<ScrollNotification>(
              
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
              //key: _pageViewKey,
              itemCount: 1,
                scrollDirection: Axis.vertical,
                physics: !boolprov.ispageend
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                //mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.all(10),
                //shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {  
                  if(value.memeData != null){
                    return GestureDetector(
                    onVerticalDragEnd:(details) {
                                if (details.primaryVelocity! < 0) {
                                  if(handleVerticalSwipeEnd(details, context))
                                  {
                                    customprov.nextmeme();
                                  }
                                  print('Swipe up');
                                }
                                else if (details.primaryVelocity! > 0) {
                                  if(handleVerticalSwipeTop(details, context))
                                  {
                                    customprov.prevmeme();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        
        FloatingActionButton(
      onPressed: () {
        customprov.nextmeme();
      },
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      heroTag: 'nxt',
      elevation: 2,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.refresh_rounded),
      ),    
    const SizedBox(height: 10.0),
    FloatingActionButton(
      onPressed: (){
          downloadFile(customprov.memeData['url'], customprov.memeData['author']);
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
          Share.share(customprov.memeData['url']);
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
