- dashboard: uk_daily_signal__discover
  title: UK Daily Signal - Discover
  layout: newspaper
  elements:
  - title: Table
    name: Table
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    type: table
    fields: [ds_discover.symbol, ds_discover.corr, ds_discover.week_one_period,
      ds_discover.week_one_period_day, ds_discover.week_four_growth, ds_discover.week_three_growth,
      ds_discover.week_two_growth, ds_discover.week_one_growth, ds_discover.wtd_vs_lastw,
      ds_discover.month_one_period, ds_discover.month_one_period_day, ds_discover.month_four_growth,
      ds_discover.month_three_growth, ds_discover.month_two_growth, ds_discover.month_one_growth,
      ds_discover.mtd_vs_lastm, ds_discover.qtr_one_period, ds_discover.qtr_one_period_day,
      ds_discover.qtr_four_growth, ds_discover.qtr_three_growth, ds_discover.qtr_two_growth,
      ds_discover.qtr_one_growth, ds_discover.qtd_vs_lastq, ds_discover.qtd_compare,
      ds_discover.balance_of_q, ds_discover.est_pct_cap]
    sorts: [ds_discover.corr desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ds_discover.qtd_compare: QTD YA Compare
      ds_discover.balance_of_q: Balance of Q YA Compare
      ds_discover.est_pct_cap: Est. % Total Quarter Sales Captured
      ds_discover.week_one_period_day: Days into Week
      ds_discover.month_one_period_day: Days into Month
      ds_discover.qtr_one_period_day: Days into Quarter
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 0.9, background_color: "#71C6C2",
        font_color: !!null '', color_application: {collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8,
          palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [ds_discover.corr]}, {type: between, value: [
          0.8, 0.9], background_color: "#a7c9c9", font_color: !!null '', color_application: {
          collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8, palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [ds_discover.corr]},
      {type: between, value: [0.7, 0.8], background_color: "#b3caca", font_color: !!null '',
        color_application: {collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8, palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [ds_discover.corr]},
      {type: less than, value: 0.7, background_color: "#cbccce", font_color: !!null '',
        color_application: {collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8, palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [ds_discover.corr]},
      {type: along a scale..., value: !!null '', background_color: "#83B0C8", font_color: !!null '',
        color_application: {collection_id: 51a67144-9b6f-4574-aece-3ec68b0b99a8, palette_id: 572fd018-daf2-4334-b9d5-cf80d5e128b6,
          options: {steps: 5, constraints: {min: {type: number, value: -0.3}, mid: {
                type: number, value: 0}, max: {type: number, value: 0.3}}, mirror: false,
            reverse: false, stepped: false}}, bold: false, italic: false, strikethrough: false,
        fields: [ds_discover.wtd_vs_lastw, ds_discover.mtd_vs_lastm, ds_discover.qtd_vs_lastq]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    title_hidden: true
    listen:
      Symbol: ds_discover.symbol
      Correlation: ds_discover.corr_filter
      Panel Method: ds_discover.param_panel_type
      Cardtype: ds_discover.param_cardtype
      Listed Status: ds_discover.ownership_status
      Days into Week: ds_discover.week_one_period_day
      Days into Month: ds_discover.month_one_period_day
      Days into Quarter: ds_discover.qtr_one_period_day
    row: 0
    col: 0
    width: 24
    height: 13
  filters:
  - name: Symbol
    title: Symbol
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.symbol
  - name: Correlation
    title: Correlation
    type: field_filter
    default_value: "[70, 100]"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.corr_filter
  - name: Panel Method
    title: Panel Method
    type: field_filter
    default_value: Recommended
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.param_panel_type
  - name: Cardtype
    title: Cardtype
    type: field_filter
    default_value: recommended
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.param_cardtype
  - name: Listed Status
    title: Listed Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.ownership_status
  - name: Days into Week
    title: Days into Week
    type: field_filter
    default_value: ">=0"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.week_one_period_day
  - name: Days into Month
    title: Days into Month
    type: field_filter
    default_value: ">=0"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.month_one_period_day
  - name: Days into Quarter
    title: Days into Quarter
    type: field_filter
    default_value: ">=0"
    allow_multiple_values: true
    required: false
    model: ce_transact_uk_daily_signal
    explore: ds_discover
    listens_to_filters: []
    field: ds_discover.qtr_one_period_day
