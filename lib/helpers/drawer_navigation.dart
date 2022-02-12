import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children:  [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/378800000801493189/368c5259f60a04cadeca7e2a58d799ec_400x400.jpeg"),
              ),
              accountName: Text("Jalloh"),
              accountEmail: Text("Jalloh@gmail.com"),
              decoration: BoxDecoration(color: Colors.blue),
            ),

          ],
        ),
      ),
    );
  }
}
