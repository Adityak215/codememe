import 'package:flutter/material.dart';
import 'package:codememe/Mains/api_service.dart';

class Hindipro with ChangeNotifier
{
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;
  final APIService apiService = APIService();

  void fetchHindiMeme() {
    apiService.fetchHindiMeme().then((data) {
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
          fetchHindiMeme();
        }
      notifyListeners();
  }

  void prevmeme()
  {
    if(memeData==prevdata)
    {}
    else
    {
    currdata=memeData;
    memeData=prevdata;
    notifyListeners();
    }
  }
}