import 'easteregg.dart';
import 'package:flutter/material.dart';
import 'custom_sub.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Enterscreen extends StatefulWidget {
  const Enterscreen({super.key});

  @override
  State<StatefulWidget> createState() => _Enterscreenstate();
}

class _Enterscreenstate extends State<Enterscreen> {

  final cust= TextEditingController();
  bool egg=false;
  int _counter = 0;

  final _control=PageController(
    initialPage: 0,
  );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  void initState(){
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
    // if(_counter>18)
    // {
    //   return PageView(
    //     controller: _control,
    //     scrollDirection: Axis.vertical,
    //     children: const [
    //       Enterscreen(),
    //       Easterscreen(title: 'Congratulations, Enjoy you Slut'),
    //     ],
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
          title: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Enter Meme Subreddit'),
              const Spacer(),
              TextButton(
                onPressed: (){
                  _incrementCounter();
                  if(_counter<6)
                  {Fluttertoast.showToast(
                    msg: '$_counter',
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  }
                  else if(_counter>=6&&_counter<10)
                  {
                    Fluttertoast.showToast(
                      msg: 'What are you trying huh?',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(_counter>=10&&_counter<14)
                  {
                    Fluttertoast.showToast(
                      msg: 'Ugh, fine you found a button, Move on!',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(_counter>=14&&_counter<18)
                  {
                    Fluttertoast.showToast(
                      msg: 'Um, Why are you not looking at Memes?',
                      toastLength: Toast.LENGTH_SHORT,
                      );
                  }
                  else if(_counter>=18&&_counter<20)
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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
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

            Visibility(
                visible: _counter>18,
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

              ),
            ]
          )
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