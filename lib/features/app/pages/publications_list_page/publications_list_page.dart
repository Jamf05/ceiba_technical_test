import 'package:ceiba_technical_test/features/app/custom/components/custom_app_bar.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/widgets/user_card_widget.dart';
import 'package:ceiba_technical_test/features/app/pages/publications_list_page/widgets/publications_card_widget.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class PublicationsListPage extends StatelessWidget {
  static const route = "/PublicationsListPage";
  const PublicationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Publicaciones",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const UserCardWidget(
              showButton: false,
              user: UserEntity(),
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(10, (index) => const PublicationsCardWidget())
          ],
        ),
      ),
    );
  }
}
