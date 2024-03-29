import 'package:flutter/widgets.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';

class ModalDecorationWidget extends StatelessWidget {
  const ModalDecorationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 4,
      decoration: BoxDecoration(color: AppColors.greySecond, borderRadius: BorderRadius.circular(6)),
    );
  }
}