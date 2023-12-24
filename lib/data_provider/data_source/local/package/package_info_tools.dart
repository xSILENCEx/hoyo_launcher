import 'package:hoyo_launcher/commons/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _PackageInfo {
  const _PackageInfo._();

  static Future<void> _initDevice() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      errorLog('_initDevice error $e');
    }
  }

  static late PackageInfo _packageInfo;
}

class PackageTool {
  const PackageTool._();

  static Future<void> initDevice() async => _PackageInfo._initDevice();

  /// 包信息
  static PackageInfo get packageInfo => _PackageInfo._packageInfo;

  static String getVersionStr() {
    return packageInfo.version;
  }
}
