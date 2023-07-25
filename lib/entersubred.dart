import 'package:flutter/material.dart';
import 'custom_sub.dart';

class Enterscreen extends StatefulWidget {
  const Enterscreen({super.key});

  @override
  State<StatefulWidget> createState() => _Enterscreenstate();
}

class _Enterscreenstate extends State<Enterscreen> {

  final cust= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Enter Meme Subreddit'),
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