import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

const List<String> _innerIcons = <String>[
  'assets/icons/genshin_impact.png',
  'assets/icons/honkai_impact_3.png',
  'assets/icons/honkai_star_rail.png',
  'assets/icons/zzz.png',
];

const double _size = 60;

const double _itemSpacing = 10;

class IconSelector extends StatefulWidget {
  const IconSelector({super.key, required this.onSelected, this.initIconPath});

  final String? initIconPath;

  final Function(String iconPath) onSelected;

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final LayerLink _layerLink = LayerLink();

  late String? _iconPath = widget.initIconPath;

  Future<void> _showPicker() async {
    final String? iconPath = await showDialog<String>(
      context: context,
      builder: _buildDefaultIconList,
      barrierDismissible: true,
    );

    if (iconPath == null) return;

    _onPathChanged(iconPath);
  }

  void _onPathChanged(String path) {
    setState(() {
      _iconPath = path;
    });

    widget.onSelected(path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CompositedTransformTarget(
          link: _layerLink,
          child: SizedBox(
            width: _size,
            height: _size,
            child: FilledButton(
              onPressed: _showPicker,
              style: ButtonStyle(
                padding: ButtonState.all(EdgeInsets.zero),
                shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                backgroundColor: ButtonState.all(Colors.grey),
              ),
              child: _iconPath == null
                  ? const Icon(FluentIcons.add, size: 30)
                  : Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        AppImg.cover(url: _iconPath, width: _size, height: _size, radius: 6),
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Icon(FluentIcons.edit, size: 10, color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: PathPicker(
            initialPath: _iconPath,
            headerValue: '自定义图标'.withColon,
            pickType: PickType.file,
            onPathChanged: _onPathChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultIconList(BuildContext context) {
    return CompositedTransformFollower(
      link: _layerLink,
      offset: const Offset(_size + _itemSpacing, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          height: _size * 2 + _itemSpacing,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: _innerIcons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: _itemSpacing,
              crossAxisSpacing: _itemSpacing,
            ),
            // separatorBuilder: (_, __) => const SizedBox(width: _itemSpacing),
            itemBuilder: (_, int index) {
              final String icon = _innerIcons[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(icon),
                child: AppImg.cover(
                  url: icon,
                  width: _size,
                  height: _size,
                  radius: 10,
                ),
              );
            },
            // children: <Widget>[
            //   for (final String icon in _innerIcons)
            //     GestureDetector(
            //       onTap: () => Navigator.of(context).pop(icon),
            //       child: AppImg.cover(
            //         url: icon,
            //         width: _size,
            //         height: _size,
            //         radius: 10,
            //       ),
            //     ),
            // ],
          ),
        ),
      ),
    );
  }
}
