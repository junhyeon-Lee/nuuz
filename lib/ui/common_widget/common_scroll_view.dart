import 'package:flutter/material.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';

class CommonScrollView extends StatefulWidget {
  const CommonScrollView({
    Key? key,
    required this.text,
  }) : super(key: key);

  // final ScrollController _scrollController;
  final String text;

  @override
  State<CommonScrollView> createState() => _CommonScrollViewState();
}

class _CommonScrollViewState extends State<CommonScrollView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: RawScrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thumbColor: CustomColor.primary,
        trackVisibility: true,
        mainAxisMargin: 50,
        thickness: 5,
        // thicknessWhileDragging: 20,
        radius: const Radius.circular(20),
        // radiusWhileDragging: Radius.circular(20),
        child:
            SingleChildScrollView(controller: _scrollController, padding: const EdgeInsets.all(24), child: LargeDescriptionText(text: widget.text)),
      ),
    );
  }
}
