import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/search_provider.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';
import 'package:sau_directory/widget/text/simple_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: const CustomAppbarInApp(appbarName: "Search"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: TextField(
                    controller: provider.textEditingController,
                    autofocus: true,
                    onChanged: (text) async{
                      await provider.textWatcher(text);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: provider.searchEmployeeList.isEmpty
                  ? const Center(
                      child: Text("search data"),
                    )
                  : ListView.builder(
                      itemCount: provider.searchEmployeeList.length,
                      itemBuilder: (context, position) {
                        var member = provider.searchEmployeeList[position];
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
                                member.about !=null
                                    ? SimpleText(text: member.about)
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                member.mobile != null
                                    ? _buildContactDetailRow(
                                        context,
                                        "Mobile",
                                        member.mobile,
                                        Icons.phone,
                                        null,
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                member.phone != null
                                    ? _buildContactDetailRow(
                                        context,
                                        "Phone",
                                        member.phone!,
                                        Icons.phone,
                                        null,
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                member.email != null
                                    ? _buildContactDetailRow(
                                        context,
                                        "Email",
                                        member.email!,
                                        Icons.email,
                                        Colors.red,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      );
    });
  }

  Widget _buildContactDetailRow(
      BuildContext context, String title, String detail, IconData icon,
      [Color? colors]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
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
