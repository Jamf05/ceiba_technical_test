import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/button_widget.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget with BaseWidget {
  final UserEntity user;
  final void Function()? onPressed;
  final bool showButton;
  const UserCardWidget({
    Key? key,
    required this.user,
    this.onPressed,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            ListTile(
              textColor: AppColors.blackFirst,
              iconColor: theme.primaryColor,
              title: Text(
                user.name ?? '',
                style:
                    AppFonts.textStyleM18.copyWith(color: theme.primaryColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 5,),
                      Text(user.phone ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 5,),
                      Text(user.email ?? ''),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showButton,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Spacer(),
                    ButtonWidget(text: "VER PUBLICACIONES", onPressed: onPressed),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
