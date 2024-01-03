import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/nuuz_talk/providers/review/reviews_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_result_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_image_container.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

import '../../ui/indicator/indicator.dart';

Future<T?> showReviewSearchPage<T>({
  required BuildContext context,
  required SearchDelegate<T> delegate,
  String? query = '',
  bool useRootNavigator = false,
}) {
  delegate.query = query ?? delegate.query;
  delegate._currentBody = _SearchBody.suggestions;
  return Navigator.of(context, rootNavigator: useRootNavigator).push(_SearchPageRoute<T>(
    delegate: delegate,
  ));
}

class CustomSearchDelegate extends SearchDelegate {
  final Function onTapItem;

  CustomSearchDelegate({required this.onTapItem});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: context.pop,
        icon: Icon(
          CupertinoIcons.clear,
          color: CustomColor.dark,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _renderQueryResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _renderQueryResult();
  }

  Widget _renderQueryResult() {
    return Consumer(
      builder: (context, ref, child) {
        final reviewList = ref.watch(resultProvider);
        return reviewList.when(
          data: (data) {
            final result = data.where((element) {
              return (element.program?.care_program_name ?? '').toLowerCase().contains(_queryTextController.text);
            });
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: result.isNotEmpty
                  ? Column(
                      children: data
                          .where((element) {
                            // print(element.program!.care_program_name);
                            return (element.program?.care_program_name ?? '').toLowerCase().contains(_queryTextController.text);
                          })
                          .map((e) => Column(
                                children: [
                                  NuuzContainer(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            onTapItem(e);
                                          },
                                          child: CareProgramResultListItem(
                                              name: (e.program?.care_program_name ?? '').tr(),
                                              description: (e.program?.description ?? '').tr(),
                                              imageUrl: e.result_image,
                                              date: e.date ?? DateTime.now().toString()),
                                          // child: SizedBox(
                                          //   height: 120.h,
                                          //   child: Row(
                                          //     children: [
                                          //       wSize(10),
                                          //       Container(
                                          //         width: 96.w,
                                          //         height: 96.h,
                                          //         decoration: BoxDecoration(
                                          //           borderRadius: const BorderRadius.all(Radius.circular(9)),
                                          //           color: CustomColor.lightGray,
                                          //           border: Border.all(color: Colors.black.withOpacity(0.25)),
                                          //         ),
                                          //         child: e.result_image != null ? Image.network(e.result_image!) : const Placeholder(),
                                          //       ),
                                          //       wSize(14),
                                          //       Expanded(
                                          //         child: Column(
                                          //           crossAxisAlignment: CrossAxisAlignment.start,
                                          //           children: [
                                          //             hSize(14),
                                          //             SmallHeaderText(text: e.program!.care_program_name!.tr()),
                                          //             hSize(10),
                                          //             SizedBox(
                                          //               width: 205.w,
                                          //               height: 32.h,
                                          //               child: Text(
                                          //                 (e.program!.description ?? "").tr(),
                                          //                 maxLines: 2,
                                          //                 overflow: TextOverflow.ellipsis,
                                          //               ),
                                          //             ),
                                          //             hSize(15),
                                          //             SizedBox(width: 48.w, child: Image.asset(IconPath.programLogo)),
                                          //           ],
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ))
                          .toList(),
                    )
                  : NuuzContainer(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 22.h),
                        child: Column(
                          children: [
                            SvgPicture.asset(IconPath.noData),
                            hSize(12),
                            Text(
                              "Talk_Serc_0002".tr(),
                              style: CustomTextStyle.descriptionM,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
          error: (error, stackTrace) => Text('Some error occured'),
          loading: () => Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: CustomIndicator('Comm_Gene_0001'.tr())),
        );
      },
    );
  }

  @override
  String? get searchFieldLabel => "search or add your own";
}

abstract class SearchDelegate<T> {
  SearchDelegate({
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.searchFieldDecorationTheme,
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  }) : assert(searchFieldStyle == null || searchFieldDecorationTheme == null);

  Widget buildSuggestions(BuildContext context);

  Widget buildResults(BuildContext context);

  Widget? buildLeading(BuildContext context);

  List<Widget>? buildActions(BuildContext context);

  // PreferredSizeWidget? buildBottom(BuildContext context) => null;
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        toolbarTextStyle: theme.textTheme.bodyText2,
        titleTextStyle: theme.textTheme.headline6,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  String get query => _queryTextController.text;

  set query(String value) {
    _queryTextController.text = value;
    if (_queryTextController.text.isNotEmpty) {
      _queryTextController.selection = TextSelection.fromPosition(TextPosition(offset: _queryTextController.text.length));
    }
  }

  void showResults(BuildContext context) {
    _focusNode?.unfocus();
    _currentBody = _SearchBody.results;
  }

  void showSuggestions(BuildContext context) {
    assert(_focusNode != null, '_focusNode must be set by route before showSuggestions is called.');
    _focusNode?.requestFocus();
    _currentBody = _SearchBody.suggestions;
  }

  void close(BuildContext context, T result) {
    _currentBody = null;
    _focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  final String? searchFieldLabel;
  final TextStyle? searchFieldStyle;
  final InputDecorationTheme? searchFieldDecorationTheme;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => _proxyAnimation;

  // The focus node to use for manipulating focus on the search page. This is
  // managed, owned, and set by the _SearchPageRoute using this delegate.
  FocusNode? _focusNode;

  final TextEditingController _queryTextController = TextEditingController();

  final ProxyAnimation _proxyAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  final ValueNotifier<_SearchBody?> _currentBodyNotifier = ValueNotifier<_SearchBody?>(null);

  _SearchBody? get _currentBody => _currentBodyNotifier.value;

  set _currentBody(_SearchBody? value) {
    _currentBodyNotifier.value = value;
  }

  _SearchPageRoute<T>? _route;
}

enum _SearchBody {
  suggestions,
  results,
}

class _SearchPageRoute<T> extends PageRoute<T> {
  _SearchPageRoute({
    required this.delegate,
  }) {
    assert(
      delegate._route == null,
      'The ${delegate.runtimeType} instance is currently used by another active '
      'search. Please close that search by calling close() on the SearchDelegate '
      'before opening another search with the same delegate instance.',
    );
    delegate._route = this;
  }

  final SearchDelegate<T> delegate;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate._proxyAnimation.parent = animation;
    return animation;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _SearchPage<T>(
      delegate: delegate,
      animation: animation,
    );
  }

  @override
  void didComplete(T? result) {
    super.didComplete(result);
    assert(delegate._route == this);
    delegate._route = null;
    delegate._currentBody = null;
  }
}

class _SearchPage<T> extends StatefulWidget {
  const _SearchPage({
    required this.delegate,
    required this.animation,
  });

  final SearchDelegate<T> delegate;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => _SearchPageState<T>();
}

class _SearchPageState<T> extends State<_SearchPage<T>> {
  // This node is owned, but not hosted by, the search page. Hosting is done by
  // the text field.
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.delegate._queryTextController.addListener(_onQueryChanged);
    widget.animation.addStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
    focusNode.addListener(_onFocusChanged);
    widget.delegate._focusNode = focusNode;
  }

  @override
  void dispose() {
    super.dispose();
    widget.delegate._queryTextController.removeListener(_onQueryChanged);
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    widget.delegate._currentBodyNotifier.removeListener(_onSearchBodyChanged);
    widget.delegate._focusNode = null;
    focusNode.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    if (widget.delegate._currentBody == _SearchBody.suggestions) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(_SearchPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate) {
      oldWidget.delegate._queryTextController.removeListener(_onQueryChanged);
      widget.delegate._queryTextController.addListener(_onQueryChanged);
      oldWidget.delegate._currentBodyNotifier.removeListener(_onSearchBodyChanged);
      widget.delegate._currentBodyNotifier.addListener(_onSearchBodyChanged);
      oldWidget.delegate._focusNode = null;
      widget.delegate._focusNode = focusNode;
    }
  }

  void _onFocusChanged() {
    if (focusNode.hasFocus && widget.delegate._currentBody != _SearchBody.suggestions) {
      widget.delegate.showSuggestions(context);
    }
  }

  void _onQueryChanged() {
    setState(() {
      // rebuild ourselves because query changed.
    });
  }

  void _onSearchBodyChanged() {
    setState(() {
      // rebuild ourselves because search body changed.
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = widget.delegate.appBarTheme(context);
    final String searchFieldLabel = widget.delegate.searchFieldLabel ?? MaterialLocalizations.of(context).searchFieldLabel;
    Widget? body;
    switch (widget.delegate._currentBody) {
      case _SearchBody.suggestions:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.suggestions),
          child: widget.delegate.buildSuggestions(context),
        );
        break;
      case _SearchBody.results:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.results),
          child: widget.delegate.buildResults(context),
        );
        break;
      case null:
        break;
    }

    late final String routeName;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        routeName = searchFieldLabel;
    }

    return Semantics(
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      label: routeName,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.h),
          child: AppBar(
            elevation: 0,
            leading: widget.delegate.buildLeading(context),
            title: Text('Talk_Serc_0005'.tr(), style: CustomTextStyle.headerL),
            centerTitle: true,
            actions: widget.delegate.buildActions(context),
            // bottom: widget.delegate.buildBottom(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 50.h,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //     child: TextField(
              //       cursorColor: CustomColor.primary,
              //       controller: widget.delegate._queryTextController,
              //       focusNode: focusNode,
              //       style: widget.delegate.searchFieldStyle ?? theme.textTheme.headline6,
              //       textInputAction: widget.delegate.textInputAction,
              //       keyboardType: widget.delegate.keyboardType,
              //       onSubmitted: (String _) {
              //         widget.delegate.showResults(context);
              //       },
              //       decoration: InputDecoration(
              //         hintText: 'Talk_Serc_0001'.tr(),
              //         hintStyle: CustomTextStyle.descriptionL,
              //         filled: true,
              //         fillColor: CustomColor.darkWhite,
              //         suffixIcon: Icon(
              //           CupertinoIcons.search,
              //           color: CustomColor.dark,
              //         ),
              //
              //         border: MaterialStateOutlineInputBorder.resolveWith((_) => OutlineInputBorder(
              //             borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(13))),
              //         // border: OutlineInputBorder(
              //
              //         //     borderSide: BorderSide(color: CustomColor.dark),
              //         //     borderRadius: BorderRadius.circular(13)),
              //         // hintText: searchFieldLabel,
              //       ),
              //     ),
              //   ),
              // ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
