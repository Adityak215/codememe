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

class Boolprovider with ChangeNotifier
{
  bool _ispageend = false;
  bool _ispagetop = true;

  bool get ispageend =>_ispageend;
  bool get ispagetop => _ispagetop;

  void setendboo(bool boo)
  {
    _ispageend=boo;
  }

  void settopboo(boo)
  {
    _ispagetop=boo;
  }
}

