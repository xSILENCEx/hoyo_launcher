import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';

import 'widgets/nav_hover_box.dart';

const double _navMinWidth = 60;
const double _navMaxWidth = 280;

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
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: navItems.length,
                  itemBuilder: (_, int index) => _buildItem(index, navItems[index], navMinWidth, value),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(int index, GameInfoEntity item, double navMinWidth, double animationValue) {
    const double leadingMargin = 6;
    final double leadingSize = navMinWidth - leadingMargin * 2;
    final bool isSelected = selectIndex == index;

    return GestureDetector(
      onTap: () => onItemTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: leadingMargin),
        height: leadingSize,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.grey[800]!.withOpacity(0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            AnimatedContainer(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              width: 3,
              height: isSelected ? (_navMinWidth - leadingMargin * 2) / 2.5 : 0,
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
                  Container(
                    width: leadingSize,
                    height: leadingSize,
                    padding: const EdgeInsets.all(leadingMargin * 2),
                    child: AppImg.cover(url: item.icon, width: 26, height: 26, radius: 4),
                  ),
                  const SizedBox(width: leadingMargin),
                  SizedBox(
                    width: _navMaxWidth - _navMinWidth - _navMinWidth - leadingMargin * 2,
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: leadingMargin),
                  IconButton(
                    onPressed: () => onEditItemTap(item),
                    icon: const Icon(fu.FluentIcons.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
