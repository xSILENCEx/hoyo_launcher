import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';
import 'package:reorderables/reorderables.dart';

import 'widgets/nav_hover_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return NavHoverBox(
      minWidth: navBarMinWidth,
      maxWidth: navBarMaxWidth,
      childBuilder: (double value, double width) {
        onNavHover?.call(width);

        final double navMinWidth = navBarMinWidth + (value * navBarMinWidth * 0.15);

        return Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ReorderableColumn(
                onReorder: (int oldIndex, int newIndex) {
                  print('onReorder oldIndex = $oldIndex, newIndex = $newIndex');
                },
                needsLongPressDraggable: false,
                padding: EdgeInsets.zero,
                buildDraggableFeedback: (_, __, Widget child) => child,
                draggedItemBuilder: (_, int index) => _buildItem(context, index, navItems[index], navMinWidth),
                children: List<Widget>.generate(
                  navItems.length,
                  (int i) => _buildItem(context, i, navItems[i], navMinWidth),
                ),
              ),
              _buildAddItem(context, navMinWidth),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: _buildSettingItem(context, navMinWidth),
              ),
              const SizedBox(height: _leadingMargin),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, int index, GameInfoEntity item, double navMinWidth) {
    return KeyedSubtree(
      key: ValueKey<String>(item.id),
      child: _buildBasicItem(
        context,
        item.title,
        AppImg.cover(url: item.icon, width: 26, height: 26, radius: 4),
        navMinWidth,
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

  Widget _buildAddItem(BuildContext context, double navMinWidth) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
          context,
          l10n.create_info,
          const Icon(fu.FluentIcons.add),
          navMinWidth,
          isSelected: isHover,
          hasIndicator: false,
          onTap: onAddItemTap,
          iconPadding: const EdgeInsets.all(_leadingMargin * 2),
        );
      },
    );
  }

  Widget _buildSettingItem(BuildContext context, double navMinWidth) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
          context,
          l10n.settings,
          const Icon(fu.FluentIcons.settings),
          navMinWidth,
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
    double navMinWidth, {
    required bool isSelected,
    int index = -1,
    bool hasIndicator = true,
    List<Widget> trailings = const <Widget>[],
    EdgeInsetsGeometry? iconPadding,
    Function()? onTap,
  }) {
    final double leadingSize = navMinWidth - _leadingMargin * 2;

    final fu.FluentThemeData fluentTheme = fu.FluentTheme.of(context);

    final Color navColor = fluentTheme.navigationPaneTheme.backgroundColor!.withOpacity(0.4);
    final Color indicatorColor = fluentTheme.accentColor;

    return GestureDetector(
      onTap: onTap ?? () => onItemTap(navItems[index]),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _leadingMargin),
        height: leadingSize,
        decoration: BoxDecoration(
          color: isSelected ? navColor : navColor.withOpacity(0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            if (hasIndicator)
              AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                width: 3,
                height: isSelected ? (navBarMinWidth - _leadingMargin * 2) / 2.5 : 0,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: <Widget>[
                  Container(width: leadingSize, height: leadingSize, padding: iconPadding, child: icon),
                  const SizedBox(width: _leadingMargin),
                  SizedBox(
                    width: navBarMaxWidth + _leadingMargin * 2 - navBarMinWidth * (trailings.length + 1),
                    child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (trailings.isNotEmpty) const SizedBox(width: _leadingMargin),
                  if (trailings.isNotEmpty) ...trailings,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
