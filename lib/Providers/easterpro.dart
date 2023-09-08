import 'package:flutter/material.dart';
import 'package:codememe/Mains/api_service.dart';

class Easterpro with ChangeNotifier
{
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;
  final APIService apiService = APIService();

  void fetcheasterMeme() {
    apiService.fetcheasterMeme().then((data) {
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
          fetcheasterMeme();
        }
      notifyListeners();
  }

  void prevmeme()
  {
    if(memeData==prevdata)
    {}
    else if(prevdata==null)
    {}
    else
    {
    currdata=memeData;
    memeData=prevdata;
    notifyListeners();
    }
  }
}