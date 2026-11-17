// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

/// Cloudscape component messages for `ja`.
library;

import 'package:cloudscape_flutter/src/i18n/message_ast.dart';

/// Upstream `@cloudscape-design/components/i18n/messages/all.ja`.
const CsI18nMessages csMessagesJa = {
  'cloudscape-design-components': {
    'ja': {
      '[charts]': {
        'errorText': <CsMessageNode>[
          CsLiteralNode('データを取得できませんでした。後でもう一度お試しください。'),
        ],
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('グラフ'),
        ],
        'i18nStrings.enterZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズームモードに入る'),
        ],
        'i18nStrings.enterZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('ズーム'),
        ],
        'i18nStrings.exitZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズームモードを終了'),
        ],
        'i18nStrings.exitZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('ズームを終了'),
        ],
        'i18nStrings.filterLabel': <CsMessageNode>[
          CsLiteralNode('表示されたデータをフィルタリング'),
        ],
        'i18nStrings.filterPlaceholder': <CsMessageNode>[
          CsLiteralNode('データをフィルタリング'),
        ],
        'i18nStrings.legendAriaLabel': <CsMessageNode>[CsLiteralNode('凡例')],
        'i18nStrings.resetZoomButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズームをリセットしてデータ範囲全体を表示'),
        ],
        'i18nStrings.resetZoomButtonText': <CsMessageNode>[
          CsLiteralNode('リセット'),
        ],
        'i18nStrings.xAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('x-軸'),
        ],
        'i18nStrings.yAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('y-軸'),
        ],
        'i18nStrings.zoomControlsAriaLabel': <CsMessageNode>[
          CsLiteralNode('チャートズームコントロール'),
        ],
        'i18nStrings.zoomCursorAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズーム範囲カーソル'),
        ],
        'i18nStrings.zoomCursorNextButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズームカーソルを次の点に移動'),
        ],
        'i18nStrings.zoomCursorPreviousButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('ズームカーソルを前のポイントに移動'),
        ],
        'i18nStrings.zoomModeEnteredAnnouncementText': <CsMessageNode>[
          CsLiteralNode('ズームモード。カーソルは '),
          CsArgumentNode('value'),
          CsLiteralNode(' の位置にあります。移動するには矢印キーを使用し、開始点を設定するには Enter キーを使用します。'),
        ],
        'i18nStrings.zoomModeExitedAnnouncementText': <CsMessageNode>[
          CsLiteralNode('ズームモードがキャンセルされました。'),
        ],
        'i18nStrings.zoomRangeChangeAnnouncementText': <CsMessageNode>[
          CsArgumentNode('startValue'),
          CsLiteralNode(' から '),
          CsArgumentNode('endValue'),
          CsLiteralNode(' にズームしました。'),
        ],
        'i18nStrings.zoomResetAnnouncementText': <CsMessageNode>[
          CsLiteralNode('ズームリセット。データ範囲全体を表示します。'),
        ],
        'i18nStrings.zoomSelectionAnnouncementText': <CsMessageNode>[
          CsArgumentNode('startValue'),
          CsLiteralNode(' から '),
          CsArgumentNode('endValue'),
          CsLiteralNode(' までのズーム範囲を選択します。'),
        ],
        'i18nStrings.zoomStartPointAnnouncementText': <CsMessageNode>[
          CsLiteralNode('開始点は '),
          CsArgumentNode('value'),
          CsLiteralNode(' に設定されました。カーソルを移動し、ズームの終了点を設定します。'),
        ],
        'loadingText': <CsMessageNode>[CsLiteralNode('グラフのロード中')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('再試行')],
      },
      'alert': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('アラートを閉じる')],
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('アラートを閉じる'),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('情報')],
        'i18nStrings.successIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'annotation-context': {
        'i18nStrings.finishButtonText': <CsMessageNode>[CsLiteralNode('終了')],
        'i18nStrings.labelDismissAnnotation': <CsMessageNode>[
          CsLiteralNode('注釈を閉じる'),
        ],
        'i18nStrings.labelHotspot': <CsMessageNode>[
          CsSelectNode('openState', {
            'false': <CsMessageNode>[
              CsLiteralNode('ステップ '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode('/'),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' の注釈'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('ステップ '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode('/'),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' の注釈'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.nextButtonText': <CsMessageNode>[CsLiteralNode('次へ')],
        'i18nStrings.previousButtonText': <CsMessageNode>[CsLiteralNode('戻る')],
        'i18nStrings.stepCounterText': <CsMessageNode>[
          CsLiteralNode('ステップ '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('/'),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('タスク '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode(': '),
          CsArgumentNode('taskTitle'),
        ],
      },
      'app-layout': {
        'ariaLabels.drawers': <CsMessageNode>[CsLiteralNode('ドロワー')],
        'ariaLabels.drawersOverflow': <CsMessageNode>[
          CsLiteralNode('ドロワーオーバーフロー'),
        ],
        'ariaLabels.drawersOverflowWithBadge': <CsMessageNode>[
          CsLiteralNode('バッジでドロワーがオーバーフローしています'),
        ],
        'ariaLabels.navigation': <CsMessageNode>[CsLiteralNode('サイドナビゲーション')],
        'ariaLabels.navigationClose': <CsMessageNode>[
          CsLiteralNode('サイドナビゲーションを閉じる'),
        ],
        'ariaLabels.navigationToggle': <CsMessageNode>[
          CsLiteralNode('サイドナビゲーションを開く'),
        ],
        'ariaLabels.notifications': <CsMessageNode>[CsLiteralNode('通知')],
        'ariaLabels.tools': <CsMessageNode>[CsLiteralNode('ヘルプパネル')],
        'ariaLabels.toolsClose': <CsMessageNode>[CsLiteralNode('ヘルプパネルを閉じる')],
        'ariaLabels.toolsToggle': <CsMessageNode>[CsLiteralNode('ヘルプパネルを開く')],
      },
      'area-chart': {
        'i18nStrings.detailTotalLabel': <CsMessageNode>[CsLiteralNode('合計')],
      },
      'attribute-editor': {
        'i18nStrings.itemRemovedAriaLive': <CsMessageNode>[
          CsLiteralNode('アイテムが削除されました'),
        ],
        'removeButtonText': <CsMessageNode>[CsLiteralNode('削除')],
      },
      'autosuggest': {
        'enteredTextLabel': <CsMessageNode>[
          CsLiteralNode('使用:「'),
          CsArgumentNode('value'),
          CsLiteralNode('」'),
        ],
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.enteredTextLabel': <CsMessageNode>[
          CsSelectNode('isTokenMode', {
            'false': <CsMessageNode>[
              CsLiteralNode('「'),
              CsArgumentNode('value'),
              CsLiteralNode('」を使用'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('「'),
              CsArgumentNode('value'),
              CsLiteralNode('」を追加'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tokenDismissLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' を削除'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode('挿入されました'),
        ],
        'i18nStrings.tokenOverflowAriaLabel': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('あと 1 件の項目')],
            'other': <CsMessageNode>[
              CsLiteralNode('あと '),
              CsArgumentNode('count'),
              CsLiteralNode(' 件の項目'),
            ],
          }),
        ],
        'recoveryText': <CsMessageNode>[CsLiteralNode('再試行')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('選択済み')],
      },
      'breadcrumb-group': {
        'expandAriaLabel': <CsMessageNode>[CsLiteralNode('パスの表示')],
      },
      'button': {
        'i18nStrings.externalIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('新しいタブで開く'),
        ],
      },
      'button-dropdown': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'filteringResultsText': <CsMessageNode>[
          CsArgumentNode('totalCount'),
          CsLiteralNode(' 件のうち '),
          CsArgumentNode('matchesCount'),
          CsLiteralNode(' 件の商品'),
        ],
        'i18nStrings.filteringItemAriaDescription': <CsMessageNode>[
          CsLiteralNode('入力を続けると結果が絞り込まれます。'),
        ],
        'noMatch': <CsMessageNode>[CsLiteralNode('一致するアクションなし')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('再試行')],
      },
      'calendar': {
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('当月'),
        ],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('翌年')],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('前年'),
        ],
        'nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('来月')],
        'previousMonthAriaLabel': <CsMessageNode>[CsLiteralNode('前月')],
        'todayAriaLabel': <CsMessageNode>[CsLiteralNode('今日')],
      },
      'cards': {
        'ariaLabels.selectionGroupLabel': <CsMessageNode>[
          CsLiteralNode('項目の選択'),
        ],
      },
      'code-editor': {
        'i18nStrings.cursorPosition': <CsMessageNode>[
          CsLiteralNode('行 '),
          CsArgumentNode('row'),
          CsLiteralNode('、列 '),
          CsArgumentNode('column'),
        ],
        'i18nStrings.cursorPositionAriaLabel': <CsMessageNode>[
          CsLiteralNode('カーソルは行 '),
          CsArgumentNode('row'),
        ],
        'i18nStrings.editorGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('コードエディタ'),
        ],
        'i18nStrings.errorState': <CsMessageNode>[
          CsLiteralNode('コードエディタのロード中にエラーが発生しました。'),
        ],
        'i18nStrings.errorStateRecovery': <CsMessageNode>[CsLiteralNode('再試行')],
        'i18nStrings.errorsTab': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.loadingState': <CsMessageNode>[
          CsLiteralNode('コードエディタをロードしています'),
        ],
        'i18nStrings.paneCloseButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('閉じる'),
        ],
        'i18nStrings.preferencesButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('詳細設定'),
        ],
        'i18nStrings.preferencesModalCancel': <CsMessageNode>[
          CsLiteralNode('キャンセル'),
        ],
        'i18nStrings.preferencesModalConfirm': <CsMessageNode>[
          CsLiteralNode('確認'),
        ],
        'i18nStrings.preferencesModalDarkThemes': <CsMessageNode>[
          CsLiteralNode('暗いテーマ'),
        ],
        'i18nStrings.preferencesModalHeader': <CsMessageNode>[
          CsLiteralNode('詳細設定'),
        ],
        'i18nStrings.preferencesModalLightThemes': <CsMessageNode>[
          CsLiteralNode('明るいテーマ'),
        ],
        'i18nStrings.preferencesModalTheme': <CsMessageNode>[
          CsLiteralNode('テーマ'),
        ],
        'i18nStrings.preferencesModalThemeFilteringAriaLabel': <CsMessageNode>[
          CsLiteralNode('テーマをフィルタリング'),
        ],
        'i18nStrings.preferencesModalThemeFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('テーマをフィルタリング')],
        'i18nStrings.preferencesModalWrapLines': <CsMessageNode>[
          CsLiteralNode('折り返す'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('リサイズハンドル'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('ドラッグまたは選択してリサイズする'),
        ],
        'i18nStrings.statusBarGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('ステータスバー'),
        ],
        'i18nStrings.warningsTab': <CsMessageNode>[CsLiteralNode('警告')],
      },
      'collection-preferences': {
        'cancelLabel': <CsMessageNode>[CsLiteralNode('キャンセル')],
        'confirmLabel': <CsMessageNode>[CsLiteralNode('確認')],
        'contentDensityPreference.description': <CsMessageNode>[
          CsLiteralNode('選択すると、より高密度でコンパクトなモードでコンテンツが表示されます'),
        ],
        'contentDensityPreference.label': <CsMessageNode>[
          CsLiteralNode('コンパクトモード'),
        ],
        'contentDisplayPreference.description': <CsMessageNode>[
          CsLiteralNode('列の表示設定と順序をカスタマイズします。'),
        ],
        'contentDisplayPreference.dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            'Space キーまたは Enter キーを使用して項目のドラッグを有効にし、矢印キーを使用して項目の位置を移動します。位置の移動を完了するには Space キーまたは Enter キーを使用し、移動を取り消すには Esc キーを使用します。スクリーンリーダーでブラウジングモードを切り替える必要がある場合があります。画面読み上げソフトの閲覧モードを切り替える必要がある場合があります。',
          ),
        ],
        'contentDisplayPreference.dragHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('ドラッグハンドル'),
        ],
        'contentDisplayPreference.i18nStrings.columnFilteringAriaLabel':
            <CsMessageNode>[CsLiteralNode('フィルター列')],
        'contentDisplayPreference.i18nStrings.columnFilteringClearFilterText':
            <CsMessageNode>[CsLiteralNode('フィルターをクリア')],
        'contentDisplayPreference.i18nStrings.columnFilteringCountText':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[CsLiteralNode('1 件の一致')],
                'other': <CsMessageNode>[
                  CsArgumentNode('count'),
                  CsLiteralNode(' 件の一致'),
                ],
                'zero': <CsMessageNode>[CsLiteralNode('0 件の一致')],
              }),
            ],
        'contentDisplayPreference.i18nStrings.columnFilteringNoMatchText':
            <CsMessageNode>[CsLiteralNode('一致が見つかりません')],
        'contentDisplayPreference.i18nStrings.columnFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('フィルター列')],
        'contentDisplayPreference.liveAnnouncementDndDiscarded':
            <CsMessageNode>[CsLiteralNode('順序変更をキャンセルしました')],
        'contentDisplayPreference.liveAnnouncementDndGroupLabel':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('、1 個の項目'),
                ],
                'other': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('、'),
                  CsArgumentNode('count'),
                  CsLiteralNode(' 個の項目'),
                ],
                'zero': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('、0 個の項目'),
                ],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemCommitted':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('項目が位置 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' から位置 '),
                  CsArgumentNode('finalPosition'),
                  CsLiteralNode('/'),
                  CsArgumentNode('total'),
                  CsLiteralNode(' に移動しました'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('項目は元の位置 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode('/'),
                  CsArgumentNode('total'),
                  CsLiteralNode(' に戻りました'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemReordered':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('項目を位置 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode('/'),
                  CsArgumentNode('total'),
                  CsLiteralNode(' に移動しています'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('項目を位置 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode('/'),
                  CsArgumentNode('total'),
                  CsLiteralNode(' に戻しています'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndStarted': <CsMessageNode>[
          CsArgumentNode('position'),
          CsLiteralNode('/'),
          CsArgumentNode('total'),
          CsLiteralNode(' の位置で項目をピックアップしました'),
        ],
        'contentDisplayPreference.title': <CsMessageNode>[
          CsLiteralNode('列の詳細設定'),
        ],
        'pageSizePreference.title': <CsMessageNode>[CsLiteralNode('ページサイズ')],
        'stickyColumnsPreference.firstColumns.description': <CsMessageNode>[
          CsLiteralNode('テーブルの内容を水平方向にスクロールしている間は、最初の列を表示したままにします。'),
        ],
        'stickyColumnsPreference.firstColumns.options[0].label':
            <CsMessageNode>[CsLiteralNode('なし')],
        'stickyColumnsPreference.firstColumns.options[1].label':
            <CsMessageNode>[CsLiteralNode('最初の列')],
        'stickyColumnsPreference.firstColumns.options[2].label':
            <CsMessageNode>[CsLiteralNode('最初の 2 列')],
        'stickyColumnsPreference.firstColumns.title': <CsMessageNode>[
          CsLiteralNode('最初の列を固定'),
        ],
        'stickyColumnsPreference.lastColumns.description': <CsMessageNode>[
          CsLiteralNode('テーブルの内容を水平方向にスクロールしている間は、最後の列を表示したままにします。'),
        ],
        'stickyColumnsPreference.lastColumns.options[0].label': <CsMessageNode>[
          CsLiteralNode('なし'),
        ],
        'stickyColumnsPreference.lastColumns.options[1].label': <CsMessageNode>[
          CsLiteralNode('最後の列'),
        ],
        'stickyColumnsPreference.lastColumns.title': <CsMessageNode>[
          CsLiteralNode('最後の列を固定'),
        ],
        'stripedRowsPreference.description': <CsMessageNode>[
          CsLiteralNode('選択すると、交互に影が付いた行が追加されます'),
        ],
        'stripedRowsPreference.label': <CsMessageNode>[CsLiteralNode('縞模様の行')],
        'title': <CsMessageNode>[CsLiteralNode('詳細設定')],
        'wrapLinesPreference.description': <CsMessageNode>[
          CsLiteralNode('選択すると、すべてのテキストが表示され、折り返されます'),
        ],
        'wrapLinesPreference.label': <CsMessageNode>[CsLiteralNode('折り返す')],
      },
      'copy-to-clipboard': {
        'i18nStrings.copyButtonText': <CsMessageNode>[CsLiteralNode('コピー')],
      },
      'date-picker': {
        'i18nStrings.openCalendarAriaLabel': <CsMessageNode>[
          CsSelectNode('selectedDate', {
            'none': <CsMessageNode>[CsLiteralNode('日付を選択')],
            'other': <CsMessageNode>[
              CsLiteralNode('日付を選択してください。選択された日付は '),
              CsArgumentNode('selectedDate'),
              CsLiteralNode(' です'),
            ],
          }),
        ],
      },
      'date-range-picker': {
        'i18nStrings.absoluteModeTitle': <CsMessageNode>[
          CsLiteralNode('絶対モード'),
        ],
        'i18nStrings.applyButtonLabel': <CsMessageNode>[CsLiteralNode('適用')],
        'i18nStrings.cancelButtonLabel': <CsMessageNode>[
          CsLiteralNode('キャンセル'),
        ],
        'i18nStrings.clearButtonLabel': <CsMessageNode>[
          CsLiteralNode('クリアして閉じる'),
        ],
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('今月'),
        ],
        'i18nStrings.customRelativeRangeDurationLabel': <CsMessageNode>[
          CsLiteralNode('期間'),
        ],
        'i18nStrings.customRelativeRangeDurationPlaceholder': <CsMessageNode>[
          CsLiteralNode('期間の入力'),
        ],
        'i18nStrings.customRelativeRangeOptionDescription': <CsMessageNode>[
          CsLiteralNode('過去のカスタム範囲を設定'),
        ],
        'i18nStrings.customRelativeRangeOptionLabel': <CsMessageNode>[
          CsLiteralNode('カスタム範囲'),
        ],
        'i18nStrings.customRelativeRangeUnitLabel': <CsMessageNode>[
          CsLiteralNode('時間の単位'),
        ],
        'i18nStrings.dateConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY/MM/DD を使用します。'),
        ],
        'i18nStrings.datePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.dateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY/MM/DD を使用します。時刻には 24 時間形式を使用します。'),
        ],
        'i18nStrings.endDateLabel': <CsMessageNode>[CsLiteralNode('終了日')],
        'i18nStrings.endMonthLabel': <CsMessageNode>[CsLiteralNode('終了月')],
        'i18nStrings.endTimeLabel': <CsMessageNode>[CsLiteralNode('終了時刻')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.formatRelativeRange': <CsMessageNode>[
          CsSelectNode('unit', {
            'day': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 日間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 日間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 日間'),
                ],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 時間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 時間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 時間'),
                ],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分間'),
                ],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' か月間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' か月間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' か月間'),
                ],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒間'),
                ],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 週間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 週間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 週間'),
                ],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年間'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年間'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('直近 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年間'),
                ],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.formatUnit': <CsMessageNode>[
          CsSelectNode('unit', {
            'day': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('日間')],
                'other': <CsMessageNode>[CsLiteralNode('日間')],
                'zero': <CsMessageNode>[CsLiteralNode('日間')],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('時間')],
                'other': <CsMessageNode>[CsLiteralNode('時間')],
                'zero': <CsMessageNode>[CsLiteralNode('時間')],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('分間')],
                'other': <CsMessageNode>[CsLiteralNode('分間')],
                'zero': <CsMessageNode>[CsLiteralNode('分間')],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('か月間')],
                'other': <CsMessageNode>[CsLiteralNode('か月間')],
                'zero': <CsMessageNode>[CsLiteralNode('か月間')],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('秒間')],
                'other': <CsMessageNode>[CsLiteralNode('秒間')],
                'zero': <CsMessageNode>[CsLiteralNode('秒間')],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('週間')],
                'other': <CsMessageNode>[CsLiteralNode('週間')],
                'zero': <CsMessageNode>[CsLiteralNode('週間')],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('年間')],
                'other': <CsMessageNode>[CsLiteralNode('年間')],
                'zero': <CsMessageNode>[CsLiteralNode('年間')],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.isoDateConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY-MM-DD を使用します。'),
        ],
        'i18nStrings.isoDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.isoDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY-MM-DD を使用します。時刻には 24 時間形式を使用します。'),
        ],
        'i18nStrings.isoMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('月には YYYY-MM を使用します。'),
        ],
        'i18nStrings.monthConstraintText': <CsMessageNode>[
          CsLiteralNode('月には YYYY/MM を使用します。'),
        ],
        'i18nStrings.nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('翌月')],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('翌年')],
        'i18nStrings.previousMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('前月'),
        ],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('前年'),
        ],
        'i18nStrings.relativeModeTitle': <CsMessageNode>[
          CsLiteralNode('相対モード'),
        ],
        'i18nStrings.relativeRangeSelectionHeading': <CsMessageNode>[
          CsLiteralNode('範囲を選択'),
        ],
        'i18nStrings.relativeRangeSelectionMonthlyDescription': <CsMessageNode>[
          CsLiteralNode('各オプションは、最初の日から最後の日までを数えた 1 か月を表します。'),
        ],
        'i18nStrings.renderSelectedAbsoluteRangeAriaLive': <CsMessageNode>[
          CsArgumentNode('startDate'),
          CsLiteralNode(' から '),
          CsArgumentNode('endDate'),
          CsLiteralNode(' で選択された範囲'),
        ],
        'i18nStrings.slashedDateConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY/MM/DD を使用します。'),
        ],
        'i18nStrings.slashedDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY/MM/DD'),
        ],
        'i18nStrings.slashedDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日付には YYYY/MM/DD を使用します。時刻には 24 時間形式を使用します。'),
        ],
        'i18nStrings.slashedMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('月には YYYY/MM を使用します。'),
        ],
        'i18nStrings.startDateLabel': <CsMessageNode>[CsLiteralNode('開始日')],
        'i18nStrings.startMonthLabel': <CsMessageNode>[CsLiteralNode('開始月')],
        'i18nStrings.startTimeLabel': <CsMessageNode>[CsLiteralNode('開始時刻')],
        'i18nStrings.timePlaceholder': <CsMessageNode>[
          CsLiteralNode('hh:mm:ss'),
        ],
        'i18nStrings.todayAriaLabel': <CsMessageNode>[CsLiteralNode('今日')],
      },
      'dialog': {
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('ダイアログを閉じる'),
        ],
      },
      'drawer': {
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('コンテンツのロード中')],
      },
      'error-boundary': {
        'i18nStrings.descriptionText': <CsMessageNode>[
          CsSelectNode('hasFeedback', {
            'true': <CsMessageNode>[
              CsLiteralNode('更新してもう一度お試しください。この問題は現在追跡中ですが、'),
              CsTagNode('Feedback', <CsMessageNode>[
                CsLiteralNode('詳しい情報はこちら'),
              ]),
              CsLiteralNode('で共有できます。'),
            ],
            'other': <CsMessageNode>[CsLiteralNode('更新してもう一度お試しください。')],
          }),
        ],
        'i18nStrings.headerText': <CsMessageNode>[
          CsLiteralNode('予期しないエラー、コンテンツを表示できませんでした'),
        ],
        'i18nStrings.refreshActionText': <CsMessageNode>[
          CsLiteralNode('ページを更新'),
        ],
      },
      'features-notification-drawer': {
        'ariaLabels.closeButton': <CsMessageNode>[CsLiteralNode('通知を閉じる')],
        'ariaLabels.content': <CsMessageNode>[CsLiteralNode('機能の通知')],
        'ariaLabels.resizeHandle': <CsMessageNode>[CsLiteralNode('機能の通知をリサイズ')],
        'ariaLabels.triggerButton': <CsMessageNode>[CsLiteralNode('機能の通知を表示')],
        'i18nStrings.title': <CsMessageNode>[CsLiteralNode('最新機能リリース')],
        'i18nStrings.viewAll': <CsMessageNode>[CsLiteralNode('すべての機能リリースを表示')],
      },
      'file-token-group': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('少なく表示')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('さらに表示')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('ファイル '),
          CsArgumentNode('fileIndex'),
          CsLiteralNode('、'),
          CsArgumentNode('fileName'),
          CsLiteralNode(' を削除'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'file-upload': {
        'i18nStrings.dropzoneText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('ファイルをドロップしてアップロード')],
            'true': <CsMessageNode>[CsLiteralNode('ファイルをドロップしてアップロード')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('少なく表示')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('さらに表示')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('ファイル '),
          CsArgumentNode('fileIndex'),
          CsLiteralNode(' を削除'),
        ],
        'i18nStrings.uploadButtonText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('ファイルを選択')],
            'true': <CsMessageNode>[CsLiteralNode('ファイルを選択')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'flashbar': {
        'i18nStrings.ariaLabel': <CsMessageNode>[CsLiteralNode('通知')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.inProgressIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('進行中'),
        ],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('情報')],
        'i18nStrings.notificationBarAriaLabel': <CsMessageNode>[
          CsLiteralNode('すべての通知'),
        ],
        'i18nStrings.notificationBarText': <CsMessageNode>[CsLiteralNode('通知')],
        'i18nStrings.successIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'form': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
      },
      'form-field': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'help-panel': {
        'loadingText': <CsMessageNode>[CsLiteralNode('コンテンツのロード中')],
      },
      'input': {
        'clearAriaLabel': <CsMessageNode>[CsLiteralNode('クリア')],
      },
      'link': {
        'externalIconAriaLabel': <CsMessageNode>[CsLiteralNode('新しいタブで開く')],
      },
      'list': {
        'dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            'Space または Enter を使用して項目のドラッグをアクティブ化し、矢印キーを使用して項目の位置を移動します。位置の移動を完了するには、Space または Enter を使用します。移動を取り消すには、Escape を使用します。',
          ),
        ],
        'dragHandleAriaLabel': <CsMessageNode>[CsLiteralNode('ドラッグハンドル')],
        'liveAnnouncementDndDiscarded': <CsMessageNode>[
          CsLiteralNode('順序変更をキャンセルしました'),
        ],
        'liveAnnouncementDndItemCommitted': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('項目が位置 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' から位置 '),
              CsArgumentNode('finalPosition'),
              CsLiteralNode('/'),
              CsArgumentNode('total'),
              CsLiteralNode(' に移動しました'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('項目は元の位置 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode('/'),
              CsArgumentNode('total'),
              CsLiteralNode(' に戻りました'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndItemReordered': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('項目を位置 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode('/'),
              CsArgumentNode('total'),
              CsLiteralNode(' に移動しています'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('項目を位置 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode('/'),
              CsArgumentNode('total'),
              CsLiteralNode(' に戻しています'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndStarted': <CsMessageNode>[
          CsArgumentNode('position'),
          CsLiteralNode('/'),
          CsArgumentNode('total'),
          CsLiteralNode(' の位置で項目をピックアップしました'),
        ],
      },
      'modal': {
        'closeAriaLabel': <CsMessageNode>[CsLiteralNode('モーダルを閉じる')],
      },
      'multiselect': {
        'deselectAriaLabel': <CsMessageNode>[
          CsArgumentNode('option__label'),
          CsLiteralNode(' を削除'),
        ],
        'i18nStrings.selectAllText': <CsMessageNode>[CsLiteralNode('すべて選択')],
      },
      'option-list': {
        'i18nStrings.selectedAriaLabel': <CsMessageNode>[CsLiteralNode('選択済み')],
      },
      'pagination': {
        'ariaLabels.jumpToPageButtonLabel': <CsMessageNode>[
          CsLiteralNode('ページに移動'),
        ],
        'ariaLabels.nextPageLabel': <CsMessageNode>[CsLiteralNode('次のページ')],
        'ariaLabels.pageLabel': <CsMessageNode>[
          CsLiteralNode('全ページ中 '),
          CsArgumentNode('pageNumber'),
          CsLiteralNode(' ページ'),
        ],
        'ariaLabels.previousPageLabel': <CsMessageNode>[CsLiteralNode('前のページ')],
        'i18nStrings.jumpToPageError': <CsMessageNode>[
          CsLiteralNode('ページが範囲外です。最後に利用可能なページを表示しています。'),
        ],
        'i18nStrings.jumpToPageInputLabel': <CsMessageNode>[
          CsLiteralNode('ページ'),
        ],
        'i18nStrings.jumpToPageLoadingText': <CsMessageNode>[
          CsLiteralNode('ロード中'),
        ],
        'i18nStrings.pagesCompactText': <CsMessageNode>[
          CsSelectNode('openEnd', {
            'false': <CsMessageNode>[
              CsArgumentNode('currentPage'),
              CsLiteralNode('/'),
              CsArgumentNode('pagesCount'),
            ],
            'true': <CsMessageNode>[
              CsArgumentNode('currentPage'),
              CsLiteralNode('/'),
              CsArgumentNode('pagesCount'),
              CsLiteralNode('+'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
      },
      'panel-resize-handle': {
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('パネルのサイズ変更ハンドル'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('ドラッグまたは選択してリサイズする'),
        ],
      },
      'pie-chart': {
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('円グラフ'),
        ],
        'i18nStrings.detailsPercentage': <CsMessageNode>[
          CsLiteralNode('パーセンテージ'),
        ],
        'i18nStrings.detailsValue': <CsMessageNode>[CsLiteralNode('値')],
        'i18nStrings.segmentAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('セグメント'),
        ],
      },
      'popover': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('ポップオーバーを閉じる')],
      },
      'prompt-input': {
        'i18nStrings.actionButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('プロンプトの送信'),
        ],
        'i18nStrings.menuErrorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('エラー'),
        ],
        'i18nStrings.menuErrorText': <CsMessageNode>[
          CsLiteralNode('項目の取得中にエラーが発生しました'),
        ],
        'i18nStrings.menuFinishedText': <CsMessageNode>[CsLiteralNode('結果の最後')],
        'i18nStrings.menuLoadingText': <CsMessageNode>[
          CsLiteralNode('項目をロード中'),
        ],
        'i18nStrings.menuRecoveryText': <CsMessageNode>[CsLiteralNode('再試行')],
        'i18nStrings.selectedMenuItemAriaLabel': <CsMessageNode>[
          CsLiteralNode('選択済み'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' が挿入されました'),
        ],
        'i18nStrings.tokenPinnedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' がピン留めされました'),
        ],
        'i18nStrings.tokenRemovedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' が削除されました'),
        ],
      },
      'property-filter': {
        'i18nStrings.allPropertiesLabel': <CsMessageNode>[
          CsLiteralNode('すべてのプロパティ'),
        ],
        'i18nStrings.applyActionText': <CsMessageNode>[CsLiteralNode('適用')],
        'i18nStrings.cancelActionText': <CsMessageNode>[CsLiteralNode('キャンセル')],
        'i18nStrings.clearFiltersText': <CsMessageNode>[
          CsLiteralNode('フィルターをクリア'),
        ],
        'i18nStrings.editTokenHeader': <CsMessageNode>[
          CsLiteralNode('フィルターを編集'),
        ],
        'i18nStrings.formatToken': <CsMessageNode>[
          CsSelectNode('token__operator', {
            'contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' を含む'),
            ],
            'equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' と等しい'),
            ],
            'greater_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' 以上'),
            ],
            'greater_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' より大きい'),
            ],
            'less_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' 以下'),
            ],
            'less_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' 未満'),
            ],
            'not_contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' を含まない'),
            ],
            'not_equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' と等しくない'),
            ],
            'not_starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' で始まらない'),
            ],
            'starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' は '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' で始まる'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.groupEditAriaLabel': <CsMessageNode>[
          CsSelectNode('group__formattedTokens__length', {
            '2': <CsMessageNode>[
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsLiteralNode(' のフィルターグループを編集'),
            ],
            '3': <CsMessageNode>[
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens2__formattedText'),
              CsLiteralNode(' のフィルターグループを編集'),
            ],
            '4': <CsMessageNode>[
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens2__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens3__formattedText'),
              CsLiteralNode(' のフィルターグループを編集'),
            ],
            '5': <CsMessageNode>[
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens2__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens3__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' ともう 1 つのフィルターグループを編集'),
            ],
            'other': <CsMessageNode>[
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsArgumentNode('group__operationLabel'),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsArgumentNode('group__operationLabel'),
              CsArgumentNode('group__formattedTokens2__formattedText'),
              CsArgumentNode('group__operationLabel'),
              CsArgumentNode('group__formattedTokens3__formattedText'),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' を超えるフィルターグループを編集'),
            ],
          }),
        ],
        'i18nStrings.groupPropertiesText': <CsMessageNode>[
          CsLiteralNode('プロパティ'),
        ],
        'i18nStrings.groupValuesText': <CsMessageNode>[CsLiteralNode('値')],
        'i18nStrings.operationAndText': <CsMessageNode>[CsLiteralNode('および')],
        'i18nStrings.operationOrText': <CsMessageNode>[CsLiteralNode('または')],
        'i18nStrings.operatorContainsText': <CsMessageNode>[
          CsLiteralNode('次を含む:'),
        ],
        'i18nStrings.operatorDoesNotContainText': <CsMessageNode>[
          CsLiteralNode('次を含まない:'),
        ],
        'i18nStrings.operatorDoesNotEqualText': <CsMessageNode>[
          CsLiteralNode('次と等しくない:'),
        ],
        'i18nStrings.operatorDoesNotStartWithText': <CsMessageNode>[
          CsLiteralNode('次始まらない:'),
        ],
        'i18nStrings.operatorEqualsText': <CsMessageNode>[
          CsLiteralNode('次と等しい:'),
        ],
        'i18nStrings.operatorGreaterOrEqualText': <CsMessageNode>[
          CsLiteralNode('次以上'),
        ],
        'i18nStrings.operatorGreaterText': <CsMessageNode>[
          CsLiteralNode('次より大きい'),
        ],
        'i18nStrings.operatorLessOrEqualText': <CsMessageNode>[
          CsLiteralNode('次以下'),
        ],
        'i18nStrings.operatorLessText': <CsMessageNode>[
          CsLiteralNode('次より少ない'),
        ],
        'i18nStrings.operatorStartsWithText': <CsMessageNode>[
          CsLiteralNode('次で始まる:'),
        ],
        'i18nStrings.operatorText': <CsMessageNode>[CsLiteralNode('演算子')],
        'i18nStrings.operatorsText': <CsMessageNode>[CsLiteralNode('演算子')],
        'i18nStrings.propertyText': <CsMessageNode>[CsLiteralNode('プロパティ')],
        'i18nStrings.removeTokenButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('フィルターを取り外し、'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenAriaLabel': <CsMessageNode>[
          CsLiteralNode('グループに '),
          CsArgumentNode('token__formattedText'),
          CsLiteralNode(' フィルターを追加'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenLabel': <CsMessageNode>[
          CsLiteralNode('グループに '),
          CsArgumentNode('token__propertyLabel'),
          CsArgumentNode('token__operator'),
          CsArgumentNode('token__value'),
          CsLiteralNode(' フィルターを追加'),
        ],
        'i18nStrings.tokenEditorAddNewTokenLabel': <CsMessageNode>[
          CsLiteralNode('新しいフィルターを追加'),
        ],
        'i18nStrings.tokenEditorAddTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('フィルターアクションを追加'),
        ],
        'i18nStrings.tokenEditorTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('アクションをフィルタリングし、'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveAriaLabel': <CsMessageNode>[
          CsLiteralNode('フィルターを取り外し、'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveFromGroupLabel': <CsMessageNode>[
          CsLiteralNode('グループからフィルターを取り外す'),
        ],
        'i18nStrings.tokenEditorTokenRemoveLabel': <CsMessageNode>[
          CsLiteralNode('フィルターを取り外す'),
        ],
        'i18nStrings.tokenLimitShowFewer': <CsMessageNode>[
          CsLiteralNode('少なく表示'),
        ],
        'i18nStrings.tokenLimitShowMore': <CsMessageNode>[
          CsLiteralNode('さらに表示'),
        ],
        'i18nStrings.valueText': <CsMessageNode>[CsLiteralNode('値')],
      },
      's3-resource-selector': {
        'i18nStrings.clearFilterButtonText': <CsMessageNode>[
          CsLiteralNode('フィルターをクリア'),
        ],
        'i18nStrings.columnBucketCreationDate': <CsMessageNode>[
          CsLiteralNode('作成日'),
        ],
        'i18nStrings.columnBucketID': <CsMessageNode>[CsLiteralNode('ID')],
        'i18nStrings.columnBucketName': <CsMessageNode>[CsLiteralNode('名前')],
        'i18nStrings.columnBucketRegion': <CsMessageNode>[
          CsLiteralNode('リージョン'),
        ],
        'i18nStrings.columnObjectKey': <CsMessageNode>[CsLiteralNode('キー')],
        'i18nStrings.columnObjectLastModified': <CsMessageNode>[
          CsLiteralNode('最終更新日'),
        ],
        'i18nStrings.columnObjectSize': <CsMessageNode>[CsLiteralNode('サイズ')],
        'i18nStrings.columnVersionID': <CsMessageNode>[
          CsLiteralNode('バージョン ID'),
        ],
        'i18nStrings.columnVersionLastModified': <CsMessageNode>[
          CsLiteralNode('最終更新日'),
        ],
        'i18nStrings.columnVersionSize': <CsMessageNode>[CsLiteralNode('サイズ')],
        'i18nStrings.filteringCantFindMatch': <CsMessageNode>[
          CsLiteralNode('一致が見つかりません。'),
        ],
        'i18nStrings.filteringCounterText': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('1 件の一致')],
            'other': <CsMessageNode>[
              CsArgumentNode('count'),
              CsLiteralNode(' 件の一致'),
            ],
          }),
        ],
        'i18nStrings.filteringNoMatches': <CsMessageNode>[
          CsLiteralNode('一致なし'),
        ],
        'i18nStrings.inContextBrowseButton': <CsMessageNode>[
          CsLiteralNode('S3 を参照'),
        ],
        'i18nStrings.inContextLoadingText': <CsMessageNode>[
          CsLiteralNode('リソースのロード中'),
        ],
        'i18nStrings.inContextSelectPlaceholder': <CsMessageNode>[
          CsLiteralNode('バージョンを選択してください'),
        ],
        'i18nStrings.inContextUriLabel': <CsMessageNode>[
          CsLiteralNode('S3 URI'),
        ],
        'i18nStrings.inContextVersionSelectLabel': <CsMessageNode>[
          CsLiteralNode('オブジェクトのバージョン'),
        ],
        'i18nStrings.inContextViewButton': <CsMessageNode>[CsLiteralNode('表示')],
        'i18nStrings.inContextViewButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('表示 (新しいタブで開きます)'),
        ],
        'i18nStrings.labelBreadcrumbs': <CsMessageNode>[
          CsLiteralNode('S3 パンくずリスト'),
        ],
        'i18nStrings.labelFiltering': <CsMessageNode>[
          CsArgumentNode('itemsType'),
          CsLiteralNode(' を検索'),
        ],
        'i18nStrings.labelIconFolder': <CsMessageNode>[CsLiteralNode('フォルダ')],
        'i18nStrings.labelIconObject': <CsMessageNode>[CsLiteralNode('オブジェクト')],
        'i18nStrings.labelNotSorted': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(' (ソートなし)'),
        ],
        'i18nStrings.labelRefresh': <CsMessageNode>[CsLiteralNode('データを更新')],
        'i18nStrings.labelSortedAscending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(' (昇順でソート)'),
        ],
        'i18nStrings.labelSortedDescending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(' (降順でソート)'),
        ],
        'i18nStrings.labelsBucketsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Name')],
        'i18nStrings.labelsBucketsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('バケット')],
        'i18nStrings.labelsObjectsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Key')],
        'i18nStrings.labelsObjectsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('オブジェクト')],
        'i18nStrings.labelsVersionsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__VersionId')],
        'i18nStrings.labelsVersionsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('バージョン')],
        'i18nStrings.modalBreadcrumbRootItem': <CsMessageNode>[
          CsLiteralNode('S3 バケット'),
        ],
        'i18nStrings.modalCancelButton': <CsMessageNode>[
          CsLiteralNode('キャンセル'),
        ],
        'i18nStrings.modalLastUpdatedText': <CsMessageNode>[
          CsLiteralNode('最終更新日'),
        ],
        'i18nStrings.modalSubmitButton': <CsMessageNode>[CsLiteralNode('選択')],
        'i18nStrings.modalTitle': <CsMessageNode>[
          CsLiteralNode('S3 のオブジェクトを選択'),
        ],
        'i18nStrings.selectionBuckets': <CsMessageNode>[CsLiteralNode('バケット')],
        'i18nStrings.selectionBucketsLoading': <CsMessageNode>[
          CsLiteralNode('バケットのロード中'),
        ],
        'i18nStrings.selectionBucketsNoItems': <CsMessageNode>[
          CsLiteralNode('バケットなし'),
        ],
        'i18nStrings.selectionBucketsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('バケットを検索します'),
        ],
        'i18nStrings.selectionObjects': <CsMessageNode>[
          CsLiteralNode('オブジェクト'),
        ],
        'i18nStrings.selectionObjectsLoading': <CsMessageNode>[
          CsLiteralNode('オブジェクトのロード中'),
        ],
        'i18nStrings.selectionObjectsNoItems': <CsMessageNode>[
          CsLiteralNode('オブジェクトなし'),
        ],
        'i18nStrings.selectionObjectsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('プレフィックスでオブジェクトを検索します'),
        ],
        'i18nStrings.selectionVersions': <CsMessageNode>[
          CsLiteralNode('バージョン'),
        ],
        'i18nStrings.selectionVersionsLoading': <CsMessageNode>[
          CsLiteralNode('バージョンのロード中'),
        ],
        'i18nStrings.selectionVersionsNoItems': <CsMessageNode>[
          CsLiteralNode('バージョンなし'),
        ],
        'i18nStrings.selectionVersionsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('バージョンを検索します'),
        ],
        'i18nStrings.validationBucketLength': <CsMessageNode>[
          CsLiteralNode('バケット名は 3～63 文字である必要があります。'),
        ],
        'i18nStrings.validationBucketLowerCase': <CsMessageNode>[
          CsLiteralNode('バケット名の先頭は小文字または数字である必要があります。'),
        ],
        'i18nStrings.validationBucketMustComplyDns': <CsMessageNode>[
          CsLiteralNode('バケット名は DNS 命名規則に準拠している必要があります。'),
        ],
        'i18nStrings.validationBucketMustNotContain': <CsMessageNode>[
          CsLiteralNode('バケット名には大文字を使用できません。'),
        ],
        'i18nStrings.validationPathMustBegin': <CsMessageNode>[
          CsLiteralNode('パスが有効であるためには、s3:// で始まる必要があります。'),
        ],
      },
      'select': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('エラー')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('再試行')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('選択済み')],
      },
      'slider': {
        'i18nStrings.valueTextRange': <CsMessageNode>[
          CsArgumentNode('value'),
          CsLiteralNode('、'),
          CsArgumentNode('previousValue'),
          CsLiteralNode('と'),
          CsArgumentNode('nextValue'),
          CsLiteralNode('の間'),
        ],
      },
      'split-panel': {
        'i18nStrings.closeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('パネルを閉じる'),
        ],
        'i18nStrings.openButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('パネルを開く'),
        ],
        'i18nStrings.preferencesCancel': <CsMessageNode>[
          CsLiteralNode('キャンセル'),
        ],
        'i18nStrings.preferencesConfirm': <CsMessageNode>[CsLiteralNode('確認')],
        'i18nStrings.preferencesPositionBottom': <CsMessageNode>[
          CsLiteralNode('下'),
        ],
        'i18nStrings.preferencesPositionDescription': <CsMessageNode>[
          CsLiteralNode('サービスの分割パネルのデフォルトの位置を選択します。'),
        ],
        'i18nStrings.preferencesPositionLabel': <CsMessageNode>[
          CsLiteralNode('分割パネルの位置'),
        ],
        'i18nStrings.preferencesPositionSide': <CsMessageNode>[
          CsLiteralNode('横'),
        ],
        'i18nStrings.preferencesTitle': <CsMessageNode>[
          CsLiteralNode('分割パネルの詳細設定'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('分割パネルのサイズを変更'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('ドラッグまたは選択してリサイズする'),
        ],
      },
      'table': {
        'ariaLabels.collapseButtonLabel': <CsMessageNode>[
          CsLiteralNode('折りたたむ'),
        ],
        'ariaLabels.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展開する')],
        'ariaLabels.liveAnnouncementSortCleared': <CsMessageNode>[
          CsLiteralNode('ソートがクリアされました'),
        ],
        'ariaLabels.liveAnnouncementSortOrder': <CsMessageNode>[
          CsLiteralNode('表は '),
          CsArgumentNode('columns'),
          CsLiteralNode('でソートされています'),
        ],
        'ariaLabels.resizerRoleDescription': <CsMessageNode>[
          CsLiteralNode('[サイズを変更] ボタン'),
        ],
        'ariaLabels.sortAscending': <CsMessageNode>[CsLiteralNode('昇順')],
        'ariaLabels.sortDescending': <CsMessageNode>[CsLiteralNode('降順')],
        'ariaLabels.sortMenuTriggerLabel': <CsMessageNode>[
          CsLiteralNode('ソートオプション'),
        ],
        'ariaLabels.sortPriority': <CsMessageNode>[
          CsLiteralNode('ソートの優先順位 '),
          CsArgumentNode('priority'),
        ],
        'ariaLabels.submittingEditText': <CsMessageNode>[
          CsLiteralNode('編集を送信中'),
        ],
        'ariaLabels.successfulEditLabel': <CsMessageNode>[
          CsLiteralNode('編集に成功しました'),
        ],
        'columnDefinitions.editConfig.editIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('編集可能'),
        ],
        'columnDefinitions.editConfig.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('エラー'),
        ],
        'i18nStrings.clearSort': <CsMessageNode>[CsLiteralNode('ソートをクリア')],
        'i18nStrings.sortDropdownAddToSortAscending': <CsMessageNode>[
          CsLiteralNode('ソートに追加 (昇順)'),
        ],
        'i18nStrings.sortDropdownAddToSortDescending': <CsMessageNode>[
          CsLiteralNode('ソートに追加 (降順)'),
        ],
        'i18nStrings.sortDropdownAddToSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('この列は既にソートされています'),
        ],
        'i18nStrings.sortDropdownMultiColumnSortGroup': <CsMessageNode>[
          CsLiteralNode('複数列ソート (Shift + Click)'),
        ],
        'i18nStrings.sortDropdownRemoveFromSort': <CsMessageNode>[
          CsLiteralNode('ソートから削除'),
        ],
        'i18nStrings.sortDropdownRemoveFromSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('この列はソートされていません'),
        ],
        'i18nStrings.sortDropdownSortAscending': <CsMessageNode>[
          CsLiteralNode('昇順にソート'),
        ],
        'i18nStrings.sortDropdownSortDescending': <CsMessageNode>[
          CsLiteralNode('降順にソート'),
        ],
      },
      'tabs': {
        'i18nStrings.scrollLeftAriaLabel': <CsMessageNode>[
          CsLiteralNode('左にスクロール'),
        ],
        'i18nStrings.scrollRightAriaLabel': <CsMessageNode>[
          CsLiteralNode('右にスクロール'),
        ],
        'i18nStrings.tabsWithActionsAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('アクション付きのタブ'),
        ],
      },
      'tag-editor': {
        'i18nStrings.addButton': <CsMessageNode>[CsLiteralNode('新しいタグを追加')],
        'i18nStrings.awsPrefixError': <CsMessageNode>[
          CsLiteralNode('aws: で始めることはできません'),
        ],
        'i18nStrings.duplicateKeyError': <CsMessageNode>[
          CsLiteralNode('一意のタグキーを指定してください。'),
        ],
        'i18nStrings.emptyKeyError': <CsMessageNode>[
          CsLiteralNode('タグキーを指定してください'),
        ],
        'i18nStrings.emptyTags': <CsMessageNode>[
          CsLiteralNode('リソースに関連付けられたタグがありません。'),
        ],
        'i18nStrings.invalidKeyError': <CsMessageNode>[
          CsLiteralNode(
            '無効なキー。キーには、Unicode 文字、数字、空白、および次のいずれかのみを含めることができます: _.:/=+@-',
          ),
        ],
        'i18nStrings.invalidValueError': <CsMessageNode>[
          CsLiteralNode(
            '無効な値。値には、Unicode 文字、数字、空白、および次のいずれかのみを含めることができます: _.:/=+@-',
          ),
        ],
        'i18nStrings.keyHeader': <CsMessageNode>[CsLiteralNode('キー')],
        'i18nStrings.keyPlaceholder': <CsMessageNode>[CsLiteralNode('キーを入力')],
        'i18nStrings.keySuggestion': <CsMessageNode>[
          CsLiteralNode('カスタムのタグキー'),
        ],
        'i18nStrings.keysSuggestionError': <CsMessageNode>[
          CsLiteralNode('タグキーを取得できませんでした'),
        ],
        'i18nStrings.keysSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('タグキーをロードしています'),
        ],
        'i18nStrings.loading': <CsMessageNode>[
          CsLiteralNode('このリソースに関連付けられているタグをロードしています'),
        ],
        'i18nStrings.maxKeyCharLengthError': <CsMessageNode>[
          CsLiteralNode('タグキーには最大 128 文字を使用できます。'),
        ],
        'i18nStrings.maxValueCharLengthError': <CsMessageNode>[
          CsLiteralNode('タグ値には最大 256 文字を使用できます。'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('オプション')],
        'i18nStrings.removeButton': <CsMessageNode>[CsLiteralNode('削除')],
        'i18nStrings.removeButtonAriaLabel': <CsMessageNode>[
          CsArgumentNode('tag__key'),
          CsLiteralNode(' を削除'),
        ],
        'i18nStrings.tagLimit': <CsMessageNode>[
          CsSelectNode('tagLimitAvailable', {
            'false': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'one': <CsMessageNode>[CsLiteralNode('最大 1 個のタグをさらに追加できます。')],
                'other': <CsMessageNode>[
                  CsLiteralNode('最大 '),
                  CsArgumentNode('availableTags'),
                  CsLiteralNode(' 個のタグをさらに追加できます。'),
                ],
              }),
            ],
            'true': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'other': <CsMessageNode>[
                  CsLiteralNode('最大 '),
                  CsArgumentNode('tagLimit'),
                  CsLiteralNode(' 個のタグを追加できます。'),
                ],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tagLimitExceeded': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('タグの上限数である 1 個を超えました。')],
            'other': <CsMessageNode>[
              CsLiteralNode('タグの上限数である '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 個を超えました。'),
            ],
          }),
        ],
        'i18nStrings.tagLimitReached': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('タグの上限数である 1 個に達しました。')],
            'other': <CsMessageNode>[
              CsLiteralNode('タグの上限数である '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 個に達しました。'),
            ],
          }),
        ],
        'i18nStrings.tooManyKeysSuggestion': <CsMessageNode>[
          CsLiteralNode('表示できる数を超えるキーがあります'),
        ],
        'i18nStrings.tooManyValuesSuggestion': <CsMessageNode>[
          CsLiteralNode('表示できる数を超える値があります'),
        ],
        'i18nStrings.undoButton': <CsMessageNode>[CsLiteralNode('元に戻す')],
        'i18nStrings.undoPrompt': <CsMessageNode>[
          CsLiteralNode('このタグは、変更を保存すると削除されます'),
        ],
        'i18nStrings.valueHeader': <CsMessageNode>[CsLiteralNode('値')],
        'i18nStrings.valuePlaceholder': <CsMessageNode>[CsLiteralNode('値を入力')],
        'i18nStrings.valueSuggestion': <CsMessageNode>[
          CsLiteralNode('カスタムのタグ値'),
        ],
        'i18nStrings.valuesSuggestionError': <CsMessageNode>[
          CsLiteralNode('タグ値を取得できませんでした'),
        ],
        'i18nStrings.valuesSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('タグ値をロードしています'),
        ],
      },
      'token-group': {
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('少なく表示')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('さらに表示')],
      },
      'top-navigation': {
        'i18nStrings.overflowMenuBackIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('戻る'),
        ],
        'i18nStrings.overflowMenuDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('メニューを閉じる'),
        ],
        'i18nStrings.overflowMenuTitleText': <CsMessageNode>[
          CsLiteralNode('すべて'),
        ],
        'i18nStrings.overflowMenuTriggerText': <CsMessageNode>[
          CsLiteralNode('さらに詳しく'),
        ],
        'i18nStrings.searchDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('検索を閉じる'),
        ],
        'i18nStrings.searchIconAriaLabel': <CsMessageNode>[CsLiteralNode('検索')],
      },
      'tree-view': {
        'i18nStrings.collapseButtonLabel': <CsMessageNode>[
          CsLiteralNode('折りたたむ'),
        ],
        'i18nStrings.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展開する')],
      },
      'tutorial-panel': {
        'i18nStrings.completionScreenTitle': <CsMessageNode>[
          CsLiteralNode('これでチュートリアルは完了です。'),
        ],
        'i18nStrings.dismissTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('チュートリアルを終了する'),
        ],
        'i18nStrings.feedbackLinkText': <CsMessageNode>[
          CsLiteralNode('フィードバック'),
        ],
        'i18nStrings.labelExitTutorial': <CsMessageNode>[
          CsLiteralNode('チュートリアルを終了する'),
        ],
        'i18nStrings.labelTotalSteps': <CsMessageNode>[
          CsLiteralNode('合計ステップ: '),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.labelTutorialListDownloadLink': <CsMessageNode>[
          CsLiteralNode('このチュートリアルの PDF バージョンをダウンロードする'),
        ],
        'i18nStrings.labelsTaskStatus.in-progress': <CsMessageNode>[
          CsLiteralNode('進行中'),
        ],
        'i18nStrings.labelsTaskStatus.pending': <CsMessageNode>[
          CsLiteralNode('保留中'),
        ],
        'i18nStrings.labelsTaskStatus.success': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.learnMoreLinkText': <CsMessageNode>[
          CsLiteralNode('詳細はこちら'),
        ],
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('ロード中')],
        'i18nStrings.restartTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('チュートリアルの再起動'),
        ],
        'i18nStrings.startTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('チュートリアルを開始する'),
        ],
        'i18nStrings.stepTitle': <CsMessageNode>[
          CsLiteralNode('ステップ '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(': '),
          CsArgumentNode('stepTitle'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('タスク '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode(': '),
          CsArgumentNode('taskTitle'),
        ],
        'i18nStrings.tutorialCompletedText': <CsMessageNode>[
          CsLiteralNode('チュートリアルが完了しました'),
        ],
        'i18nStrings.tutorialListDownloadLinkText': <CsMessageNode>[
          CsLiteralNode('PDF バージョンのダウンロード'),
        ],
        'i18nStrings.tutorialListTitle': <CsMessageNode>[
          CsLiteralNode('チュートリアルを選択する'),
        ],
      },
      'wizard': {
        'i18nStrings.cancelButton': <CsMessageNode>[CsLiteralNode('キャンセル')],
        'i18nStrings.collapsedStepsLabel': <CsMessageNode>[
          CsLiteralNode('ステップ '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('/'),
          CsArgumentNode('stepsCount'),
        ],
        'i18nStrings.navigationAriaLabel': <CsMessageNode>[
          CsLiteralNode('ステップ'),
        ],
        'i18nStrings.nextButton': <CsMessageNode>[CsLiteralNode('次へ')],
        'i18nStrings.nextButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('次のステップをロード中'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('オプション')],
        'i18nStrings.previousButton': <CsMessageNode>[CsLiteralNode('戻る')],
        'i18nStrings.skipToButtonLabel': <CsMessageNode>[
          CsArgumentNode('task__title'),
          CsLiteralNode(' にスキップ'),
        ],
        'i18nStrings.stepNumberLabel': <CsMessageNode>[
          CsLiteralNode('ステップ '),
          CsArgumentNode('stepNumber'),
        ],
        'i18nStrings.submitButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('フォーム送信'),
        ],
      },
    },
  },
};
