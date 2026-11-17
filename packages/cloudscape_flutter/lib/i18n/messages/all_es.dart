// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

/// Cloudscape component messages for `es`.
library;

import 'package:cloudscape_flutter/src/i18n/message_ast.dart';

/// Upstream `@cloudscape-design/components/i18n/messages/all.es`.
const CsI18nMessages csMessagesEs = {
  'cloudscape-design-components': {
    'es': {
      '[charts]': {
        'errorText': <CsMessageNode>[
          CsLiteralNode(
            'No se pudieron recuperar los datos. Inténtelo de nuevo más tarde.',
          ),
        ],
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('Gráfico'),
        ],
        'i18nStrings.enterZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Ingrese en el modo de zoom'),
        ],
        'i18nStrings.enterZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('Zoom'),
        ],
        'i18nStrings.exitZoomModeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Salir del modo de zoom'),
        ],
        'i18nStrings.exitZoomModeButtonText': <CsMessageNode>[
          CsLiteralNode('Salir del zoom'),
        ],
        'i18nStrings.filterLabel': <CsMessageNode>[
          CsLiteralNode('Filtrar los datos mostrados'),
        ],
        'i18nStrings.filterPlaceholder': <CsMessageNode>[
          CsLiteralNode('Filtrar datos'),
        ],
        'i18nStrings.legendAriaLabel': <CsMessageNode>[
          CsLiteralNode('Leyenda'),
        ],
        'i18nStrings.resetZoomButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode(
            'Restablezca el zoom para mostrar el rango completo de datos',
          ),
        ],
        'i18nStrings.resetZoomButtonText': <CsMessageNode>[
          CsLiteralNode('Restablecer'),
        ],
        'i18nStrings.xAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('eje x'),
        ],
        'i18nStrings.yAxisAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('eje y'),
        ],
        'i18nStrings.zoomControlsAriaLabel': <CsMessageNode>[
          CsLiteralNode('Controles de zoom del gráfico'),
        ],
        'i18nStrings.zoomCursorAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cursor de rango de zoom'),
        ],
        'i18nStrings.zoomCursorNextButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Mueva el cursor de zoom al siguiente punto'),
        ],
        'i18nStrings.zoomCursorPreviousButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Mueva el cursor de zoom al punto anterior'),
        ],
        'i18nStrings.zoomModeEnteredAnnouncementText': <CsMessageNode>[
          CsLiteralNode('Modo de zoom. Cursor en '),
          CsArgumentNode('value'),
          CsLiteralNode(
            '. Use las teclas de flecha para moverse y Enter para establecer el punto de inicio.',
          ),
        ],
        'i18nStrings.zoomModeExitedAnnouncementText': <CsMessageNode>[
          CsLiteralNode('Modo de zoom cancelado.'),
        ],
        'i18nStrings.zoomRangeChangeAnnouncementText': <CsMessageNode>[
          CsLiteralNode('Ampliado de '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' a '),
          CsArgumentNode('endValue'),
          CsLiteralNode('.'),
        ],
        'i18nStrings.zoomResetAnnouncementText': <CsMessageNode>[
          CsLiteralNode(
            'Reinicio del zoom. Mostrando el rango completo de datos.',
          ),
        ],
        'i18nStrings.zoomSelectionAnnouncementText': <CsMessageNode>[
          CsLiteralNode('Seleccionando el rango de zoom de '),
          CsArgumentNode('startValue'),
          CsLiteralNode(' a '),
          CsArgumentNode('endValue'),
          CsLiteralNode('.'),
        ],
        'i18nStrings.zoomStartPointAnnouncementText': <CsMessageNode>[
          CsLiteralNode('Punto de inicio establecido en '),
          CsArgumentNode('value'),
          CsLiteralNode(
            '. Mueva el cursor y ajuste el punto final para hacer zoom.',
          ),
        ],
        'loadingText': <CsMessageNode>[CsLiteralNode('Cargando gráfico')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('Reintentar')],
      },
      'alert': {
        'dismissAriaLabel': <CsMessageNode>[CsLiteralNode('Descartar alerta')],
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('Descartar alerta'),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Información'),
        ],
        'i18nStrings.successIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Éxito'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Aviso'),
        ],
      },
      'annotation-context': {
        'i18nStrings.finishButtonText': <CsMessageNode>[
          CsLiteralNode('Finalizar'),
        ],
        'i18nStrings.labelDismissAnnotation': <CsMessageNode>[
          CsLiteralNode('Descartar anotación'),
        ],
        'i18nStrings.labelHotspot': <CsMessageNode>[
          CsSelectNode('openState', {
            'false': <CsMessageNode>[
              CsLiteralNode('Anotación para el paso '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' de '),
              CsArgumentNode('totalStepCount'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('Anotación para el paso '),
              CsArgumentNode('stepNumber'),
              CsLiteralNode(' de '),
              CsArgumentNode('totalStepCount'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.nextButtonText': <CsMessageNode>[
          CsLiteralNode('Siguiente'),
        ],
        'i18nStrings.previousButtonText': <CsMessageNode>[
          CsLiteralNode('Anterior'),
        ],
        'i18nStrings.stepCounterText': <CsMessageNode>[
          CsLiteralNode('Paso '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(' de '),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('Tarea '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode(': '),
          CsArgumentNode('taskTitle'),
        ],
      },
      'app-layout': {
        'ariaLabels.drawers': <CsMessageNode>[CsLiteralNode('Cajones')],
        'ariaLabels.drawersOverflow': <CsMessageNode>[
          CsLiteralNode('Desbordamiento de cajones'),
        ],
        'ariaLabels.drawersOverflowWithBadge': <CsMessageNode>[
          CsLiteralNode('Desbordamiento de cajones con insignia'),
        ],
        'ariaLabels.navigation': <CsMessageNode>[
          CsLiteralNode('Navegación lateral'),
        ],
        'ariaLabels.navigationClose': <CsMessageNode>[
          CsLiteralNode('Cerrar navegación lateral'),
        ],
        'ariaLabels.navigationToggle': <CsMessageNode>[
          CsLiteralNode('Abrir navegación lateral'),
        ],
        'ariaLabels.notifications': <CsMessageNode>[
          CsLiteralNode('Notificaciones'),
        ],
        'ariaLabels.tools': <CsMessageNode>[CsLiteralNode('Panel de ayuda')],
        'ariaLabels.toolsClose': <CsMessageNode>[
          CsLiteralNode('Cerrar el panel de ayuda'),
        ],
        'ariaLabels.toolsToggle': <CsMessageNode>[
          CsLiteralNode('Abrir el panel de ayuda'),
        ],
      },
      'area-chart': {
        'i18nStrings.detailTotalLabel': <CsMessageNode>[CsLiteralNode('Total')],
      },
      'attribute-editor': {
        'i18nStrings.itemRemovedAriaLive': <CsMessageNode>[
          CsLiteralNode('Elemento eliminado'),
        ],
        'removeButtonText': <CsMessageNode>[CsLiteralNode('Eliminar')],
      },
      'autosuggest': {
        'enteredTextLabel': <CsMessageNode>[
          CsLiteralNode('Utilizar: “'),
          CsArgumentNode('value'),
          CsLiteralNode('”'),
        ],
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('Error')],
        'i18nStrings.enteredTextLabel': <CsMessageNode>[
          CsSelectNode('isTokenMode', {
            'false': <CsMessageNode>[
              CsLiteralNode('Usar: “'),
              CsArgumentNode('value'),
              CsLiteralNode('”'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('Agregar “'),
              CsArgumentNode('value'),
              CsLiteralNode('”'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tokenDismissLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar '),
          CsArgumentNode('token__label'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsLiteralNode('Se insertó '),
          CsArgumentNode('token__label'),
        ],
        'i18nStrings.tokenOverflowAriaLabel': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('1 elemento más')],
            'other': <CsMessageNode>[
              CsArgumentNode('count'),
              CsLiteralNode(' elementos más'),
            ],
          }),
        ],
        'recoveryText': <CsMessageNode>[CsLiteralNode('Reintentar')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('Seleccionado')],
      },
      'breadcrumb-group': {
        'expandAriaLabel': <CsMessageNode>[CsLiteralNode('Mostrar ruta')],
      },
      'button': {
        'i18nStrings.externalIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Se abre en una pestaña nueva'),
        ],
      },
      'button-dropdown': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('Error')],
        'filteringResultsText': <CsMessageNode>[
          CsArgumentNode('matchesCount'),
          CsLiteralNode(' de '),
          CsArgumentNode('totalCount'),
          CsLiteralNode(' elementos'),
        ],
        'i18nStrings.filteringItemAriaDescription': <CsMessageNode>[
          CsLiteralNode('Siga escribiendo para filtrar los resultados.'),
        ],
        'noMatch': <CsMessageNode>[
          CsLiteralNode('No hay acciones coincidentes'),
        ],
        'recoveryText': <CsMessageNode>[CsLiteralNode('Reintentar')],
      },
      'calendar': {
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('Mes actual'),
        ],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('Próximo año'),
        ],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('Año anterior'),
        ],
        'nextMonthAriaLabel': <CsMessageNode>[CsLiteralNode('Próximo mes')],
        'previousMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('Mes anterior'),
        ],
        'todayAriaLabel': <CsMessageNode>[CsLiteralNode('Hoy')],
      },
      'cards': {
        'ariaLabels.selectionGroupLabel': <CsMessageNode>[
          CsLiteralNode('Selección de elementos'),
        ],
      },
      'code-editor': {
        'i18nStrings.cursorPosition': <CsMessageNode>[
          CsLiteralNode('Ln '),
          CsArgumentNode('row'),
          CsLiteralNode(', Col '),
          CsArgumentNode('column'),
        ],
        'i18nStrings.cursorPositionAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cursor en fila '),
          CsArgumentNode('row'),
        ],
        'i18nStrings.editorGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('Editor de código'),
        ],
        'i18nStrings.errorState': <CsMessageNode>[
          CsLiteralNode(
            'Se ha producido un error al cargar el editor de código.',
          ),
        ],
        'i18nStrings.errorStateRecovery': <CsMessageNode>[
          CsLiteralNode('Reintentar'),
        ],
        'i18nStrings.errorsTab': <CsMessageNode>[CsLiteralNode('Errores')],
        'i18nStrings.loadingState': <CsMessageNode>[
          CsLiteralNode('Cargando editor de código'),
        ],
        'i18nStrings.paneCloseButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar'),
        ],
        'i18nStrings.preferencesButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Preferencias'),
        ],
        'i18nStrings.preferencesModalCancel': <CsMessageNode>[
          CsLiteralNode('Cancelar'),
        ],
        'i18nStrings.preferencesModalConfirm': <CsMessageNode>[
          CsLiteralNode('Confirmar'),
        ],
        'i18nStrings.preferencesModalDarkThemes': <CsMessageNode>[
          CsLiteralNode('Temas oscuros'),
        ],
        'i18nStrings.preferencesModalHeader': <CsMessageNode>[
          CsLiteralNode('Preferencias'),
        ],
        'i18nStrings.preferencesModalLightThemes': <CsMessageNode>[
          CsLiteralNode('Temas claros'),
        ],
        'i18nStrings.preferencesModalTheme': <CsMessageNode>[
          CsLiteralNode('Tema'),
        ],
        'i18nStrings.preferencesModalThemeFilteringAriaLabel': <CsMessageNode>[
          CsLiteralNode('Filtrar temas'),
        ],
        'i18nStrings.preferencesModalThemeFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('Filtrar temas')],
        'i18nStrings.preferencesModalWrapLines': <CsMessageNode>[
          CsLiteralNode('Ajustar líneas'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cambiar el tamaño del controlador'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('Arrastre o seleccione para cambiar el tamaño'),
        ],
        'i18nStrings.statusBarGroupAriaLabel': <CsMessageNode>[
          CsLiteralNode('Barra de estado'),
        ],
        'i18nStrings.warningsTab': <CsMessageNode>[
          CsLiteralNode('Advertencias'),
        ],
      },
      'collection-preferences': {
        'cancelLabel': <CsMessageNode>[CsLiteralNode('Cancelar')],
        'confirmLabel': <CsMessageNode>[CsLiteralNode('Confirmar')],
        'contentDensityPreference.description': <CsMessageNode>[
          CsLiteralNode(
            'Seleccione para mostrar contenido en un modo más denso y compacto',
          ),
        ],
        'contentDensityPreference.label': <CsMessageNode>[
          CsLiteralNode('Modo compacto'),
        ],
        'contentDisplayPreference.description': <CsMessageNode>[
          CsLiteralNode(
            'Personalice la visibilidad y el orden de las columnas.',
          ),
        ],
        'contentDisplayPreference.dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            'Utilice la barra espaciadora o Enter para activar el arrastre de un elemento y, a continuación, utilice las teclas de flecha para mover la posición del elemento. Para completar el movimiento de la posición, utilice la barra espaciadora o Enter, o para descartar el movimiento, utilice Escape. Es posible que necesite cambiar el modo de navegación en el lector de pantalla.',
          ),
        ],
        'contentDisplayPreference.dragHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('Arrastrar controlador'),
        ],
        'contentDisplayPreference.i18nStrings.columnFilteringAriaLabel':
            <CsMessageNode>[CsLiteralNode('Filtrar columnas')],
        'contentDisplayPreference.i18nStrings.columnFilteringClearFilterText':
            <CsMessageNode>[CsLiteralNode('Quitar filtro')],
        'contentDisplayPreference.i18nStrings.columnFilteringCountText':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[CsLiteralNode('1 coincidencia')],
                'other': <CsMessageNode>[
                  CsArgumentNode('count'),
                  CsLiteralNode(' coincidencias'),
                ],
                'zero': <CsMessageNode>[CsLiteralNode('0 coincidencias')],
              }),
            ],
        'contentDisplayPreference.i18nStrings.columnFilteringNoMatchText':
            <CsMessageNode>[CsLiteralNode('No se encontraron coincidencias')],
        'contentDisplayPreference.i18nStrings.columnFilteringPlaceholder':
            <CsMessageNode>[CsLiteralNode('Filtrar columnas')],
        'contentDisplayPreference.liveAnnouncementDndDiscarded':
            <CsMessageNode>[CsLiteralNode('Reordenación cancelada')],
        'contentDisplayPreference.liveAnnouncementDndGroupLabel':
            <CsMessageNode>[
              CsPluralNode('count', {
                'one': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode(', 1 elemento'),
                ],
                'other': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode(', '),
                  CsArgumentNode('count'),
                  CsLiteralNode(' elementos'),
                ],
                'zero': <CsMessageNode>[
                  CsArgumentNode('label'),
                  CsLiteralNode(', 0 elementos'),
                ],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemCommitted':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('El artículo se movió de la posición '),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' a la posición '),
                  CsArgumentNode('finalPosition'),
                  CsLiteralNode(' de '),
                  CsArgumentNode('total'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode(
                    'El artículo ha vuelto a su posición original ',
                  ),
                  CsArgumentNode('initialPosition'),
                  CsLiteralNode(' de '),
                  CsArgumentNode('total'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndItemReordered':
            <CsMessageNode>[
              CsSelectNode('isInitialPosition', {
                'false': <CsMessageNode>[
                  CsLiteralNode('Mover el elemento a la posición '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode(' de '),
                  CsArgumentNode('total'),
                ],
                'true': <CsMessageNode>[
                  CsLiteralNode('Mover el elemento de nuevo a la posición '),
                  CsArgumentNode('currentPosition'),
                  CsLiteralNode(' de '),
                  CsArgumentNode('total'),
                ],
                'other': <CsMessageNode>[],
              }),
            ],
        'contentDisplayPreference.liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('Recogida del elemento en la posición '),
          CsArgumentNode('position'),
          CsLiteralNode(' de '),
          CsArgumentNode('total'),
        ],
        'contentDisplayPreference.title': <CsMessageNode>[
          CsLiteralNode('Preferencias de columnas'),
        ],
        'pageSizePreference.title': <CsMessageNode>[
          CsLiteralNode('Tamaño de página'),
        ],
        'stickyColumnsPreference.firstColumns.description': <CsMessageNode>[
          CsLiteralNode(
            'Mantenga las primeras columnas visibles mientras desplaza horizontalmente el contenido de la tabla.',
          ),
        ],
        'stickyColumnsPreference.firstColumns.options[0].label':
            <CsMessageNode>[CsLiteralNode('Ninguno')],
        'stickyColumnsPreference.firstColumns.options[1].label':
            <CsMessageNode>[CsLiteralNode('Primera columna')],
        'stickyColumnsPreference.firstColumns.options[2].label':
            <CsMessageNode>[CsLiteralNode('Primeras dos columnas')],
        'stickyColumnsPreference.firstColumns.title': <CsMessageNode>[
          CsLiteralNode('Pegar las primeras columnas'),
        ],
        'stickyColumnsPreference.lastColumns.description': <CsMessageNode>[
          CsLiteralNode(
            'Mantenga visible la última columna mientras desplaza horizontalmente el contenido de la tabla.',
          ),
        ],
        'stickyColumnsPreference.lastColumns.options[0].label': <CsMessageNode>[
          CsLiteralNode('Ninguno'),
        ],
        'stickyColumnsPreference.lastColumns.options[1].label': <CsMessageNode>[
          CsLiteralNode('Última columna'),
        ],
        'stickyColumnsPreference.lastColumns.title': <CsMessageNode>[
          CsLiteralNode('Pegar la última columna'),
        ],
        'stripedRowsPreference.description': <CsMessageNode>[
          CsLiteralNode(
            'Seleccione para agregar filas sombreadas alternativas',
          ),
        ],
        'stripedRowsPreference.label': <CsMessageNode>[
          CsLiteralNode('Filas rayadas'),
        ],
        'title': <CsMessageNode>[CsLiteralNode('Preferencias')],
        'wrapLinesPreference.description': <CsMessageNode>[
          CsLiteralNode(
            'Seleccione para ver todo el texto y ajustar las líneas',
          ),
        ],
        'wrapLinesPreference.label': <CsMessageNode>[
          CsLiteralNode('Ajustar líneas'),
        ],
      },
      'copy-to-clipboard': {
        'i18nStrings.copyButtonText': <CsMessageNode>[CsLiteralNode('Copiar')],
      },
      'date-picker': {
        'i18nStrings.openCalendarAriaLabel': <CsMessageNode>[
          CsSelectNode('selectedDate', {
            'none': <CsMessageNode>[CsLiteralNode('Elegir fecha')],
            'other': <CsMessageNode>[
              CsLiteralNode('Elegir fecha; la fecha seleccionada es '),
              CsArgumentNode('selectedDate'),
            ],
          }),
        ],
      },
      'date-range-picker': {
        'i18nStrings.absoluteModeTitle': <CsMessageNode>[
          CsLiteralNode('Modo absoluto'),
        ],
        'i18nStrings.applyButtonLabel': <CsMessageNode>[
          CsLiteralNode('Aplicar'),
        ],
        'i18nStrings.cancelButtonLabel': <CsMessageNode>[
          CsLiteralNode('Cancelar'),
        ],
        'i18nStrings.clearButtonLabel': <CsMessageNode>[
          CsLiteralNode('Borrar y descartar'),
        ],
        'i18nStrings.currentMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('Este mes'),
        ],
        'i18nStrings.customRelativeRangeDurationLabel': <CsMessageNode>[
          CsLiteralNode('Duración'),
        ],
        'i18nStrings.customRelativeRangeDurationPlaceholder': <CsMessageNode>[
          CsLiteralNode('Introduzca una duración'),
        ],
        'i18nStrings.customRelativeRangeOptionDescription': <CsMessageNode>[
          CsLiteralNode('Establecer un rango personalizado en el pasado'),
        ],
        'i18nStrings.customRelativeRangeOptionLabel': <CsMessageNode>[
          CsLiteralNode('Rango personalizado'),
        ],
        'i18nStrings.customRelativeRangeUnitLabel': <CsMessageNode>[
          CsLiteralNode('Unidad de tiempo'),
        ],
        'i18nStrings.dateConstraintText': <CsMessageNode>[
          CsLiteralNode('Para la fecha, use el formato AAAA/MM/DD.'),
        ],
        'i18nStrings.datePlaceholder': <CsMessageNode>[
          CsLiteralNode('AAAA-MM-DD'),
        ],
        'i18nStrings.dateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode(
            'Para la fecha, utilice AAAA/MM/DD. Para la hora, utilice el formato de 24 horas.',
          ),
        ],
        'i18nStrings.endDateLabel': <CsMessageNode>[
          CsLiteralNode('Fecha de finalización'),
        ],
        'i18nStrings.endMonthLabel': <CsMessageNode>[
          CsLiteralNode('Mes de finalización'),
        ],
        'i18nStrings.endTimeLabel': <CsMessageNode>[
          CsLiteralNode('Hora de finalización'),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.formatRelativeRange': <CsMessageNode>[
          CsSelectNode('unit', {
            'day': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Último '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' día'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' días'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' días'),
                ],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Última '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' hora'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimas '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' horas'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimas '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' horas'),
                ],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Último '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' minuto'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' minutos'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' minutos'),
                ],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Último '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' mes'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' meses'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' meses'),
                ],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Último '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' segundo'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' segundos'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' segundos'),
                ],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Última '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' semana'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimas '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' semanas'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimas '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' semanas'),
                ],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Último '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' año'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' años'),
                ],
                'zero': <CsMessageNode>[
                  CsLiteralNode('Últimos '),
                  CsArgumentNode('amount'),
                  CsLiteralNode(' años'),
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
                'one': <CsMessageNode>[CsLiteralNode('día')],
                'other': <CsMessageNode>[CsLiteralNode('días')],
                'zero': <CsMessageNode>[CsLiteralNode('días')],
              }),
            ],
            'hour': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('hora')],
                'other': <CsMessageNode>[CsLiteralNode('horas')],
                'zero': <CsMessageNode>[CsLiteralNode('horas')],
              }),
            ],
            'minute': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('minuto')],
                'other': <CsMessageNode>[CsLiteralNode('minutos')],
                'zero': <CsMessageNode>[CsLiteralNode('minutos')],
              }),
            ],
            'month': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('mes')],
                'other': <CsMessageNode>[CsLiteralNode('meses')],
                'zero': <CsMessageNode>[CsLiteralNode('meses')],
              }),
            ],
            'second': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('segundo')],
                'other': <CsMessageNode>[CsLiteralNode('segundos')],
                'zero': <CsMessageNode>[CsLiteralNode('segundos')],
              }),
            ],
            'week': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('semana')],
                'other': <CsMessageNode>[CsLiteralNode('semanas')],
                'zero': <CsMessageNode>[CsLiteralNode('semanas')],
              }),
            ],
            'year': <CsMessageNode>[
              CsPluralNode('amount', {
                'one': <CsMessageNode>[CsLiteralNode('año')],
                'other': <CsMessageNode>[CsLiteralNode('años')],
                'zero': <CsMessageNode>[CsLiteralNode('años')],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.isoDateConstraintText': <CsMessageNode>[
          CsLiteralNode('Para la fecha, use el formato AAAA-MM-DD.'),
        ],
        'i18nStrings.isoDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('AAAA-MM-DD'),
        ],
        'i18nStrings.isoDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode(
            'Para la fecha, use AAAA-MM-DD. Para la hora, use el formato de 24 horas.',
          ),
        ],
        'i18nStrings.isoMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('Para el mes, use el formato AAAA-MM.'),
        ],
        'i18nStrings.monthConstraintText': <CsMessageNode>[
          CsLiteralNode('Para el mes, use el formato AAAA/MM.'),
        ],
        'i18nStrings.nextMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('Próximo mes'),
        ],
        'i18nStrings.nextYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('Próximo año'),
        ],
        'i18nStrings.previousMonthAriaLabel': <CsMessageNode>[
          CsLiteralNode('Mes anterior'),
        ],
        'i18nStrings.previousYearAriaLabel': <CsMessageNode>[
          CsLiteralNode('Año anterior'),
        ],
        'i18nStrings.relativeModeTitle': <CsMessageNode>[
          CsLiteralNode('Modo relativo'),
        ],
        'i18nStrings.relativeRangeSelectionHeading': <CsMessageNode>[
          CsLiteralNode('Elegir un rango'),
        ],
        'i18nStrings.relativeRangeSelectionMonthlyDescription': <CsMessageNode>[
          CsLiteralNode(
            'Cada opción representa el mes completo, contando desde el primer día hasta el último.',
          ),
        ],
        'i18nStrings.renderSelectedAbsoluteRangeAriaLive': <CsMessageNode>[
          CsLiteralNode('Rango seleccionado de '),
          CsArgumentNode('startDate'),
          CsLiteralNode(' a '),
          CsArgumentNode('endDate'),
        ],
        'i18nStrings.slashedDateConstraintText': <CsMessageNode>[
          CsLiteralNode('Para la fecha, use el formato AAAA/MM/DD.'),
        ],
        'i18nStrings.slashedDatePlaceholder': <CsMessageNode>[
          CsLiteralNode('AAAA/MM/DD'),
        ],
        'i18nStrings.slashedDateTimeConstraintText': <CsMessageNode>[
          CsLiteralNode(
            'Para la fecha, utilice AAAA/MM/DD. Para la hora, utilice el formato de 24 horas.',
          ),
        ],
        'i18nStrings.slashedMonthConstraintText': <CsMessageNode>[
          CsLiteralNode('Para el mes, use el formato AAAA/MM.'),
        ],
        'i18nStrings.startDateLabel': <CsMessageNode>[
          CsLiteralNode('Fecha de inicio'),
        ],
        'i18nStrings.startMonthLabel': <CsMessageNode>[
          CsLiteralNode('Mes de inicio'),
        ],
        'i18nStrings.startTimeLabel': <CsMessageNode>[
          CsLiteralNode('Hora de inicio'),
        ],
        'i18nStrings.timePlaceholder': <CsMessageNode>[
          CsLiteralNode('hh:mm:ss'),
        ],
        'i18nStrings.todayAriaLabel': <CsMessageNode>[CsLiteralNode('Hoy')],
      },
      'dialog': {
        'i18nStrings.dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar cuadro de diálogo'),
        ],
      },
      'drawer': {
        'i18nStrings.loadingText': <CsMessageNode>[
          CsLiteralNode('Cargando contenido'),
        ],
      },
      'error-boundary': {
        'i18nStrings.descriptionText': <CsMessageNode>[
          CsSelectNode('hasFeedback', {
            'true': <CsMessageNode>[
              CsLiteralNode(
                'Actualice para intentarlo de nuevo. Estamos siguiendo este problema, pero puede compartir ',
              ),
              CsTagNode('Feedback', <CsMessageNode>[
                CsLiteralNode('más información aquí'),
              ]),
              CsLiteralNode('.'),
            ],
            'other': <CsMessageNode>[
              CsLiteralNode('Actualice para intentarlo de nuevo.'),
            ],
          }),
        ],
        'i18nStrings.headerText': <CsMessageNode>[
          CsLiteralNode('Error inesperado. No se pudo mostrar el contenido'),
        ],
        'i18nStrings.refreshActionText': <CsMessageNode>[
          CsLiteralNode('Actualizar página'),
        ],
      },
      'features-notification-drawer': {
        'ariaLabels.closeButton': <CsMessageNode>[
          CsLiteralNode('Cerrar notificaciones'),
        ],
        'ariaLabels.content': <CsMessageNode>[
          CsLiteralNode('Notificaciones de características'),
        ],
        'ariaLabels.resizeHandle': <CsMessageNode>[
          CsLiteralNode('Redimensionar notificaciones de características'),
        ],
        'ariaLabels.triggerButton': <CsMessageNode>[
          CsLiteralNode('Mostrar notificaciones de características'),
        ],
        'i18nStrings.title': <CsMessageNode>[
          CsLiteralNode('Últimos lanzamientos de características'),
        ],
        'i18nStrings.viewAll': <CsMessageNode>[
          CsLiteralNode('Ver todos los lanzamientos de características'),
        ],
      },
      'file-token-group': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.limitShowFewer': <CsMessageNode>[
          CsLiteralNode('Mostrar menos'),
        ],
        'i18nStrings.limitShowMore': <CsMessageNode>[
          CsLiteralNode('Mostrar más'),
        ],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar archivo '),
          CsArgumentNode('fileIndex'),
          CsLiteralNode(', '),
          CsArgumentNode('fileName'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Aviso'),
        ],
      },
      'file-upload': {
        'i18nStrings.dropzoneText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[
              CsLiteralNode('Arrastrar el archivo para cargarlo'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('Arrastrar los archivos para cargarlos'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.limitShowFewer': <CsMessageNode>[
          CsLiteralNode('Mostrar menos'),
        ],
        'i18nStrings.limitShowMore': <CsMessageNode>[
          CsLiteralNode('Mostrar más'),
        ],
        'i18nStrings.removeFileAriaLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar archivo '),
          CsArgumentNode('fileIndex'),
        ],
        'i18nStrings.uploadButtonText': <CsMessageNode>[
          CsSelectNode('multiple', {
            'false': <CsMessageNode>[CsLiteralNode('Elegir archivo')],
            'true': <CsMessageNode>[CsLiteralNode('Elegir archivos')],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Aviso'),
        ],
      },
      'flashbar': {
        'i18nStrings.ariaLabel': <CsMessageNode>[
          CsLiteralNode('Notificaciones'),
        ],
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.inProgressIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('En curso'),
        ],
        'i18nStrings.infoIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Información'),
        ],
        'i18nStrings.notificationBarAriaLabel': <CsMessageNode>[
          CsLiteralNode('Todas las notificaciones'),
        ],
        'i18nStrings.notificationBarText': <CsMessageNode>[
          CsLiteralNode('Notificaciones'),
        ],
        'i18nStrings.successIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Éxito'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Aviso'),
        ],
      },
      'form': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('Error')],
      },
      'form-field': {
        'i18nStrings.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.warningIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Aviso'),
        ],
      },
      'help-panel': {
        'loadingText': <CsMessageNode>[CsLiteralNode('Cargando contenido')],
      },
      'input': {
        'clearAriaLabel': <CsMessageNode>[CsLiteralNode('Borrar')],
      },
      'link': {
        'externalIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Se abre en una pestaña nueva'),
        ],
      },
      'list': {
        'dragHandleAriaDescription': <CsMessageNode>[
          CsLiteralNode(
            'Utilice la barra espaciadora o Enter para activar el arrastre de un elemento y, a continuación, utilice las teclas de flecha para mover la posición del elemento. Para completar el movimiento de la posición, utilice la barra espaciadora o Enter, o para descartar el movimiento, utilice Escape.',
          ),
        ],
        'dragHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('Arrastrar controlador'),
        ],
        'liveAnnouncementDndDiscarded': <CsMessageNode>[
          CsLiteralNode('Reordenación cancelada'),
        ],
        'liveAnnouncementDndItemCommitted': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('El artículo se movió de la posición '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' a la posición '),
              CsArgumentNode('finalPosition'),
              CsLiteralNode(' de '),
              CsArgumentNode('total'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('El artículo ha vuelto a su posición original '),
              CsArgumentNode('initialPosition'),
              CsLiteralNode(' de '),
              CsArgumentNode('total'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndItemReordered': <CsMessageNode>[
          CsSelectNode('isInitialPosition', {
            'false': <CsMessageNode>[
              CsLiteralNode('Mover el elemento a la posición '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode(' de '),
              CsArgumentNode('total'),
            ],
            'true': <CsMessageNode>[
              CsLiteralNode('Mover el elemento de nuevo a la posición '),
              CsArgumentNode('currentPosition'),
              CsLiteralNode(' de '),
              CsArgumentNode('total'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'liveAnnouncementDndStarted': <CsMessageNode>[
          CsLiteralNode('Recogida del elemento en la posición '),
          CsArgumentNode('position'),
          CsLiteralNode(' de '),
          CsArgumentNode('total'),
        ],
      },
      'modal': {
        'closeAriaLabel': <CsMessageNode>[CsLiteralNode('Cerrar modal')],
      },
      'multiselect': {
        'deselectAriaLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar '),
          CsArgumentNode('option__label'),
        ],
        'i18nStrings.selectAllText': <CsMessageNode>[
          CsLiteralNode('Seleccionar todo'),
        ],
      },
      'option-list': {
        'i18nStrings.selectedAriaLabel': <CsMessageNode>[
          CsLiteralNode('Seleccionado'),
        ],
      },
      'pagination': {
        'ariaLabels.jumpToPageButtonLabel': <CsMessageNode>[
          CsLiteralNode('Ir a la página'),
        ],
        'ariaLabels.nextPageLabel': <CsMessageNode>[
          CsLiteralNode('Página siguiente'),
        ],
        'ariaLabels.pageLabel': <CsMessageNode>[
          CsLiteralNode('Página '),
          CsArgumentNode('pageNumber'),
          CsLiteralNode(' de todas las páginas'),
        ],
        'ariaLabels.previousPageLabel': <CsMessageNode>[
          CsLiteralNode('Página anterior'),
        ],
        'i18nStrings.jumpToPageError': <CsMessageNode>[
          CsLiteralNode(
            'Página fuera de rango. Se muestra la última página disponible.',
          ),
        ],
        'i18nStrings.jumpToPageInputLabel': <CsMessageNode>[
          CsLiteralNode('Página'),
        ],
        'i18nStrings.jumpToPageLoadingText': <CsMessageNode>[
          CsLiteralNode('Cargando'),
        ],
        'i18nStrings.pagesCompactText': <CsMessageNode>[
          CsSelectNode('openEnd', {
            'false': <CsMessageNode>[
              CsArgumentNode('currentPage'),
              CsLiteralNode(' de '),
              CsArgumentNode('pagesCount'),
            ],
            'true': <CsMessageNode>[
              CsArgumentNode('currentPage'),
              CsLiteralNode(' de '),
              CsArgumentNode('pagesCount'),
              CsLiteralNode('+'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
      },
      'panel-resize-handle': {
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('Controlador de cambio del tamaño del panel'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('Arrastre o seleccione para cambiar el tamaño'),
        ],
      },
      'pie-chart': {
        'i18nStrings.chartAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('Gráfico circular'),
        ],
        'i18nStrings.detailsPercentage': <CsMessageNode>[
          CsLiteralNode('Porcentaje'),
        ],
        'i18nStrings.detailsValue': <CsMessageNode>[CsLiteralNode('Valor')],
        'i18nStrings.segmentAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('Segmento'),
        ],
      },
      'popover': {
        'dismissAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar ventana emergente'),
        ],
      },
      'prompt-input': {
        'i18nStrings.actionButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Enviar petición'),
        ],
        'i18nStrings.menuErrorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.menuErrorText': <CsMessageNode>[
          CsLiteralNode('Error al obtener los elementos'),
        ],
        'i18nStrings.menuFinishedText': <CsMessageNode>[
          CsLiteralNode('Fin de los resultados'),
        ],
        'i18nStrings.menuLoadingText': <CsMessageNode>[
          CsLiteralNode('Cargar elementos'),
        ],
        'i18nStrings.menuRecoveryText': <CsMessageNode>[
          CsLiteralNode('Reintentar'),
        ],
        'i18nStrings.selectedMenuItemAriaLabel': <CsMessageNode>[
          CsLiteralNode('Seleccionado'),
        ],
        'i18nStrings.tokenInsertedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' insertado'),
        ],
        'i18nStrings.tokenPinnedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' fijado'),
        ],
        'i18nStrings.tokenRemovedAriaLabel': <CsMessageNode>[
          CsArgumentNode('token__label'),
          CsLiteralNode(' eliminado'),
        ],
      },
      'property-filter': {
        'i18nStrings.allPropertiesLabel': <CsMessageNode>[
          CsLiteralNode('Todas las propiedades'),
        ],
        'i18nStrings.applyActionText': <CsMessageNode>[
          CsLiteralNode('Aplicar'),
        ],
        'i18nStrings.cancelActionText': <CsMessageNode>[
          CsLiteralNode('Cancelar'),
        ],
        'i18nStrings.clearFiltersText': <CsMessageNode>[
          CsLiteralNode('Borrar filtros'),
        ],
        'i18nStrings.editTokenHeader': <CsMessageNode>[
          CsLiteralNode('Editar filtro'),
        ],
        'i18nStrings.formatToken': <CsMessageNode>[
          CsSelectNode('token__operator', {
            'contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' contiene '),
              CsArgumentNode('token__value'),
            ],
            'equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' es igual a '),
              CsArgumentNode('token__value'),
            ],
            'greater_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' es mayor que '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' o igual'),
            ],
            'greater_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' es mayor que '),
              CsArgumentNode('token__value'),
            ],
            'less_than_equal': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' es menor que '),
              CsArgumentNode('token__value'),
              CsLiteralNode(' o igual'),
            ],
            'less_than': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' es menor que '),
              CsArgumentNode('token__value'),
            ],
            'not_contains': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' no contiene '),
              CsArgumentNode('token__value'),
            ],
            'not_equals': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' no es igual a '),
              CsArgumentNode('token__value'),
            ],
            'not_starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' no empieza con '),
              CsArgumentNode('token__value'),
            ],
            'starts_with': <CsMessageNode>[
              CsArgumentNode('token__propertyLabel'),
              CsLiteralNode(' empieza con '),
              CsArgumentNode('token__value'),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.groupEditAriaLabel': <CsMessageNode>[
          CsSelectNode('group__formattedTokens__length', {
            '2': <CsMessageNode>[
              CsLiteralNode('Editar grupo de filtros '),
              CsArgumentNode('group__formattedTokens0__formattedText'),
              CsLiteralNode(' '),
              CsArgumentNode('group__operationLabel'),
              CsLiteralNode(' '),
              CsArgumentNode('group__formattedTokens1__formattedText'),
            ],
            '3': <CsMessageNode>[
              CsLiteralNode('Editar grupo de filtros '),
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
              CsLiteralNode('Editar grupo de filtros '),
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
              CsLiteralNode('Editar grupo de filtros '),
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
              CsLiteralNode(' 1 más'),
            ],
            'other': <CsMessageNode>[
              CsLiteralNode('Editar grupo de filtros '),
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
              CsLiteralNode(' más'),
            ],
          }),
        ],
        'i18nStrings.groupPropertiesText': <CsMessageNode>[
          CsLiteralNode('Propiedades'),
        ],
        'i18nStrings.groupValuesText': <CsMessageNode>[
          CsLiteralNode('Valores'),
        ],
        'i18nStrings.operationAndText': <CsMessageNode>[CsLiteralNode('y')],
        'i18nStrings.operationOrText': <CsMessageNode>[CsLiteralNode('o')],
        'i18nStrings.operatorContainsText': <CsMessageNode>[
          CsLiteralNode('Contiene'),
        ],
        'i18nStrings.operatorDoesNotContainText': <CsMessageNode>[
          CsLiteralNode('No contiene'),
        ],
        'i18nStrings.operatorDoesNotEqualText': <CsMessageNode>[
          CsLiteralNode('No es igual a'),
        ],
        'i18nStrings.operatorDoesNotStartWithText': <CsMessageNode>[
          CsLiteralNode('No empieza con'),
        ],
        'i18nStrings.operatorEqualsText': <CsMessageNode>[
          CsLiteralNode('Igual a'),
        ],
        'i18nStrings.operatorGreaterOrEqualText': <CsMessageNode>[
          CsLiteralNode('Mayor o igual que'),
        ],
        'i18nStrings.operatorGreaterText': <CsMessageNode>[
          CsLiteralNode('Mayor que'),
        ],
        'i18nStrings.operatorLessOrEqualText': <CsMessageNode>[
          CsLiteralNode('Menor o igual que'),
        ],
        'i18nStrings.operatorLessText': <CsMessageNode>[
          CsLiteralNode('Menor que'),
        ],
        'i18nStrings.operatorStartsWithText': <CsMessageNode>[
          CsLiteralNode('Empieza con'),
        ],
        'i18nStrings.operatorText': <CsMessageNode>[CsLiteralNode('Operador')],
        'i18nStrings.operatorsText': <CsMessageNode>[
          CsLiteralNode('Operadores'),
        ],
        'i18nStrings.propertyText': <CsMessageNode>[CsLiteralNode('Propiedad')],
        'i18nStrings.removeTokenButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Quitar el filtro '),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenAriaLabel': <CsMessageNode>[
          CsLiteralNode('Agregar filtro '),
          CsArgumentNode('token__formattedText'),
          CsLiteralNode(' al grupo'),
        ],
        'i18nStrings.tokenEditorAddExistingTokenLabel': <CsMessageNode>[
          CsLiteralNode('Agregar filtro '),
          CsArgumentNode('token__propertyLabel'),
          CsLiteralNode(' '),
          CsArgumentNode('token__operator'),
          CsLiteralNode(' '),
          CsArgumentNode('token__value'),
          CsLiteralNode(' al grupo'),
        ],
        'i18nStrings.tokenEditorAddNewTokenLabel': <CsMessageNode>[
          CsLiteralNode('Agregar filtro nuevo'),
        ],
        'i18nStrings.tokenEditorAddTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('Agregar acciones de filtrado'),
        ],
        'i18nStrings.tokenEditorTokenActionsAriaLabel': <CsMessageNode>[
          CsLiteralNode('Filtrar acciones, '),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveAriaLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar filtro, '),
          CsArgumentNode('token__formattedText'),
        ],
        'i18nStrings.tokenEditorTokenRemoveFromGroupLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar filtro del grupo'),
        ],
        'i18nStrings.tokenEditorTokenRemoveLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar filtro'),
        ],
        'i18nStrings.tokenLimitShowFewer': <CsMessageNode>[
          CsLiteralNode('Mostrar menos'),
        ],
        'i18nStrings.tokenLimitShowMore': <CsMessageNode>[
          CsLiteralNode('Mostrar más'),
        ],
        'i18nStrings.valueText': <CsMessageNode>[CsLiteralNode('Valor')],
      },
      's3-resource-selector': {
        'i18nStrings.clearFilterButtonText': <CsMessageNode>[
          CsLiteralNode('Borrar filtro'),
        ],
        'i18nStrings.columnBucketCreationDate': <CsMessageNode>[
          CsLiteralNode('Fecha de creación'),
        ],
        'i18nStrings.columnBucketID': <CsMessageNode>[CsLiteralNode('ID')],
        'i18nStrings.columnBucketName': <CsMessageNode>[
          CsLiteralNode('Nombre'),
        ],
        'i18nStrings.columnBucketRegion': <CsMessageNode>[
          CsLiteralNode('Región'),
        ],
        'i18nStrings.columnObjectKey': <CsMessageNode>[CsLiteralNode('Clave')],
        'i18nStrings.columnObjectLastModified': <CsMessageNode>[
          CsLiteralNode('Modificado por última vez'),
        ],
        'i18nStrings.columnObjectSize': <CsMessageNode>[
          CsLiteralNode('Tamaño'),
        ],
        'i18nStrings.columnVersionID': <CsMessageNode>[
          CsLiteralNode('ID de la versión'),
        ],
        'i18nStrings.columnVersionLastModified': <CsMessageNode>[
          CsLiteralNode('Modificado por última vez'),
        ],
        'i18nStrings.columnVersionSize': <CsMessageNode>[
          CsLiteralNode('Tamaño'),
        ],
        'i18nStrings.filteringCantFindMatch': <CsMessageNode>[
          CsLiteralNode('No se encuentra ninguna coincidencia.'),
        ],
        'i18nStrings.filteringCounterText': <CsMessageNode>[
          CsPluralNode('count', {
            'one': <CsMessageNode>[CsLiteralNode('1 coincidencia')],
            'other': <CsMessageNode>[
              CsArgumentNode('count'),
              CsLiteralNode(' coincidencias'),
            ],
          }),
        ],
        'i18nStrings.filteringNoMatches': <CsMessageNode>[
          CsLiteralNode('No hay coincidencias'),
        ],
        'i18nStrings.inContextBrowseButton': <CsMessageNode>[
          CsLiteralNode('Explorar S3'),
        ],
        'i18nStrings.inContextLoadingText': <CsMessageNode>[
          CsLiteralNode('Cargando recurso'),
        ],
        'i18nStrings.inContextSelectPlaceholder': <CsMessageNode>[
          CsLiteralNode('Elija una versión'),
        ],
        'i18nStrings.inContextUriLabel': <CsMessageNode>[
          CsLiteralNode('URI de S3'),
        ],
        'i18nStrings.inContextVersionSelectLabel': <CsMessageNode>[
          CsLiteralNode('Versión del objeto'),
        ],
        'i18nStrings.inContextViewButton': <CsMessageNode>[
          CsLiteralNode('Ver'),
        ],
        'i18nStrings.inContextViewButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Ver (se abre en una pestaña nueva)'),
        ],
        'i18nStrings.labelBreadcrumbs': <CsMessageNode>[
          CsLiteralNode('Rutas de navegación de S3'),
        ],
        'i18nStrings.labelFiltering': <CsMessageNode>[
          CsLiteralNode('Encuentre '),
          CsArgumentNode('itemsType'),
        ],
        'i18nStrings.labelIconFolder': <CsMessageNode>[
          CsLiteralNode('Carpeta'),
        ],
        'i18nStrings.labelIconObject': <CsMessageNode>[CsLiteralNode('Objeto')],
        'i18nStrings.labelNotSorted': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(', no ordenados'),
        ],
        'i18nStrings.labelRefresh': <CsMessageNode>[
          CsLiteralNode('Actualizar los datos'),
        ],
        'i18nStrings.labelSortedAscending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(', ordenados de forma ascendente'),
        ],
        'i18nStrings.labelSortedDescending': <CsMessageNode>[
          CsArgumentNode('columnName'),
          CsLiteralNode(', ordenados de forma descendente'),
        ],
        'i18nStrings.labelsBucketsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Name')],
        'i18nStrings.labelsBucketsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('Buckets')],
        'i18nStrings.labelsObjectsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__Key')],
        'i18nStrings.labelsObjectsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('Objetos')],
        'i18nStrings.labelsVersionsSelection.itemSelectionLabel':
            <CsMessageNode>[CsArgumentNode('item__VersionId')],
        'i18nStrings.labelsVersionsSelection.selectionGroupLabel':
            <CsMessageNode>[CsLiteralNode('Versiones')],
        'i18nStrings.modalBreadcrumbRootItem': <CsMessageNode>[
          CsLiteralNode('Buckets de S3'),
        ],
        'i18nStrings.modalCancelButton': <CsMessageNode>[
          CsLiteralNode('Cancelar'),
        ],
        'i18nStrings.modalLastUpdatedText': <CsMessageNode>[
          CsLiteralNode('Última actualización'),
        ],
        'i18nStrings.modalSubmitButton': <CsMessageNode>[
          CsLiteralNode('Elija'),
        ],
        'i18nStrings.modalTitle': <CsMessageNode>[
          CsLiteralNode('Elige un objeto en S3'),
        ],
        'i18nStrings.selectionBuckets': <CsMessageNode>[
          CsLiteralNode('Buckets'),
        ],
        'i18nStrings.selectionBucketsLoading': <CsMessageNode>[
          CsLiteralNode('Cargando buckets'),
        ],
        'i18nStrings.selectionBucketsNoItems': <CsMessageNode>[
          CsLiteralNode('No hay buckets'),
        ],
        'i18nStrings.selectionBucketsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('Encuentra un bucket'),
        ],
        'i18nStrings.selectionObjects': <CsMessageNode>[
          CsLiteralNode('Objetos'),
        ],
        'i18nStrings.selectionObjectsLoading': <CsMessageNode>[
          CsLiteralNode('Cargando objetos'),
        ],
        'i18nStrings.selectionObjectsNoItems': <CsMessageNode>[
          CsLiteralNode('No hay objetos'),
        ],
        'i18nStrings.selectionObjectsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('Buscar objeto por el prefijo'),
        ],
        'i18nStrings.selectionVersions': <CsMessageNode>[
          CsLiteralNode('Versiones'),
        ],
        'i18nStrings.selectionVersionsLoading': <CsMessageNode>[
          CsLiteralNode('Cargando versiones'),
        ],
        'i18nStrings.selectionVersionsNoItems': <CsMessageNode>[
          CsLiteralNode('No hay versiones'),
        ],
        'i18nStrings.selectionVersionsSearchPlaceholder': <CsMessageNode>[
          CsLiteralNode('Encuentre la versión'),
        ],
        'i18nStrings.validationBucketLength': <CsMessageNode>[
          CsLiteralNode(
            'El nombre del bucket debe tener entre 3 y 63 caracteres.',
          ),
        ],
        'i18nStrings.validationBucketLowerCase': <CsMessageNode>[
          CsLiteralNode(
            'El nombre del bucket debe empezar por un carácter o número en minúscula.',
          ),
        ],
        'i18nStrings.validationBucketMustComplyDns': <CsMessageNode>[
          CsLiteralNode(
            'El nombre del bucket debe cumplir con las convenciones de nomenclatura de DNS.',
          ),
        ],
        'i18nStrings.validationBucketMustNotContain': <CsMessageNode>[
          CsLiteralNode(
            'El nombre del bucket no debe contener caracteres en mayúscula.',
          ),
        ],
        'i18nStrings.validationPathMustBegin': <CsMessageNode>[
          CsLiteralNode('La ruta debe empezar por s3://para que sea válida.'),
        ],
      },
      'select': {
        'errorIconAriaLabel': <CsMessageNode>[CsLiteralNode('Error')],
        'recoveryText': <CsMessageNode>[CsLiteralNode('Reintentar')],
        'selectedAriaLabel': <CsMessageNode>[CsLiteralNode('Seleccionado')],
      },
      'slider': {
        'i18nStrings.valueTextRange': <CsMessageNode>[
          CsArgumentNode('value'),
          CsLiteralNode(', entre '),
          CsArgumentNode('previousValue'),
          CsLiteralNode(' y '),
          CsArgumentNode('nextValue'),
        ],
      },
      'split-panel': {
        'i18nStrings.closeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar panel'),
        ],
        'i18nStrings.openButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Abrir panel'),
        ],
        'i18nStrings.preferencesCancel': <CsMessageNode>[
          CsLiteralNode('Cancelar'),
        ],
        'i18nStrings.preferencesConfirm': <CsMessageNode>[
          CsLiteralNode('Confirmar'),
        ],
        'i18nStrings.preferencesPositionBottom': <CsMessageNode>[
          CsLiteralNode('Parte inferior'),
        ],
        'i18nStrings.preferencesPositionDescription': <CsMessageNode>[
          CsLiteralNode(
            'Elija la posición predeterminada del panel dividido para el servicio.',
          ),
        ],
        'i18nStrings.preferencesPositionLabel': <CsMessageNode>[
          CsLiteralNode('Posición del panel dividido'),
        ],
        'i18nStrings.preferencesPositionSide': <CsMessageNode>[
          CsLiteralNode('Lateral'),
        ],
        'i18nStrings.preferencesTitle': <CsMessageNode>[
          CsLiteralNode('Preferencias de panel dividido'),
        ],
        'i18nStrings.resizeHandleAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cambiar el tamaño del panel dividido'),
        ],
        'i18nStrings.resizeHandleTooltipText': <CsMessageNode>[
          CsLiteralNode('Arrastre o seleccione para cambiar el tamaño'),
        ],
      },
      'table': {
        'ariaLabels.collapseButtonLabel': <CsMessageNode>[
          CsLiteralNode('Contraer'),
        ],
        'ariaLabels.expandButtonLabel': <CsMessageNode>[
          CsLiteralNode('Ampliar'),
        ],
        'ariaLabels.liveAnnouncementSortCleared': <CsMessageNode>[
          CsLiteralNode('Ordenación borrada'),
        ],
        'ariaLabels.liveAnnouncementSortOrder': <CsMessageNode>[
          CsLiteralNode('Tabla ordenada por '),
          CsArgumentNode('columns'),
        ],
        'ariaLabels.resizerRoleDescription': <CsMessageNode>[
          CsLiteralNode('botón de redimensionamiento'),
        ],
        'ariaLabels.sortAscending': <CsMessageNode>[
          CsLiteralNode('ascendente'),
        ],
        'ariaLabels.sortDescending': <CsMessageNode>[
          CsLiteralNode('descendente'),
        ],
        'ariaLabels.sortMenuTriggerLabel': <CsMessageNode>[
          CsLiteralNode('Opciones de ordenación'),
        ],
        'ariaLabels.sortPriority': <CsMessageNode>[
          CsLiteralNode('prioridad de ordenación '),
          CsArgumentNode('priority'),
        ],
        'ariaLabels.submittingEditText': <CsMessageNode>[
          CsLiteralNode('Envío de edición'),
        ],
        'ariaLabels.successfulEditLabel': <CsMessageNode>[
          CsLiteralNode('Se ha editado correctamente'),
        ],
        'columnDefinitions.editConfig.editIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('editable'),
        ],
        'columnDefinitions.editConfig.errorIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Error'),
        ],
        'i18nStrings.clearSort': <CsMessageNode>[
          CsLiteralNode('Borrar ordenación'),
        ],
        'i18nStrings.sortDropdownAddToSortAscending': <CsMessageNode>[
          CsLiteralNode('Agregar a la ordenación (ascendente)'),
        ],
        'i18nStrings.sortDropdownAddToSortDescending': <CsMessageNode>[
          CsLiteralNode('Agregar a la ordenación (descendente)'),
        ],
        'i18nStrings.sortDropdownAddToSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('Esta columna ya está ordenada'),
        ],
        'i18nStrings.sortDropdownMultiColumnSortGroup': <CsMessageNode>[
          CsLiteralNode('Ordenar por varias columnas (Mayús y clic)'),
        ],
        'i18nStrings.sortDropdownRemoveFromSort': <CsMessageNode>[
          CsLiteralNode('Eliminar de la ordenación'),
        ],
        'i18nStrings.sortDropdownRemoveFromSortDisabledReason': <CsMessageNode>[
          CsLiteralNode('Esta columna no está ordenada'),
        ],
        'i18nStrings.sortDropdownSortAscending': <CsMessageNode>[
          CsLiteralNode('Ordenar de forma ascendente'),
        ],
        'i18nStrings.sortDropdownSortDescending': <CsMessageNode>[
          CsLiteralNode('Ordenar de forma descendente'),
        ],
      },
      'tabs': {
        'i18nStrings.scrollLeftAriaLabel': <CsMessageNode>[
          CsLiteralNode('Desplácese hacia la izquierda'),
        ],
        'i18nStrings.scrollRightAriaLabel': <CsMessageNode>[
          CsLiteralNode('Desplácese hacia la derecha'),
        ],
        'i18nStrings.tabsWithActionsAriaRoleDescription': <CsMessageNode>[
          CsLiteralNode('Pestañas con acciones'),
        ],
      },
      'tag-editor': {
        'i18nStrings.addButton': <CsMessageNode>[
          CsLiteralNode('Agregar nueva etiqueta'),
        ],
        'i18nStrings.awsPrefixError': <CsMessageNode>[
          CsLiteralNode('No se puede iniciar con “aws:”.'),
        ],
        'i18nStrings.duplicateKeyError': <CsMessageNode>[
          CsLiteralNode(
            'Debe especificar una clave de etiqueta que sea única.',
          ),
        ],
        'i18nStrings.emptyKeyError': <CsMessageNode>[
          CsLiteralNode('Debe especificar una clave de etiqueta.'),
        ],
        'i18nStrings.emptyTags': <CsMessageNode>[
          CsLiteralNode('No hay etiquetas asociadas con el recurso.'),
        ],
        'i18nStrings.invalidKeyError': <CsMessageNode>[
          CsLiteralNode(
            'La clave no es válida. Las claves solo pueden contener letras de un solo código, dígitos, espacios en blanco y uno de los siguientes símbolos: _.:/=+@-.',
          ),
        ],
        'i18nStrings.invalidValueError': <CsMessageNode>[
          CsLiteralNode(
            'El valor no es válido. Los valores solo pueden contener letras de un solo código, dígitos, espacios en blanco y uno de los siguientes símbolos: _.:/=+@-.',
          ),
        ],
        'i18nStrings.keyHeader': <CsMessageNode>[CsLiteralNode('Clave')],
        'i18nStrings.keyPlaceholder': <CsMessageNode>[
          CsLiteralNode('Ingresar clave'),
        ],
        'i18nStrings.keySuggestion': <CsMessageNode>[
          CsLiteralNode('Clave de etiqueta personalizada'),
        ],
        'i18nStrings.keysSuggestionError': <CsMessageNode>[
          CsLiteralNode('No se pudieron recuperar las claves de etiqueta.'),
        ],
        'i18nStrings.keysSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('Cargando claves de etiqueta'),
        ],
        'i18nStrings.loading': <CsMessageNode>[
          CsLiteralNode('Cargando las etiquetas asociadas con este recurso'),
        ],
        'i18nStrings.maxKeyCharLengthError': <CsMessageNode>[
          CsLiteralNode(
            'En una clave de etiqueta, puede utilizar 128 caracteres como máximo.',
          ),
        ],
        'i18nStrings.maxValueCharLengthError': <CsMessageNode>[
          CsLiteralNode(
            'En un valor de etiqueta, puede utilizar 256 caracteres como máximo.',
          ),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('opcional')],
        'i18nStrings.removeButton': <CsMessageNode>[CsLiteralNode('Eliminar')],
        'i18nStrings.removeButtonAriaLabel': <CsMessageNode>[
          CsLiteralNode('Eliminar '),
          CsArgumentNode('tag__key'),
        ],
        'i18nStrings.tagLimit': <CsMessageNode>[
          CsSelectNode('tagLimitAvailable', {
            'false': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'one': <CsMessageNode>[
                  CsLiteralNode('Puede agregar hasta 1 etiqueta más.'),
                ],
                'other': <CsMessageNode>[
                  CsLiteralNode('Puede agregar hasta '),
                  CsArgumentNode('availableTags'),
                  CsLiteralNode(' etiquetas más.'),
                ],
              }),
            ],
            'true': <CsMessageNode>[
              CsPluralNode('availableTags', {
                'other': <CsMessageNode>[
                  CsLiteralNode('Puede agregar hasta '),
                  CsArgumentNode('tagLimit'),
                  CsLiteralNode(' etiquetas.'),
                ],
              }),
            ],
            'other': <CsMessageNode>[],
          }),
        ],
        'i18nStrings.tagLimitExceeded': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[
              CsLiteralNode('Superó el límite de 1 etiqueta.'),
            ],
            'other': <CsMessageNode>[
              CsLiteralNode('Superó el límite de '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' etiquetas.'),
            ],
          }),
        ],
        'i18nStrings.tagLimitReached': <CsMessageNode>[
          CsPluralNode('tagLimit', {
            'one': <CsMessageNode>[
              CsLiteralNode('Alcanzó el límite de 1 etiqueta.'),
            ],
            'other': <CsMessageNode>[
              CsLiteralNode('Alcanzó el límite de '),
              CsArgumentNode('tagLimit'),
              CsLiteralNode(' etiquetas.'),
            ],
          }),
        ],
        'i18nStrings.tooManyKeysSuggestion': <CsMessageNode>[
          CsLiteralNode('Tiene más claves de las que se pueden mostrar.'),
        ],
        'i18nStrings.tooManyValuesSuggestion': <CsMessageNode>[
          CsLiteralNode('Tiene más valores de los que se pueden mostrar.'),
        ],
        'i18nStrings.undoButton': <CsMessageNode>[CsLiteralNode('Deshacer')],
        'i18nStrings.undoPrompt': <CsMessageNode>[
          CsLiteralNode(
            'Esta etiqueta se eliminará una vez que se guarden los cambios.',
          ),
        ],
        'i18nStrings.valueHeader': <CsMessageNode>[CsLiteralNode('Valor')],
        'i18nStrings.valuePlaceholder': <CsMessageNode>[
          CsLiteralNode('Ingresar valor'),
        ],
        'i18nStrings.valueSuggestion': <CsMessageNode>[
          CsLiteralNode('Valor de etiqueta personalizado'),
        ],
        'i18nStrings.valuesSuggestionError': <CsMessageNode>[
          CsLiteralNode('No se pudieron recuperar los valores de etiqueta.'),
        ],
        'i18nStrings.valuesSuggestionLoading': <CsMessageNode>[
          CsLiteralNode('Cargando valores de etiqueta'),
        ],
      },
      'token-group': {
        'i18nStrings.limitShowFewer': <CsMessageNode>[
          CsLiteralNode('Mostrar menos'),
        ],
        'i18nStrings.limitShowMore': <CsMessageNode>[
          CsLiteralNode('Mostrar más'),
        ],
      },
      'top-navigation': {
        'i18nStrings.overflowMenuBackIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Volver'),
        ],
        'i18nStrings.overflowMenuDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar menú'),
        ],
        'i18nStrings.overflowMenuTitleText': <CsMessageNode>[
          CsLiteralNode('Todos'),
        ],
        'i18nStrings.overflowMenuTriggerText': <CsMessageNode>[
          CsLiteralNode('Más'),
        ],
        'i18nStrings.searchDismissIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Cerrar búsqueda'),
        ],
        'i18nStrings.searchIconAriaLabel': <CsMessageNode>[
          CsLiteralNode('Buscar'),
        ],
      },
      'tree-view': {
        'i18nStrings.collapseButtonLabel': <CsMessageNode>[
          CsLiteralNode('Contraer'),
        ],
        'i18nStrings.expandButtonLabel': <CsMessageNode>[
          CsLiteralNode('Ampliar'),
        ],
      },
      'tutorial-panel': {
        'i18nStrings.completionScreenTitle': <CsMessageNode>[
          CsLiteralNode('¡Enhorabuena! Ha completado el tutorial.'),
        ],
        'i18nStrings.dismissTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('Descartar tutorial'),
        ],
        'i18nStrings.feedbackLinkText': <CsMessageNode>[
          CsLiteralNode('Comentarios'),
        ],
        'i18nStrings.labelExitTutorial': <CsMessageNode>[
          CsLiteralNode('Descartar tutorial'),
        ],
        'i18nStrings.labelTotalSteps': <CsMessageNode>[
          CsLiteralNode('Total de pasos: '),
          CsArgumentNode('totalStepCount'),
        ],
        'i18nStrings.labelTutorialListDownloadLink': <CsMessageNode>[
          CsLiteralNode('Descargue la versión en PDF de este tutorial'),
        ],
        'i18nStrings.labelsTaskStatus.in-progress': <CsMessageNode>[
          CsLiteralNode('En curso'),
        ],
        'i18nStrings.labelsTaskStatus.pending': <CsMessageNode>[
          CsLiteralNode('Pendiente'),
        ],
        'i18nStrings.labelsTaskStatus.success': <CsMessageNode>[
          CsLiteralNode('Correcto'),
        ],
        'i18nStrings.learnMoreLinkText': <CsMessageNode>[
          CsLiteralNode('Más información'),
        ],
        'i18nStrings.loadingText': <CsMessageNode>[CsLiteralNode('Cargando')],
        'i18nStrings.restartTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('Tutorial de reinicio'),
        ],
        'i18nStrings.startTutorialButtonText': <CsMessageNode>[
          CsLiteralNode('Tutorial de inicio'),
        ],
        'i18nStrings.stepTitle': <CsMessageNode>[
          CsLiteralNode('Paso'),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(':'),
          CsArgumentNode('stepTitle'),
        ],
        'i18nStrings.taskTitle': <CsMessageNode>[
          CsLiteralNode('Tarea '),
          CsArgumentNode('taskNumber'),
          CsLiteralNode(': '),
          CsArgumentNode('taskTitle'),
        ],
        'i18nStrings.tutorialCompletedText': <CsMessageNode>[
          CsLiteralNode('Tutorial completado'),
        ],
        'i18nStrings.tutorialListDownloadLinkText': <CsMessageNode>[
          CsLiteralNode('Descargar versión en PDF'),
        ],
        'i18nStrings.tutorialListTitle': <CsMessageNode>[
          CsLiteralNode('Elija un tutorial'),
        ],
      },
      'wizard': {
        'i18nStrings.cancelButton': <CsMessageNode>[CsLiteralNode('Cancelar')],
        'i18nStrings.collapsedStepsLabel': <CsMessageNode>[
          CsLiteralNode('Paso '),
          CsArgumentNode('stepNumber'),
          CsLiteralNode(' de '),
          CsArgumentNode('stepsCount'),
        ],
        'i18nStrings.navigationAriaLabel': <CsMessageNode>[
          CsLiteralNode('Pasos'),
        ],
        'i18nStrings.nextButton': <CsMessageNode>[CsLiteralNode('Siguiente')],
        'i18nStrings.nextButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('Cargando paso siguiente'),
        ],
        'i18nStrings.optional': <CsMessageNode>[CsLiteralNode('opcional')],
        'i18nStrings.previousButton': <CsMessageNode>[
          CsLiteralNode('Anterior'),
        ],
        'i18nStrings.skipToButtonLabel': <CsMessageNode>[
          CsLiteralNode('Vaya a '),
          CsArgumentNode('task__title'),
        ],
        'i18nStrings.stepNumberLabel': <CsMessageNode>[
          CsLiteralNode('Paso '),
          CsArgumentNode('stepNumber'),
        ],
        'i18nStrings.submitButtonLoadingAnnouncement': <CsMessageNode>[
          CsLiteralNode('Formulario de envío'),
        ],
      },
    },
  },
};
