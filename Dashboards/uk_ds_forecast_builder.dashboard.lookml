- dashboard: uk_daily_signal__forecast_builder
  title: UK Daily Signal - Forecast Builder
  layout: newspaper
  elements:
  - title: QTD Performance
    name: QTD Performance
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    type: looker_line
    fields: [qtd_chart.day_count, qtd_chart.current_period_start_dt_date, qtd_chart.current_cum_end_dt_date,
      qtd_chart.yago_period_start_dt_date, qtd_chart.yago_cum_end_dt_date, qtd_chart.two_yago_period_start_dt_date,
      qtd_chart.two_yago_cum_end_dt_date, qtd_chart.balance_yago_cum_start_dt_date,
      qtd_chart.balance_yago_period_end_dt_date, qtd_chart.balance_two_yago_cum_start_dt_date,
      qtd_chart.balance_two_yago_period_end_dt_date, qtd_chart.current_growth_include,
      qtd_chart.yago_growth_include, qtd_chart.balance_growth_include, qtd_chart.current_spend_amount,
      qtd_chart.yago_spend_amount, qtd_chart.two_yago_spend_amount, qtd_chart.balance_yago_spend_amount,
      qtd_chart.balance_two_yago_spend_amount]
    sorts: [qtd_chart.day_count]
    limit: 500
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_labels:
      qtd_chart.current_growth_include: QTD Panel Growth
      qtd_chart.yago_growth_include: QTD YA Compare
      qtd_chart.balance_growth_include: Balance of Q YA Compare
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Growth, orientation: left, series: [{id: qtd_chart.current_growth_include,
            name: QTD Compare, axisId: qtd_chart.current_growth_include}, {id: qtd_chart.yago_growth_include,
            name: QTD YoY Sales, axisId: qtd_chart.yago_growth_include}, {id: qtd_chart.balance_growth_include,
            name: Balance of Q Compare, axisId: qtd_chart.balance_growth_include}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Cumulative Trend As Of
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields: [qtd_chart.current_spend_amount, qtd_chart.yago_spend_amount, qtd_chart.two_yago_spend_amount,
      qtd_chart.balance_yago_spend_amount, qtd_chart.balance_two_yago_spend_amount,
      qtd_chart.current_period_start_dt_date, qtd_chart.yago_period_start_dt_date,
      qtd_chart.yago_cum_end_dt_date, qtd_chart.two_yago_period_start_dt_date, qtd_chart.two_yago_cum_end_dt_date,
      qtd_chart.balance_yago_cum_start_dt_date, qtd_chart.balance_yago_period_end_dt_date,
      qtd_chart.balance_two_yago_cum_start_dt_date, qtd_chart.balance_two_yago_period_end_dt_date,
      qtd_chart.day_count]
    listen:
      Symbol: qtd_chart.symbol
      Fiscal Quarter: qtd_chart.param_quarters
      Panel Method: qtd_chart.param_panel_type
      Cardtype: qtd_chart.param_cardtype
      M&A Activity: qtd_chart.param_merger_type
      Date Axis Display Starts _ Days Into Quarter: qtd_chart.day_count
      Date Axis Display Ends _ Days Before End of Quarter: qtd_chart.reverse_day_count
    row: 6
    col: 0
    width: 16
    height: 10
  - title: YoY Compares
    name: YoY Compares
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    type: looker_line
    fields: [qtd_chart.day_count, qtd_chart.current_period_start_dt_date, qtd_chart.current_cum_end_dt_date,
      qtd_chart.yago_period_start_dt_date, qtd_chart.yago_cum_end_dt_date, qtd_chart.two_yago_period_start_dt_date,
      qtd_chart.two_yago_cum_end_dt_date, qtd_chart.balance_yago_cum_start_dt_date,
      qtd_chart.balance_yago_period_end_dt_date, qtd_chart.balance_two_yago_cum_start_dt_date,
      qtd_chart.balance_two_yago_period_end_dt_date, qtd_chart.current_spend_amount,
      qtd_chart.yago_spend_amount, qtd_chart.two_yago_spend_amount, qtd_chart.balance_yago_spend_amount,
      qtd_chart.balance_two_yago_spend_amount, qtd_chart.yago_growth, qtd_chart.balance_growth]
    sorts: [qtd_chart.day_count]
    limit: 500
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      qtd_chart.balance_growth: "#595096"
      qtd_chart.yago_growth: "#257891"
    series_labels:
      qtd_chart.current_growth_include: QTD Compare
      qtd_chart.yago_growth_include: QTD YoY Sales
      qtd_chart.balance_growth_include: Balance of Q Compare
      qtd_chart.yago_growth: QTD YA Compare
      qtd_chart.balance_growth: Balance of Q YA Compare
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: Growth, orientation: left, series: [{id: qtd_chart.yago_growth,
            name: Yago Growth, axisId: qtd_chart.yago_growth}, {id: qtd_chart.balance_growth,
            name: Balance Growth, axisId: qtd_chart.balance_growth}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Cumulative Trend As Of
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields: [qtd_chart.current_spend_amount, qtd_chart.yago_spend_amount, qtd_chart.two_yago_spend_amount,
      qtd_chart.balance_yago_spend_amount, qtd_chart.balance_two_yago_spend_amount,
      qtd_chart.current_period_start_dt_date, qtd_chart.yago_period_start_dt_date,
      qtd_chart.yago_cum_end_dt_date, qtd_chart.two_yago_period_start_dt_date, qtd_chart.two_yago_cum_end_dt_date,
      qtd_chart.balance_yago_cum_start_dt_date, qtd_chart.balance_yago_period_end_dt_date,
      qtd_chart.balance_two_yago_cum_start_dt_date, qtd_chart.balance_two_yago_period_end_dt_date,
      qtd_chart.day_count]
    listen:
      Symbol: qtd_chart.symbol
      Fiscal Quarter: qtd_chart.param_quarters
      Panel Method: qtd_chart.param_panel_type
      Cardtype: qtd_chart.param_cardtype
      M&A Activity: qtd_chart.param_merger_type
      Date Axis Display Starts _ Days Into Quarter: qtd_chart.day_count
      Date Axis Display Ends _ Days Before End of Quarter: qtd_chart.reverse_day_count
    row: 16
    col: 0
    width: 16
    height: 9
  - title: Fiscal Quarter Y/y % Growth (Panel vs Reported)
    name: Fiscal Quarter Y/y % Growth (Panel vs Reported)
    model: ce_transact_uk_daily_signal
    explore: financial_forecast_graph
    type: looker_line
    fields: [financial_forecast_graph.period, financial_forecast_graph.reported_growth,
      financial_forecast_graph.estimated_growth, financial_forecast_graph.predicted_reported,
      financial_forecast_graph.consensus_growth]
    filters:
      financial_forecast_graph.quarter_number: "<=10"
    sorts: [financial_forecast_graph.period]
    limit: 500
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    limit_displayed_rows_values:
      show_hide: show
      first_last: last
      num_rows: '8'
    hidden_series: []
    series_types: {}
    series_colors:
      financial_forecast_graph.reported_growth: "#231F20"
      financial_forecast_graph.predicted_reported: "#1d4fd6"
      financial_forecast_graph.consensus_growth: "#a1a1a1"
    series_labels:
      financial_forecast_graph.estimated_growth: Panel
      financial_forecast_graph.reported_growth: Reported
      financial_forecast_graph.predicted_reported: Implied Reported
      financial_forecast_graph.consensus_growth: Consensus
    series_point_styles:
      financial_forecast_graph.consensus_growth: triangle-down
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#000000",
        line_value: '0'}]
    defaults_version: 1
    listen:
      Symbol: financial_forecast_graph.symbol
      Panel Method: financial_forecast_graph.param_panel_type
      Cardtype: financial_forecast_graph.param_cardtype
      Number of Quarters Gap for Implied Reported: financial_forecast_graph.param_gap_calc
    row: 27
    col: 0
    width: 15
    height: 12
  - title: Correlation
    name: Correlation
    model: ce_transact_uk_daily_signal
    explore: financial_forecast_graph
    type: single_value
    fields: [financial_forecast_graph.period, financial_forecast_graph.estimated_growth,
      financial_forecast_graph.reported_growth, financial_forecast_graph.predicted_reported]
    filters:
      financial_forecast_graph.quarter_number: "<=10"
    sorts: [financial_forecast_graph.period]
    limit: 500
    dynamic_fields: [{table_calculation: correlation, label: Correlation, expression: 'correl(${financial_forecast_graph.estimated_growth},
          ${financial_forecast_graph.reported_growth})', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Correlation
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: last
      num_rows: '8'
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields: [financial_forecast_graph.estimated_growth, financial_forecast_graph.reported_growth,
      financial_forecast_graph.predicted_reported]
    listen:
      Symbol: financial_forecast_graph.symbol
      Panel Method: financial_forecast_graph.param_panel_type
      Cardtype: financial_forecast_graph.param_cardtype
      Number of Quarters Gap for Implied Reported: financial_forecast_graph.param_gap_calc
    row: 27
    col: 15
    width: 4
    height: 6
  - title: Correlation Stats
    name: Correlation Stats
    model: ce_transact_uk_daily_signal
    explore: financial_forecast_graph
    type: looker_single_record
    fields: [financial_forecast_graph.period, financial_forecast_graph.estimated_growth,
      financial_forecast_graph.reported_growth, financial_forecast_graph.predicted_reported]
    filters:
      financial_forecast_graph.quarter_number: "<=10"
    sorts: [financial_forecast_graph.period]
    limit: 500
    dynamic_fields: [{table_calculation: of_yy_quarters, label: "# of Y/y Quarters",
        expression: 'count(${financial_forecast_graph.reported_growth})', value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: diff, label: Diff, expression: "${financial_forecast_graph.reported_growth}-\
          \ ${financial_forecast_graph.estimated_growth}", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}, {
        table_calculation: stddev_diff, label: StdDev Diff, expression: 'stddev_pop(${diff})',
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: avg_diff, label: Avg Diff, expression: 'sum(abs(${diff}))/count(${diff})',
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Correlation
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: last
      num_rows: '8'
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields: [financial_forecast_graph.estimated_growth, financial_forecast_graph.reported_growth,
      financial_forecast_graph.predicted_reported, financial_forecast_graph.period,
      diff]
    listen:
      Symbol: financial_forecast_graph.symbol
      Panel Method: financial_forecast_graph.param_panel_type
      Cardtype: financial_forecast_graph.param_cardtype
      Number of Quarters Gap for Implied Reported: financial_forecast_graph.param_gap_calc
    row: 27
    col: 19
    width: 5
    height: 6
  - title: Latest Quarter Information
    name: Latest Quarter Information
    model: ce_transact_uk_daily_signal
    explore: financial_forecast_graph
    type: looker_single_record
    fields: [financial_forecast_graph.period, financial_forecast_graph.current_qtr_length,
      financial_forecast_graph.yago_qtr_length, financial_forecast_graph.two_yago_qtr_length,
      financial_forecast_graph.days_into_quarter, financial_forecast_graph.actual_financial_start_dt_date,
      financial_forecast_graph.actual_financial_end_dt_date, financial_forecast_graph.actual_yago_financial_start_dt_date,
      financial_forecast_graph.actual_yago_financial_end_dt_date, financial_forecast_graph.reported_metric_summary]
    filters:
      financial_forecast_graph.quarter_number: "<=8"
    sorts: [financial_forecast_graph.period desc]
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Correlation
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: last
      num_rows: '8'
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    hidden_fields: [financial_forecast_graph.period, diff]
    listen:
      Symbol: financial_forecast_graph.symbol
      Panel Method: financial_forecast_graph.param_panel_type
      Cardtype: financial_forecast_graph.param_cardtype
      Number of Quarters Gap for Implied Reported: financial_forecast_graph.param_gap_calc
    row: 33
    col: 15
    width: 9
    height: 6
  - title: Cumulative Sales
    name: Cumulative Sales
    model: ce_transact_uk_daily_signal
    explore: qtd_captured_sales
    type: table
    fields: [qtd_captured_sales.row_name, qtd_captured_sales.metric, qtd_captured_sales.row]
    filters: {}
    sorts: [qtd_captured_sales.row]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      qtd_captured_sales.row_name: Metric
      qtd_captured_sales.metric: Value
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [qtd_captured_sales.row]
    listen:
      Symbol: qtd_captured_sales.symbol_liquid
      Fiscal Quarter: qtd_captured_sales.param_quarters
      Panel Method: qtd_captured_sales.param_panel_type
      Cardtype: qtd_captured_sales.param_cardtype
      M&A Activity: qtd_captured_sales.param_merger_type
    row: 6
    col: 16
    width: 8
    height: 19
  - name: About This Dashboard
    type: text
    title_text: About This Dashboard
    body_text: Build a forecast for the full quarter by looking at intraquarter trends
      vs. the same number of days after the start of the previous year's fiscal quarter
      and examining how the compare evolved over last year's fiscal quarter vs. the
      same number of days the previous year.  Assess how the gap between the panel
      and reported data has evolved over time for further refinement.
    row: 0
    col: 0
    width: 12
    height: 4
  - title: New Tile
    name: New Tile
    model: ce_transact_uk_daily_signal
    explore: symbol_comparison
    type: table
    fields: [symbol_comparison.max_ptd_end_dt, symbol_comparison.symbol, symbol_comparison.panel_method,
      symbol_comparison.cardtype_include]
    filters:
      symbol_comparison.period_start_dt_date: after 2015/01/01
      symbol_comparison.param_period_type: CAL^_QTR
      symbol_comparison.param_panel_type: Recommended
      symbol_comparison.param_cardtype: Recommended
      symbol_comparison.param_manda: manda
    sorts: [symbol_comparison.max_ptd_end_dt desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      symbol_comparison.max_ptd_end_dt: Latest Date of Data
      symbol_comparison.symbol: Ticker Symbol
      symbol_comparison.panel_method: Recommended Panel
      symbol_comparison.cardtype_include: Recommended Card Type(s)
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    title_hidden: true
    listen:
      Symbol: symbol_comparison.symbol
    row: 0
    col: 12
    width: 12
    height: 4
  - name: Panel vs Reported
    type: text
    title_text: Panel vs. Reported
    row: 25
    col: 0
    width: 24
    height: 2
  - name: Intraquarter Trends
    type: text
    title_text: Intraquarter Trends
    row: 4
    col: 0
    width: 24
    height: 2
  filters:
  - name: Symbol
    title: Symbol
    type: field_filter
    default_value: DKS
    allow_multiple_values: false
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.symbol
  - name: Fiscal Quarter
    title: Fiscal Quarter
    type: field_filter
    default_value: current^_quarter
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.param_quarters
  - name: Panel Method
    title: Panel Method
    type: field_filter
    default_value: Recommended
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.param_panel_type
  - name: Cardtype
    title: Cardtype
    type: field_filter
    default_value: recommended
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.param_cardtype
  - name: M&A Activity
    title: M&A Activity
    type: field_filter
    default_value: manda
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.param_merger_type
  - name: Date Axis Display Starts _ Days Into Quarter
    title: Date Axis Display Starts _ Days Into Quarter
    type: field_filter
    default_value: ">5"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.day_count
  - name: Date Axis Display Ends _ Days Before End of Quarter
    title: Date Axis Display Ends _ Days Before End of Quarter
    type: field_filter
    default_value: ">5"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: qtd_chart
    listens_to_filters: []
    field: qtd_chart.reverse_day_count
  - name: Number of Quarters Gap for Implied Reported
    title: Number of Quarters Gap for Implied Reported
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: financial_forecast_graph
    listens_to_filters: []
    field: financial_forecast_graph.param_gap_calc
