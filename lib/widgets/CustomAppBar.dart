import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  AnimationController animationController;
  Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
  Function()? onPressed;

  CustomAppBar({
    super.key,
    required this.animationController,
    required this.colorsTween,
    required this.homeTween,
    required this.yogaTween,
    required this.iconTween,
    required this.drawerTween,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return AppBar(
            leading: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.dehaze,
                color: drawerTween.value,
              ),
            ),
            backgroundColor: colorsTween.value,
            elevation: 0,
            title: Row(
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                    color: homeTween.value,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Yoga",
                  style: TextStyle(
                    color: yogaTween.value,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            actions: [
              Icon(
                Icons.notifications,
                color: iconTween.value,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
