// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

import 'package:cloudscape_flutter/src/i18n/i18n_formatter.dart';
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';
import 'package:flutter/foundation.dart';
import 'package:cloudscape_flutter/i18n/messages/all_ar.dart' deferred as ar;
import 'package:cloudscape_flutter/i18n/messages/all_de.dart' deferred as de;
import 'package:cloudscape_flutter/i18n/messages/all_en.dart' deferred as en;
import 'package:cloudscape_flutter/i18n/messages/all_en_gb.dart'
    deferred as en_gb;
import 'package:cloudscape_flutter/i18n/messages/all_es.dart' deferred as es;
import 'package:cloudscape_flutter/i18n/messages/all_fr.dart' deferred as fr;
import 'package:cloudscape_flutter/i18n/messages/all_id.dart' deferred as id;
import 'package:cloudscape_flutter/i18n/messages/all_it.dart' deferred as it;
import 'package:cloudscape_flutter/i18n/messages/all_ja.dart' deferred as ja;
import 'package:cloudscape_flutter/i18n/messages/all_ko.dart' deferred as ko;
import 'package:cloudscape_flutter/i18n/messages/all_pt_br.dart'
    deferred as pt_br;
import 'package:cloudscape_flutter/i18n/messages/all_th.dart' deferred as th;
import 'package:cloudscape_flutter/i18n/messages/all_tr.dart' deferred as tr;
import 'package:cloudscape_flutter/i18n/messages/all_zh_cn.dart'
    deferred as zh_cn;
import 'package:cloudscape_flutter/i18n/messages/all_zh_tw.dart'
    deferred as zh_tw;

/// Locales with built-in messages.
const List<String> csI18nLocales = [
  'ar',
  'de',
  'en',
  'en-GB',
  'es',
  'fr',
  'id',
  'it',
  'ja',
  'ko',
  'pt-BR',
  'th',
  'tr',
  'zh-CN',
  'zh-TW',
];

final Set<String> _warned = {};

/// Loads the built-in messages for [locale] (upstream `importMessages`).
///
/// The locale is widened (`en-AU` → `en`). Each locale is a deferred
/// library, so on the web it is downloaded only when requested.
Future<List<CsI18nMessages>> csImportMessages(String locale) async {
  for (final l in csMatchableLocales(locale)) {
    switch (l.toLowerCase()) {
      case 'ar':
        await ar.loadLibrary();
        return [ar.csMessagesAr];
      case 'de':
        await de.loadLibrary();
        return [de.csMessagesDe];
      case 'en':
        await en.loadLibrary();
        return [en.csMessagesEn];
      case 'en-gb':
        await en_gb.loadLibrary();
        return [en_gb.csMessagesEnGb];
      case 'es':
        await es.loadLibrary();
        return [es.csMessagesEs];
      case 'fr':
        await fr.loadLibrary();
        return [fr.csMessagesFr];
      case 'id':
        await id.loadLibrary();
        return [id.csMessagesId];
      case 'it':
        await it.loadLibrary();
        return [it.csMessagesIt];
      case 'ja':
        await ja.loadLibrary();
        return [ja.csMessagesJa];
      case 'ko':
        await ko.loadLibrary();
        return [ko.csMessagesKo];
      case 'pt-br':
        await pt_br.loadLibrary();
        return [pt_br.csMessagesPtBr];
      case 'th':
        await th.loadLibrary();
        return [th.csMessagesTh];
      case 'tr':
        await tr.loadLibrary();
        return [tr.csMessagesTr];
      case 'zh-cn':
        await zh_cn.loadLibrary();
        return [zh_cn.csMessagesZhCn];
      case 'zh-tw':
        await zh_tw.loadLibrary();
        return [zh_tw.csMessagesZhTw];
    }
  }
  if (kDebugMode && _warned.add(locale)) {
    debugPrint(
      '[AwsUi] [importMessages] Unknown locale "$locale" provided to importMessages',
    );
  }
  return const [];
}
