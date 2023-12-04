import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/others_contact/widget/person_card.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class OthersContactScreen extends StatelessWidget {
  const OthersContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Others Contacts',
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return provider.othersContactList == null
            ? const Center(
                child: Text("Data no found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.othersContactList!.length,
                    itemBuilder: (context, position) {
                      var directoryModel = provider.othersContactList![position];
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
                                    bool allMembersNull =
                                        directoryModel.memberList.isEmpty;

                                    return Dialog(
                                      insetPadding: const EdgeInsets.symmetric(
                                          vertical: 40, horizontal: 10),
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              constraints:
                                              const BoxConstraints(minHeight: 50),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5))),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                  child: SimpleText3(
                                                text: directoryModel.name,
                                                color: Colors.white,
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                minHeight:
                                                    400, // Set a minimum height for the message
                                              ),
                                              child: allMembersNull
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Center(
                                                        child: Text(
                                                          'No members available',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    )
                                                  : AnimationLimiter(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            directoryModel
                                                                .memberList
                                                                .length,
                                                        itemBuilder: (context,
                                                            position) {
                                                          var titleModel =
                                                              directoryModel
                                                                      .memberList[
                                                                  position];
                                                          return AnimationConfiguration
                                                              .staggeredList(
                                                      position: position,
                                                      duration:
                                                      const Duration(seconds: 1),
                                                      child: SlideAnimation(
                                                        horizontalOffset: 500.0,
                                                        child: SlideAnimation(
                                                          child: PersonItemCard(
                                                            name: titleModel.name,
                                                                  designation:
                                                                      titleModel
                                                                          .about,
                                                                  mobile:
                                                                      titleModel
                                                                          .mobile,
                                                                  phone:
                                                                      titleModel
                                                                          .phone,
                                                                  email:
                                                                      titleModel
                                                                          .email,
                                                                ),
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
                                shadowColor: Colors.grey,
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
