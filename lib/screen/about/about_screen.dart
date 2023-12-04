import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/introduction/widget/custom_cards.dart';
import 'package:sau_directory/widget/person_card.dart';
import 'package:sau_directory/widget/widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'About SAU Directory',
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return provider.aboutSauDirectory == null
              ? const Center(
                  child: Text("Data not found"),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(seconds: 1),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 500.0,
                            child: SlideAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            MessageCard(
                              title: provider.aboutSauDirectory!.about,
                            ),
                            PersonItemCard(
                              title: 'Owner',
                              name: provider.aboutSauDirectory!.owner,
                              designation: 'SAU Directory, Copyright 2023',
                            ),
                            PersonItemCard(
                              title: 'Supervisor',
                              name: provider
                                  .aboutSauDirectory?.supervisorData.name,
                              designation: provider.aboutSauDirectory
                                  ?.supervisorData.designation,
                              mobile: provider
                                  .aboutSauDirectory?.supervisorData.mobile,
                              phone: provider
                                  .aboutSauDirectory?.supervisorData.phone,
                              email: provider
                                  .aboutSauDirectory?.supervisorData.email,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildTitleDetails(
      String title, String detail, Brightness brightness) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: TextStyle(
              color:
                  brightness == Brightness.light ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      TextSpan(
          text: detail,
          style: TextStyle(
              color:
                  brightness == Brightness.light ? Colors.black : Colors.white,
              fontSize: 16)),
    ]));
  }
}
