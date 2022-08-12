import 'package:flutter/material.dart';

import 'breakpoint.dart';
import 'breakpoints.dart';

enum AdaptiveScaffoldFeature {
  navigationRail,
  bottomNavigationBar,
}

class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({
    Key? key,
    this.showNavigation = true,
    required this.destinations,
    required this.selectedDestination,
    required this.onDestinationSelected,
    required this.appBar,
    required this.body,
  }) : super(key: key);

  final bool showNavigation;
  final List<NavigationDestination> destinations;
  final NavigationDestination selectedDestination;
  final ValueChanged<NavigationDestination> onDestinationSelected;
  final PreferredSizeWidget appBar;
  final Widget body;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();

  static Set<AdaptiveScaffoldFeature> featuresFor(BuildContext context) {
    final _InheritedAdaptiveFeatures? inherited = context
        .dependOnInheritedWidgetOfExactType<_InheritedAdaptiveFeatures>();
    return inherited?.features ?? {};
  }
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold>
    with SingleTickerProviderStateMixin {
  Widget _buildWithNav(BuildContext context) {
    bool showNavRail;
    final Breakpoint breakpoint = BreakpointLayout.breakpointFor(context);
    switch (breakpoint) {
      case DesktopLargeBreakpoint():
        showNavRail = true;
        break;
      case DesktopSmallBreakpoint():
      default:
        showNavRail = false;
        break;
    }

    const double railWidth = 72;
    const double bottomNavHeight = kBottomNavigationBarHeight;
    final int selectedIndex =
        widget.destinations.indexOf(widget.selectedDestination);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
        elevation: 0,
        title: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                        child: Text("Today's news",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(62, 61, 63, 0.9)))),
                    Row(
                      children: [
                        const Text(
                          "70° F",
                          style:
                              TextStyle(color: Color.fromRGBO(62, 61, 63, 0.9)),
                        ),
                        Container(
                            child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.sunny,
                            size: 30,
                            color: Color.fromARGB(177, 198, 188, 78),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(4, 0, 0, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text("Saturday, June 23",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromRGBO(62, 61, 63, 0.9)))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: showNavRail ? railWidth : 0,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.centerRight,
                minWidth: railWidth,
                maxWidth: railWidth,
                child: NavigationRail(
                  backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                  destinations:
                      widget.destinations.map(_toRailDestination).toList(),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    widget.onDestinationSelected(widget.destinations[index]);
                  },
                ),
              ),
            ),
          ),
          _InheritedAdaptiveFeatures(
            features: {
              showNavRail
                  ? AdaptiveScaffoldFeature.navigationRail
                  : AdaptiveScaffoldFeature.bottomNavigationBar
            },
            child: Expanded(child: widget.body),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: showNavRail ? 0 : bottomNavHeight,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.topCenter,
            minHeight: bottomNavHeight,
            maxHeight: bottomNavHeight,
            child: BottomNavigationBar(
              backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
              items: widget.destinations.map(_toBottomNavItem).toList(),
              currentIndex: selectedIndex,
              showUnselectedLabels: true,
              onTap: (int index) {
                widget.onDestinationSelected(widget.destinations[index]);
              },
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithoutNav(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widget.appBar,
      body: widget.body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.showNavigation
        ? _buildWithNav(context)
        : _buildWithoutNav(context);
  }
}

class _InheritedAdaptiveFeatures extends InheritedWidget {
  const _InheritedAdaptiveFeatures({
    Key? key,
    required this.features,
    required Widget child,
  }) : super(key: key, child: child);

  final Set<AdaptiveScaffoldFeature> features;

  @override
  bool updateShouldNotify(_InheritedAdaptiveFeatures oldWidget) {
    return features != oldWidget.features;
  }
}

NavigationRailDestination _toRailDestination(
    NavigationDestination destination) {
  return NavigationRailDestination(
    label: Text(destination.label),
    icon: destination.icon,
  );
}

BottomNavigationBarItem _toBottomNavItem(NavigationDestination destination) {
  return BottomNavigationBarItem(
    label: destination.label,
    icon: destination.icon,
  );
}
