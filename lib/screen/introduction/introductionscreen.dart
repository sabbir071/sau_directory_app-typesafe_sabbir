import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/introduction/widget/custom_cards.dart';
import 'package:sau_directory/widget/person_card.dart';
import 'package:sau_directory/widget/widget.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Introduction',
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return provider.introductionModel == null
              ? const Center(
                  child: Text("Data no found"),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                                title:
                                    provider.introductionModel?.message ?? ""),
                            PersonItemCard(
                              title: "Vice Chancellor",
                              name: provider.introductionModel!.importantPersons
                                  .viceChancellor.name,
                              mobile: provider.introductionModel!
                                  .importantPersons.viceChancellor.mobile,
                              phone: provider.introductionModel!
                                  .importantPersons.viceChancellor.phone,
                              email: provider.introductionModel!
                                  .importantPersons.viceChancellor.email,
                            ),
                            PersonItemCard(
                              title: "Pro Vice Chancellor",
                              name: provider.introductionModel!.importantPersons
                                  .proViceChancellor.name,
                              mobile: provider.introductionModel!
                                  .importantPersons.proViceChancellor.mobile,
                              phone: provider.introductionModel!
                                  .importantPersons.proViceChancellor.phone,
                              email: provider.introductionModel!
                                  .importantPersons.proViceChancellor.email,
                            ),
                            PersonItemCard(
                              title: "Treasurer",
                              name: provider.introductionModel!.importantPersons
                                  .treasurer.name,
                              mobile: provider.introductionModel!
                                  .importantPersons.treasurer.mobile,
                              phone: provider.introductionModel!
                                  .importantPersons.treasurer.phone,
                              email: provider.introductionModel!
                                  .importantPersons.treasurer.email,
                            ),
                            PersonItemCard(
                              title: "Registrar",
                              name: provider.introductionModel!.importantPersons
                                  .registrar.name,
                              mobile: provider.introductionModel!
                                  .importantPersons.registrar.mobile,
                              phone: provider.introductionModel!
                                  .importantPersons.registrar.phone,
                              email: provider.introductionModel!
                                  .importantPersons.registrar.email,
                            ),
                            Card(
                              color: Theme.of(context).primaryColor,
                              elevation: 5,
                              shadowColor: Colors.grey,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: SimpleText4(
                                    text: 'SAU At A Glance',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Theme.of(context).cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildTitleDetails(
                                        context,
                                        'Date of Establishment: July 15, 2001 ',
                                        'Established through the transformation of Bangladesh Agricultural Institute (BAI)',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Location & Area: ',
                                        provider.introductionModel!.location,
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Faculty : ',
                                        '${provider.introductionModel!.atAGlance.faculty}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Departments : ',
                                        '${provider.introductionModel!.atAGlance.departments}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Teachers : ',
                                        '${provider.introductionModel!.atAGlance.teachers}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Officers : ',
                                        '${provider.introductionModel!.atAGlance.officers}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Staff : ',
                                        '${provider.introductionModel!.atAGlance.staff}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Students : ',
                                        provider.introductionModel!.atAGlance
                                            .students,
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Hall : ',
                                        '${provider.introductionModel!.atAGlance.hall}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'Farm : ',
                                        '${provider.introductionModel!.atAGlance.farm}',
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'SAU Library: ',
                                        provider.introductionModel!.sauLibrary,
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'SAURES: ',
                                        provider.introductionModel!.saures,
                                        brightness),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildTitleDetails(
                                        context,
                                        'SAU Outreach Programme: ',
                                        provider.introductionModel!.sauOutreach,
                                        brightness)
                                  ],
                                ),
                              ),
                            ),
                            PersonItemCard(
                              title: "Contact",
                              phone: provider.introductionModel!.phone,
                              email: provider.introductionModel!.email,
                            ),
                          ]),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildTitleDetails(BuildContext context, String title, String detail,
      Brightness brightness) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1?.color,
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      TextSpan(
          text: detail,
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1?.color,
              fontSize: 16)),
    ]));
  }
}
