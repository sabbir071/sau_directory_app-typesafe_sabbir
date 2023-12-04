import 'package:flutter/material.dart';
import 'package:sau_directory/model/employee_model.dart';
import 'package:sau_directory/widget/text/simple_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
            scrollDirection: Axis.vertical,
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
                      member.mobile !=null
                          ? _buildContactDetailRow(context,"Mobile", member.mobile!,
                              Icons.phone, null, brightness)
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      member.phone !=null
                          ? _buildContactDetailRow(context,"Phone", member.phone,
                              Icons.phone, null, brightness)
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      member.email !=null
                          ? _buildContactDetailRow(context,"Email", member.email!,
                              Icons.email, Colors.red, brightness)
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget _buildContactDetailRow(BuildContext context,String title, String detail, IconData icon,
      [Color? colors, Brightness? brightness]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [



        InkWell(

          onTap: () async {
            if (title.toLowerCase() == 'email') {
              _makeEmail(detail);
            } else {
              _makePhoneCall(detail);
            }
          },

          child: Expanded(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "$title: ",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1?.color)),
              TextSpan(
                  text: detail,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFA2DFFB))),
            ])),
          ),
        ),
        GestureDetector(
            onTap: () async {
              if (title.toLowerCase() == 'email') {
                _makeEmail(detail);
              } else {
                _makePhoneCall(detail);
              }
            },
            child: Icon(icon, color: colors ?? Colors.green, size: 20)),
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
