import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';

import 'widgets/nav_hover_box.dart';

const double _navMinWidth = 60;
const double _navMaxWidth = 280;

const double _leadingMargin = 6;

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectIndex,
    required this.navItems,
    required this.onItemTap,
    required this.onSettingItemTap,
    required this.onDelItemTap,
    required this.onEditItemTap,
    required this.onAddItemTap,
  });

  final int selectIndex;
  final List<GameInfoEntity> navItems;
  final Function(int index) onItemTap;
  final Function(GameInfoEntity info) onEditItemTap;
  final Function(GameInfoEntity info) onDelItemTap;
  final Function() onSettingItemTap;
  final Function() onAddItemTap;

  @override
  Widget build(BuildContext context) {
    return NavHoverBox(
      minWidth: _navMinWidth,
      maxWidth: _navMaxWidth,
      childBuilder: (double value) {
        final double navMinWidth = _navMinWidth + (value * _navMinWidth * 0.15);

        return Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: navItems.length + 1,
                  itemBuilder: (_, int index) {
                    if (index == navItems.length) {
                      return _buildAddItem(context, navMinWidth);
                    }

                    return _buildItem(context, index, navItems[index], navMinWidth);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              ),
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
    return _buildBasicItem(
      context,
      item.title,
      AppImg.cover(url: item.icon, width: 26, height: 26, radius: 4),
      navMinWidth,
      isSelected: selectIndex == index,
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
      onTap: onTap ?? () => onItemTap(index),
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
                height: isSelected ? (_navMinWidth - _leadingMargin * 2) / 2.5 : 0,
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
                    width: _navMaxWidth + _leadingMargin * 2 - _navMinWidth * (trailings.length + 1),
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
