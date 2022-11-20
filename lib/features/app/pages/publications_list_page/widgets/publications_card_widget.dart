import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:flutter/material.dart';

class PublicationsCardWidget extends StatelessWidget with BaseWidget {
  final void Function()? onPressed;
  const PublicationsCardWidget({
    Key? key,
    this.onPressed,
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
              title: Text(
                "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                style:
                    AppFonts.textStyleM18.copyWith(color: theme.primaryColor),
              ),
              subtitle: const Text("quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            ),
          ],
        ),
      ),
    );
  }
}
