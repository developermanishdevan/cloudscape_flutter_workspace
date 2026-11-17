// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

/// Cloudscape component messages for `zh-CN`.
library;

import 'package:cloudscape_flutter/src/i18n/message_ast.dart';

/// Upstream `@cloudscape-design/components/i18n/messages/all.zh-CN`.
const CsI18nMessages csMessagesZhCn = {
  'cloudscape-design-components': {
    'zh-CN': {
      '[charts]': {
        'errorText': <CsMessageNode>[CsLiteralNode('无法获取数据。请稍后重试。')],
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('图表'),
        ],
        'i18nStrings.enterZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('进入缩放模式'),
        ],
        'i18nStrings.enterZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('缩放'),
        ],
        'i18nStrings.exitZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('退出缩放模式'),
        ],
        'i18nStrings.exitZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('退出缩放'),
        ],
        'i18nStrings.filterLabel': <CsMessageNode>[CsLiteralNode('筛选显示的数据')],
        'i18nStrings.filterPlaceholder': <CsMessageNode>[CsLiteralNode('筛选数据')],
        'i18nStrings.legendAriaLabel': <CsMessageNode>[CsLiteralNode('图例')],
        'i18nStrings.resetZoomButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('重置缩放以显示完整数据范围'),
        ],
        'i18nStrings.resetZoomButtonText': <CsMessageNode>[CsLiteralNode('重置')],
        'i18nStrings.xAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('x 轴'),
        ],
        'i18nStrings.yAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('y 轴'),
        ],
        'i18nStrings.zoomControlsAriaLabel': <CsMessageNode>[
          CsLiteralNode('图表缩放控件'),
        ],
        'i18nStrings.zoomCursorAriaLabel': <CsMessageNode>[
          CsLiteralNode('缩放范围光标'),
        ],
        'i18nStrings.zoomCursorNextButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('将缩放光标移动到下一个点'),
        ],
        'i18nStrings.zoomCursorPreviousButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('将缩放光标移到上一个点'),
        ],
        'i18nStrings.zoomModeEnteredAnnouncementText': <CsMessageNode>[
          CsLiteralNode('缩放模式。光标位于 '),
          CsArgumentNode('value'),
          CsLiteralNode('。使用箭头键移动，使用 Enter 键设置起点。'),
        ],
        'i18nStrings.zoomModeExitedAnnouncementText': <CsMessageNode>[
          CsLiteralNode('缩放模式已取消。'),
        ],
        'i18nStrings.zoomRangeChangeAnnouncementText': <CsMessageNode>[
          CsLiteralNode('已从 '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' 缩放到 '),
          CsArgumentNode('endValue'),
          CsLiteralNode('。'),
        ],
        'i18nStrings.zoomResetAnnouncementText': <CsMessageNode>[
          CsLiteralNode('缩放重置。正在显示完整的数据范围。'),
        ],
        'i18nStrings.zoomSelectionAnnouncementText': <CsMessageNode>[
          CsLiteralNode('正在选择从 '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' 到 '),
          CsArgumentNode('endValue'),
          CsLiteralNode(' 的缩放范围。'),
        ],
        'i18nStrings.zoomStartPointAnnouncementText': <CsMessageNode>[
          CsLiteralNode('起点设置为 '),
          CsArgumentNode('value'),
          CsLiteralNode('。移动光标并设置终点以进行缩放。'),
        ],
        'loadingText': <CsMessageNode>[CsLiteralNode('正在加载图表')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重试')],
      },
      'alert': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('关闭提示')],
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[CsLiteralNode('关闭提醒')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('信息')],
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
          CsLiteralNode('关闭注释'),
        ],
        'i18nStrings.labelHotspot': <CsMessageNode>[
          CsSelectNode('openState', {
            'false': <CsMessageNode>[
              CsLiteralNode('第 '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' 步（共 '),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' 步）的注释'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('第 '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' 步（共 '),
              CsArgumentNode('totalStepCount'),
              CsLiteralNode(' 步）的注释'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.nextButtonText': <CsMessageNode>[CsLiteralNode('下一步')],
        'i18nStrings.previousButtonText': <CsMessageNode>[CsLiteralNode('上一步')],
        'i18nStrings.stepCounterText': <CsMessageNode>[
          CsLiteralNode('第 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(' 步，共 '),
          CsArgumentNode('totalStepCount'),
          CsLiteralNode(' 步'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('任务 '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode('：'),
          CsArgumentNode('taskTitle'),
        ],
      },
      'app-layout': {
        'ariaLabels.drawers': <CsMessageNode>[CsLiteralNode('抽屉')],
        'ariaLabels.drawersOverflow': <CsMessageNode>[CsLiteralNode('抽屉溢出')],
        'ariaLabels.drawersOverflowWithBadge': <CsMessageNode>[
          CsLiteralNode('抽屉中徽章溢出'),
        ],
        'ariaLabels.navigation': <CsMessageNode>[CsLiteralNode('侧导航')],
        'ariaLabels.navigationClose': <CsMessageNode>[CsLiteralNode('关闭侧导航')],
        'ariaLabels.navigationToggle': <CsMessageNode>[CsLiteralNode('打开侧导航')],
        'ariaLabels.notifications': <CsMessageNode>[CsLiteralNode('通知')],
        'ariaLabels.tools': <CsMessageNode>[CsLiteralNode('帮助面板')],
        'ariaLabels.toolsClose': <CsMessageNode>[CsLiteralNode('关闭帮助面板')],
        'ariaLabels.toolsToggle': <CsMessageNode>[CsLiteralNode('打开帮助面板')],
      },
      'area-chart': {
        'i18nStrings.detailTotalLabel': <CsMessageNode>[CsLiteralNode('总计')],
      },
      'attribute-editor': {
        'i18nStrings.itemRemovedAriaLive': <CsMessageNode>[
          CsLiteralNode('项目已移除'),
        ],
        'removeButtonText': <CsMessageNode>[CsLiteralNode('删除')],
      },
      'autosuggest': {
        'enteredTextLabel': <CsMessageNode>[
          CsLiteralNode('使用：“'),
          CsArgumentNode('value'),
          CsLiteralNode('”'),
        ],
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.enteredTextLabel': <CsMessageNode>[
          CsSelectNode('isTokenMode', {
            'false': <CsMessageNode>[
              CsLiteralNode('使用：“'),
              CsArgumentNode('value'),
              CsLiteralNode('”'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('添加“'),
              CsArgumentNode('value'),
              CsLiteralNode('”'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tokenDismissLabel': <CsMessageNode>[
          CsLiteralNode('移除 '),
          CsArgumentNode('token__label'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsLiteralNode('已插入 '),
          CsArgumentNode('token__label'),
        ],
        'i18nStrings.tokenOverflowAriaLabel': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('另外 1 个项目')],
            'other': <CsMessageNode>[
              CsLiteralNode('另外 '),
              CsArgumentNode('count'),
              CsLiteralNode(' 个项目'),
            ],
          }),
        ],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重试')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已选定')],
      },
      'breadcrumb-group': {
        'expandAriaLabel': <CsMessageNode>[CsLiteralNode('显示路径')],
      },
      'button': {
        'i18nStrings.externalIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('在新选项卡中打开'),
        ],
      },
      'button-dropdown': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'filteringResultsText': <CsMessageNode>[
          CsArgumentNode('matchesCount'),
          CsLiteralNode(' 个项目（共 '),
          CsArgumentNode('totalCount'),
          CsLiteralNode(' 个）'),
        ],
        'i18nStrings.filteringItemAriaDescription': <CsMessageNode>[
          CsLiteralNode('继续键入以筛选结果。'),
        ],
        'noMatch': <CsMessageNode>[CsLiteralNode('没有匹配的操作')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重试')],
      },
      'calendar': {
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('本月'),
        ],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('下一年')],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('上一年'),
        ],
        'nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('下个月')],
        'previousMonthAriaLabel': <CsMessageNode>[CsLiteralNode('上个月')],
        'todayAriaLabel': <CsMessageNode>[CsLiteralNode('今天')],
      },
      'cards': {
        'ariaLabels.selectionGroupLabel': <CsMessageNode>[
          CsLiteralNode('项目选择'),
        ],
      },
      'code-editor': {
        'i18nStrings.cursorPosition': <CsMessageNode>[
          CsLiteralNode('第 '),
          CsArgumentNode('row'),
          CsLiteralNode(' 行，第 '),
          CsArgumentNode('column'),
          CsLiteralNode(' 列'),
        ],
        'i18nStrings.cursorPositionAriaLabel': <CsMessageNode>[
          CsLiteralNode('光标位于第 '),
          CsArgumentNode('row'),
          CsLiteralNode(' 行'),
        ],
        'i18nStrings.editorGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('代码编辑器'),
        ],
        'i18nStrings.errorState': <CsMessageNode>[CsLiteralNode('加载代码编辑器时出错。')],
        'i18nStrings.errorStateRecovery': <CsMessageNode>[CsLiteralNode('重试')],
        'i18nStrings.errorsTab': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.loadingState': <CsMessageNode>[CsLiteralNode('正在加载代码编辑器')],
        'i18nStrings.paneCloseButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('关闭'),
        ],
        'i18nStrings.preferencesButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('首选项'),
        ],
        'i18nStrings.preferencesModalCancel': <CsMessageNode>[
          CsLiteralNode('取消'),
        ],
        'i18nStrings.preferencesModalConfirm': <CsMessageNode>[
          CsLiteralNode('确认'),
        ],
        'i18nStrings.preferencesModalDarkThemes': <CsMessageNode>[
          CsLiteralNode('深色主题'),
        ],
        'i18nStrings.preferencesModalHeader': <CsMessageNode>[
          CsLiteralNode('首选项'),
        ],
        'i18nStrings.preferencesModalLightThemes': <CsMessageNode>[
          CsLiteralNode('浅色主题'),
        ],
        'i18nStrings.preferencesModalTheme': <CsMessageNode>[
          CsLiteralNode('主题'),
        ],
        'i18nStrings.preferencesModalThemeFilteringAriaLabel': <CsMessageNode>[
          CsLiteralNode('筛选主题'),
        ],
        'i18nStrings.preferencesModalThemeFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('筛选主题')],
        'i18nStrings.preferencesModalWrapLines': <CsMessageNode>[
          CsLiteralNode('换行'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('调整手柄的大小'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('通过拖动或选择来调整大小'),
        ],
        'i18nStrings.statusBarGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('状态栏'),
        ],
        'i18nStrings.warningsTab': <CsMessageNode>[CsLiteralNode('警告')],
      },
      'collection-preferences': {
        'cancelLabel': <CsMessageNode>[CsLiteralNode('取消')],
        'confirmLabel': <CsMessageNode>[CsLiteralNode('确认')],
        'contentDensityPreference.description': <CsMessageNode>[
          CsLiteralNode('选择以更密集、更紧凑的模式显示内容'),
        ],
        'contentDensityPreference.label': <CsMessageNode>[
          CsLiteralNode('紧凑模式'),
        ],
        'contentDisplayPreference.description': <CsMessageNode>[
          CsLiteralNode('自定义列的可见性和顺序。'),
        ],
        'contentDisplayPreference.dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            '使用空格键或 Enter 键激活项目拖动功能，然后使用箭头键移动项目的位置。要完成位置移动，请使用空格键或 Enter 键，要放弃移动，请使用 Esc 键。您可能需要在屏幕阅读器上切换浏览模式。',
          ),
        ],
        'contentDisplayPreference.dragHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('拖动手柄'),
        ],
        'contentDisplayPreference.i18nStrings.columnFilteringAriaLabel':
            <CsMessageNode>[CsLiteralNode('筛选列')],
        'contentDisplayPreference.i18nStrings.columnFilteringClearFilterText':
            <CsMessageNode>[CsLiteralNode('清除筛选条件')],
        'contentDisplayPreference.i18nStrings.columnFilteringCountText':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[CsLiteralNode('1 个匹配项')],
                'other': <CsMessageNode>[
                  CsArgumentNode('count'),
                  CsLiteralNode(' 个匹配项'),
                ],
                'zero': <CsMessageNode>[CsLiteralNode('0 个匹配项')],
              }),
            ],
        'contentDisplayPreference.i18nStrings.columnFilteringNoMatchText':
            <CsMessageNode>[CsLiteralNode('未找到匹配项')],
        'contentDisplayPreference.i18nStrings.columnFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('筛选列')],
        'contentDisplayPreference.liveAnnouncementDndDiscarded':
            <CsMessageNode>[CsLiteralNode('重新排序已取消')],
        'contentDisplayPreference.liveAnnouncementDndGroupLabel':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，1 个项目'),
                ],
                'other': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，'),
                  CsArgumentNode('count'),
                  CsLiteralNode(' 个项目'),
                ],
                'zero': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode('，0 个项目'),
                ],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemCommitted':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('已将项目从位置 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' 移动到位置 '),
                  CsArgumentNode('finalPosition'),
                  CsLiteralNode('（共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 个位置）'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('已将项目移回其原始位置 '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode('（共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 个位置）'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemReordered':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('正在将项目移动到位置 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode('（共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 个位置）'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('正在将项目移回位置 '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode('（共 '),
                  CsArgumentNode('total'),
                  CsLiteralNode(' 个位置）'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('已选择位于位置 '),
          CsArgumentNode('position'),
          CsLiteralNode('（共 '),
          CsArgumentNode('total'),
          CsLiteralNode(' 个位置）的项目'),
        ],
        'contentDisplayPreference.title': <CsMessageNode>[
          CsLiteralNode('列首选项'),
        ],
        'pageSizePreference.title': <CsMessageNode>[CsLiteralNode('页面大小')],
        'stickyColumnsPreference.firstColumns.description': <CsMessageNode>[
          CsLiteralNode('水平滚动表格内容时，保持前几列可见。'),
        ],
        'stickyColumnsPreference.firstColumns.options[0].label':
            <CsMessageNode>[CsLiteralNode('无')],
        'stickyColumnsPreference.firstColumns.options[1].label':
            <CsMessageNode>[CsLiteralNode('第一列')],
        'stickyColumnsPreference.firstColumns.options[2].label':
            <CsMessageNode>[CsLiteralNode('前两列')],
        'stickyColumnsPreference.firstColumns.title': <CsMessageNode>[
          CsLiteralNode('粘贴前几列'),
        ],
        'stickyColumnsPreference.lastColumns.description': <CsMessageNode>[
          CsLiteralNode('水平滚动表格内容时，保持最后一列可见。'),
        ],
        'stickyColumnsPreference.lastColumns.options[0].label': <CsMessageNode>[
          CsLiteralNode('无'),
        ],
        'stickyColumnsPreference.lastColumns.options[1].label': <CsMessageNode>[
          CsLiteralNode('最后一列'),
        ],
        'stickyColumnsPreference.lastColumns.title': <CsMessageNode>[
          CsLiteralNode('粘贴最后一列'),
        ],
        'stripedRowsPreference.description': <CsMessageNode>[
          CsLiteralNode('选择添加交替阴影行'),
        ],
        'stripedRowsPreference.label': <CsMessageNode>[CsLiteralNode('带条纹的行')],
        'title': <CsMessageNode>[CsLiteralNode('首选项')],
        'wrapLinesPreference.description': <CsMessageNode>[
          CsLiteralNode('选择查看所有文本并换行'),
        ],
        'wrapLinesPreference.label': <CsMessageNode>[CsLiteralNode('换行')],
      },
      'copy-to-clipboard': {
        'i18nStrings.copyButtonText': <CsMessageNode>[CsLiteralNode('复制')],
      },
      'date-picker': {
        'i18nStrings.openCalendarAriaLabel': <CsMessageNode>[
          CsSelectNode('selectedDate', {
            'none': <CsMessageNode>[CsLiteralNode('选择日期')],
            'other': <CsMessageNode>[
              CsLiteralNode('选择日期，所选日期为 '),
              CsArgumentNode('selectedDate'),
            ],
          }),
        ],
      },
      'date-range-picker': {
        'i18nStrings.absoluteModeTitle': <CsMessageNode>[CsLiteralNode('绝对模式')],
        'i18nStrings.applyButtonLabel': <CsMessageNode>[CsLiteralNode('应用')],
        'i18nStrings.cancelButtonLabel': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.clearButtonLabel': <CsMessageNode>[CsLiteralNode('清除并关闭')],
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('本月'),
        ],
        'i18nStrings.customRelativeRangeDurationLabel': <CsMessageNode>[
          CsLiteralNode('持续时间'),
        ],
        'i18nStrings.customRelativeRangeDurationPlaceholder': <CsMessageNode>[
          CsLiteralNode('输入持续时间'),
        ],
        'i18nStrings.customRelativeRangeOptionDescription': <CsMessageNode>[
          CsLiteralNode('设置过去的自定义范围'),
        ],
        'i18nStrings.customRelativeRangeOptionLabel': <CsMessageNode>[
          CsLiteralNode('自定义范围'),
        ],
        'i18nStrings.customRelativeRangeUnitLabel': <CsMessageNode>[
          CsLiteralNode('时间单位'),
        ],
        'i18nStrings.dateConstraintText': <CsMessageNode>[
          CsLiteralNode('对于日期，请使用 YYYY/MM/DD。'),
        ],
        'i18nStrings.datePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.dateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('对于日期，请使用 YYYY/MM/DD。对于时间，请使用 24 小时格式。'),
        ],
        'i18nStrings.endDateLabel': <CsMessageNode>[CsLiteralNode('结束日期')],
        'i18nStrings.endMonthLabel': <CsMessageNode>[CsLiteralNode('结束月底')],
        'i18nStrings.endTimeLabel': <CsMessageNode>[CsLiteralNode('结束时间')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.formatRelativeRange': <CsMessageNode>[
          CsSelectNode('unit', {
            'day': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 天'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 天'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 天'),
                ],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 小时'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 小时'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 小时'),
                ],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分钟'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分钟'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 分钟'),
                ],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 月'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 月'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 月'),
                ],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 秒'),
                ],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 周'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 周'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 周'),
                ],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('过去 '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' 年'),
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
                'one': <CsMessageNode>[CsLiteralNode('小时')],
                'other': <CsMessageNode>[CsLiteralNode('小时')],
                'zero': <CsMessageNode>[CsLiteralNode('小时')],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('分钟')],
                'other': <CsMessageNode>[CsLiteralNode('分钟')],
                'zero': <CsMessageNode>[CsLiteralNode('分钟')],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('月')],
                'other': <CsMessageNode>[CsLiteralNode('月')],
                'zero': <CsMessageNode>[CsLiteralNode('月')],
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
                'one': <CsMessageNode>[CsLiteralNode('周')],
                'other': <CsMessageNode>[CsLiteralNode('周')],
                'zero': <CsMessageNode>[CsLiteralNode('周')],
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
          CsLiteralNode('对于日期，请使用 YYYY-MM-DD。'),
        ],
        'i18nStrings.isoDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY-MM-DD'),
        ],
        'i18nStrings.isoDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('对于日期，请使用 YYYY-MM-DD。对于时间，请使用 24 小时格式。'),
        ],
        'i18nStrings.isoMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('对于月份，请使用 YYYY-MM。'),
        ],
        'i18nStrings.monthConstraintText': <CsMessageNode>[
          CsLiteralNode('对于月份，请使用 YYYY/MM。'),
        ],
        'i18nStrings.nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('下个月')],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[CsLiteralNode('下一年')],
        'i18nStrings.previousMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('上个月'),
        ],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('上一年'),
        ],
        'i18nStrings.relativeModeTitle': <CsMessageNode>[CsLiteralNode('相对模式')],
        'i18nStrings.relativeRangeSelectionHeading': <CsMessageNode>[
          CsLiteralNode('选择一个范围'),
        ],
        'i18nStrings.relativeRangeSelectionMonthlyDescription': <CsMessageNode>[
          CsLiteralNode('每个选项代表完整的月份，从该月的第一天到最后一天。'),
        ],
        'i18nStrings.renderSelectedAbsoluteRangeAriaLive': <CsMessageNode>[
          CsLiteralNode('选定范围从 '),
          CsArgumentNode('startDate'),
          CsLiteralNode(' 到 '),
          CsArgumentNode('endDate'),
        ],
        'i18nStrings.slashedDateConstraintText': <CsMessageNode>[
          CsLiteralNode('对于日期，请使用 YYYY/MM/DD。'),
        ],
        'i18nStrings.slashedDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('YYYY/MM/DD'),
        ],
        'i18nStrings.slashedDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode('对于日期，请使用 YYYY/MM/DD。对于时间，请使用 24 小时格式。'),
        ],
        'i18nStrings.slashedMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('对于月份，请使用 YYYY/MM。'),
        ],
        'i18nStrings.startDateLabel': <CsMessageNode>[CsLiteralNode('开始日期')],
        'i18nStrings.startMonthLabel': <CsMessageNode>[CsLiteralNode('开始月份')],
        'i18nStrings.startTimeLabel': <CsMessageNode>[CsLiteralNode('开始时间')],
        'i18nStrings.timePlaceholder': <CsMessageNode>[
          CsLiteralNode('hh:mm:ss'),
        ],
        'i18nStrings.todayAriaLabel': <CsMessageNode>[CsLiteralNode('今天')],
      },
      'dialog': {
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[CsLiteralNode('关闭对话框')],
      },
      'drawer': {
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('正在加载内容')],
      },
      'error-boundary': {
        'i18nStrings.descriptionText': <CsMessageNode>[
          CsSelectNode('hasFeedback', {
            'true': <CsMessageNode>[
              CsLiteralNode('刷新再试一次。我们正在跟踪此问题，但您可以'),
              CsTagNode('Feedback', <CsMessageNode>[
                CsLiteralNode('在此处共享更多信息'),
              ]),
              CsLiteralNode('。'),
            ],
            'other': <CsMessageNode>[CsLiteralNode('刷新再试一次。')],
          }),
        ],
        'i18nStrings.headerText': <CsMessageNode>[CsLiteralNode('意外错误，内容无法显示')],
        'i18nStrings.refreshActionText': <CsMessageNode>[CsLiteralNode('刷新页面')],
      },
      'features-notification-drawer': {
        'ariaLabels.closeButton': <CsMessageNode>[CsLiteralNode('关闭通知')],
        'ariaLabels.content': <CsMessageNode>[CsLiteralNode('功能通知')],
        'ariaLabels.resizeHandle': <CsMessageNode>[CsLiteralNode('调整功能通知的大小')],
        'ariaLabels.triggerButton': <CsMessageNode>[CsLiteralNode('显示功能通知')],
        'i18nStrings.title': <CsMessageNode>[CsLiteralNode('最新功能发布')],
        'i18nStrings.viewAll': <CsMessageNode>[CsLiteralNode('查看所有功能发布')],
      },
      'file-token-group': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('显示更少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('显示更多')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除文件 '),
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
            'false': <CsMessageNode>[CsLiteralNode('删除要上传的文件')],
            'true': <CsMessageNode>[CsLiteralNode('删除要上传的文件')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('显示更少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('显示更多')],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除文件 '),
          CsArgumentNode('fileIndex'),
        ],
        'i18nStrings.uploadButtonText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('选择文件')],
            'true': <CsMessageNode>[CsLiteralNode('选择文件')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'flashbar': {
        'i18nStrings.ariaLabel': <CsMessageNode>[CsLiteralNode('通知')],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.inProgressIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('进行中'),
        ],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[CsLiteralNode('信息')],
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
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
      },
      'form-field': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('警告'),
        ],
      },
      'help-panel': {
        'loadingText': <CsMessageNode>[CsLiteralNode('正在加载内容')],
      },
      'input': {
        'clearAriaLabel': <CsMessageNode>[CsLiteralNode('清除')],
      },
      'link': {
        'externalIconAriaLabel': <CsMessageNode>[CsLiteralNode('在新标签页中打开')],
      },
      'list': {
        'dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            '使用空格键或 Enter 键激活项目拖动功能，然后使用箭头键移动项目的位置。要完成位置移动，请使用空格键或 Enter 键，要放弃移动，请使用 Esc 键。',
          ),
        ],
        'dragHandleAriaLabel': <CsMessageNode>[CsLiteralNode('拖动手柄')],
        'liveAnnouncementDndDiscarded': <CsMessageNode>[
          CsLiteralNode('重新排序已取消'),
        ],
        'liveAnnouncementDndItemCommitted': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('已将项目从位置 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' 移动到位置 '),
              CsArgumentNode('finalPosition'),
              CsLiteralNode('（共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 个位置）'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('已将项目移回其原始位置 '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode('（共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 个位置）'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndItemReordered': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('正在将项目移动到位置 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode('（共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 个位置）'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('正在将项目移回位置 '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode('（共 '),
              CsArgumentNode('total'),
              CsLiteralNode(' 个位置）'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('已选择位于位置 '),
          CsArgumentNode('position'),
          CsLiteralNode('（共 '),
          CsArgumentNode('total'),
          CsLiteralNode(' 个位置）的项目'),
        ],
      },
      'modal': {
        'closeAriaLabel': <CsMessageNode>[CsLiteralNode('关闭模态')],
      },
      'multiselect': {
        'deselectAriaLabel': <CsMessageNode>[
          CsLiteralNode('删除 '),
          CsArgumentNode('option__label'),
        ],
        'i18nStrings.selectAllText': <CsMessageNode>[CsLiteralNode('选择全部')],
      },
      'option-list': {
        'i18nStrings.selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已选中')],
      },
      'pagination': {
        'ariaLabels.jumpToPageButtonLabel': <CsMessageNode>[
          CsLiteralNode('跳转到页面'),
        ],
        'ariaLabels.nextPageLabel': <CsMessageNode>[CsLiteralNode('下一页')],
        'ariaLabels.pageLabel': <CsMessageNode>[
          CsLiteralNode('所有页面中的第 '),
          CsArgumentNode('pageNumber'),
          CsLiteralNode(' 页'),
        ],
        'ariaLabels.previousPageLabel': <CsMessageNode>[CsLiteralNode('上一页')],
        'i18nStrings.jumpToPageError': <CsMessageNode>[
          CsLiteralNode('页面超出范围。显示最后一个可用页面。'),
        ],
        'i18nStrings.jumpToPageInputLabel': <CsMessageNode>[
          CsLiteralNode('页面'),
        ],
        'i18nStrings.jumpToPageLoadingText': <CsMessageNode>[
          CsLiteralNode('正在加载'),
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
              CsLiteralNode(' / '),
              CsArgumentNode('pagesCount'),
              CsLiteralNode('+'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
      },
      'panel-resize-handle': {
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('面板大小调整手柄'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('通过拖动或选择来调整大小'),
        ],
      },
      'pie-chart': {
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('饼状图'),
        ],
        'i18nStrings.detailsPercentage': <CsMessageNode>[CsLiteralNode('百分比')],
        'i18nStrings.detailsValue': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.segmentAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('部分'),
        ],
      },
      'popover': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('关闭弹出框')],
      },
      'prompt-input': {
        'i18nStrings.actionButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('提交提示'),
        ],
        'i18nStrings.menuErrorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('错误'),
        ],
        'i18nStrings.menuErrorText': <CsMessageNode>[CsLiteralNode('获取项目时出错')],
        'i18nStrings.menuFinishedText': <CsMessageNode>[CsLiteralNode('结果结束')],
        'i18nStrings.menuLoadingText': <CsMessageNode>[CsLiteralNode('正在加载项目')],
        'i18nStrings.menuRecoveryText': <CsMessageNode>[CsLiteralNode('重试')],
        'i18nStrings.selectedMenuItemAriaLabel': <CsMessageNode>[
          CsLiteralNode('已选择'),
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
          CsLiteralNode('所有属性'),
        ],
        'i18nStrings.applyActionText': <CsMessageNode>[CsLiteralNode('应用')],
        'i18nStrings.cancelActionText': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.clearFiltersText': <CsMessageNode>[
          CsLiteralNode('清除筛选条件'),
        ],
        'i18nStrings.editTokenHeader': <CsMessageNode>[CsLiteralNode('编辑筛选条件')],
        'i18nStrings.formatToken': <CsMessageNode>[
          CsSelectNode('token__operator', {
            'contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 包含 '),
              CsArgumentNode('token__value'),
            ],
            'equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 等于 '),
              CsArgumentNode('token__value'),
            ],
            'greater_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 大于或等于 '),
              CsArgumentNode('token__value'),
            ],
            'greater_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 大于 '),
              CsArgumentNode('token__value'),
            ],
            'less_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 小于或等于 '),
              CsArgumentNode('token__value'),
            ],
            'less_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 小于 '),
              CsArgumentNode('token__value'),
            ],
            'not_contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 不包含 '),
              CsArgumentNode('token__value'),
            ],
            'not_equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 不等于 '),
              CsArgumentNode('token__value'),
            ],
            'not_starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 开头不为 '),
              CsArgumentNode('token__value'),
            ],
            'starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' 开头为 '),
              CsArgumentNode('token__value'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.groupEditAriaLabel': <CsMessageNode>[
          CsSelectNode('group__formattedTokens__length', {
            '2': <CsMessageNode>[
              CsLiteralNode('编辑筛选条件组 '),
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
            ],
            '3': <CsMessageNode>[
              CsLiteralNode('编辑筛选条件组 '),
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
              CsLiteralNode('编辑筛选条件组 '),
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
              CsLiteralNode('再一次编辑筛选条件组 '),
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
              CsLiteralNode('再多次编辑筛选条件组 '),
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
        'i18nStrings.groupPropertiesText': <CsMessageNode>[CsLiteralNode('属性')],
        'i18nStrings.groupValuesText': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.operationAndText': <CsMessageNode>[CsLiteralNode('与')],
        'i18nStrings.operationOrText': <CsMessageNode>[CsLiteralNode('或')],
        'i18nStrings.operatorContainsText': <CsMessageNode>[
          CsLiteralNode('包含'),
        ],
        'i18nStrings.operatorDoesNotContainText': <CsMessageNode>[
          CsLiteralNode('不包含'),
        ],
        'i18nStrings.operatorDoesNotEqualText': <CsMessageNode>[
          CsLiteralNode('不等于'),
        ],
        'i18nStrings.operatorDoesNotStartWithText': <CsMessageNode>[
          CsLiteralNode('开头不为'),
        ],
        'i18nStrings.operatorEqualsText': <CsMessageNode>[CsLiteralNode('等于')],
        'i18nStrings.operatorGreaterOrEqualText': <CsMessageNode>[
          CsLiteralNode('大于或等于'),
        ],
        'i18nStrings.operatorGreaterText': <CsMessageNode>[CsLiteralNode('大于')],
        'i18nStrings.operatorLessOrEqualText': <CsMessageNode>[
          CsLiteralNode('小于或等于'),
        ],
        'i18nStrings.operatorLessText': <CsMessageNode>[CsLiteralNode('小于')],
        'i18nStrings.operatorStartsWithText': <CsMessageNode>[
          CsLiteralNode('开头为'),
        ],
        'i18nStrings.operatorText': <CsMessageNode>[CsLiteralNode('运算符')],
        'i18nStrings.operatorsText': <CsMessageNode>[CsLiteralNode('运算符')],
        'i18nStrings.propertyText': <CsMessageNode>[CsLiteralNode('属性')],
        'i18nStrings.removeTokenButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除筛选条件，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenAriaLabel': <CsMessageNode>[
          CsLiteralNode('向组添加筛选条件 '),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenLabel': <CsMessageNode>[
          CsLiteralNode('向组添加筛选条件 '),
          CsArgumentNode('token__propertyLabel'),
          CsLiteralNode(' '),
          CsArgumentNode('token__operator'),
          CsLiteralNode(' '),
          CsArgumentNode('token__value'),
        ],
        'i18nStrings.tokenEditorAddNewTokenLabel': <CsMessageNode>[
          CsLiteralNode('添加新筛选条件'),
        ],
        'i18nStrings.tokenEditorAddTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('添加筛选条件操作'),
        ],
        'i18nStrings.tokenEditorTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('筛选条件操作，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveAriaLabel': <CsMessageNode>[
          CsLiteralNode('移除筛选条件，'),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveFromGroupLabel': <CsMessageNode>[
          CsLiteralNode('从组中移除筛选条件'),
        ],
        'i18nStrings.tokenEditorTokenRemoveLabel': <CsMessageNode>[
          CsLiteralNode('移除筛选条件'),
        ],
        'i18nStrings.tokenLimitShowFewer': <CsMessageNode>[
          CsLiteralNode('显示更少'),
        ],
        'i18nStrings.tokenLimitShowMore': <CsMessageNode>[
          CsLiteralNode('显示更多'),
        ],
        'i18nStrings.valueText': <CsMessageNode>[CsLiteralNode('值')],
      },
      's3-resource-selector': {
        'i18nStrings.clearFilterButtonText': <CsMessageNode>[
          CsLiteralNode('清除筛选条件'),
        ],
        'i18nStrings.columnBucketCreationDate': <CsMessageNode>[
          CsLiteralNode('创建日期'),
        ],
        'i18nStrings.columnBucketID': <CsMessageNode>[CsLiteralNode('ID')],
        'i18nStrings.columnBucketName': <CsMessageNode>[CsLiteralNode('名称')],
        'i18nStrings.columnBucketRegion': <CsMessageNode>[CsLiteralNode('区域')],
        'i18nStrings.columnObjectKey': <CsMessageNode>[CsLiteralNode('键')],
        'i18nStrings.columnObjectLastModified': <CsMessageNode>[
          CsLiteralNode('上次修改时间'),
        ],
        'i18nStrings.columnObjectSize': <CsMessageNode>[CsLiteralNode('大小')],
        'i18nStrings.columnVersionID': <CsMessageNode>[CsLiteralNode('版本 ID')],
        'i18nStrings.columnVersionLastModified': <CsMessageNode>[
          CsLiteralNode('上次修改时间'),
        ],
        'i18nStrings.columnVersionSize': <CsMessageNode>[CsLiteralNode('大小')],
        'i18nStrings.filteringCantFindMatch': <CsMessageNode>[
          CsLiteralNode('找不到匹配项'),
        ],
        'i18nStrings.filteringCounterText': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('1 个匹配项')],
            'other': <CsMessageNode>[
              CsArgumentNode('count'),
              CsLiteralNode(' 个匹配项'),
            ],
          }),
        ],
        'i18nStrings.filteringNoMatches': <CsMessageNode>[
          CsLiteralNode('没有匹配项'),
        ],
        'i18nStrings.inContextBrowseButton': <CsMessageNode>[
          CsLiteralNode('浏览 S3'),
        ],
        'i18nStrings.inContextLoadingText': <CsMessageNode>[
          CsLiteralNode('正在加载资源'),
        ],
        'i18nStrings.inContextSelectPlaceholder': <CsMessageNode>[
          CsLiteralNode('选择版本'),
        ],
        'i18nStrings.inContextUriLabel': <CsMessageNode>[
          CsLiteralNode('S3 URI'),
        ],
        'i18nStrings.inContextVersionSelectLabel': <CsMessageNode>[
          CsLiteralNode('对象版本'),
        ],
        'i18nStrings.inContextViewButton': <CsMessageNode>[CsLiteralNode('查看')],
        'i18nStrings.inContextViewButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('查看（在新选项卡中打开）'),
        ],
        'i18nStrings.labelBreadcrumbs': <CsMessageNode>[
          CsLiteralNode('S3 面包屑'),
        ],
        'i18nStrings.labelFiltering': <CsMessageNode>[
          CsLiteralNode('查找 '),
          CsArgumentNode('itemsType'),
        ],
        'i18nStrings.labelIconFolder': <CsMessageNode>[CsLiteralNode('文件夹')],
        'i18nStrings.labelIconObject': <CsMessageNode>[CsLiteralNode('对象')],
        'i18nStrings.labelNotSorted': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，未排序'),
        ],
        'i18nStrings.labelRefresh': <CsMessageNode>[CsLiteralNode('刷新数据')],
        'i18nStrings.labelSortedAscending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，按升序排序'),
        ],
        'i18nStrings.labelSortedDescending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode('，按降序排序'),
        ],
        'i18nStrings.labelsBucketsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Name')],
        'i18nStrings.labelsBucketsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('存储桶')],
        'i18nStrings.labelsObjectsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Key')],
        'i18nStrings.labelsObjectsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('对象')],
        'i18nStrings.labelsVersionsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__VersionId')],
        'i18nStrings.labelsVersionsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('版本')],
        'i18nStrings.modalBreadcrumbRootItem': <CsMessageNode>[
          CsLiteralNode('S3 存储桶'),
        ],
        'i18nStrings.modalCancelButton': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.modalLastUpdatedText': <CsMessageNode>[
          CsLiteralNode('上次更新时间'),
        ],
        'i18nStrings.modalSubmitButton': <CsMessageNode>[CsLiteralNode('选择')],
        'i18nStrings.modalTitle': <CsMessageNode>[
          CsLiteralNode('在 S3 中选择一个对象'),
        ],
        'i18nStrings.selectionBuckets': <CsMessageNode>[CsLiteralNode('存储桶')],
        'i18nStrings.selectionBucketsLoading': <CsMessageNode>[
          CsLiteralNode('正在加载存储桶'),
        ],
        'i18nStrings.selectionBucketsNoItems': <CsMessageNode>[
          CsLiteralNode('没有存储桶'),
        ],
        'i18nStrings.selectionBucketsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('查找存储桶'),
        ],
        'i18nStrings.selectionObjects': <CsMessageNode>[CsLiteralNode('对象')],
        'i18nStrings.selectionObjectsLoading': <CsMessageNode>[
          CsLiteralNode('正在加载对象'),
        ],
        'i18nStrings.selectionObjectsNoItems': <CsMessageNode>[
          CsLiteralNode('没有对象'),
        ],
        'i18nStrings.selectionObjectsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('按前缀查找对象'),
        ],
        'i18nStrings.selectionVersions': <CsMessageNode>[CsLiteralNode('版本')],
        'i18nStrings.selectionVersionsLoading': <CsMessageNode>[
          CsLiteralNode('正在加载版本'),
        ],
        'i18nStrings.selectionVersionsNoItems': <CsMessageNode>[
          CsLiteralNode('没有版本'),
        ],
        'i18nStrings.selectionVersionsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('查找版本'),
        ],
        'i18nStrings.validationBucketLength': <CsMessageNode>[
          CsLiteralNode('存储桶名称必须介于 3 到 63 个字符之间。'),
        ],
        'i18nStrings.validationBucketLowerCase': <CsMessageNode>[
          CsLiteralNode('存储桶名称必须以小写字符或数字开头。'),
        ],
        'i18nStrings.validationBucketMustComplyDns': <CsMessageNode>[
          CsLiteralNode('存储桶名称必须符合 DNS 命名惯例。'),
        ],
        'i18nStrings.validationBucketMustNotContain': <CsMessageNode>[
          CsLiteralNode('存储桶名称不得包含大写字符。'),
        ],
        'i18nStrings.validationPathMustBegin': <CsMessageNode>[
          CsLiteralNode('路径必须以 s3:// 开头才有效。'),
        ],
      },
      'select': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('错误')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('重试')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('已选定')],
      },
      'slider': {
        'i18nStrings.valueTextRange': <CsMessageNode>[
          CsArgumentNode('value'),
          CsLiteralNode('，介于 '),
          CsArgumentNode('previousValue'),
          CsLiteralNode(' 和 '),
          CsArgumentNode('nextValue'),
          CsLiteralNode(' 之间'),
        ],
      },
      'split-panel': {
        'i18nStrings.closeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('关闭面板'),
        ],
        'i18nStrings.openButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('打开面板'),
        ],
        'i18nStrings.preferencesCancel': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.preferencesConfirm': <CsMessageNode>[CsLiteralNode('确认')],
        'i18nStrings.preferencesPositionBottom': <CsMessageNode>[
          CsLiteralNode('底部'),
        ],
        'i18nStrings.preferencesPositionDescription': <CsMessageNode>[
          CsLiteralNode('为服务选择默认的拆分面板位置。'),
        ],
        'i18nStrings.preferencesPositionLabel': <CsMessageNode>[
          CsLiteralNode('拆分面板位置'),
        ],
        'i18nStrings.preferencesPositionSide': <CsMessageNode>[
          CsLiteralNode('侧面'),
        ],
        'i18nStrings.preferencesTitle': <CsMessageNode>[
          CsLiteralNode('拆分面板首选项'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('调整拆分面板的大小'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('通过拖动或选择来调整大小'),
        ],
      },
      'table': {
        'ariaLabels.collapseButtonLabel': <CsMessageNode>[CsLiteralNode('折叠')],
        'ariaLabels.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展开')],
        'ariaLabels.liveAnnouncementSortCleared': <CsMessageNode>[
          CsLiteralNode('排序已清除'),
        ],
        'ariaLabels.liveAnnouncementSortOrder': <CsMessageNode>[
          CsLiteralNode('表格已按 '),
          CsArgumentNode('columns'),
          CsLiteralNode(' 排序'),
        ],
        'ariaLabels.resizerRoleDescription': <CsMessageNode>[
          CsLiteralNode('调整按钮大小'),
        ],
        'ariaLabels.sortAscending': <CsMessageNode>[CsLiteralNode('升序')],
        'ariaLabels.sortDescending': <CsMessageNode>[CsLiteralNode('降序')],
        'ariaLabels.sortMenuTriggerLabel': <CsMessageNode>[
          CsLiteralNode('排序选项'),
        ],
        'ariaLabels.sortPriority': <CsMessageNode>[
          CsLiteralNode('排序优先级 '),
          CsArgumentNode('priority'),
        ],
        'ariaLabels.submittingEditText': <CsMessageNode>[
          CsLiteralNode('正在提交编辑'),
        ],
        'ariaLabels.successfulEditLabel': <CsMessageNode>[
          CsLiteralNode('编辑成功'),
        ],
        'columnDefinitions.editConfig.editIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('可编辑'),
        ],
        'columnDefinitions.editConfig.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('错误'),
        ],
        'i18nStrings.clearSort': <CsMessageNode>[CsLiteralNode('清除排序')],
        'i18nStrings.sortDropdownAddToSortAscending': <CsMessageNode>[
          CsLiteralNode('添加到排序（升序）'),
        ],
        'i18nStrings.sortDropdownAddToSortDescending': <CsMessageNode>[
          CsLiteralNode('添加到排序（降序）'),
        ],
        'i18nStrings.sortDropdownAddToSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('此列已排序'),
        ],
        'i18nStrings.sortDropdownMultiColumnSortGroup': <CsMessageNode>[
          CsLiteralNode('多列排序（按住 Shift 键点击）'),
        ],
        'i18nStrings.sortDropdownRemoveFromSort': <CsMessageNode>[
          CsLiteralNode('从排序中移除'),
        ],
        'i18nStrings.sortDropdownRemoveFromSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('此列未排序'),
        ],
        'i18nStrings.sortDropdownSortAscending': <CsMessageNode>[
          CsLiteralNode('升序排序'),
        ],
        'i18nStrings.sortDropdownSortDescending': <CsMessageNode>[
          CsLiteralNode('降序排序'),
        ],
      },
      'tabs': {
        'i18nStrings.scrollLeftAriaLabel': <CsMessageNode>[
          CsLiteralNode('向左滚动'),
        ],
        'i18nStrings.scrollRightAriaLabel': <CsMessageNode>[
          CsLiteralNode('向右滚动'),
        ],
        'i18nStrings.tabsWithActionsAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('带有操作的选项卡'),
        ],
      },
      'tag-editor': {
        'i18nStrings.addButton': <CsMessageNode>[CsLiteralNode('添加新标签')],
        'i18nStrings.awsPrefixError': <CsMessageNode>[
          CsLiteralNode('不能以 aws: 开头'),
        ],
        'i18nStrings.duplicateKeyError': <CsMessageNode>[
          CsLiteralNode('您必须指定唯一的标签键。'),
        ],
        'i18nStrings.emptyKeyError': <CsMessageNode>[CsLiteralNode('您必须指定标签键')],
        'i18nStrings.emptyTags': <CsMessageNode>[CsLiteralNode('没有与资源关联的标签。')],
        'i18nStrings.invalidKeyError': <CsMessageNode>[
          CsLiteralNode('键无效。键只能包含 Unicode 字母、数字、空格和以下任意字符：_.:/=+@-'),
        ],
        'i18nStrings.invalidValueError': <CsMessageNode>[
          CsLiteralNode('值无效。值只能包含 Unicode 字母、数字、空格和以下任意字符：_.:/=+@-'),
        ],
        'i18nStrings.keyHeader': <CsMessageNode>[CsLiteralNode('键')],
        'i18nStrings.keyPlaceholder': <CsMessageNode>[CsLiteralNode('输入键')],
        'i18nStrings.keySuggestion': <CsMessageNode>[CsLiteralNode('自定义标签键')],
        'i18nStrings.keysSuggestionError': <CsMessageNode>[
          CsLiteralNode('无法检索标签键'),
        ],
        'i18nStrings.keysSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('正在加载标签键'),
        ],
        'i18nStrings.loading': <CsMessageNode>[CsLiteralNode('正在加载与此资源关联的标签')],
        'i18nStrings.maxKeyCharLengthError': <CsMessageNode>[
          CsLiteralNode('标签键中最多可使用 128 个字符。'),
        ],
        'i18nStrings.maxValueCharLengthError': <CsMessageNode>[
          CsLiteralNode('标签值中最多可使用 256 个字符。'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('可选')],
        'i18nStrings.removeButton': <CsMessageNode>[CsLiteralNode('删除')],
        'i18nStrings.removeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('删除 '),
          CsArgumentNode('tag__key'),
        ],
        'i18nStrings.tagLimit': <CsMessageNode>[
          CsSelectNode('tagLimitAvailable', {
            'false': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'one': <CsMessageNode>[CsLiteralNode('您最多可以再添加 1 个标签。')],
                'other': <CsMessageNode>[
                  CsLiteralNode('您最多可以再添加 '),
                  CsArgumentNode('availableTags'),
                  CsLiteralNode(' 个标签。'),
                ],
              }),
            ],
            'true': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'other': <CsMessageNode>[
                  CsLiteralNode('您最多可以添加 '),
                  CsArgumentNode('tagLimit'),
                  CsLiteralNode(' 个标签。'),
                ],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tagLimitExceeded': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('您已超过 1 个标签的限制。')],
            'other': <CsMessageNode>[
              CsLiteralNode('您已超过 '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 个标签的限制。'),
            ],
          }),
        ],
        'i18nStrings.tagLimitReached': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[CsLiteralNode('您已达到 1 个标签的限制。')],
            'other': <CsMessageNode>[
              CsLiteralNode('您已达到 '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' 个标签的限制。'),
            ],
          }),
        ],
        'i18nStrings.tooManyKeysSuggestion': <CsMessageNode>[
          CsLiteralNode('您的键超过了可以显示的数量'),
        ],
        'i18nStrings.tooManyValuesSuggestion': <CsMessageNode>[
          CsLiteralNode('您的值超过了可以显示的数量'),
        ],
        'i18nStrings.undoButton': <CsMessageNode>[CsLiteralNode('撤销')],
        'i18nStrings.undoPrompt': <CsMessageNode>[CsLiteralNode('保存更改后将删除此标签')],
        'i18nStrings.valueHeader': <CsMessageNode>[CsLiteralNode('值')],
        'i18nStrings.valuePlaceholder': <CsMessageNode>[CsLiteralNode('输入值')],
        'i18nStrings.valueSuggestion': <CsMessageNode>[CsLiteralNode('自定义标签值')],
        'i18nStrings.valuesSuggestionError': <CsMessageNode>[
          CsLiteralNode('无法检索标签值'),
        ],
        'i18nStrings.valuesSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('正在加载标签值'),
        ],
      },
      'token-group': {
        'i18nStrings.limitShowFewer': <CsMessageNode>[CsLiteralNode('显示更少')],
        'i18nStrings.limitShowMore': <CsMessageNode>[CsLiteralNode('显示更多')],
      },
      'top-navigation': {
        'i18nStrings.overflowMenuBackIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('返回'),
        ],
        'i18nStrings.overflowMenuDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('关闭菜单'),
        ],
        'i18nStrings.overflowMenuTitleText': <CsMessageNode>[
          CsLiteralNode('全部'),
        ],
        'i18nStrings.overflowMenuTriggerText': <CsMessageNode>[
          CsLiteralNode('更多'),
        ],
        'i18nStrings.searchDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('关闭搜索'),
        ],
        'i18nStrings.searchIconAriaLabel': <CsMessageNode>[CsLiteralNode('搜索')],
      },
      'tree-view': {
        'i18nStrings.collapseButtonLabel': <CsMessageNode>[CsLiteralNode('折叠')],
        'i18nStrings.expandButtonLabel': <CsMessageNode>[CsLiteralNode('展开')],
      },
      'tutorial-panel': {
        'i18nStrings.completionScreenTitle': <CsMessageNode>[
          CsLiteralNode('恭喜！您完成了本教程。'),
        ],
        'i18nStrings.dismissTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('关闭教程'),
        ],
        'i18nStrings.feedbackLinkText': <CsMessageNode>[CsLiteralNode('反馈')],
        'i18nStrings.labelExitTutorial': <CsMessageNode>[CsLiteralNode('关闭教程')],
        'i18nStrings.labelTotalSteps': <CsMessageNode>[
          CsLiteralNode('总步骤数：'),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.labelTutorialListDownloadLink': <CsMessageNode>[
          CsLiteralNode('下载本教程的 PDF 版本'),
        ],
        'i18nStrings.labelsTaskStatus.in-progress': <CsMessageNode>[
          CsLiteralNode('进行中'),
        ],
        'i18nStrings.labelsTaskStatus.pending': <CsMessageNode>[
          CsLiteralNode('待处理'),
        ],
        'i18nStrings.labelsTaskStatus.success': <CsMessageNode>[
          CsLiteralNode('成功'),
        ],
        'i18nStrings.learnMoreLinkText': <CsMessageNode>[CsLiteralNode('了解更多')],
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('正在加载')],
        'i18nStrings.restartTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('重启教程'),
        ],
        'i18nStrings.startTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('启动教程'),
        ],
        'i18nStrings.stepTitle': <CsMessageNode>[
          CsLiteralNode('步骤 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode('：'),
          CsArgumentNode('stepTitle'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('任务 '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode('：'),
          CsArgumentNode('taskTitle'),
        ],
        'i18nStrings.tutorialCompletedText': <CsMessageNode>[
          CsLiteralNode('教程已完成'),
        ],
        'i18nStrings.tutorialListDownloadLinkText': <CsMessageNode>[
          CsLiteralNode('下载 PDF 版本'),
        ],
        'i18nStrings.tutorialListTitle': <CsMessageNode>[CsLiteralNode('选择教程')],
      },
      'wizard': {
        'i18nStrings.cancelButton': <CsMessageNode>[CsLiteralNode('取消')],
        'i18nStrings.collapsedStepsLabel': <CsMessageNode>[
          CsLiteralNode('第 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(' 步，共 '),
          CsArgumentNode('stepsCount'),
          CsLiteralNode(' 步'),
        ],
        'i18nStrings.navigationAriaLabel': <CsMessageNode>[CsLiteralNode('步骤')],
        'i18nStrings.nextButton': <CsMessageNode>[CsLiteralNode('下一步')],
        'i18nStrings.nextButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('正在加载下一步'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('可选')],
        'i18nStrings.previousButton': <CsMessageNode>[CsLiteralNode('上一步')],
        'i18nStrings.skipToButtonLabel': <CsMessageNode>[
          CsLiteralNode('跳至 '),
          CsArgumentNode('task__title'),
        ],
        'i18nStrings.stepNumberLabel': <CsMessageNode>[
          CsLiteralNode('第 '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(' 步'),
        ],
        'i18nStrings.submitButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('正在提交表单'),
        ],
      },
    },
  },
};
