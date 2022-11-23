import 'package:flutter/cupertino.dart';

class RootAppProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void changeSelectedTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
