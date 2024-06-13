import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
class GenericSizedBox extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Function(String)? onChanged;
  GenericSizedBox({required this.labelText, required this.hintText, required this.prefixIcon, required this.onChanged});

  @override
  Widget build(BuildContext Build){
    return SizedBox(
      height: 100.0,
      width: 500.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

void restartApp() {
  if (kIsWeb) {
    return;
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    Process.run('dart', ['run']);
  }
}


class WaveAppBarShape extends ShapeBorder {
  final double appBarHeight;

  const WaveAppBarShape({this.appBarHeight = kToolbarHeight});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final double curveHeight = 60;

    path.lineTo(0, rect.height - curveHeight);
    final firstControlPoint = Offset(rect.width / 4, rect.height);
    final firstEndPoint = Offset(rect.width / 2, rect.height - curveHeight);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    final secondControlPoint = Offset(
        rect.width - (rect.width / 4), rect.height - (curveHeight * 2));
    final secondEndPoint = Offset(rect.width, rect.height - curveHeight);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}

Drawer customDrawer() {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text('Item 1'),
          onTap: (){},
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: (){},
        ),
      ],
    ),
  );
}

AppBar customAppbar() {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 130,
    backgroundColor: Color.fromARGB(255, 7, 133, 237),
    title: Align(
      alignment: Alignment.topCenter,
    ),
    shape: WaveAppBarShape(),
    iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
  );
}


class CustomElevatedButton2 extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onPressed;

  CustomElevatedButton2({required this.label, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}


class CuSiz extends StatelessWidget {
  final double? width;
  final double? height;
  final String? image;

  CuSiz({this.width, this.height, this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(image!),
      
    );
  }
}


