import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';
import 'package:hoyo_launcher/presentation/widgets/smooth_scroll_view.dart';

import 'widgets/nav_hover_box.dart';
import 'widgets/tap_box.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectItem,
    required this.navItems,
    required this.onItemTap,
    required this.onSettingItemTap,
    required this.onDelItemTap,
    required this.onEditItemTap,
    required this.onAddItemTap,
    required this.onReorder,
    this.onNavHover,
  });

  static const double navBarMinWidth = 60;
  static const double navBarMaxWidth = 280;
  static const double _leadingMargin = 6;

  final GameInfoEntity? selectItem;
  final List<GameInfoEntity> navItems;
  final Function(GameInfoEntity info) onItemTap;
  final Function(GameInfoEntity info) onEditItemTap;
  final Function(GameInfoEntity info) onDelItemTap;
  final Function() onSettingItemTap;
  final Function() onAddItemTap;

  final Function(double animationValue)? onNavHover;
  final Function(int fromIndex, int toIndex) onReorder;

  fu.FluentThemeData _fluentTheme(BuildContext context) => fu.FluentTheme.of(context);

  @override
  Widget build(BuildContext context) {
    return NavHoverBox(
      minWidth: navBarMinWidth,
      maxWidth: navBarMaxWidth,
      childBuilder: (NavHoverController navHoverController) {
        onNavHover?.call(navHoverController.width);

        final double navMinWidth = navBarMinWidth + (navHoverController.value * navBarMinWidth * 0.15);

        final bool showMore = navHoverController.value > 0;

        return Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SmoothScrollView.provider(
                  builder: (_, ScrollController controller) {
                    return ReorderableListView.builder(
                      scrollController: controller,
                      onReorder: onReorder,
                      onReorderStart: (_) => navHoverController.onEnter(),
                      onReorderEnd: (_) => navHoverController.onExit(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: navItems.length,
                      buildDefaultDragHandles: false,
                      itemBuilder: (_, int index) => _buildItem(context, index, navItems[index], navMinWidth, showMore),
                      proxyDecorator: (Widget child, int index, __) =>
                          _buildItem(context, index, navItems[index], navMinWidth, false),
                      footer: _buildAddItem(context, navMinWidth, showMore),
                    );
                  },
                ),
              ),
              _buildSettingItem(context, navMinWidth, showMore),
              const SizedBox(height: _leadingMargin / 2),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    GameInfoEntity item,
    double navMinWidth,
    bool showMore,
  ) {
    return KeyedSubtree(
      key: ValueKey<String>(item.id),
      child: _buildBasicItem(
        context,
        item.title,
        AppImg.cover(url: item.icon, width: 26, height: 26, radius: 4),
        navMinWidth,
        showMore,
        isSelected: selectItem == item,
        index: index,
        trailings: <Widget>[
          IconButton(
            onPressed: () => onEditItemTap(item),
            icon: const Icon(fu.FluentIcons.edit, size: 12),
          ),
          IconButton(
            onPressed: () => onDelItemTap(item),
            icon: const Icon(fu.FluentIcons.delete, size: 12),
          ),
        ],
        iconPadding: const EdgeInsets.all(_leadingMargin * 2),
      ),
    );
  }

  Widget _buildAddItem(BuildContext context, double navMinWidth, bool showMore) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
          context,
          l10n.create_info,
          const Icon(fu.FluentIcons.add),
          navMinWidth,
          showMore,
          isSelected: isHover,
          hasIndicator: false,
          onTap: onAddItemTap,
        );
      },
    );
  }

  Widget _buildSettingItem(BuildContext context, double navMinWidth, bool showMore) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
          context,
          l10n.settings,
          const Icon(fu.FluentIcons.settings),
          navMinWidth,
          showMore,
          isSelected: isHover,
          hasIndicator: false,
          onTap: onSettingItemTap,
        );
      },
    );
  }

  Widget _buildBasicItem(
    BuildContext context,
    String title,
    Widget icon,
    double navMinWidth,
    bool showMore, {
    required bool isSelected,
    int index = -1,
    bool hasIndicator = true,
    List<Widget> trailings = const <Widget>[],
    EdgeInsetsGeometry? iconPadding,
    Function()? onTap,
  }) {
    final double leadingSize = navMinWidth - _leadingMargin * 2;

    final fu.FluentThemeData fluentTheme = _fluentTheme(context);

    final Color navColor = fluentTheme.navigationPaneTheme.backgroundColor!.withOpacity(0.4);
    final Color indicatorColor = fluentTheme.accentColor;

    final double textWidth = navBarMaxWidth - navMinWidth - kMinInteractiveDimension * trailings.length;

    const double minLeadingSize = navBarMinWidth - _leadingMargin * 2;

    final Widget iconWidget = ReorderableDelayedDragStartListener(
      index: index,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(width: leadingSize, height: leadingSize, padding: iconPadding, child: icon),
          if (hasIndicator)
            AnimatedContainer(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              width: 3,
              height: isSelected ? (navBarMinWidth - _leadingMargin * 2) / 2.5 : 0,
              decoration: BoxDecoration(color: indicatorColor, borderRadius: BorderRadius.circular(4)),
            ),
        ],
      ),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: TapBox(
        onTap: onTap ?? () => onItemTap(navItems[index]),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: _leadingMargin, vertical: _leadingMargin / 2),
          width: showMore ? null : minLeadingSize,
          height: showMore ? leadingSize : minLeadingSize,
          decoration: BoxDecoration(
            color: isSelected ? navColor : navColor.withOpacity(0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: showMore
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      iconWidget,
                      const SizedBox(width: _leadingMargin),
                      SizedBox(width: textWidth, child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      if (trailings.isNotEmpty) const SizedBox(width: _leadingMargin),
                      if (trailings.isNotEmpty) ...trailings,
                      const SizedBox(width: _leadingMargin),
                    ],
                  ),
                )
              : iconWidget,
        ),
      ),
    );
  }
}
