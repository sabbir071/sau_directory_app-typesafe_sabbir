import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sau_directory/model/faculty_model.dart';
import 'package:sau_directory/screen/facultydepartment/widget/card_widget.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class FacultySubScreen extends StatelessWidget {
  final FacultyModel facultyModel;
  const FacultySubScreen({super.key, required this.facultyModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Faculty, Department & Teachers',
      ),
      body: AnimationLimiter(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: facultyModel.department.length,
            itemBuilder: (context, position) {
              var departmentModel = facultyModel.department[position];
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

                            bool allMembersNull = departmentModel.designation.every((titleModel) =>
                            titleModel.employee.isEmpty);

                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child:  Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      constraints:
                                      const BoxConstraints(minHeight: 50),
                                      decoration:  BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(5) , topRight: Radius.circular(5))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: SimpleText3(
                                            text: departmentModel.name,
                                            color: Colors.white,
                                            textAlign: TextAlign.center,

                                          )),
                                    ),

                                    Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 400, // Set a minimum height for the message
                                      ),
                                      child: allMembersNull?const Padding(
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
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: departmentModel.designation.length,
                                          itemBuilder: (context, position) {
                                            var titleModel = departmentModel
                                                .designation[position];
                                            return AnimationConfiguration.staggeredList(
                                              position: position,
                                              duration: const Duration(seconds: 1),
                                              child: SlideAnimation(
                                                horizontalOffset: 500.0,
                                                child: SlideAnimation(
                                                  child: titleModel.employee.isNotEmpty?
                                                  ListItemCard(
                                                      title: titleModel.name,
                                                      members: titleModel.employee) : const SizedBox.shrink(),


                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )


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
                          child: departmentModel.designation.any((element) => element.employee.isEmpty)
                              ? CardText(text: departmentModel.name.toString(),color: Colors.white,)
                              : const SizedBox.shrink(),

                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}