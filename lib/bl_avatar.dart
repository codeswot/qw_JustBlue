// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

class BlAvatar extends StatefulWidget {
  const BlAvatar(this.icon,{super.key});
  final IconData icon;
  @override
  _BlAvatarState createState() => _BlAvatarState();
}

class _BlAvatarState extends State<BlAvatar> {
  double _radius = 90.0;
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();

    // Start a timer to continuously update the radius and create a ripple effect
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _radius = _radius == 95.0 ? 100.0 : 95.0;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the animation timer when the widget is disposed
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        width: _radius * 2,
        height: _radius * 2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: CircleAvatar(
          backgroundColor: const Color(0xffc5deff).withOpacity(0.3),
          radius: _radius,
          child:  Icon(
           widget.icon,
            color: Colors.black26,
            size: 55,
          ),
        ),
      ),
    );
  }
}
