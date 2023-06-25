import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80"),
              ),
            ),
          ),
          const ListTile(
            title: Text(
              "Reset Progress",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: Icon(
              Icons.restart_alt_sharp,
              size: 25,
            ),
          ),
          const ListTile(
            title: Text(
              "Share With Friends",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: Icon(
              Icons.share,
              size: 25,
            ),
          ),
          const ListTile(
            title: Text(
              "Rate Us",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: Icon(
              Icons.star_rate,
              size: 25,
            ),
          ),
          const ListTile(
            title: Text(
              "FeedBack",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: Icon(
              Icons.feedback_outlined,
              size: 25,
            ),
          ),
          const ListTile(
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            leading: Icon(
              Icons.security_sharp,
              size: 25,
            ),
          ),
          const Divider(
            indent: 30,
            endIndent: 30,
            thickness: 2,
          ),
          const Text(
            "Version 1.0.0",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
