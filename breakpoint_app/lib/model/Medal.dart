import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../painters/medal_painter.dart';

class Medal extends StatelessWidget {
  final Color color;
  final double size;

  const Medal({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size * 1.3),
            painter: MedalPainter(color: color),
          ),
          Padding(
            padding: EdgeInsets.all(size * 0.25),
            child: SvgPicture.asset(
              'assets/images/medal_icon.svg',
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
    );
  }
}