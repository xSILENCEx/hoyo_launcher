import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';

enum PickType { folder, file }

class PathPicker extends StatefulWidget {
  const PathPicker({
    super.key,
    required this.onPathChanged,
    required this.pickType,
    this.headerValue,
    this.initialPath,
  });

  final String? initialPath;

  final String? headerValue;
  final PickType pickType;
  final Function(String path) onPathChanged;

  @override
  State<PathPicker> createState() => _PathPickerState();
}

class _PathPickerState extends State<PathPicker> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialPath);

  bool _isSelecting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PathPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialPath != oldWidget.initialPath) {
      _controller.text = widget.initialPath ?? '';
    }
  }

  Future<void> _selectPath() async {
    String? path;

    try {
      if (_isSelecting) return;
      _isSelecting = true;
      if (widget.pickType == PickType.folder) {
        path = await FilePicker.platform.getDirectoryPath();
      } else if (widget.pickType == PickType.file) {
        final FilePickerResult? result = await FilePicker.platform.pickFiles();
        path = result?.files.single.path;
      }
    } catch (e) {
      AppInfoBar.show(
        context,
        e.toString(),
        severity: InfoBarSeverity.error,
      );
    } finally {
      _isSelecting = false;
    }

    if (path == null) return;

    widget.onPathChanged(path);
    _controller.text = path;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      children: <Widget>[
        Flexible(
          child: TextBox(
            controller: _controller,
            onEditingComplete: () => widget.onPathChanged(_controller.text),
            maxLength: 4000,
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 100,
          height: 32,
          child: Button(
            onPressed: _selectPath,
            child: Center(child: Text(l10n.select)),
          ),
        ),
      ],
    );

    if (widget.headerValue != null) {
      child = InfoLabel(label: widget.headerValue!, child: child);
    }

    return child;
  }
}
