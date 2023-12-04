import 'package:flutter/material.dart';
import 'package:sau_directory/widget/text/simple_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonItemCard extends StatelessWidget {
  final String? title;
  final String? name;
  final String? designation;
  final String? mobile;
  final String? phone;
  final String? email;
  final String? web;

  const PersonItemCard(
      {Key? key,
      this.title,
      this.name,
      this.designation,
      this.mobile,
      this.phone,
      this.email,
      this.web})
      : super(key: key);

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
        Card(
          color: Theme.of(context).cardColor,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name != null ? SimpleText2(text: name!) : const SizedBox(),
                designation != null
                    ? SimpleText(text: designation!)
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                mobile != null
                    ? _buildContactDetailRow(context, "Mobile", mobile!,
                        Icons.phone, null, brightness)
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                phone != null
                    ? _buildContactDetailRow(
                        context, "Phone", phone!, Icons.phone, null, brightness)
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                email != null
                    ? _buildContactDetailRow(context, "Email", email!,
                        Icons.email, Colors.red, brightness)
                    : const SizedBox(),
                web != null
                    ? _buildAddress("Web Address", web!)
                    : const SizedBox(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContactDetailRow(
      BuildContext context, String title, String detail, IconData icon,
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
            )),
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

  Widget _buildAddress(String title, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(text: '$title:'),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _makeWebLaunch(details);
            },
            child: Text(
              details,
              style: const TextStyle(
                color: Color(0xFFA2DFFB),
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        )
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

  Future<void> _makeWebLaunch(String email) async {
    final Uri url = Uri.parse(email);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
