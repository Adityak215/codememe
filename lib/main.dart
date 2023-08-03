import 'package:codememe/dank.dart';
import 'package:codememe/hindi.dart';
import 'entersubred.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'home.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize(debug: true);
  //await Permission.storage.request();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent)
            .copyWith(background: Colors.black),
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static const List<Widget> _widgetOptions = <Widget>[
    Mainscreen(title: 'Home: All sorts of Memes'),
    Dankscreen(title: 'Dank memes Around here'),
    Hindiscreen(title: 'Indian Dank MEMES Hindi'),
    Enterscreen(),

  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
          _onItemTapped(index);
        },
      ),
    );
  }
}
