import 'package:flutter/material.dart';
import 'package:sau_directory/widget/text/simple_text.dart';
import 'package:url_launcher/url_launcher.dart';


class PersonItemCard extends StatelessWidget {
  final String? title;
  final String? name;
  final String? designation;
  final String? mobile;
  final String? phone;
 // final List<String>? phone;
  final String? email;

  const PersonItemCard(
      {Key? key,
       this.title,
      this.name,
      this.designation,
      this.mobile,
      this.phone,
      this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return Column(
      children: [
        title!=null?

        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),

          color: Colors.green[900],

         // color: Colors.white,
          elevation: 5,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SimpleText(
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
                designation != null ? SimpleText(text: designation!) : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),

                mobile != null
                    ? _buildContactDetailRow(context,"Mobile", mobile!, Icons.phone,null,brightness)
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),


             phone != null && phone!.trim().isNotEmpty
                    ? _buildContactDetailRow(
                    context,"Phone", phone!, Icons.phone,null,brightness)
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),

                email != null
                    ? _buildContactDetailRow(context,
                        "Email", email!, Icons.email, Colors.red,brightness)
                    : const SizedBox(),
              ],
            ),
          ),
        )
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
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: Colors.red

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





