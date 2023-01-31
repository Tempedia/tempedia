import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class ExpandableTabView extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;

  const ExpandableTabView(
      {super.key, required this.tabs, required this.children})
      : assert(tabs.length == children.length);
  @override
  State<StatefulWidget> createState() => _ExpandableTabViewState();
}

class _ExpandableTabViewState extends State<ExpandableTabView>
    with TickerProviderStateMixin {
  late TabController tabController;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: widget.tabs.length, vsync: this);
    tabController.addListener(() {
      // pageController.jumpToPage(tabController.index);
      int currentPage = pageController.page!.toInt();
      if (currentPage > tabController.index + 1) {
        pageController.jumpToPage(tabController.index + 1);
      } else if (currentPage < tabController.index - 1) {
        pageController.jumpToPage(tabController.index - 1);
      }
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          labelColor: Theme.of(context).textTheme.titleMedium?.color,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: tabController,
          isScrollable: true,
          tabs: widget.tabs
              .map((e) => Tab(
                    text: e,
                    height: 30,
                  ))
              .toList(),
        ),
        ExpandablePageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.children,
        ),
      ],
    );
  }
}
