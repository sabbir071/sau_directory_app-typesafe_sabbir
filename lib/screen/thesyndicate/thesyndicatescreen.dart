import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/thesyndicate/widget/card_widget.dart';
import 'package:sau_directory/widget/widget.dart';

class TheSyndicateScreen extends StatelessWidget {
  const TheSyndicateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'The Syndicate',
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return provider.syndicateList == null
              ? const Center(
                  child: Text("Data not found"),
                )
              : AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.syndicateList!.length,
                    itemBuilder: (context, position) {
                      var memberList = provider.syndicateList![position];
                      return AnimationConfiguration.staggeredList(
                        position: position,
                        duration: const Duration(seconds: 1),
                        child: SlideAnimation(
                          horizontalOffset: 500.0,
                          child: SlideAnimation(
                            child: ListItemCard(
                                title: memberList.name,
                                members: memberList.memberList),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
