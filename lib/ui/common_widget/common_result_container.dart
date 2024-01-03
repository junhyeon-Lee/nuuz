import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonResultContainer extends StatefulWidget {
  final result;
  bool isList;

  CommonResultContainer({super.key, required this.result, required this.isList});

  @override
  State<CommonResultContainer> createState() => _CommonResultContainerState();
}

class _CommonResultContainerState extends State<CommonResultContainer> {
  @override
  Widget build(BuildContext context) {
    return widget.isList
        ? Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate((widget.result.length ?? 0), (index) => _tagsViewBuilder(index)),
            /*   children: [
              for (int i = 0; i < widget.result.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Text(
                      widget.result[i],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
              SizedBox(
                height: 5.h,
                width: 5.h,
              )
            ],*/
          )
        : Container(
            width: MediaQuery.of(context).size.height * 0.17,
            height: 40.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.black, width: 1)),
            child: Center(
                child: Text(
              widget.result ?? '',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            )),
          );
  }

  Widget _tagsViewBuilder(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // width: MediaQuery.of(context).size.height * 0.2,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.black, width: 1)),
            child: Text(
              widget.result[index],
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonResultContainerText extends StatelessWidget {
  final String text;
  final result;

  const CommonResultContainerText({super.key, required this.text, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.40,
      height: 40.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.black, width: 1)),
      child: Center(
          child: Text(
        '$text $result',
        style: const TextStyle(fontSize: 15, color: Colors.black),
      )),
    );
  }
}
