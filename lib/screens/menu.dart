import 'package:application/data/globlas.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(currentUser!.email),
            accountName: Text(currentUser!.np),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: currentUser!.image.isNotEmpty
                  ? NetworkImage(currentUser!.image)
                  : null,
              child: currentUser!.image.isEmpty
                  ? Container()
                  : const Icon(
                      Icons.person,
                      color: Colors.amber,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
