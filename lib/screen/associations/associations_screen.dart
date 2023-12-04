import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/associations/widget/card_widget.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class AssociationsScreen extends StatelessWidget {
  const AssociationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Associations',
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return provider.associationList == null
            ? const Center(
                child: Text("Data no found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.associationList!.length,
                    itemBuilder: (context, position) {
                      var directoryModel = provider.associationList![position];
                      return AnimationConfiguration.staggeredList(
                        position: position,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 100.0,
                          child: FadeInAnimation(
                            curve: Curves.fastOutSlowIn,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    bool allMembersNull = directoryModel.title.every((titleModel) =>
                                    titleModel.employee.isEmpty);

                                    return Dialog(
                                      insetPadding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              constraints:
                                                  const BoxConstraints(minHeight: 50),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(5),
                                                      topRight: Radius.circular(5))),
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                  child: SimpleText3(
                                                text: directoryModel.name,
                                                color: Colors.white,
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                minHeight: 400, // Set a minimum height for the message
                                              ),
                                              child: allMembersNull ? const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Center(
                                                  child: Text(
                                                    'No members available',
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              ): AnimationLimiter(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  itemCount: directoryModel.title.length,
                                                  itemBuilder: (context, position) {
                                                    var titleModel =
                                                    directoryModel.title[position];
                                                    return AnimationConfiguration
                                                        .staggeredList(
                                                      position: position,
                                                      duration:
                                                      const Duration(seconds: 1),
                                                      child: SlideAnimation(
                                                        horizontalOffset: 500.0,
                                                        child: SlideAnimation(
                                                          child: titleModel.employee.isNotEmpty ? ListItemCard(
                                                              title: titleModel.name,
                                                              members:
                                                              titleModel.employee) : const SizedBox.shrink(),
                                                        ),
                                                      ),
                                                    );
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
                                    text: directoryModel.name,
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
}
