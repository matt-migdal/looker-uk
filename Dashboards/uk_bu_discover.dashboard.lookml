- dashboard: uk_daily_brand_universe__discover
  title: UK Daily Brand Universe - Discover
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Discover Brand New
    name: Discover Brand New
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    type: table
    fields: [bu_discover.brand_name, bu_discover.industry_name, bu_discover.subindustry_name,
      bu_discover.trans_count, bu_discover.spend_amount, bu_discover.three_pa_growth,
      bu_discover.two_pa_growth, bu_discover.one_pa_growth, bu_discover.one_pa_acceleration]
    sorts: [bu_discover.one_pa_acceleration desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#83B0C8",
        font_color: !!null '', color_application: {collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8,
          palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6, options: {steps: 8, constraints: {
              min: {type: percentile, value: 10}, mid: {type: number, value: 0}, max: {
                type: percentile, value: 75}}, mirror: false, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [bu_discover.one_pa_acceleration]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Brand Name: bu_discover.brand_name
      Industry: bu_discover.industry_name
      Subindustry: bu_discover.subindustry_name
      Panel Method: bu_discover.param_panel_type
      Metric for Growth: bu_discover.param_metric
      Growth Type: bu_discover.growth_type
      Display Period Length: bu_discover.period_length
      Dollar Sales for the Most Recent Period: bu_discover.spend_amount
      Number of Transactions for the Most Recent Period: bu_discover.trans_count
    row: 3
    col: 0
    width: 24
    height: 18
  - title: Period Legend
    name: Period Legend
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    type: looker_single_record
    fields: [bu_discover.period, bu_discover.prev_period, bu_discover.two_prev_period,
      bu_discover.max_ptd_end_dt]
    filters:
      bu_discover.period_length: '7'
      bu_discover.currency: gbp
      bu_discover.param_metric: spend
      bu_discover.param_panel_type: Emax
      bu_discover.growth_type: yoy
    limit: 500
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 0
    col: 14
    width: 10
    height: 3
  - name: Discover
    type: text
    title_text: Discover
    row: 0
    col: 0
    width: 14
    height: 3
  filters:
  - name: Brand Name
    title: Brand Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.brand_name
  - name: Industry
    title: Industry
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.industry_name
  - name: Subindustry
    title: Subindustry
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.subindustry_name
  - name: Panel Method
    title: Panel Method
    type: field_filter
    default_value: Constant Card
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.param_panel_type
  - name: Metric for Growth
    title: Metric for Growth
    type: field_filter
    default_value: spend
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.param_metric
  - name: Growth Type
    title: Growth Type
    type: field_filter
    default_value: yoy
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.growth_type
  - name: Display Period Length
    title: Display Period Length
    type: field_filter
    default_value: '35'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.period_length
  - name: Dollar Sales for the Most Recent Period
    title: Dollar Sales for the Most Recent Period
    type: field_filter
    default_value: ">=30000"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.spend_amount
  - name: Number of Transactions for the Most Recent Period
    title: Number of Transactions for the Most Recent Period
    type: field_filter
    default_value: ">=300"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ce_transact_uk_daily_signal
    explore: bu_discover
    listens_to_filters: []
    field: bu_discover.trans_count
