import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/game_info_bg.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/rotation_folder_bg.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/rotation_list_bg.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/single_image_bg.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

const double _typeBtnHeight = 30;
const double _typeBtnWidth = 120;

extension _ExGameInfoBgType on GameInfoBgType {
  String get name {
    switch (this) {
      case GameInfoBgType.folderRotation:
        return l10n.folder_loop;
      case GameInfoBgType.listRotation:
        return l10n.list_loop;
      case GameInfoBgType.singleImage:
        return l10n.single_image;
      case GameInfoBgType.unknown:
        return '';
    }
  }
}

class EditGameBgBox extends StatefulWidget {
  const EditGameBgBox({
    super.key,
    this.initInfoBgType,
    this.initInfoBg,
    required this.onGameInfoBgChanged,
  });

  final GameInfoBgType? initInfoBgType;
  final GameInfoBg? initInfoBg;

  final Function(GameInfoBgType gameInfoBgType, GameInfoBg gameInfoBg) onGameInfoBgChanged;

  @override
  State<EditGameBgBox> createState() => _EditGameBgBoxState();
}

class _EditGameBgBoxState extends State<EditGameBgBox> {
  final LayerLink _layerLink = LayerLink();

  late GameInfoBgType _gameInfoBgType = widget.initInfoBgType ?? GameInfoBgType.singleImage;
  late GameInfoBg _gameInfoBg = widget.initInfoBg ?? const SingleImageBg.empty();

  FluentThemeData get _fluentTheme => FluentTheme.of(context);

  Future<void> _showBgTypeSelector() async {
    final GameInfoBgType? type = await showDialog<GameInfoBgType>(
      context: context,
      builder: _buildBgTypeSelectorMenu,
      barrierDismissible: true,
    );

    if (type == null) return;

    _gameInfoBgType = type;

    if (type == widget.initInfoBgType) {
      _gameInfoBg = widget.initInfoBg ?? GameInfoBg.getEmpty(type);
    } else {
      _gameInfoBg = GameInfoBg.getEmpty(type);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _fluentTheme.cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.bg_type.withColon),
              const SizedBox(width: 10),
              _buildBgTypeSelector(),
            ],
          ),
          const Divider(
            style: DividerThemeData(
              horizontalMargin: EdgeInsets.symmetric(vertical: 16),
              thickness: 1,
            ),
          ),
          _buildView(),
        ],
      ),
    );
  }

  /// 类型选择器
  Widget _buildBgTypeSelector() {
    return GestureDetector(
      onTap: _showBgTypeSelector,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          constraints: const BoxConstraints(minWidth: _typeBtnWidth),
          height: _typeBtnHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _fluentTheme.inactiveColor),
          ),
          child: Text(_gameInfoBgType.name),
        ),
      ),
    );
  }

  /// 根据类型选择对应的视图
  Widget _buildView() {
    switch (_gameInfoBgType) {
      case GameInfoBgType.folderRotation:
        return _buildFolderPicker();
      case GameInfoBgType.listRotation:
        return _buildImageList();
      case GameInfoBgType.singleImage:
        return _buildSingleImage();
      case GameInfoBgType.unknown:
        return const SizedBox.shrink();
    }
  }

  /// 选择单张图片
  Widget _buildSingleImage() {
    final SingleImageBg bg = _gameInfoBg as SingleImageBg;

    return PathPicker(
      initialPath: bg.imageUrl,
      onPathChanged: (String path) {
        if (path.trim().isEmpty) return;

        _gameInfoBg = bg.copyWith(imageUrl: path);
        widget.onGameInfoBgChanged(_gameInfoBgType, _gameInfoBg);
      },
      pickType: PickType.file,
    );
  }

  /// 选择文件夹
  Widget _buildFolderPicker() {
    final RotationFolderBg bg = _gameInfoBg as RotationFolderBg;

    return PathPicker(
      initialPath: bg.imageFolder,
      onPathChanged: (String path) {
        if (path.trim().isEmpty) return;

        _gameInfoBg = bg.copyWith(imageFolder: path);
        widget.onGameInfoBgChanged(_gameInfoBgType, _gameInfoBg);
      },
      pickType: PickType.folder,
    );
  }

  /// 选择多张图片
  Widget _buildImageList() {
    final RotationListBg bg = _gameInfoBg as RotationListBg;

    return _ImageListBox(
      pathList: bg.imageList,
      onPathListChanged: (List<String> pathList) {
        _gameInfoBg = bg.copyWith(imageList: pathList);
        widget.onGameInfoBgChanged(_gameInfoBgType, _gameInfoBg);
      },
    );
  }

  Widget _buildBgTypeSelectorMenu(BuildContext context) {
    const List<GameInfoBgType> types = GameInfoBgType.values;

    return CompositedTransformFollower(
      link: _layerLink,
      offset: const Offset(0, -_typeBtnHeight - 10),
      targetAnchor: Alignment.bottomCenter,
      followerAnchor: Alignment.bottomCenter,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: (types.length - 1) * (_typeBtnHeight * 1.2),
          decoration: BoxDecoration(
            color: _fluentTheme.cardColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < types.length - 1; i++)
                HoverBuilder(
                  builder: (bool isHover) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(types[i]),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: _typeBtnWidth),
                        decoration: BoxDecoration(
                          color: isHover ? _fluentTheme.navigationPaneTheme.backgroundColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: _typeBtnHeight * 1.2,
                        child: Center(
                          widthFactor: 1,
                          child: Text(types[i].name),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageListBox extends StatefulWidget {
  const _ImageListBox({required this.pathList, required this.onPathListChanged});

  final List<String> pathList;
  final Function(List<String> pathList) onPathListChanged;

  @override
  State<_ImageListBox> createState() => _ImageListBoxState();
}

class _ImageListBoxState extends State<_ImageListBox> {
  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: l10n.one_image_per_line,
      child: TextBox(
        onEditingComplete: () {},
        maxLength: 4000,
        maxLines: 2,
      ),
    );
  }
}
