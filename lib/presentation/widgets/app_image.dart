import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/commons/logger.dart';
import 'package:hoyo_launcher/presentation/utils/safe_state.dart';

export 'package:extended_image/src/utils.dart';

/// 图片组件封装
/// 传入`url`进行自动识别
class AppImg extends StatelessWidget {
  const AppImg({
    Key? key,
    this.url,
    this.bytes,
    this.scale = 1,
    this.headers,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.centerSlice,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.gaplessPlayback = true,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
    this.radius = 0,
    this.borderRadius,
    this.duration,
    this.mode = ExtendedImageMode.none,
    this.enableSlideOutPage = false,
    this.heroBuilderForSlidingPage,
    this.initGestureConfigHandler,
  }) : super(key: key);

  factory AppImg.cover({
    Key? key,
    String? url,
    Uint8List? bytes,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    double radius = 0,
    BorderRadius? borderRadius,
    Duration? duration,
    Map<String, String>? headers,
  }) =>
      AppImg(
        key: key,
        url: url,
        bytes: bytes,
        headers: headers,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        radius: radius,
        borderRadius: borderRadius,
        duration: duration,
        fit: BoxFit.cover,
      );

  final String? url;
  final Uint8List? bytes;
  final double scale;
  final Map<String, String>? headers;

  final double radius;
  final BorderRadius? borderRadius;

  final String? semanticLabel;
  final bool excludeFromSemantics;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final FilterQuality filterQuality;
  final Duration? duration;

  final ExtendedImageMode mode;
  final bool enableSlideOutPage;
  final Widget Function(Widget)? heroBuilderForSlidingPage;
  final GestureConfig Function(ExtendedImageState)? initGestureConfigHandler;

  static Future<void> clearCache() async {
    await clearDiskCachedImages();
  }

  bool get _isNetwork => url?.startsWith('http') ?? false;

  @override
  Widget build(BuildContext context) {
    if ((url?.isEmpty ?? true) && bytes == null) return const SizedBox.shrink();

    ImageProvider<Object>? image;

    if (url!.startsWith('/')) {
      image = FileImage(File(url!), scale: scale);
    } else if (url!.startsWith('assets')) {
      image = AssetImage(url!);
    } else if (bytes != null) {
      image = MemoryImage(bytes!, scale: scale);
    } else if (_isNetwork) {
      image = ExtendedNetworkImageProvider(
        url!,
        scale: scale,
        headers: headers,
        cache: true,
        cacheRawData: true,
      );
    } else {
      return const SizedBox.shrink();
    }

    Widget child = _isNetwork
        ? ExtendedImage(
            image: image,
            semanticLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
            mode: mode,
            enableSlideOutPage: enableSlideOutPage,
            heroBuilderForSlidingPage: heroBuilderForSlidingPage,
            initGestureConfigHandler: initGestureConfigHandler,
            width: width,
            height: height,
            color: color,
            opacity: opacity,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            centerSlice: centerSlice,
            matchTextDirection: matchTextDirection,
            gaplessPlayback: gaplessPlayback,
            isAntiAlias: isAntiAlias,
            filterQuality: filterQuality,
            loadStateChanged: _loadingBuilder,
          )
        : Image(
            image: image,
            semanticLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
            width: width,
            height: height,
            color: color,
            opacity: opacity,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            centerSlice: centerSlice,
            matchTextDirection: matchTextDirection,
            gaplessPlayback: gaplessPlayback,
            isAntiAlias: isAntiAlias,
            filterQuality: filterQuality,
          );

    if (radius > 0 || borderRadius != null) {
      child = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        child: child,
      );
    }

    return child;
  }

  Widget? _loadingBuilder(ExtendedImageState s) {
    return _FadeInBox(
      imageState: s,
      duration: duration,
      width: width,
      height: height,
      radius: radius,
    );
  }
}

/// 渐入
class _FadeInBox extends StatefulWidget {
  const _FadeInBox({
    Key? key,
    required this.imageState,
    this.duration,
    this.width,
    this.height,
    required this.radius,
  }) : super(key: key);

  final ExtendedImageState imageState;
  final Duration? duration;

  final double? width;
  final double? height;

  final double radius;

  @override
  State<_FadeInBox> createState() => _FadeInBoxState();
}

class _FadeInBoxState extends State<_FadeInBox> with SafeState<_FadeInBox>, SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Animation<double>? _opacity;

  late LoadState _oldImageState = widget.imageState.extendedImageLoadState;

  ExtendedImageState get _imageState => widget.imageState;

  LoadState get _loadState => _imageState.extendedImageLoadState;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 300),
    );
    if (_animationController != null) {
      _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.ease,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(covariant _FadeInBox oldWidget) {
    _dealState();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  /// 处理状态
  Future<void> _dealState() async {
    switch (_loadState) {
      case LoadState.loading:
        _animationController?.reset();
        break;
      case LoadState.completed:
        await _animationController?.forward();
        break;
      case LoadState.failed:
        _animationController?.reset();
        break;
    }

    if (_oldImageState != _loadState) {
      safeSetState(() => _oldImageState = _loadState);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_oldImageState == LoadState.completed || _opacity == null) {
      return _imageState.completedWidget;
    }

    if (_oldImageState == LoadState.failed) {
      errorLog(_imageState.lastException);
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: _opacity!,
              child: _imageState.completedWidget,
            ),
          ),
        ],
      ),
    );
  }
}
