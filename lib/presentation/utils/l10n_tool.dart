import 'package:flutter/material.dart';
import 'package:hoyo_launcher/presentation/gen/l10n/app_localizations.dart';

import 'router_tool.dart';

/// 需要Context的国际化
AppLocalizations l10nWithContext(BuildContext context) => AppLocalizations.of(context);

/// 国际化
AppLocalizations get l10n => AppLocalizations.of(currentContext);
