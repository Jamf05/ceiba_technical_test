import 'package:flutter/material.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? overrideTitle;
  final String? titleText;
  final TextStyle? titleTextStyle;
  final double? elevation;
  final Widget? leading;
  final Color? leadingIconColor;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Color? actionsColor;
  final Color? backgroundColor;
  final bool? centerTitle;
  final Color? shadowColor;
  @override
  final Size preferredSize;
  final double? toolbarHeight;
  final double? titleSpacing;
  final double? leadingWidth;
  CustomAppBar(
      {Key? key,
      this.overrideTitle,
      this.elevation,
      this.titleText,
      this.titleTextStyle,
      this.leading = const BackButton(
        color: AppColors.whiteFirst,
      ),
      this.actions = const [],
      this.bottom,
      this.backgroundColor,
      this.leadingIconColor,
      this.actionsColor,
      this.centerTitle,
      this.toolbarHeight,
      this.titleSpacing,
      this.shadowColor = AppColors.whiteFirst,
      this.leadingWidth,
  })
      : preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: leadingIconColor ?? AppColors.whiteFirst),
      titleSpacing: titleSpacing,
      actionsIconTheme:
          IconThemeData(color: actionsColor ?? AppColors.blackFirst),
      title:
          overrideTitle ?? Text(titleText ?? '', style: AppFonts.textStyleM20),
      elevation: elevation,
      backgroundColor: backgroundColor,
      leading: leading,
      centerTitle: centerTitle,
      bottom: bottom,
      actions: actions,
      shadowColor: shadowColor,
      leadingWidth: leadingWidth,
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
