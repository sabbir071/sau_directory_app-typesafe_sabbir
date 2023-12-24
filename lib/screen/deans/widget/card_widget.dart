import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/model/employee_model.dart';
import 'package:sau_directory/widget/text/simple_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/constant.dart';
import '../../../provider/theme_mode.dart';

class ListItemCard extends StatelessWidget {
  final String? title;
  final List<Employee>? members;

  const ListItemCard({Key? key, this.title, this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return Column(
      children: [
        title != null
            ? Card(
                color: Theme.of(context).primaryColor,
                elevation: 5,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SimpleText4(
                      text: title!,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: members!.length,
            itemBuilder: (context, position) {
              var member = members![position];
              return Card(
                color: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      member.name.isNotEmpty
                          ? SimpleText2(text: member.name)
                          : const SizedBox(),
                      member.designation !=null
                          ? SimpleText(text: member.designation)
                          : const SizedBox(),
                      member.about !=null
                          ? SimpleText(text: member.about,color: Colors.grey,)
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      member.mobile != null
                          ? _buildContactDetailRow(context, "Mobile",
                              member.mobile, Icons.phone, null, brightness)
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      member.phone != null
                          ? _buildContactDetailRow(context, "Phone",
                              member.phone, Icons.phone, null, brightness)
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      member.email != null
                          ? _buildContactDetailRow(context, "Email",
                              member.email, Icons.email, Colors.red, brightness)
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget _buildContactDetailRow(context, String title, String detail, IconData icon,
      [Color? colors, Brightness? brightness]) {
    // Split the phone numbers
    List<String> phoneNumbers = detail.split(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var phoneNumber in phoneNumbers)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (title.toLowerCase() == 'email') {
                      _makeEmail(phoneNumber);
                    } else {
                      _makePhoneCall(phoneNumber);
                    }
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "$title: ",
                        style: TextStyle(
                            color: Colors.green,fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(
                        text: phoneNumber,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: Provider.of<ThemeProvider>(context).currentTheme == 'light'
                              ? CustomColors.text_required_color
                              : CustomColors.freelancer_color,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (title.toLowerCase() == 'email') {
                    _makeEmail(phoneNumber);
                  } else {
                    _makePhoneCall(phoneNumber);
                  }
                },
                child: Icon(icon, color: colors ?? Colors.green, size: 20),
              ),
            ],
          ),
        const SizedBox(height: 5),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
