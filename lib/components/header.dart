import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color1;
  final Color color2;

  const IconHeader(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.color1 = const Color.fromARGB(244, 8, 149, 86),
      this.color2 = const Color(0xFF66BB6A)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color whiteColor = Colors.white.withOpacity(0.7);
    return Stack(
      children: [
        _IconHeaderBackground(
          color1: color1,
          color2: color2,
        ),
        Positioned(
          top: -50,
          left: -70,
          child: FaIcon(
            icon,
            size: 200,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 70,
              width: double.infinity,
            ),
            Text(subtitle, style: TextStyle(fontSize: 22, color: whiteColor)),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20, color: whiteColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FaIcon(
              icon,
              size: 70,
              color: Colors.white,
            )
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _IconHeaderBackground({
    Key? key,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: primarySwatch,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(70),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1,
            color2,
          ],
        ),
      ),
    );
  }
}
