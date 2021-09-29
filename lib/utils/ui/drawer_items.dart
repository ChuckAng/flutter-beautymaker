import 'package:beautymaker/models/drawer_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItems {
  static const home = DrawerItem(title: 'Home', icon: FontAwesomeIcons.home);
  static const profile =
      DrawerItem(title: 'Profile', icon: FontAwesomeIcons.userAlt);
  static const favourite =
      DrawerItem(title: 'Favourite', icon: FontAwesomeIcons.solidHeart);
  static const orders =
      DrawerItem(title: 'My\nOrders', icon: FontAwesomeIcons.receipt);
  static const settings =
      DrawerItem(title: 'Settings', icon: FontAwesomeIcons.cog);
  static const logout =
      DrawerItem(title: 'Logout', icon: FontAwesomeIcons.signOutAlt);

  static final List<DrawerItem> upperDrawer = [
    home,
    profile,
    orders,
  ];

  static final List<DrawerItem> bottomDrawer = [settings, logout];
}
