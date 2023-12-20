import 'package:hoyo_launcher/data_provider/data_source/local/database/database.dart';

class FullGameInfoDBModel {
  const FullGameInfoDBModel(this.gameInfoDBModel, this.gameInfoBgDBModel);

  final GameInfoDBModel gameInfoDBModel;
  final GameInfoBgDBModel? gameInfoBgDBModel;
}
