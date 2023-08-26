import 'package:flutter/material.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.lightBlue,
            ),
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.lightBlue,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://randomuser.me/portraits/women/10.jpg'),
                radius: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
