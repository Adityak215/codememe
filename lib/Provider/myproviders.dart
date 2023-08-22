import 'package:codememe/Main/api_service.dart';
import 'package:flutter/material.dart';

class Countprovider with ChangeNotifier
{
  int _count = 0;
  int get count => _count;

  increcount()
  {
    _count++;
    notifyListeners();
  }
}

class Indexprovider with ChangeNotifier
{
  int _selectedindex=0;
  int get selectedindex => _selectedindex;

  void setindex(int index)
  {
    _selectedindex=index;
    notifyListeners();
  }
}


class Memeprovider with ChangeNotifier
{
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;
  final APIService apiService = APIService();

  // setmeme(data)
  // {
  //   memeData=data;
  //   notifyListeners();
  // }

  void fetchRandomMeme() {
    apiService.fetchRandomMeme().then((data) {
      memeData=data;
      notifyListeners();
    }).catchError((e) {
      const Text(
        'I Donno man the MF jus went and died',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      print(e);
    });
  }

  void nextmeme()
  {
    if(memeData==prevdata&&memeData!=currdata)
        {
          memeData=currdata;
        }
    else
        {
          prevdata=memeData;
          fetchRandomMeme();
        }
      notifyListeners();
  }

  void prevmeme()
  {
    currdata=memeData;
    memeData=prevdata;
    notifyListeners();
  }
}