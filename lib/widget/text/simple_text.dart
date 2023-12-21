import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/theme_mode.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;

  const SimpleText({Key? key, required this.text, this.color, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Text(
        text,
        style: Theme.of(context).textTheme.headline1?.copyWith(
            fontSize: fontSize ?? 14 * provider.currentValue,
            color: color ?? Theme.of(context).textTheme.headline1?.color),
      );
    });
  }
}

class SimpleText2 extends StatelessWidget {
  final String text;
  final Color? color;

  const SimpleText2({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Text(text,
          style: Theme.of(context).textTheme.headline2?.copyWith(
              fontSize: 16 * provider.currentValue,
              color: color ?? Theme.of(context).textTheme.headline1?.color));
    });
  }
}
class SimpleText3 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const SimpleText3({Key? key, required this.text, this.color,this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Text(text,
          textAlign: textAlign?? TextAlign.start,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: 18 * provider.currentValue,
              color: color ?? Theme.of(context).textTheme.headline1?.color));
    });
  }
}

class CardText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CardText({Key? key, required this.text, this.color,this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Text(text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5?.copyWith(
              fontSize: 18 * provider.currentValue,
              color: color ??  Theme.of(context).textTheme.headline1?.color,));
    });
  }
}

class SimpleText4 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const SimpleText4({Key? key, required this.text, this.color,this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Text(text,
          textAlign: textAlign?? TextAlign.start,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: 20 * provider.currentValue,
              color: color ?? Theme.of(context).textTheme.headline1?.color));
    });
  }
}



