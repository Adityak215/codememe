import 'package:provider/provider.dart';
import 'Mains/dank.dart';
import 'Mains/hindi.dart';
import 'Mains/entersubred.dart';
import 'package:flutter/material.dart';
import 'Mains/home.dart';
import 'package:codememe/Providers/myproviders.dart';
import 'package:codememe/Providers/randompro.dart';
import 'package:codememe/Providers/hindipro.dart';
import 'package:codememe/Providers/easterpro.dart';
import 'package:codememe/Providers/dankpro.dart';
import 'package:codememe/Providers/custompro.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_)=> Countprovider()),
          ChangeNotifierProvider(create: (_)=> Indexprovider()),
          ChangeNotifierProvider(create: (_)=> Randompro()),
          ChangeNotifierProvider(create: (_)=> Hindipro()),
          ChangeNotifierProvider(create: (_)=> Easterpro()),
          ChangeNotifierProvider(create: (_)=> Dankpro()),
          ChangeNotifierProvider(create: (_)=> Custompro()),
          ChangeNotifierProvider(create: (_)=> Boolprovider()),
        ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddit Meme',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent)
            .copyWith(background: Colors.black),
      ),
      home: const MyHomePage(title: 'Get your Random Reddit MEMES'),
      )
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


  static const List<Widget> _widgetOptions = <Widget>[
    Mainscreen(title: 'Home: All sorts of Memes'),
    Dankscreen(title: 'Dank memes Around here'),
    Hindiscreen(title: 'Indian Dank MEMES Hindi'),
    Enterscreen(),

  ];
  

  @override
  Widget build(BuildContext context) {
     
    return Consumer<Indexprovider>(builder: (context, value, child) {
        return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(value.selectedindex),
        ),
    
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: value.selectedindex,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions_rounded),
              label: 'Dank',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake),
              label: 'Hindi Memes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page_rounded),
              label: 'Custom Sub',
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          onTap: (index) {
            value.setindex(index);
          },
        ),
      );
    },);
  }
}
