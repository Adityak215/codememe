import 'package:flutter/material.dart';
import 'package:codememe/Mains/api_service.dart';

class Custompro with ChangeNotifier
{
  final APIService apiService = APIService();
  dynamic memeData;
  dynamic prevdata;
  dynamic currdata;
  late String cust;

  void fetchCustomMeme() {
    apiService.fetchCustomMeme(cust).then((data) {
        memeData = data;
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
          fetchCustomMeme();
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