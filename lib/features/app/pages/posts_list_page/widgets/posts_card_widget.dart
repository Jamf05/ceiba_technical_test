import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:flutter/material.dart';

class PostsCardWidget extends StatelessWidget with BaseWidget {
  final PostEntity item;
  const PostsCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            ListTile(
              textColor:
                  isDarkTheme ? AppColors.whiteFirst : AppColors.blackFirst,
                title: Text(
                  item.title ?? '',
                  style:
                      AppFonts.textStyleM18.copyWith(color: theme.primaryColor),
                ),
                subtitle: Text(item.body ?? '')),
          ],
        ),
      ),
    );
  }
}
