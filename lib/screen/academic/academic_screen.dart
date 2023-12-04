import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/screen/academic/widget/person_card.dart';
import 'package:sau_directory/widget/widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AcademicScreen extends StatelessWidget {
  const AcademicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).convertFileFromData();
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Academic calendar & Class routine',
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return provider.academicCalendar == null
              ? const Center(
                  child: Text("Data not found"),
                )
              : AnimationLimiter(
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
                        PersonItemCard(
                          title: 'Academic Calendar',
                          mobile: provider.academicCalendar!.mobile,
                          phone: provider.academicCalendar!.phone,
                          web: provider.academicCalendar!.details,
                        ),
                        provider.pdfFile != null
                            ?provider.isPdf? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .65,
                                child: SfPdfViewer.file(provider.pdfFile!))
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                child: InteractiveViewer(
                                  panEnabled: false, // Set it to false
                                  minScale: 0.5,
                                  maxScale: 2,
                                  child: Image.file(provider.pdfFile!,
                                    fit: BoxFit
                                        .cover, // Adjust the fit as needed
                                  ),
                                ),
                              ):const SizedBox(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
