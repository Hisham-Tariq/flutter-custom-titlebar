import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_titlebar/widgets/mouse_state_builder.dart';

class TitleBar extends StatelessWidget {
  final Widget appLogo;

  const TitleBar({
    Key? key,
    this.appLogo = const FlutterLogo(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: appLogo,
          ),
          Text("Custom Title Bar"),
          Expanded(
            child: MoveWindow(),
          ),
          _TitleBarButtons()
        ],
      ),
    );
  }
}

class _TitleBarButtons extends StatelessWidget {
  //Minimze & Maximize Button Colors
  final bgMouseOverOrDownColor = Colors.black26;
  final iconMouseOverOrDownColor = Colors.black54;

  // Close Button Color
  final closeBgMouseOverOrDownColor = Colors.red;
  final closeIconMouseOverOrDownColor = Colors.white;

  //Normal Color for all Buttons Icon
  final iconNormalColor = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeButton(
          iconNormalColor: iconNormalColor,
          bgMouseOverOrDownColor: bgMouseOverOrDownColor,
          iconMouseOverOrDownColor: iconMouseOverOrDownColor,
        ),
        MaximizeOrRestoreButton(
          iconNormalColor: iconNormalColor,
          bgMouseOverOrDownColor: bgMouseOverOrDownColor,
          iconMouseOverOrDownColor: iconMouseOverOrDownColor,
        ),
        CloseButton(
          iconNormalColor: iconNormalColor,
          bgMouseOverOrDownColor: closeBgMouseOverOrDownColor,
          iconMouseOverOrDownColor: closeIconMouseOverOrDownColor,
        ),
      ],
    );
  }
}

class TitleBarButton extends StatelessWidget {
  final Function onTap;
  // Hover & Tap State
  final Color bgMouseOverOrDownColor;
  final Color iconMouseOverOrDownColor;
  //Normal
  final Color iconNormalColor;
  //IconData
  final IconData icon;
  // for maximize and restore
  final bool rotateIcon;

  const TitleBarButton({
    Key? key,
    required this.onTap,
    required this.bgMouseOverOrDownColor,
    required this.iconMouseOverOrDownColor,
    required this.iconNormalColor,
    required this.icon,
    this.rotateIcon = false,
  }) : super(key: key);

  Color getIconColor(MouseState mouseState) {
    if (mouseState.isMouseOver || mouseState.isMouseDown)
      return this.iconMouseOverOrDownColor;
    return this.iconNormalColor;
  }

  Color getBackgroundColor(MouseState mouseState) {
    if (mouseState.isMouseOver || mouseState.isMouseDown)
      return this.bgMouseOverOrDownColor;
    return Colors.white.withOpacity(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 60.0,
      child: MouseStateBuilder(
        builder: (context, mouseState) {
          return GestureDetector(
            onTap: this.onTap as VoidCallback,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              color: getBackgroundColor(mouseState),
              child: Transform.rotate(
                angle: this.rotateIcon ? 3.14 : 0.0, // 3.14 = 180
                child: Icon(
                  this.icon,
                  color: getIconColor(mouseState),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MinimizeButton extends StatelessWidget {
  final Color iconNormalColor;
  final Color iconMouseOverOrDownColor;
  final Color bgMouseOverOrDownColor;

  const MinimizeButton(
      {Key? key,
      required this.iconNormalColor,
      required this.iconMouseOverOrDownColor,
      required this.bgMouseOverOrDownColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TitleBarButton(
      icon: Icons.minimize,
      bgMouseOverOrDownColor: Colors.black26,
      iconMouseOverOrDownColor: Colors.black54,
      iconNormalColor: Colors.grey.shade800,
      onTap: appWindow.minimize,
    );
  }
}

class MaximizeOrRestoreButton extends StatelessWidget {
  final Color iconNormalColor;
  final Color iconMouseOverOrDownColor;
  final Color bgMouseOverOrDownColor;

  const MaximizeOrRestoreButton(
      {Key? key,
      required this.iconNormalColor,
      required this.iconMouseOverOrDownColor,
      required this.bgMouseOverOrDownColor})
      : super(key: key);

  Widget build(BuildContext context) {
    return TitleBarButton(
      icon: Icons.crop_square_sharp,
      bgMouseOverOrDownColor: bgMouseOverOrDownColor,
      iconMouseOverOrDownColor: iconMouseOverOrDownColor,
      iconNormalColor: iconNormalColor,
      onTap: appWindow.maximizeOrRestore,
    );
  }
}

class CloseButton extends StatelessWidget {
  final Color iconNormalColor;
  final Color iconMouseOverOrDownColor;
  final Color bgMouseOverOrDownColor;

  const CloseButton(
      {Key? key,
      required this.iconNormalColor,
      required this.iconMouseOverOrDownColor,
      required this.bgMouseOverOrDownColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TitleBarButton(
      icon: Icons.close,
      bgMouseOverOrDownColor: bgMouseOverOrDownColor,
      iconMouseOverOrDownColor: iconMouseOverOrDownColor,
      iconNormalColor: iconNormalColor,
      onTap: appWindow.close,
    );
  }
}
