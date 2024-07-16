import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class BasePage extends StatelessWidget {
  final List<Widget> children;
  final Widget slidingUpPanelWidget;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;
  final Color backgroundColor;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  Widget buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            const SizedBox(
              height: 30,
            ),
            ...children
          ],
        ),
      ),
    );
  }

  const BasePage({
    super.key,
    required this.children,
    this.slidingUpPanelWidget = const SizedBox.shrink(),
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.all(15),
    this.backgroundColor = palette.bgColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: buildBody(),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        ),
        slidingUpPanelWidget,
      ],
    );
  }
}

class BasePageWithScroll extends BasePage {
  const BasePageWithScroll({
    super.key,
    required super.children,
    super.slidingUpPanelWidget,
    super.appBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.padding,
    super.backgroundColor,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
  });

  @override
  Widget buildBody() {
    return SingleChildScrollView(
      child: super.buildBody(),
    );
  }
}
