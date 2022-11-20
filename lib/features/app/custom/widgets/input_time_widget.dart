import 'package:flutter/material.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';

class InputTimeWidget extends StatelessWidget {
  final String label;
  final String time;
  final void Function()? onTap;
  final double? width;
  final double? height;
  const InputTimeWidget({
    Key? key,
    required this.label,
    required this.time,
    required this.onTap,
    this.width = 130,
    this.height = 110,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: AppFonts.textStyleB16,
            ),
            const Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  time,
                  style: AppFonts.textStyleR18,
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
            const Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }
}