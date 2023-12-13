import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          ListTile(
            title: Text("hello"),
          ),
          ListTile(
            title: Text("hi"),
          ),
        ],
      ),
    );
  }
}
