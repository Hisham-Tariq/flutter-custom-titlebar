import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/widgets.dart';

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
