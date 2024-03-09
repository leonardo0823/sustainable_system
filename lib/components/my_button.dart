import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final Color color1;
  final Color color2;
  final void Function() onPress;
  final void Function()? onLongPress;

  final EdgeInsetsGeometry? margin;
  final double? height;

  const MyButton(
      {Key? key,
      this.icon = FontAwesomeIcons.circle,
      required this.child,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      required this.onPress,
      this.onLongPress,
      this.margin = const EdgeInsets.all(20),
      this.height = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLongPress,
      child: Stack(
        children: [
          _ButtonItemBackground(
            height: height,
            margin: margin,
            icon: icon,
            color1: color1,
            color2: color2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: (height ?? 0) + 40, width: 40),
              FaIcon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: child,
              ),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
              ),
              const SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _ButtonItemBackground extends StatelessWidget {
  final IconData icon;

  final Color color1;
  final Color color2;

  final EdgeInsetsGeometry? margin;
  final double? height;

  const _ButtonItemBackground(
      {Key? key,
      required this.icon,
      required this.color1,
      required this.color2,
      this.margin,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 6),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                right: -15,
                top: -8,
                child: FaIcon(
                  icon,
                  size: 115,
                  color: Colors.white.withOpacity(0.2),
                ))
          ],
        ),
      ),
    );
  }
}
