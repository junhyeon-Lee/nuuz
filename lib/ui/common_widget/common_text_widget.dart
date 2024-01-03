import 'package:flutter/material.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class ExtraLargeHeaderText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  final Color? color;

  const ExtraLargeHeaderText({super.key, required this.text, this.color, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null
          ? Theme.of(context).textTheme.headlineSmall!.apply(fontSizeFactor: 2.5)
          : Theme.of(context).textTheme.headlineSmall!.apply(fontSizeFactor: 2.5, color: color),
    );
  }
}

class LargeHeaderText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  final Color? color;

  const LargeHeaderText({super.key, required this.text, this.color, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.headlineLarge : Theme.of(context).textTheme.headlineLarge!.apply(color: color),
    );
  }
}

class MediumHeaderText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign textAlign;

  const MediumHeaderText({super.key, required this.text, this.color, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.headlineMedium : Theme.of(context).textTheme.headlineMedium!.apply(color: color),
    );
  }
}

class SmallHeaderText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const SmallHeaderText({super.key, required this.text, this.color, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.headlineSmall : Theme.of(context).textTheme.headlineSmall!.apply(color: color),
    );
  }
}

class LargeDescriptionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const LargeDescriptionText({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.bodyLarge!.apply(color: color),
    );
  }
}

class MediumDescriptionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const MediumDescriptionText({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}

class SmallDescriptionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const SmallDescriptionText({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}

class NickNameMText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const NickNameMText({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: color == null ? CustomTextStyle.descriptionM : CustomTextStyle.descriptionM!.apply(color: color, decoration: TextDecoration.none),
    );
  }
}
