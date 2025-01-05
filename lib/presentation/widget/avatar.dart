import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/icons/ic_photo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}