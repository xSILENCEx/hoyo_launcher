import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';

const List<String> _innerIcons = <String>[
  'assets/icons/genshin_impact.png',
  'assets/icons/honkai_impact_3.png',
  'assets/icons/honkai_star_rail.png',
  'assets/icons/zzz.png',
];

const double _size = 100;

class IconSelector extends StatefulWidget {
  const IconSelector({super.key, required this.onSelected});

  final Function(String iconPath) onSelected;

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final FlyoutController _controller = FlyoutController();

  String? _iconPath;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showPicker() async {
    _controller.showFlyout(
      autoModeConfiguration: FlyoutAutoConfiguration(preferredMode: FlyoutPlacementMode.topCenter),
      builder: _buildIconList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlyoutTarget(
      controller: _controller,
      child: SizedBox(
        width: _size,
        height: _size,
        child: FilledButton(
          onPressed: _showPicker,
          style: ButtonStyle(
            shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            backgroundColor: ButtonState.all(Colors.grey),
          ),
          child: _iconPath == null ? const Icon(FluentIcons.add, size: 30) : AppImg.cover(url: _iconPath),
        ),
      ),
    );
  }

  Widget _buildIconList(BuildContext context) {
    return FlyoutContent(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: _size,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          child: Row(
            children: <Widget>[
              for (final String icon in _innerIcons)
                AppImg.cover(
                  url: icon,
                  width: _size * 0.9,
                  height: _size * 0.9,
                  radius: 10,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
