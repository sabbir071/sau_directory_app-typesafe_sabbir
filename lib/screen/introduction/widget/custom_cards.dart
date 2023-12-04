import 'package:flutter/material.dart';
import 'package:sau_directory/widget/text/simple_text.dart';

class MessageCard extends StatelessWidget {
  final String title;

  const MessageCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 10,
      shadowColor: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: SimpleText3(
            text: title,
          ),
        ),
      ),
    );
  }
}

class CardTypeB extends StatelessWidget {
  final String title;

  const CardTypeB({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

class CardTypeC extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardTypeC({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


