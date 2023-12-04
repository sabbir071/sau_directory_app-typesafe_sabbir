import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/widget/person_card.dart';
import 'package:sau_directory/widget/widget.dart';
import 'package:sau_directory/screen/introduction/widget/custom_cards.dart';

class AboutVCScreen extends StatelessWidget {
  const AboutVCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'About VC',
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return provider.aboutVCModel == null
              ?const Center(
            child: Text("Data no found"),
          ) :  SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
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
                        // Used vcData properties
                        PersonItemCard(
                          title: "Vice Chancellor",
                          name: provider.aboutVCModel!.viceChancellor.name,
                          mobile: provider.aboutVCModel!.viceChancellor.mobile,
                          phone: provider.aboutVCModel!.viceChancellor.phone ?? "",
                          // set null value
                          email: provider.aboutVCModel!.viceChancellor.email,
                        ),
                        Card(
                          elevation: 5,
                          color: Theme.of(context).primaryColor,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: SimpleText4(
                                text: "Message From VC",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        MessageCard(title: provider.aboutVCModel!.vcMessage)
                      ],

                    ),
                  ),
                ),
              )
            ),
          );
        },
      ),
    );
  }
}
