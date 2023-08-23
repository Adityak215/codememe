import 'package:flutter/foundation.dart';

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
  int _selectedindex = 0;
  int get selectedindex => _selectedindex;

  void setindex(int index)
  {
    _selectedindex=index;
    notifyListeners();
  }
}


