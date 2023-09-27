import 'package:flutter/material.dart';

class SignupClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.3); // Start at the bottom-left corner
    path.cubicTo(
        size.width*0.25, (size.height*0.5), 3*(size.width/4), size.height*0.35,size.width, size.height*0.5); // Define the curve
    path.lineTo(size.width, 0); // End at the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LogClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.42); // Start at the bottom-left corner
    path.cubicTo(
        size.width*0.25, (size.height*0.5), 3*(size.width/4), size.height*0.25,size.width, size.height*0.35); // Define the curve
    path.lineTo(size.width, 0); // End at the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DefaultClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.2); // Start at the bottom-left corner
    path.cubicTo(
        size.width*0.25, (size.height*0.5), 3*(size.width/4), size.height*0.45,size.width, size.height*0.7); // Define the curve
    path.lineTo(size.width, 0); // End at the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DefaultClipEnd extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.6); // Start at the bottom-left corner
    path.cubicTo(
        size.width*0.25, (size.height*0.8), 3*(size.width/4), size.height*0.75,size.width, size.height*0.9); // Define the curve
    path.lineTo(size.width, 0); // End at the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class OpsClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.45); // Start at the bottom-left corner
    path.cubicTo(
        size.width*0.25, (size.height*0.7), 3*(size.width/4), size.height*0.45,size.width, size.height*0.85); // Define the curve
    path.lineTo(size.width, 0); // End at the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}