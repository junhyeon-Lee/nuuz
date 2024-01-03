import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:nuuz/models/nuuz_talk/data_model.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class FlyingAnimation extends StatefulWidget {
  const FlyingAnimation(this.child, {super.key, this.width = 768, this.height = 1024, this.milliseconds = 400, required this.list});

  final double width;
  final double height;
  final int milliseconds;
  final IconData child;
  final List<DataModel> list;

  @override
  State<StatefulWidget> createState() {
    return AnimationDiscreteWidgetState();
  }
}

class AnimationDiscreteWidgetState extends State<FlyingAnimation> {
  List<Widget> childs = [];
  var timeOut;

  AnimationDiscreteWidgetState();

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeOut = Duration(milliseconds: widget.milliseconds);

    Timer.periodic(timeOut, (timer) {
      //callback function
      if (childs.length > 20) {
        //  childs.removeAt(0);
      }
      childs.add(AnimationDiscrete(
        child: userView(widget.list[index]),
        key: UniqueKey(),
        width: widget.width,
        height: widget.height,
      ));
      index++;

      if (index >= widget.list.length) {
        index = 0;
      }
      setState(() {});
    });
  }

  Widget userView(DataModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            model.image,
            fit: BoxFit.fill,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: childs,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AnimationDiscrete extends StatefulWidget {
  double width;
  double height;
  Widget child;

  AnimationDiscrete({Key? key, this.width = 768, this.height = 1024, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimationDiscreteState();
  }
}

class AnimationDiscreteState extends State<AnimationDiscrete> with TickerProviderStateMixin {
  late AnimationController likeController;
  late CurvedAnimation likeAnimation;
  late Size sizex0;
  late Size sizex1;
  late Size sizex2;
  late Size sizex3;
  late double randomSize;
  late bool isRotate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    randomSize = randomSine().toDouble();
    likeController = AnimationController(duration: Duration(milliseconds: 15000), vsync: this); //AnimationController
    likeAnimation = CurvedAnimation(parent: likeController, curve: Curves.easeOutCirc);
    likeController.forward();
  }

  @override
  dispose() {
    likeController.dispose(); // you need this
    likeAnimation.dispose(); // you need this
    super.dispose();
  }

  void init() {
    sizex3 = Size(0, 0);
    sizex2 = Size(Random().nextInt(widget.width.toInt()).toDouble(), 0);
    sizex1 = Size(Random().nextInt(widget.width.toInt()).toDouble(), widget.height);
    sizex0 = Size(0, widget.height);

    final randomNumberGenerator = Random();
    isRotate = randomNumberGenerator.nextBool();
  }

  int randomSine() {
    return 48 + Random().nextInt(58 - 48);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //  width: widget.width,
      //  height: widget.height,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: likeAnimation,
            builder: (BuildContext ctx, Widget? child) {
              return Positioned(
                  right: getX(likeAnimation.value),
                  top: getY(likeAnimation.value),
                  child: Opacity(
                    opacity: 1 - likeAnimation.value,
                    child: SizedBox(
                      height: randomSize,
                      width: randomSize,
                      child: Stack(
                        children: [
                          Positioned(left: 7, right: 7, top: 7, bottom: 7, child: widget.child),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Transform.rotate(
                                  angle: math.pi / 180 * (isRotate ? 22 : 348),
                                  child: SvgPicture.asset(
                                    IconPath.likeIcon,
                                    width: randomSize - 26,
                                  ))),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }

  double getX(double ss) {
    double t = ss;
    return (1 - t) * ((1 - t) * sizex0.width + t * sizex1.width) + t * ((1 - t) * sizex1.width + t * sizex2.width);
  }

  double getY(double ss) {
    double t = ss;
    return (1 - t) * ((1 - t) * sizex0.height + t * sizex1.height) + t * ((1 - t) * sizex1.height + t * sizex2.height);
  }
}
