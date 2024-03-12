// ignore_for_file: sized_box_for_whitespace, unnecessary_null_comparison, prefer_const_constructors

import 'package:application/model/user.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final user = UserM.current;
    return Container(
      color: Colors.white,
      width: 250,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(user.email),
            accountName: Text(user.np),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage:
                  user.image != null ? NetworkImage(user.image) : null,
              child: user.image != null
                  ? Container()
                  : Icon(
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
