import 'package:provider/provider.dart';
import 'customclip.dart';
import 'easteregg.dart';
import 'package:flutter/material.dart';
import 'custom_sub.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:codememe/Providers/myproviders.dart';

class Enterscreen extends StatefulWidget {
  const Enterscreen({super.key});

  @override
  State<StatefulWidget> createState() => _Enterscreenstate();
}

class _Enterscreenstate extends State<Enterscreen> {

  final cust= TextEditingController();
  bool egg=false;

  final _control=PageController(
    initialPage: 0,
  );
  
  @override
  void initState(){
    final countpro=Provider.of<Countprovider>(context,listen: false);
    countpro.reset();
    super.initState();
    egg=false;
  }
  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final countpro=Provider.of<Countprovider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Enter Meme Subreddit'),
              const Spacer(),
              TextButton(
                onPressed: (){
                  countpro.increcount();
                  if(countpro.count<6)
                  {Fluttertoast.showToast(
                    msg: countpro.count.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  }
                  else if(countpro.count>=6&&countpro.count<10)
                  {
                    Fluttertoast.showToast(
                      msg: 'What are you trying huh?',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(countpro.count>=10&&countpro.count<14)
                  {
                    Fluttertoast.showToast(
                      msg: 'Ugh, fine you found a button, Move on!',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(countpro.count>=14&&countpro.count<18)
                  {
                    Fluttertoast.showToast(
                      msg: 'Um, Why are you not looking at Memes?',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(countpro.count>=18&&countpro.count<20)
                  {
                    Fluttertoast.showToast(
                      msg: 'Good now SmartAss?',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else
                  {
                    Fluttertoast.showToast(msg: 'ALRIGHT NOW CHILL WITH THE CLICKS',
                    toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                child: const Text(''))
            ]),
          titleTextStyle: const TextStyle(
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
          color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
        // title: const Text('Enter Meme Subreddit'),
      ),

      body: SingleChildScrollView(
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               ClipPath(
              clipper: DefaultClipEnd(), // Use the custom clipper
              child: Container(
                height: 600, // Make the curved section fill the screen height
                //color: const Color.fromARGB(255, 129, 80, 160), // Color of the curved section
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.deepOrange, Colors.black], // Define the colors for the gradient
                    ),
                  ),
              ),
            ),
            ClipPath(
              clipper: DefaultClipPath(), // Use the custom clipper
              child: Container(
                height: 400, // Make the curved section fill the screen height
                color: (Colors.black), // Color of the curved section
                
              ),
            ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 275,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: cust,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter Your Subreddit to see memes',
                        labelText: "MemeReddit",
                        hintStyle: TextStyle(
                          color: Colors.black
                        ),
                        prefixIconColor: Colors.black,
                        labelStyle: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Customscreen(
                                    title: 'Your OWN Meme Subreddit',
                                    cust: cust.text,
                                  )),
                        );
                      },
                      child: Text(
                        'Ted, just.. okay. just... Submit',
                        style: TextStyle(
                            fontSize: 18.0, color: Theme.of(context).colorScheme.primary,),
                      ),
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child:ElevatedButton(
            child: const Text('Alert - Read this'),
            onPressed: () {
                  _alertdialog(context);
            },
          ),
                    ),
        
                  Consumer<Countprovider>(builder: (context, value, child) {
                    return Visibility(
                        visible: value.count>18,
                        child: TextButton(
                          onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const Easterscreen(
                                      title: 'Have Fun you Horny Slut',
                                    )),
                                );
                              },
                          child: const Text('Alright You brat'),
                          )
                        );
                    },),
                ],
              ),
              ]
            ),
        )

      );
  }
}


void _alertdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(  
                backgroundColor: Colors.white,
                title: const Text('Check Capslock, Spelling and Whitespace'),
                content: const Text('Wrong Subreddit will not load anything'),
                actions: <Widget>[
                  TextButton(
                    onPressed: (){
                       Navigator.of(context).pop();
                    }
                  , child: const Text('OK'))
                ],
           );
    },
  );
}