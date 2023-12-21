import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/routes.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Faculty, Department & Teachers',
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return provider.facultyModelList == null
            ? const Center(
                child: Text("Data no found"),
              )
            : AnimationLimiter(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.facultyModelList!.length,
                  itemBuilder: (context, position) {
                    var facultyModel = provider.facultyModelList![position];
                    return facultyModel.department.isNotEmpty ? facultyModel.name != "N/A"? AnimationConfiguration.staggeredList(
                      position: position,
                      duration: const Duration(milliseconds: 375),
                      child:  SlideAnimation(
                        verticalOffset: 100.0,
                        child: FadeInAnimation(
                          curve: Curves.fastOutSlowIn,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.facultySubScreen,
                                  arguments: facultyModel);
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
                                  color: Theme.of(context).textTheme.headline1?.color,
                                  text: facultyModel.name.toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ):const SizedBox(): const SizedBox();
                  }),
            );
      }),
    );
  }
}
