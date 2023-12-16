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

final Color _navColor = Colors.grey[800]!;

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectIndex,
    required this.navItems,
    required this.onItemTap,
    required this.onSettingItemTap,
    required this.onEditItemTap,
    required this.onAddItemTap,
  });

  final int selectIndex;
  final List<GameInfoEntity> navItems;
  final Function(int index) onItemTap;
  final Function(GameInfoEntity info) onEditItemTap;
  final Function() onSettingItemTap;
  final Function() onAddItemTap;

  @override
  Widget build(BuildContext context) {
    return NavHoverBox(
      minWidth: _navMinWidth,
      maxWidth: _navMaxWidth,
      childBuilder: (double value) {
        final double navMinWidth = _navMinWidth + (value * _navMinWidth * 0.2);

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
                      return _buildAddItem(navMinWidth);
                    }

                    return _buildItem(index, navItems[index], navMinWidth);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: _buildSettingItem(navMinWidth),
              ),
              const SizedBox(height: _leadingMargin),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(int index, GameInfoEntity item, double navMinWidth) {
    return _buildBasicItem(
      item.title,
      AppImg.cover(url: item.icon, width: 26, height: 26, radius: 4),
      navMinWidth,
      isSelected: selectIndex == index,
      index: index,
      trailing: IconButton(
        onPressed: () => onEditItemTap(item),
        icon: const Icon(fu.FluentIcons.settings),
      ),
      iconPadding: const EdgeInsets.all(_leadingMargin * 2),
    );
  }

  Widget _buildAddItem(double navMinWidth) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
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

  Widget _buildSettingItem(double navMinWidth) {
    return HoverBuilder(
      builder: (bool isHover) {
        return _buildBasicItem(
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
    String title,
    Widget icon,
    double navMinWidth, {
    required bool isSelected,
    int index = -1,
    bool hasIndicator = true,
    Widget? trailing,
    EdgeInsetsGeometry? iconPadding,
    Function()? onTap,
  }) {
    final double leadingSize = navMinWidth - _leadingMargin * 2;

    return GestureDetector(
      onTap: onTap ?? () => onItemTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _leadingMargin),
        height: leadingSize,
        decoration: BoxDecoration(
          color: isSelected ? _navColor : _navColor.withOpacity(0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            if (hasIndicator)
              AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 300),
                width: 3,
                height: isSelected ? (_navMinWidth - _leadingMargin * 2) / 2.5 : 0,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    width: _navMaxWidth - _navMinWidth - _navMinWidth - _leadingMargin * 2,
                    child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (trailing != null) const SizedBox(width: _leadingMargin),
                  if (trailing != null) trailing,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
