import 'package:flutter/cupertino.dart';

class DrawerControl extends ChangeNotifier {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;

  void openDrawer() {
    xOffset = 170;
    yOffset = 120;
    scaleFactor = 0.7;
    notifyListeners();
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    notifyListeners();
  }
}
