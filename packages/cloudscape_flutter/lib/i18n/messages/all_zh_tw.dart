// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

/// Cloudscape component messages for `zh-TW`.
library;

import 'package:cloudscape_flutter/src/i18n/message_ast.dart';

/// Upstream `@cloudscape-design/components/i18n/messages/all.zh-TW`.
const CsI18nMessages csMessagesZhTw = {
  'cloudscape-design-components': {
    'zh-TW': {
      '[charts]': {
        'errorText': <CsMessageNode>[CsLiteralNode('無法擷取資料。請稍後再試一次。')],
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('圖表'),
        ],
        'i18nStrings.enterZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('進入縮放模式'),
        ],
        'i18nStrings.enterZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('縮放'),
        ],
        'i18nStrings.exitZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('退出縮放模式'),
        ],
        'i18nStrings.exitZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('退出縮放'),
        ],
        'i18nStrings.filterLabel': <CsMessageNode>[CsLiteralNode('篩選顯示的資料')],
        'i18nStrings.filterPlaceholder': <CsMessageNode>[CsLiteralNode('篩選資料')],
        'i18nStrings.legendAriaLabel': <CsMessageNode>[CsLiteralNode('圖例')],
        'i18nStrings.resetZoomButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('重設縮放以顯示完整的資料範圍'),
        ],
        'i18nStrings.resetZoomButtonText': <CsMessageNode>[CsLiteralNode('重設')],
        'i18nStrings.xAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('X 軸'),
        ],
        'i18nStrings.yAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('Y 軸'),
        ],
        'i18nStrings.zoomControlsAriaLabel': <CsMessageNode>[
          CsLiteralNode('圖表縮放控制項'),
        ],
        'i18nStrings.zoomCursorAriaLabel': <CsMessageNode>[
          CsLiteralNode('縮放範圍游標'),
        ],
        'i18nStrings.zoomCursorNextButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('將縮放游標移至下一個點'),
        ],
        'i18nStrings.zoomCursorPreviousButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('將縮放游標移至上一個點'),
        ],
        'i18nStrings.zoomModeEnteredAnnouncementText': <CsMessageNode>[
          CsLiteralNode('縮放模式。游標位於 '),
          CsArgumentNode('value'),
          CsLiteralNode('。使用箭頭鍵移動，使用 Enter 設定起點。'),
        ],
        'i18nStrings.zoomModeExitedAnnouncementText': <CsMessageNode>[
          CsLiteralNode('已取消縮放模式。'),
        ],
        'i18nStrings.zoomRangeChangeAnnouncementText': <CsMessageNode>[
          CsLiteralNode('已從 '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' 縮放至 '),
          CsArgumentNode('endValue'),
          CsLiteralNode('。'),
        ],
        'i18nStrings.zoomResetAnnouncementText': <CsMessageNode>[
          CsLiteralNode('縮放重設。正在顯示完整的資料範圍。'),
        ],
        'i18nStrings.zoomSelectionAnnouncementText': <CsMessageNode>[
          CsLiteralNode('正在選取從 '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' 到 '),
          CsArgumentNode('endValue'),
          CsLiteralNode(' 的縮放範圍。'),
        ],
        'i18nStrings.zoomStartPointAnnouncementText': <CsMessageNode>[
          CsLiteralNode('起點設定為 '),
          CsArgumentNode('value'),
          CsLiteralNode('。移動游標並設定縮放的終點。'),
        ],
        'loadingText': <CsMessageNode>[CsLiteralNode('正在載入圖表')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重試')],
      },
      'alert': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('關閉提醒')],
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[CsLiteralNode('關閉提醒')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('資訊')],
        'i18nStrings.successIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'annotation-context': {
        'i18nStrings.finishButtonText': <CsMessageNode>[CsLiteralNode('完成')],
        'i18nStrings.labelDismissAnnotation': <CsMessageNode>[
          CsLiteralNode('關閉註釋'),
        ],
        'i18nStrings.labelHotspot': <CsMessageNode>[
          CsSelectNode('openState', {
            'false': <CsMessageNode>[
              CsLiteralNode('步驟 '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' (共 '),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' 步) 的註釋'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('步驟 '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' (共 '),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' 步) 的註釋'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.nextButtonText': <CsMessageNode>[CsLiteralNode('下一步')],
        'i18nStrings.previousButtonText': <CsMessageNode>[CsLiteralNode('上一步')],
        'i18nStrings.stepCounterText': <CsMessageNode>[
          CsLiteralNode('步驟 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('，共 '),
          CsArgumentNode('totalStepCount'),
          CsLiteralNode(' 步'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('任務 '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode('：'),
          CsArgumentNode('taskTitle'),
        ],
      },
      'app-layout': {
        'ariaLabels.drawers': <CsMessageNode>[CsLiteralNode('抽屜')],
        'ariaLabels.drawersOverflow': <CsMessageNode>[CsLiteralNode('抽屜溢出')],
        'ariaLabels.drawersOverflowWithBadge': <CsMessageNode>[
          CsLiteralNode('抽屜中徽章溢出'),
        ],
        'ariaLabels.navigation': <CsMessageNode>[CsLiteralNode('側邊導覽')],
        'ariaLabels.navigationClose': <CsMessageNode>[CsLiteralNode('關閉側邊導覽')],
        'ariaLabels.navigationToggle': <CsMessageNode>[CsLiteralNode('開啟側邊導覽')],
        'ariaLabels.notifications': <CsMessageNode>[CsLiteralNode('通知')],
        'ariaLabels.tools': <CsMessageNode>[CsLiteralNode('說明面板')],
        'ariaLabels.toolsClose': <CsMessageNode>[CsLiteralNode('關閉說明面板')],
        'ariaLabels.toolsToggle': <CsMessageNode>[CsLiteralNode('開啟說明面板')],
      },
      'area-chart': {
        'i18nStrings.detailTotalLabel': <CsMessageNode>[CsLiteralNode('合計')],
      },
      'attribute-editor': {
        'i18nStrings.itemRemovedAriaLive': <CsMessageNode>[
          CsLiteralNode('項目已移除'),
        ],
        'removeButtonText': <CsMessageNode>[CsLiteralNode('移除')],
      },
      'autosuggest': {
        'enteredTextLabel': <CsMessageNode>[
          CsLiteralNode('使用：“'),
          CsArgumentNode('value'),
          CsLiteralNode('”'),
        ],
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.enteredTextLabel': <CsMessageNode>[
          CsSelectNode('isTokenMode', {
            'false': <CsMessageNode>[
              CsLiteralNode('使用︰"'),
              CsArgumentNode('value'),
              CsLiteralNode('"'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('新增 "'),
              CsArgumentNode('value'),
              CsLiteralNode('"'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tokenDismissLabel': <CsMessageNode>[
          CsLiteralNode('移除 '),
          CsArgumentNode('token__label'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' 已插入'),
        ],
        'i18nStrings.tokenOverflowAriaLabel': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('還有 1 個項目')],
            'other': <CsMessageNode>[
              CsLiteralNode('還有 '),
              CsArgumentNode('count'),
              CsLiteralNode(' 個項目'),
            ],
          }),
        ],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重試')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已選取')],
      },
      'breadcrumb-group': {
        'expandAriaLabel': <CsMessageNode>[CsLiteralNode('顯示路徑')],
      },
      'button': {
        'i18nStrings.externalIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('在新索引標籤中開啟'),
        ],
      },
      'button-dropdown': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'filteringResultsText': <CsMessageNode>[
          CsArgumentNode('matchesCount'),
          CsLiteralNode(' 個項目 (共 '),
          CsArgumentNode('totalCount'),
          CsLiteralNode(' 個）'),
        ],
        'i18nStrings.filteringItemAriaDescription': <CsMessageNode>[
          CsLiteralNode('繼續輸入以篩選結果。'),
        ],
        'noMatch': <CsMessageNode>[CsLiteralNode('沒有相符的動作')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重試')],
      },
      'calendar': {
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('當前月份'),
        ],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('下一年')],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('上一年'),
        ],
        'nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('下個月')],
        'previousMonthAriaLabel': <CsMessageNode>[CsLiteralNode('上個月')],
        'todayAriaLabel': <CsMessageNode>[CsLiteralNode('今天')],
      },
      'cards': {
        'ariaLabels.selectionGroupLabel': <CsMessageNode>[
          CsLiteralNode('項目選擇'),
        ],
      },
      'code-editor': {
        'i18nStrings.cursorPosition': <CsMessageNode>[
          CsLiteralNode('行 '),
          CsArgumentNode('row'),
          CsLiteralNode('、欄 '),
          CsArgumentNode('column'),
        ],
        'i18nStrings.cursorPositionAriaLabel': <CsMessageNode>[
          CsLiteralNode('列 '),
          CsArgumentNode('row'),
          CsLiteralNode(' 上的游標'),
        ],
        'i18nStrings.editorGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('程式碼編輯器'),
        ],
        'i18nStrings.errorState': <CsMessageNode>[
          CsLiteralNode('載入程式碼編輯器時發生錯誤。'),
        ],
        'i18nStrings.errorStateRecovery': <CsMessageNode>[CsLiteralNode('重試')],
        'i18nStrings.errorsTab': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.loadingState': <CsMessageNode>[
          CsLiteralNode('正在載入程式碼編輯器'),
        ],
        'i18nStrings.paneCloseButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('關閉'),
        ],
        'i18nStrings.preferencesButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('偏好設定'),
        ],
        'i18nStrings.preferencesModalCancel': <CsMessageNode>[
          CsLiteralNode('取消'),
        ],
        'i18nStrings.preferencesModalConfirm': <CsMessageNode>[
          CsLiteralNode('確認'),
        ],
        'i18nStrings.preferencesModalDarkThemes': <CsMessageNode>[
          CsLiteralNode('深色佈景主題'),
        ],
        'i18nStrings.preferencesModalHeader': <CsMessageNode>[
          CsLiteralNode('偏好設定'),
        ],
        'i18nStrings.preferencesModalLightThemes': <CsMessageNode>[
          CsLiteralNode('淺色佈景主題'),
        ],
        'i18nStrings.preferencesModalTheme': <CsMessageNode>[
          CsLiteralNode('佈景主題'),
        ],
        'i18nStrings.preferencesModalThemeFilteringAriaLabel': <CsMessageNode>[
          CsLiteralNode('篩選主題'),
        ],
        'i18nStrings.preferencesModalThemeFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('篩選主題')],
        'i18nStrings.preferencesModalWrapLines': <CsMessageNode>[
          CsLiteralNode('換行'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('調整大小控點'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('拖曳或選取以調整大小'),
        ],
        'i18nStrings.statusBarGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('狀態列'),
        ],
        'i18nStrings.warningsTab': <CsMessageNode>[CsLiteralNode('警告')],
      },
      'collection-preferences': {
        'cancelLabel': <CsMessageNode>[CsLiteralNode('取消')],
        'confirmLabel': <CsMessageNode>[CsLiteralNode('確認')],
        'contentDensityPreference.description': <CsMessageNode>[
          CsLiteralNode('選擇以更密集、更精簡的模式顯示內容'),
        ],
        'contentDensityPreference.label': <CsMessageNode>[
          CsLiteralNode('精簡模式'),
        ],
        'contentDisplayPreference.description': <CsMessageNode>[
          CsLiteralNode('自訂欄位的可見性和順序。'),
        ],
        'contentDisplayPreference.dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            '使用空白鍵或 ENTER 鍵啟用項目拖曳功能，然後使用方向鍵移動項目的位置。若要完成位置移動，請使用空白鍵或 ENTER 鍵，或者若要捨棄移動，請使用 ESC 鍵。您可能需要在螢幕閱讀器上切換瀏覽模式。',
          ),
        ],
        'contentDisplayPreference.dragHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('拖曳控點'),
        ],
        'contentDisplayPreference.i18nStrings.columnFilteringAriaLabel':
            <CsMessageNode>[CsLiteralNode('篩選欄')],
        'contentDisplayPreference.i18nStrings.columnFilteringClearFilterText':
            <CsMessageNode>[CsLiteralNode('清除篩選條件')],
        'contentDisplayPreference.i18nStrings.columnFilteringCountText':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[CsLiteralNode('1 個符合')],
                'other': <CsMessageNode>[
                  CsArgumentNode('count'),
                  CsLiteralNode(' 個符合'),
                ],
                'zero': <CsMessageNode>[CsLiteralNode('0 個符合')],
              }),
            ],
        'contentDisplayPreference.i18nStrings.columnFilteringNoMatchText':
            <CsMessageNode>[CsLiteralNode('找不到相符項目')],
        'contentDisplayPreference.i18nStrings.columnFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('篩選欄')],
        'contentDisplayPreference.liveAnnouncementDndDiscarded':
            <CsMessageNode>[CsLiteralNode('重新排序已取消')],
        'contentDisplayPreference.liveAnnouncementDndGroupLabel':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，1 個項目'),
                ],
                'other': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，'),
                  CsArgumentNode('count'),
                  CsLiteralNode(' 個項目'),
                ],
                'zero': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，0 個項目'),
                ],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemCommitted':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('項目已從 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' 位置移到 '),
                  CsArgumentNode('finalPosition'),
                  CsLiteralNode(' 位置 (共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 個位置)'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('項目移回原來的 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' 位置 (共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 個位置)'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemReordered':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('將項目移到 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode(' 位置 (共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 個位置)'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('將項目移回 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode(' 位置 (共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 個位置)'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('在第 '),
          CsArgumentNode('position'),
          CsLiteralNode(' 位置 (共 '),
          CsArgumentNode('total'),
          CsLiteralNode(' 個位置) 拾取了項目'),
        ],
        'contentDisplayPreference.title': <CsMessageNode>[
          CsLiteralNode('欄偏好設定'),
        ],
        'pageSizePreference.title': <CsMessageNode>[CsLiteralNode('頁面大小')],
        'stickyColumnsPreference.firstColumns.description': <CsMessageNode>[
          CsLiteralNode('水平捲動資料表內容時，保持第一欄可見。'),
        ],
        'stickyColumnsPreference.firstColumns.options[0].label':
            <CsMessageNode>[CsLiteralNode('無')],
        'stickyColumnsPreference.firstColumns.options[1].label':
            <CsMessageNode>[CsLiteralNode('第一欄')],
        'stickyColumnsPreference.firstColumns.options[2].label':
            <CsMessageNode>[CsLiteralNode('前兩欄')],
        'stickyColumnsPreference.firstColumns.title': <CsMessageNode>[
          CsLiteralNode('貼上第一欄'),
        ],
        'stickyColumnsPreference.lastColumns.description': <CsMessageNode>[
          CsLiteralNode('水平捲動資料表內容時，保持最後一欄可見。'),
        ],
        'stickyColumnsPreference.lastColumns.options[0].label': <CsMessageNode>[
          CsLiteralNode('無'),
        ],
        'stickyColumnsPreference.lastColumns.options[1].label': <CsMessageNode>[
          CsLiteralNode('最後一欄'),
        ],
        'stickyColumnsPreference.lastColumns.title': <CsMessageNode>[
          CsLiteralNode('貼上最後一欄'),
        ],
        'stripedRowsPreference.description': <CsMessageNode>[
          CsLiteralNode('選取以新增加網底的列'),
        ],
        'stripedRowsPreference.label': <CsMessageNode>[CsLiteralNode('條紋列')],
        'title': <CsMessageNode>[CsLiteralNode('偏好設定')],
        'wrapLinesPreference.description': <CsMessageNode>[
          CsLiteralNode('選取以查看所有文字並換行'),
        ],
        'wrapLinesPreference.label': <CsMessageNode>[CsLiteralNode('換行')],
      },
      'copy-to-clipboard': {
        'i18nStrings.copyButtonText': <CsMessageNode>[CsLiteralNode('複製')],
      },
      'date-picker': {
        'i18nStrings.openCalendarAriaLabel': <CsMessageNode>[
          CsSelectNode('selectedDate', {
            'none': <CsMessageNode>[CsLiteralNode('選擇日期')],
            'other': <CsMessageNode>[
              CsLiteralNode('選擇日期，所選日期為 '),
              CsArgumentNode('selectedDate'),
            ],
          }),
        ],
      },
      'date-range-picker': {
        'i18nStrings.absoluteModeTitle': <CsMessageNode>[CsLiteralNode('絕對模式')],
        'i18nStrings.applyButtonLabel': <CsMessageNode>[CsLiteralNode('套用')],
        'i18nStrings.cancelButtonLabel': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.clearButtonLabel': <CsMessageNode>[CsLiteralNode('清除和關閉')],
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('本月'),
        ],
        'i18nStrings.customRelativeRangeDurationLabel': <CsMessageNode>[
          CsLiteralNode('持續時間'),
        ],
        'i18nStrings.customRelativeRangeDurationPlaceholder': <CsMessageNode>[
          CsLiteralNode('輸入持續時間'),
        ],
        'i18nStrings.customRelativeRangeOptionDescription': <CsMessageNode>[
          CsLiteralNode('設定過去的自訂範圍'),
        ],
        'i18nStrings.customRelativeRangeOptionLabel': <CsMessageNode>[
          CsLiteralNode('自訂範圍'),
        ],
        'i18nStrings.customRelativeRangeUnitLabel': <CsMessageNode>[
          CsLiteralNode('時間單位'),
        ],
        'i18nStrings.dateConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY/MM/DD 格式。'),
        ],
        'i18nStrings.datePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.dateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY/MM/DD 格式。時間請使用 24 小時格式。'),
        ],
        'i18nStrings.endDateLabel': <CsMessageNode>[CsLiteralNode('結束日期')],
        'i18nStrings.endMonthLabel': <CsMessageNode>[CsLiteralNode('結束月份')],
        'i18nStrings.endTimeLabel': <CsMessageNode>[CsLiteralNode('結束時間')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.formatRelativeRange': <CsMessageNode>[
          CsSelectNode('unit', {
            'day': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('天'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('天'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('天'),
                ],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('小時'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('小時'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('小時'),
                ],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('分鐘'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('分鐘'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('分鐘'),
                ],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('個月'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('個月'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('個月'),
                ],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('秒'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('秒'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('秒'),
                ],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('週'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('週'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('週'),
                ],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('年'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('年'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('最後'),
                  CsArgumentNode('amount'),
                  CsLiteralNode('年'),
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
                'one': <CsMessageNode>[CsLiteralNode('天')],
                'other': <CsMessageNode>[CsLiteralNode('天')],
                'zero': <CsMessageNode>[CsLiteralNode('天')],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('小時')],
                'other': <CsMessageNode>[CsLiteralNode('小時')],
                'zero': <CsMessageNode>[CsLiteralNode('小時')],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('分鐘')],
                'other': <CsMessageNode>[CsLiteralNode('分鐘')],
                'zero': <CsMessageNode>[CsLiteralNode('分鐘')],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('個月')],
                'other': <CsMessageNode>[CsLiteralNode('個月')],
                'zero': <CsMessageNode>[CsLiteralNode('個月')],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('秒')],
                'other': <CsMessageNode>[CsLiteralNode('秒')],
                'zero': <CsMessageNode>[CsLiteralNode('秒')],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('週')],
                'other': <CsMessageNode>[CsLiteralNode('週')],
                'zero': <CsMessageNode>[CsLiteralNode('週')],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('年')],
                'other': <CsMessageNode>[CsLiteralNode('年')],
                'zero': <CsMessageNode>[CsLiteralNode('年')],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.isoDateConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY-MM-DD 格式。'),
        ],
        'i18nStrings.isoDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.isoDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY-MM-DD 格式。時間請使用 24 小時格式。'),
        ],
        'i18nStrings.isoMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('月份請使用 YYYY-MM 格式。'),
        ],
        'i18nStrings.monthConstraintText': <CsMessageNode>[
          CsLiteralNode('月份請使用 YYYY/MM 格式。'),
        ],
        'i18nStrings.nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('下個月')],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('下一年')],
        'i18nStrings.previousMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('上個月'),
        ],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('上一年'),
        ],
        'i18nStrings.relativeModeTitle': <CsMessageNode>[CsLiteralNode('相對模式')],
        'i18nStrings.relativeRangeSelectionHeading': <CsMessageNode>[
          CsLiteralNode('選擇範圍'),
        ],
        'i18nStrings.relativeRangeSelectionMonthlyDescription': <CsMessageNode>[
          CsLiteralNode('每個選項代表完整的月份，從該月第一天算到最後一天。'),
        ],
        'i18nStrings.renderSelectedAbsoluteRangeAriaLive': <CsMessageNode>[
          CsLiteralNode('已選取從 '),
          CsArgumentNode('startDate'),
          CsLiteralNode(' 到 '),
          CsArgumentNode('endDate'),
          CsLiteralNode(' 的範圍'),
        ],
        'i18nStrings.slashedDateConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY/MM/DD 格式。'),
        ],
        'i18nStrings.slashedDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY/MM/DD'),
        ],
        'i18nStrings.slashedDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('日期請使用 YYYY/MM/DD 格式。時間請使用 24 小時格式。'),
        ],
        'i18nStrings.slashedMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('月份請使用 YYYY/MM 格式。'),
        ],
        'i18nStrings.startDateLabel': <CsMessageNode>[CsLiteralNode('開始日期')],
        'i18nStrings.startMonthLabel': <CsMessageNode>[CsLiteralNode('開始月份')],
        'i18nStrings.startTimeLabel': <CsMessageNode>[CsLiteralNode('開始時間')],
        'i18nStrings.timePlaceholder': <CsMessageNode>[
          CsLiteralNode('hh:mm:ss'),
        ],
        'i18nStrings.todayAriaLabel': <CsMessageNode>[CsLiteralNode('今天')],
      },
      'dialog': {
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('關閉對話方塊'),
        ],
      },
      'drawer': {
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('載入內容')],
      },
      'error-boundary': {
        'i18nStrings.descriptionText': <CsMessageNode>[
          CsSelectNode('hasFeedback', {
            'true': <CsMessageNode>[
              CsLiteralNode('重新整理以再試一次。我們正在追蹤此問題，但您可以在此處分享'),
              CsTagNode('Feedback', <CsMessageNode>[CsLiteralNode('更多資訊')]),
              CsLiteralNode('。'),
            ],
            'other': <CsMessageNode>[CsLiteralNode('重新整理以再試一次。')],
          }),
        ],
        'i18nStrings.headerText': <CsMessageNode>[CsLiteralNode('意外錯誤，內容無法顯示')],
        'i18nStrings.refreshActionText': <CsMessageNode>[
          CsLiteralNode('重新整理頁面'),
        ],
      },
      'features-notification-drawer': {
        'ariaLabels.closeButton': <CsMessageNode>[CsLiteralNode('關閉通知')],
        'ariaLabels.content': <CsMessageNode>[CsLiteralNode('功能通知')],
        'ariaLabels.resizeHandle': <CsMessageNode>[CsLiteralNode('調整功能通知的大小')],
        'ariaLabels.triggerButton': <CsMessageNode>[CsLiteralNode('顯示功能通知')],
        'i18nStrings.title': <CsMessageNode>[CsLiteralNode('最新功能發布')],
        'i18nStrings.viewAll': <CsMessageNode>[CsLiteralNode('檢視所有功能發布')],
      },
      'file-token-group': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('顯示較少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('顯示更多')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除檔案 '),
          CsArgumentNode('fileIndex'),
          CsLiteralNode('，'),
          CsArgumentNode('fileName'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'file-upload': {
        'i18nStrings.dropzoneText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('拖曳檔案以上傳')],
            'true': <CsMessageNode>[CsLiteralNode('拖曳檔案以上傳')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('顯示較少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('顯示更多')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除檔案 '),
          CsArgumentNode('fileIndex'),
        ],
        'i18nStrings.uploadButtonText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('選擇檔案')],
            'true': <CsMessageNode>[CsLiteralNode('選擇檔案')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'flashbar': {
        'i18nStrings.ariaLabel': <CsMessageNode>[CsLiteralNode('通知')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.inProgressIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('進行中'),
        ],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('資訊')],
        'i18nStrings.notificationBarAriaLabel': <CsMessageNode>[
          CsLiteralNode('所有通知'),
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
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
      },
      'form-field': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'help-panel': {
        'loadingText': <CsMessageNode>[CsLiteralNode('載入內容')],
      },
      'input': {
        'clearAriaLabel': <CsMessageNode>[CsLiteralNode('清除')],
      },
      'link': {
        'externalIconAriaLabel': <CsMessageNode>[CsLiteralNode('在新索引標籤中開啟')],
      },
      'list': {
        'dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            '使用空白鍵或 ENTER 鍵啟用項目拖曳功能，然後使用方向鍵移動項目的位置。若要完成位置移動，請使用空白鍵或 ENTER 鍵，或者若要捨棄移動，請使用 ESC 鍵。',
          ),
        ],
        'dragHandleAriaLabel': <CsMessageNode>[CsLiteralNode('拖曳控點')],
        'liveAnnouncementDndDiscarded': <CsMessageNode>[
          CsLiteralNode('重新排序已取消'),
        ],
        'liveAnnouncementDndItemCommitted': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('項目已從 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' 位置移到 '),
              CsArgumentNode('finalPosition'),
              CsLiteralNode(' 位置 (共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 個位置)'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('項目移回原來的 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' 位置 (共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 個位置)'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndItemReordered': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('將項目移到 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode(' 位置 (共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 個位置)'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('將項目移回 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode(' 位置 (共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 個位置)'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('在 '),
          CsArgumentNode('position'),
          CsLiteralNode(' 位置 (共 '),
          CsArgumentNode('total'),
          CsLiteralNode(' 個位置) 拾取了項目'),
        ],
      },
      'modal': {
        'closeAriaLabel': <CsMessageNode>[CsLiteralNode('關閉強制回應')],
      },
      'multiselect': {
        'deselectAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除 '),
          CsArgumentNode('option__label'),
        ],
        'i18nStrings.selectAllText': <CsMessageNode>[CsLiteralNode('選取全部')],
      },
      'option-list': {
        'i18nStrings.selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已選取')],
      },
      'pagination': {
        'ariaLabels.jumpToPageButtonLabel': <CsMessageNode>[
          CsLiteralNode('跳到頁面'),
        ],
        'ariaLabels.nextPageLabel': <CsMessageNode>[CsLiteralNode('下一頁')],
        'ariaLabels.pageLabel': <CsMessageNode>[
          CsLiteralNode('所有頁面中的第 '),
          CsArgumentNode('pageNumber'),
          CsLiteralNode(' 頁'),
        ],
        'ariaLabels.previousPageLabel': <CsMessageNode>[CsLiteralNode('上一頁')],
        'i18nStrings.jumpToPageError': <CsMessageNode>[
          CsLiteralNode('頁面超出範圍。顯示最後一個可用頁面。'),
        ],
        'i18nStrings.jumpToPageInputLabel': <CsMessageNode>[
          CsLiteralNode('頁面'),
        ],
        'i18nStrings.jumpToPageLoadingText': <CsMessageNode>[
          CsLiteralNode('正在載入'),
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
          CsLiteralNode('面板調整大小控點'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('拖曳或選取以調整大小'),
        ],
      },
      'pie-chart': {
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('圓餅圖'),
        ],
        'i18nStrings.detailsPercentage': <CsMessageNode>[CsLiteralNode('百分比')],
        'i18nStrings.detailsValue': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.segmentAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('區段'),
        ],
      },
      'popover': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('關閉彈出視窗')],
      },
      'prompt-input': {
        'i18nStrings.actionButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('提交提示'),
        ],
        'i18nStrings.menuErrorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('錯誤'),
        ],
        'i18nStrings.menuErrorText': <CsMessageNode>[
          CsLiteralNode('擷取項目時發生錯誤'),
        ],
        'i18nStrings.menuFinishedText': <CsMessageNode>[CsLiteralNode('結果結束')],
        'i18nStrings.menuLoadingText': <CsMessageNode>[CsLiteralNode('正在載入項目')],
        'i18nStrings.menuRecoveryText': <CsMessageNode>[CsLiteralNode('重試')],
        'i18nStrings.selectedMenuItemAriaLabel': <CsMessageNode>[
          CsLiteralNode('已選取'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' 已插入'),
        ],
        'i18nStrings.tokenPinnedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' 已固定'),
        ],
        'i18nStrings.tokenRemovedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' 已移除'),
        ],
      },
      'property-filter': {
        'i18nStrings.allPropertiesLabel': <CsMessageNode>[
          CsLiteralNode('所有屬性'),
        ],
        'i18nStrings.applyActionText': <CsMessageNode>[CsLiteralNode('套用')],
        'i18nStrings.cancelActionText': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.clearFiltersText': <CsMessageNode>[
          CsLiteralNode('清除篩選條件'),
        ],
        'i18nStrings.editTokenHeader': <CsMessageNode>[CsLiteralNode('編輯篩選條件')],
        'i18nStrings.formatToken': <CsMessageNode>[
          CsSelectNode('token__operator', {
            'contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 包含 '),
              CsArgumentNode('token__value'),
            ],
            'equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 等於 '),
              CsArgumentNode('token__value'),
            ],
            'greater_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 大於或等於 '),
              CsArgumentNode('token__value'),
            ],
            'greater_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 大於 '),
              CsArgumentNode('token__value'),
            ],
            'less_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 小於或等於 '),
              CsArgumentNode('token__value'),
            ],
            'less_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 小於 '),
              CsArgumentNode('token__value'),
            ],
            'not_contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 不包含 '),
              CsArgumentNode('token__value'),
            ],
            'not_equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 不等於 '),
              CsArgumentNode('token__value'),
            ],
            'not_starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 開頭不能為 '),
              CsArgumentNode('token__value'),
            ],
            'starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 開頭為 '),
              CsArgumentNode('token__value'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.groupEditAriaLabel': <CsMessageNode>[
          CsSelectNode('group__formattedTokens__length', {
            '2': <CsMessageNode>[
              CsLiteralNode('編輯篩選群組 '),
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
            ],
            '3': <CsMessageNode>[
              CsLiteralNode('編輯篩選群組 '),
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens2__formattedText'),
            ],
            '4': <CsMessageNode>[
              CsLiteralNode('編輯篩選群組 '),
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
            ],
            '5': <CsMessageNode>[
              CsLiteralNode('再編輯 1 個篩選群組 '),
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
            ],
            'other': <CsMessageNode>[
              CsLiteralNode('編輯更多篩選群組 '),
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
            ],
          }),
        ],
        'i18nStrings.groupPropertiesText': <CsMessageNode>[CsLiteralNode('屬性')],
        'i18nStrings.groupValuesText': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.operationAndText': <CsMessageNode>[CsLiteralNode('和')],
        'i18nStrings.operationOrText': <CsMessageNode>[CsLiteralNode('或')],
        'i18nStrings.operatorContainsText': <CsMessageNode>[
          CsLiteralNode('包含'),
        ],
        'i18nStrings.operatorDoesNotContainText': <CsMessageNode>[
          CsLiteralNode('不包含'),
        ],
        'i18nStrings.operatorDoesNotEqualText': <CsMessageNode>[
          CsLiteralNode('不等於'),
        ],
        'i18nStrings.operatorDoesNotStartWithText': <CsMessageNode>[
          CsLiteralNode('開頭不能為'),
        ],
        'i18nStrings.operatorEqualsText': <CsMessageNode>[CsLiteralNode('等於')],
        'i18nStrings.operatorGreaterOrEqualText': <CsMessageNode>[
          CsLiteralNode('大於或等於'),
        ],
        'i18nStrings.operatorGreaterText': <CsMessageNode>[CsLiteralNode('大於')],
        'i18nStrings.operatorLessOrEqualText': <CsMessageNode>[
          CsLiteralNode('小於或等於'),
        ],
        'i18nStrings.operatorLessText': <CsMessageNode>[CsLiteralNode('小於')],
        'i18nStrings.operatorStartsWithText': <CsMessageNode>[
          CsLiteralNode('開始為'),
        ],
        'i18nStrings.operatorText': <CsMessageNode>[CsLiteralNode('運算子')],
        'i18nStrings.operatorsText': <CsMessageNode>[CsLiteralNode('運算子')],
        'i18nStrings.propertyText': <CsMessageNode>[CsLiteralNode('屬性')],
        'i18nStrings.removeTokenButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除篩選條件，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenAriaLabel': <CsMessageNode>[
          CsLiteralNode('新增篩選條件 '),
          CsArgumentNode('token__formattedText'),
          CsLiteralNode(' 至群組'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenLabel': <CsMessageNode>[
          CsLiteralNode('新增篩選條件 '),
          CsArgumentNode('token__propertyLabel'),
          CsLiteralNode(' '),
          CsArgumentNode('token__operator'),
          CsLiteralNode(' '),
          CsArgumentNode('token__value'),
          CsLiteralNode(' 至群組'),
        ],
        'i18nStrings.tokenEditorAddNewTokenLabel': <CsMessageNode>[
          CsLiteralNode('新增新的篩選條件'),
        ],
        'i18nStrings.tokenEditorAddTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('新增篩選動作'),
        ],
        'i18nStrings.tokenEditorTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('篩選動作，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除篩選條件，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveFromGroupLabel': <CsMessageNode>[
          CsLiteralNode('從群組中移除篩選條件'),
        ],
        'i18nStrings.tokenEditorTokenRemoveLabel': <CsMessageNode>[
          CsLiteralNode('移除篩選條件'),
        ],
        'i18nStrings.tokenLimitShowFewer': <CsMessageNode>[
          CsLiteralNode('顯示較少'),
        ],
        'i18nStrings.tokenLimitShowMore': <CsMessageNode>[
          CsLiteralNode('顯示更多'),
        ],
        'i18nStrings.valueText': <CsMessageNode>[CsLiteralNode('值')],
      },
      's3-resource-selector': {
        'i18nStrings.clearFilterButtonText': <CsMessageNode>[
          CsLiteralNode('清除篩選條件'),
        ],
        'i18nStrings.columnBucketCreationDate': <CsMessageNode>[
          CsLiteralNode('建立日期'),
        ],
        'i18nStrings.columnBucketID': <CsMessageNode>[CsLiteralNode('ID')],
        'i18nStrings.columnBucketName': <CsMessageNode>[CsLiteralNode('名稱')],
        'i18nStrings.columnBucketRegion': <CsMessageNode>[CsLiteralNode('區域')],
        'i18nStrings.columnObjectKey': <CsMessageNode>[CsLiteralNode('索引鍵')],
        'i18nStrings.columnObjectLastModified': <CsMessageNode>[
          CsLiteralNode('上次修改'),
        ],
        'i18nStrings.columnObjectSize': <CsMessageNode>[CsLiteralNode('尺寸')],
        'i18nStrings.columnVersionID': <CsMessageNode>[CsLiteralNode('版本 ID')],
        'i18nStrings.columnVersionLastModified': <CsMessageNode>[
          CsLiteralNode('上次修改'),
        ],
        'i18nStrings.columnVersionSize': <CsMessageNode>[CsLiteralNode('尺寸')],
        'i18nStrings.filteringCantFindMatch': <CsMessageNode>[
          CsLiteralNode('找不到相符項目'),
        ],
        'i18nStrings.filteringCounterText': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('1 個符合')],
            'other': <CsMessageNode>[
              CsArgumentNode('count'),
              CsLiteralNode(' 個符合'),
            ],
          }),
        ],
        'i18nStrings.filteringNoMatches': <CsMessageNode>[
          CsLiteralNode('無相符項目'),
        ],
        'i18nStrings.inContextBrowseButton': <CsMessageNode>[
          CsLiteralNode('瀏覽 S3'),
        ],
        'i18nStrings.inContextLoadingText': <CsMessageNode>[
          CsLiteralNode('正在載入資源'),
        ],
        'i18nStrings.inContextSelectPlaceholder': <CsMessageNode>[
          CsLiteralNode('選擇一個版本'),
        ],
        'i18nStrings.inContextUriLabel': <CsMessageNode>[
          CsLiteralNode('S3 URI'),
        ],
        'i18nStrings.inContextVersionSelectLabel': <CsMessageNode>[
          CsLiteralNode('選取版本'),
        ],
        'i18nStrings.inContextViewButton': <CsMessageNode>[CsLiteralNode('檢視')],
        'i18nStrings.inContextViewButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('檢視 (在新索引標籤中開啟)'),
        ],
        'i18nStrings.labelBreadcrumbs': <CsMessageNode>[
          CsLiteralNode('S3 頁面導覽路徑'),
        ],
        'i18nStrings.labelFiltering': <CsMessageNode>[
          CsLiteralNode('尋找 '),
          CsArgumentNode('itemsType'),
        ],
        'i18nStrings.labelIconFolder': <CsMessageNode>[CsLiteralNode('資料夾')],
        'i18nStrings.labelIconObject': <CsMessageNode>[CsLiteralNode('物件')],
        'i18nStrings.labelNotSorted': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，未排序'),
        ],
        'i18nStrings.labelRefresh': <CsMessageNode>[CsLiteralNode('重新整理資料')],
        'i18nStrings.labelSortedAscending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，升序排序'),
        ],
        'i18nStrings.labelSortedDescending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，遞減排序'),
        ],
        'i18nStrings.labelsBucketsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Name')],
        'i18nStrings.labelsBucketsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('儲存貯體')],
        'i18nStrings.labelsObjectsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Key')],
        'i18nStrings.labelsObjectsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('物件')],
        'i18nStrings.labelsVersionsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__VersionId')],
        'i18nStrings.labelsVersionsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('版本')],
        'i18nStrings.modalBreadcrumbRootItem': <CsMessageNode>[
          CsLiteralNode('S3 儲存貯體'),
        ],
        'i18nStrings.modalCancelButton': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.modalLastUpdatedText': <CsMessageNode>[
          CsLiteralNode('最後更新'),
        ],
        'i18nStrings.modalSubmitButton': <CsMessageNode>[CsLiteralNode('選擇')],
        'i18nStrings.modalTitle': <CsMessageNode>[
          CsLiteralNode('在 S3 中選擇一個對象'),
        ],
        'i18nStrings.selectionBuckets': <CsMessageNode>[CsLiteralNode('儲存貯體')],
        'i18nStrings.selectionBucketsLoading': <CsMessageNode>[
          CsLiteralNode('裝載儲存貯體'),
        ],
        'i18nStrings.selectionBucketsNoItems': <CsMessageNode>[
          CsLiteralNode('沒有儲存貯體'),
        ],
        'i18nStrings.selectionBucketsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('尋找儲存貯體'),
        ],
        'i18nStrings.selectionObjects': <CsMessageNode>[CsLiteralNode('物件')],
        'i18nStrings.selectionObjectsLoading': <CsMessageNode>[
          CsLiteralNode('載入物件'),
        ],
        'i18nStrings.selectionObjectsNoItems': <CsMessageNode>[
          CsLiteralNode('沒有物件'),
        ],
        'i18nStrings.selectionObjectsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('按前綴查找物件'),
        ],
        'i18nStrings.selectionVersions': <CsMessageNode>[CsLiteralNode('版本')],
        'i18nStrings.selectionVersionsLoading': <CsMessageNode>[
          CsLiteralNode('載入版本'),
        ],
        'i18nStrings.selectionVersionsNoItems': <CsMessageNode>[
          CsLiteralNode('沒有版本'),
        ],
        'i18nStrings.selectionVersionsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('尋找版本'),
        ],
        'i18nStrings.validationBucketLength': <CsMessageNode>[
          CsLiteralNode('儲存貯體名稱必須介於 3 到 63 個字元之間。'),
        ],
        'i18nStrings.validationBucketLowerCase': <CsMessageNode>[
          CsLiteralNode('儲存貯體名稱必須以小寫字元或數字開頭。'),
        ],
        'i18nStrings.validationBucketMustComplyDns': <CsMessageNode>[
          CsLiteralNode('儲存貯體名稱必須符合 DNS 命名慣例。'),
        ],
        'i18nStrings.validationBucketMustNotContain': <CsMessageNode>[
          CsLiteralNode('儲存貯體名稱不得包含大寫字元。'),
        ],
        'i18nStrings.validationPathMustBegin': <CsMessageNode>[
          CsLiteralNode('路徑必須以 s3:// 開頭才有效。'),
        ],
      },
      'select': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('錯誤')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重試')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已選取')],
      },
      'slider': {
        'i18nStrings.valueTextRange': <CsMessageNode>[
          CsArgumentNode('value'),
          CsLiteralNode('，介於 '),
          CsArgumentNode('previousValue'),
          CsLiteralNode(' 和 '),
          CsArgumentNode('nextValue'),
          CsLiteralNode(' 之間'),
        ],
      },
      'split-panel': {
        'i18nStrings.closeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('關閉面板'),
        ],
        'i18nStrings.openButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('打開面板'),
        ],
        'i18nStrings.preferencesCancel': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.preferencesConfirm': <CsMessageNode>[CsLiteralNode('確認')],
        'i18nStrings.preferencesPositionBottom': <CsMessageNode>[
          CsLiteralNode('底部'),
        ],
        'i18nStrings.preferencesPositionDescription': <CsMessageNode>[
          CsLiteralNode('選擇服務的預設分割面板位置。'),
        ],
        'i18nStrings.preferencesPositionLabel': <CsMessageNode>[
          CsLiteralNode('分割面板位置'),
        ],
        'i18nStrings.preferencesPositionSide': <CsMessageNode>[
          CsLiteralNode('側邊'),
        ],
        'i18nStrings.preferencesTitle': <CsMessageNode>[
          CsLiteralNode('分割面板偏好'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('調整分割面板大小'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('拖曳或選取以調整大小'),
        ],
      },
      'table': {
        'ariaLabels.collapseButtonLabel': <CsMessageNode>[CsLiteralNode('摺疊')],
        'ariaLabels.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展開')],
        'ariaLabels.liveAnnouncementSortCleared': <CsMessageNode>[
          CsLiteralNode('已清除排序'),
        ],
        'ariaLabels.liveAnnouncementSortOrder': <CsMessageNode>[
          CsLiteralNode('資料表依 '),
          CsArgumentNode('columns'),
          CsLiteralNode(' 排序'),
        ],
        'ariaLabels.resizerRoleDescription': <CsMessageNode>[
          CsLiteralNode('調整按鈕大小'),
        ],
        'ariaLabels.sortAscending': <CsMessageNode>[CsLiteralNode('升序')],
        'ariaLabels.sortDescending': <CsMessageNode>[CsLiteralNode('降序')],
        'ariaLabels.sortMenuTriggerLabel': <CsMessageNode>[
          CsLiteralNode('排序選項'),
        ],
        'ariaLabels.sortPriority': <CsMessageNode>[
          CsLiteralNode('排序優先順序 '),
          CsArgumentNode('priority'),
        ],
        'ariaLabels.submittingEditText': <CsMessageNode>[CsLiteralNode('提交編輯')],
        'ariaLabels.successfulEditLabel': <CsMessageNode>[
          CsLiteralNode('編輯成功'),
        ],
        'columnDefinitions.editConfig.editIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('可編輯'),
        ],
        'columnDefinitions.editConfig.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('錯誤'),
        ],
        'i18nStrings.clearSort': <CsMessageNode>[CsLiteralNode('清除排序')],
        'i18nStrings.sortDropdownAddToSortAscending': <CsMessageNode>[
          CsLiteralNode('新增至排序 (遞增)'),
        ],
        'i18nStrings.sortDropdownAddToSortDescending': <CsMessageNode>[
          CsLiteralNode('新增至排序 (遞減)'),
        ],
        'i18nStrings.sortDropdownAddToSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('此欄已排序'),
        ],
        'i18nStrings.sortDropdownMultiColumnSortGroup': <CsMessageNode>[
          CsLiteralNode('多欄排序 (Shift + 按一下)'),
        ],
        'i18nStrings.sortDropdownRemoveFromSort': <CsMessageNode>[
          CsLiteralNode('從排序中移除'),
        ],
        'i18nStrings.sortDropdownRemoveFromSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('此欄未排序'),
        ],
        'i18nStrings.sortDropdownSortAscending': <CsMessageNode>[
          CsLiteralNode('遞增排序'),
        ],
        'i18nStrings.sortDropdownSortDescending': <CsMessageNode>[
          CsLiteralNode('遞減排序'),
        ],
      },
      'tabs': {
        'i18nStrings.scrollLeftAriaLabel': <CsMessageNode>[
          CsLiteralNode('向左捲動'),
        ],
        'i18nStrings.scrollRightAriaLabel': <CsMessageNode>[
          CsLiteralNode('向右捲動'),
        ],
        'i18nStrings.tabsWithActionsAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('具有動作的標籤'),
        ],
      },
      'tag-editor': {
        'i18nStrings.addButton': <CsMessageNode>[CsLiteralNode('新增標籤')],
        'i18nStrings.awsPrefixError': <CsMessageNode>[
          CsLiteralNode('開頭不能為 aws:'),
        ],
        'i18nStrings.duplicateKeyError': <CsMessageNode>[
          CsLiteralNode('您必須指定唯一的標籤索引鍵。'),
        ],
        'i18nStrings.emptyKeyError': <CsMessageNode>[
          CsLiteralNode('您必須指定標籤索引鍵'),
        ],
        'i18nStrings.emptyTags': <CsMessageNode>[CsLiteralNode('沒有與資源相關聯的標籤。')],
        'i18nStrings.invalidKeyError': <CsMessageNode>[
          CsLiteralNode('無效的金鑰。金鑰只能包含 Unicode 字母、數字、空格和下列符號︰ _.:/=+@–'),
        ],
        'i18nStrings.invalidValueError': <CsMessageNode>[
          CsLiteralNode('無效的值。值只能包含 Unicode 字母、數字、空格和下列符號︰_.:/=+@ –'),
        ],
        'i18nStrings.keyHeader': <CsMessageNode>[CsLiteralNode('索引鍵')],
        'i18nStrings.keyPlaceholder': <CsMessageNode>[CsLiteralNode('輸入索引鍵')],
        'i18nStrings.keySuggestion': <CsMessageNode>[CsLiteralNode('自訂標籤索引鍵')],
        'i18nStrings.keysSuggestionError': <CsMessageNode>[
          CsLiteralNode('無法擷取標籤索引鍵'),
        ],
        'i18nStrings.keysSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('正在載入標籤索引鍵'),
        ],
        'i18nStrings.loading': <CsMessageNode>[CsLiteralNode('正在載入與此資源相關聯的標籤')],
        'i18nStrings.maxKeyCharLengthError': <CsMessageNode>[
          CsLiteralNode('標籤索引鍵中可使用的字元數上限為 128 個字元。'),
        ],
        'i18nStrings.maxValueCharLengthError': <CsMessageNode>[
          CsLiteralNode('標籤值中可使用的字元數上限為 256 個字元。'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('選用')],
        'i18nStrings.removeButton': <CsMessageNode>[CsLiteralNode('移除')],
        'i18nStrings.removeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除 '),
          CsArgumentNode('tag__key'),
        ],
        'i18nStrings.tagLimit': <CsMessageNode>[
          CsSelectNode('tagLimitAvailable', {
            'false': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'one': <CsMessageNode>[CsLiteralNode('您最多可以再新增 1 個標籤。')],
                'other': <CsMessageNode>[
                  CsLiteralNode('您最多可以再新增 '),
                  CsArgumentNode('availableTags'),
                  CsLiteralNode(' 個標籤。'),
                ],
              }),
            ],
            'true': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'other': <CsMessageNode>[
                  CsLiteralNode('您最多可以新增 '),
                  CsArgumentNode('tagLimit'),
                  CsLiteralNode(' 個標籤。'),
                ],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tagLimitExceeded': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('您已超過 1 個標籤的上限。')],
            'other': <CsMessageNode>[
              CsLiteralNode('您已超過 '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 個標籤的上限。'),
            ],
          }),
        ],
        'i18nStrings.tagLimitReached': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('您已達到 1 個標籤的上限。')],
            'other': <CsMessageNode>[
              CsLiteralNode('您已達到 '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 個標籤的上限。'),
            ],
          }),
        ],
        'i18nStrings.tooManyKeysSuggestion': <CsMessageNode>[
          CsLiteralNode('您的索引鍵數目超過可顯示的數目'),
        ],
        'i18nStrings.tooManyValuesSuggestion': <CsMessageNode>[
          CsLiteralNode('您的值數目超過可顯示的數目'),
        ],
        'i18nStrings.undoButton': <CsMessageNode>[CsLiteralNode('復原')],
        'i18nStrings.undoPrompt': <CsMessageNode>[
          CsLiteralNode('此標籤會在儲存變更時移除'),
        ],
        'i18nStrings.valueHeader': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.valuePlaceholder': <CsMessageNode>[CsLiteralNode('輸入值')],
        'i18nStrings.valueSuggestion': <CsMessageNode>[CsLiteralNode('自訂標籤值')],
        'i18nStrings.valuesSuggestionError': <CsMessageNode>[
          CsLiteralNode('無法擷取標籤值'),
        ],
        'i18nStrings.valuesSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('正在載入標籤值'),
        ],
      },
      'token-group': {
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('顯示較少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('顯示更多')],
      },
      'top-navigation': {
        'i18nStrings.overflowMenuBackIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('返回'),
        ],
        'i18nStrings.overflowMenuDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('關閉選單'),
        ],
        'i18nStrings.overflowMenuTitleText': <CsMessageNode>[
          CsLiteralNode('全部'),
        ],
        'i18nStrings.overflowMenuTriggerText': <CsMessageNode>[
          CsLiteralNode('更多'),
        ],
        'i18nStrings.searchDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('關閉搜尋'),
        ],
        'i18nStrings.searchIconAriaLabel': <CsMessageNode>[CsLiteralNode('搜尋')],
      },
      'tree-view': {
        'i18nStrings.collapseButtonLabel': <CsMessageNode>[CsLiteralNode('收合')],
        'i18nStrings.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展開')],
      },
      'tutorial-panel': {
        'i18nStrings.completionScreenTitle': <CsMessageNode>[
          CsLiteralNode('恭喜！您已完成了教學課程。'),
        ],
        'i18nStrings.dismissTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('結束教學'),
        ],
        'i18nStrings.feedbackLinkText': <CsMessageNode>[CsLiteralNode('意見回饋')],
        'i18nStrings.labelExitTutorial': <CsMessageNode>[CsLiteralNode('結束教學')],
        'i18nStrings.labelTotalSteps': <CsMessageNode>[
          CsLiteralNode('總步驟︰'),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.labelTutorialListDownloadLink': <CsMessageNode>[
          CsLiteralNode('下載本教學課程的 PDF 版本'),
        ],
        'i18nStrings.labelsTaskStatus.in-progress': <CsMessageNode>[
          CsLiteralNode('進行中'),
        ],
        'i18nStrings.labelsTaskStatus.pending': <CsMessageNode>[
          CsLiteralNode('等待中'),
        ],
        'i18nStrings.labelsTaskStatus.success': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.learnMoreLinkText': <CsMessageNode>[
          CsLiteralNode('進一步了解'),
        ],
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('正在載入')],
        'i18nStrings.restartTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('重新啟動教學課程'),
        ],
        'i18nStrings.startTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('開始教學'),
        ],
        'i18nStrings.stepTitle': <CsMessageNode>[
          CsLiteralNode('步驟'),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('︰'),
          CsArgumentNode('stepTitle'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('任務 '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode('：'),
          CsArgumentNode('taskTitle'),
        ],
        'i18nStrings.tutorialCompletedText': <CsMessageNode>[
          CsLiteralNode('教學已完成'),
        ],
        'i18nStrings.tutorialListDownloadLinkText': <CsMessageNode>[
          CsLiteralNode('下載 PDF 版本'),
        ],
        'i18nStrings.tutorialListTitle': <CsMessageNode>[CsLiteralNode('選擇教學')],
      },
      'wizard': {
        'i18nStrings.cancelButton': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.collapsedStepsLabel': <CsMessageNode>[
          CsLiteralNode('步驟 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('，共 '),
          CsArgumentNode('stepsCount'),
          CsLiteralNode(' 步'),
        ],
        'i18nStrings.navigationAriaLabel': <CsMessageNode>[CsLiteralNode('步驟')],
        'i18nStrings.nextButton': <CsMessageNode>[CsLiteralNode('下一步')],
        'i18nStrings.nextButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('載入下一個步驟'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('選用')],
        'i18nStrings.previousButton': <CsMessageNode>[CsLiteralNode('上一步')],
        'i18nStrings.skipToButtonLabel': <CsMessageNode>[
          CsLiteralNode('跳到 '),
          CsArgumentNode('task__title'),
        ],
        'i18nStrings.stepNumberLabel': <CsMessageNode>[
          CsLiteralNode('步驟 '),
          CsArgumentNode('stepNumber'),
        ],
        'i18nStrings.submitButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('提交表單'),
        ],
      },
    },
  },
};
