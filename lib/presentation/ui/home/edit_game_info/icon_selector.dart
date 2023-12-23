import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/gen/assets.gen.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

final List<String> _innerIcons = <String>[
  R.iconsHonkaiImpact3.path,
  R.iconsGenshinImpact.path,
  R.iconsHonkaiStarRail.path,
  R.iconsZzz.path,
];

const double _size = 60;
const double _itemSpacing = 10;
const double _iconRadius = 6;

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
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    return Row(
      children: <Widget>[
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _showPicker,
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: fluentTheme.cardColor,
                borderRadius: BorderRadius.circular(_iconRadius),
              ),
              child: _iconPath == null
                  ? const Icon(FluentIcons.add)
                  : Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        AppImg.cover(url: _iconPath, width: _size, height: _size, radius: _iconRadius),
                        Container(
                          width: _size * 0.35,
                          height: _size * 0.35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(_iconRadius),
                              bottomRight: Radius.circular(_iconRadius),
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
            itemBuilder: (_, int index) {
              final String icon = _innerIcons[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(icon),
                child: AppImg.cover(url: icon, width: _size, height: _size, radius: _iconRadius),
              );
            },
          ),
        ),
      ),
    );
  }
}
