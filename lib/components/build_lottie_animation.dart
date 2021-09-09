import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BuildLottieAnimation extends StatelessWidget {
  BuildLottieAnimation({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.lottieUrl,
    required this.backgroundColor,
    
  }) : super(key: key);

  final double height, width, borderRadius;
  final String lottieUrl;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Lottie.network(
            lottieUrl,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
