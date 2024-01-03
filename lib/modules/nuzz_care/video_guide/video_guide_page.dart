import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/center_play_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/modules/nuzz_care/video_guide/video_progress_bar.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common_widget/common_scroll_view.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:video_player/video_player.dart';

final myProvider = Provider(
  (ref) => PlayerNotifier.init(),
);
bool isFullScreenView = false;

class VideoGuidePage extends StatefulWidget {
  const VideoGuidePage({super.key, required this.url, required this.content, required this.header, required this.counter});

  final String url;
  final String content;
  final String header;
  final int counter;

  @override
  State<VideoGuidePage> createState() => _VideoGuidePageState();
}

class _VideoGuidePageState extends State<VideoGuidePage> {
  late final VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlay();
  }

  _videoPlay() async {
    _videoPlayerController = VideoPlayerController.network(
      widget.url,
    );

    await Future.wait([_videoPlayerController.initialize()]);

    safePrint("_videoPlayerController.value.aspectRatio= _videoPlay==>${_videoPlayerController.value.aspectRatio}");
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          showOptions: true,
          autoPlay: true,
          showControlsOnInitialize: true,
          allowFullScreen: false,
          //
          // materialProgressColors: ChewieProgressColors(backgroundColor: CustomColor.white, playedColor: CustomColor.primary,bufferedColor:CustomColor.primary,
          //   handleColor: Colors.red
          //
          // )
          customControls: CommonControls(
            backgroundColor: CustomColor.white,
            iconColor: CustomColor.primary,
          ));
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    safePrint("_videoPlayerController.value.aspectRatio===>${_videoPlayerController.value.aspectRatio}");
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(controller: _chewieController!),
                )
              : AspectRatio(
                  aspectRatio: 1.7777777777777777,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: CustomColor.primary,
                      ),
                      const SizedBox(height: 20),
                      const Text('Loading'),
                    ],
                  ),
                ),
        ),
        Flexible(
          flex: 5,
          child: NuuzContainer(
            containerColor: CustomColor.whiteVariant1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(
                        widget.header.tr(),
                        style: CustomTextStyle.headerM,
                      ),
                    ],
                  ),
                  Flexible(
                    child: CommonScrollView(text: widget.content),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CommonControls extends StatefulWidget {
  const CommonControls({
    required this.backgroundColor,
    required this.iconColor,
    this.showPlayButton = true,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final Color iconColor;
  final bool showPlayButton;

  @override
  State<StatefulWidget> createState() {
    return _CommonControlsState();
  }
}

class _CommonControlsState extends State<CommonControls> with SingleTickerProviderStateMixin {
  late PlayerNotifier notifier;
  late VideoPlayerValue _latestValue;
  Timer? _hideTimer;
  final marginSize = 5.0;
  Timer? _expandCollapseTimer;
  Timer? _initTimer;
  bool _dragging = false;
  Duration? _subtitlesPosition;
  bool _subtitleOn = false;
  Timer? _bufferingDisplayTimer;
  bool _displayBufferingIndicator = false;

  late VideoPlayerController controller;

  // We know that _chewieController is set in didChangeDependencies
  ChewieController get chewieController => _chewieController!;
  ChewieController? _chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   // notifier = Provider<PlayerNotifier>((ref) => ref.read(myProvider)),)
  //   // notifier = Provider.of<PlayerNotifier>(context, listen: false);
  // }

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder != null
          ? chewieController.errorBuilder!(
              context,
              chewieController.videoPlayerController.value.errorDescription!,
            )
          : const Center(
              child: Icon(
                CupertinoIcons.exclamationmark_circle,
                color: Colors.white,
                size: 42,
              ),
            );
    }

    final backgroundColor = widget.backgroundColor;
    final iconColor = widget.iconColor;
    final orientation = MediaQuery.of(context).orientation;
    final barHeight = orientation == Orientation.portrait ? 20.0 : 47.0;
    final buttonPadding = orientation == Orientation.portrait ? 0.0 : 24.0;

    return Consumer(builder: (context, ref, child) {
      notifier = ref.read<PlayerNotifier>(myProvider);
      return MouseRegion(
        onHover: (_) => _cancelAndRestartTimer(),
        child: GestureDetector(
          onTap: () => _cancelAndRestartTimer(),
          child: AbsorbPointer(
            absorbing: notifier.hideStuff,
            child: Stack(
              children: [
                if (_displayBufferingIndicator)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  _buildHitArea(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTopBar(
                      backgroundColor,
                      iconColor,
                      barHeight,
                      buttonPadding,
                    ),
                    const Spacer(),
                    if (_subtitleOn)
                      Transform.translate(
                        offset: Offset(
                          0.0,
                          notifier.hideStuff ? barHeight * 0.8 : 0.0,
                        ),
                        child: _buildSubtitles(chewieController.subtitle!),
                      ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  child: _buildBottomBar(backgroundColor, iconColor, barHeight),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _expandCollapseTimer?.cancel();
    _initTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final oldController = _chewieController;
    _chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    if (oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  Widget _buildSubtitles(Subtitles subtitles) {
    if (!_subtitleOn) {
      return const SizedBox();
    }
    if (_subtitlesPosition == null) {
      return const SizedBox();
    }
    final currentSubtitle = subtitles.getByPosition(_subtitlesPosition!);
    if (currentSubtitle.isEmpty) {
      return const SizedBox();
    }

    if (chewieController.subtitleBuilder != null) {
      return chewieController.subtitleBuilder!(
        context,
        currentSubtitle.first!.text,
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: marginSize, right: marginSize),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0x96000000),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          currentSubtitle.first!.text.toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
  ) {
    return SafeArea(
      bottom: chewieController.isFullScreen,
      minimum: chewieController.controlsSafeAreaMinimum,
      child: AnimatedOpacity(
        // opacity: notifier.hideStuff ? 0.0 : 1.0,
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(marginSize),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(height: barHeight, child: _buildProgressBar()),
          ),
        ),
      ),
    );
  }

  Widget _buildHitArea() {
    final bool isFinished = _latestValue.position >= _latestValue.duration;
    final bool showPlayButton = widget.showPlayButton && !_latestValue.isPlaying && !_dragging;

    return GestureDetector(
      onTap: _latestValue.isPlaying
          ? _cancelAndRestartTimer
          : () {
              _hideTimer?.cancel();

              setState(() {
                notifier.hideStuff = false;
              });
            },
      child: CenterPlayButton(
        backgroundColor: widget.backgroundColor,
        iconColor: widget.iconColor,
        isFinished: isFinished,
        isPlaying: controller.value.isPlaying,
        show: showPlayButton,
        onPressed: _playPause,
      ),
    );
  }

  Widget _buildTopBar(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
    double buttonPadding,
  ) {
    final bool isFinished = _latestValue.position >= _latestValue.duration;
    final bool showPlayButton = widget.showPlayButton && !_latestValue.isPlaying && !_dragging;
    return InkWell(
      onTap: () {
        safePrint("_buildTopBar====>");

        setState(() {
          chewieController.toggleFullScreen();
          isFullScreenView = !isFullScreenView;
          safePrint("_buildTopBar====>$isFullScreenView");
        });
      },
      child: Container(
        height: barHeight,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          top: marginSize,
          right: marginSize,
          left: marginSize,
        ),
        child: Icon(
          isFullScreenView ? Icons.fullscreen_exit_outlined : Icons.fullscreen,
          color: widget.backgroundColor,
          size: isFullScreenView ? 50.h : 30.h,
        ),
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();

    setState(() {
      notifier.hideStuff = false;

      _startHideTimer();
    });
  }

  Future<void> _initialize() async {
    _subtitleOn = chewieController.subtitle?.isNotEmpty ?? false;
    controller.addListener(_updateState);

    _updateState();

    if (controller.value.isPlaying || chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          notifier.hideStuff = false;
        });
      });
    }
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: CommonProgressBar(
        controller,
        onDragStart: () {
          setState(() {
            _dragging = true;
          });

          _hideTimer?.cancel();
        },
        onDragEnd: () {
          setState(() {
            _dragging = false;
          });

          _startHideTimer();
        },
        colors: chewieController.cupertinoProgressColors ??
            ChewieProgressColors(
              playedColor: const Color.fromARGB(
                120,
                255,
                255,
                255,
              ),
              handleColor: const Color.fromARGB(
                255,
                255,
                255,
                255,
              ),
              bufferedColor: const Color.fromARGB(
                60,
                255,
                255,
                255,
              ),
              backgroundColor: const Color.fromARGB(
                20,
                255,
                255,
                255,
              ),
            ),
      ),
    );
  }

  void _playPause() {
    final isFinished = _latestValue.position >= _latestValue.duration;

    setState(() {
      if (controller.value.isPlaying) {
        notifier.hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.isInitialized) {
          controller.initialize().then((_) {
            controller.play();
          });
        } else {
          if (isFinished) {
            controller.seekTo(Duration.zero);
          }
          controller.play();
        }
      }
    });
  }

  void _startHideTimer() {
    final hideControlsTimer =
        chewieController.hideControlsTimer.isNegative ? ChewieController.defaultHideControlsTimer : chewieController.hideControlsTimer;
    _hideTimer = Timer(hideControlsTimer, () {
      setState(() {
        notifier.hideStuff = true;
      });
    });
  }

  void _bufferingTimerTimeout() {
    _displayBufferingIndicator = true;
    if (mounted) {
      setState(() {});
    }
  }

  void _updateState() {
    if (!mounted) return;

    // display the progress bar indicator only after the buffering delay if it has been set
    if (chewieController.progressIndicatorDelay != null) {
      if (controller.value.isBuffering) {
        _bufferingDisplayTimer ??= Timer(
          chewieController.progressIndicatorDelay!,
          _bufferingTimerTimeout,
        );
      } else {
        _bufferingDisplayTimer?.cancel();
        _bufferingDisplayTimer = null;
        _displayBufferingIndicator = false;
      }
    } else {
      _displayBufferingIndicator = controller.value.isBuffering;
    }

    setState(() {
      _latestValue = controller.value;
      _subtitlesPosition = controller.value.position;
    });
  }
}

class PlayerNotifier extends ChangeNotifier {
  PlayerNotifier._(
    bool hideStuff,
  ) : _hideStuff = hideStuff;

  bool _hideStuff;

  bool get hideStuff => _hideStuff;

  set hideStuff(bool value) {
    _hideStuff = value;
    notifyListeners();
  }

  // ignore: prefer_constructors_over_static_methods
  static PlayerNotifier init() {
    return PlayerNotifier._(
      true,
    );
  }
}

class CommonProgressBar extends StatelessWidget {
  CommonProgressBar(
    this.controller, {
    ChewieProgressColors? colors,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    Key? key,
  })  : colors = colors ?? ChewieProgressColors(),
        super(key: key);

  final VideoPlayerController controller;
  final ChewieProgressColors colors;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;

  @override
  Widget build(BuildContext context) {
    return VideoProgressBar(
      controller,
      barHeight: 5,
      handleHeight: 12,
      drawShadow: false,
      colors: colors,
      onDragEnd: onDragEnd,
      onDragStart: onDragStart,
      onDragUpdate: onDragUpdate,
    );
  }
}
