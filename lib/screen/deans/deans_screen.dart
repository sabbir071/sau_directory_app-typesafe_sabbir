import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/deans/widget/card_widget.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class DeansScreen extends StatelessWidget {
  const DeansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Deans',
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return provider.deansModelList == null
            ? const Center(
                child: Text("Data no found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.deansModelList!.length,
                    itemBuilder: (context, position) {
                      var deansModel = provider.deansModelList![position];
                      return AnimationConfiguration.staggeredList(
                          position: position,
                          duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 100.0,
                          child: FadeInAnimation(
                            curve: Curves.fastOutSlowIn,
                            child: GestureDetector(
                              onTap: () {
                                showCustomDialog(context, deansModel);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius more than 50% of height and width to make circle
                                ),
                                color: Theme.of(context).cardTheme.color,
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CardText(
                                    text: deansModel.name,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      }),
    );
  }

  void showCustomDialog(BuildContext context, var deansModel) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool allMembersNull = deansModel.title!.every((titleModel) =>
        titleModel!.member == null || titleModel.member.isEmpty);

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: SimpleText3(
                      text: deansModel.name,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 400, // Set a minimum height for the message
                  ),
                  child: allMembersNull
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'No members available',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                      : AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: deansModel.title!.length,
                      itemBuilder: (context, position) {
                        var titleModel = deansModel.title![position];
                        if (titleModel!.member != null &&
                            titleModel.member.isNotEmpty) {
                          return AnimationConfiguration.staggeredList(
                            position: position,
                            duration: const Duration(seconds: 1),
                            child: SlideAnimation(
                              horizontalOffset: 500.0,
                              child: SlideAnimation(
                                child: ListItemCard(
                                  title: titleModel.name,
                                  members: titleModel.member,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


/* void showCustomDialog(BuildContext context, var deansModel) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: SimpleText3(
                    text: deansModel.name,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  )),
                ),
                 AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: deansModel.title!.length,
                    itemBuilder: (context, position) {
                      var titleModel = deansModel.title![position];
                      if (titleModel!.member != null &&
                          titleModel.member.isNotEmpty) {
                        return AnimationConfiguration.staggeredList(
                          position: position,
                          duration: const Duration(seconds: 1),
                          child: SlideAnimation(
                            horizontalOffset: 500.0,
                            child: SlideAnimation(
                              child: ListItemCard(
                                title: titleModel.name,
                                members: titleModel.member,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }*/
}
