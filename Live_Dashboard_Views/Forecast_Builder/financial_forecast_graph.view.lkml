view: financial_forecast_graph {
  derived_table: {
    sql:

                SELECT          financial_chart.row,
                                financial_chart.symbol,
                                financial_chart.merger_type,
                                financial_chart.panel_type,
                                financial_chart.cardtype,
                                financial_chart.cardtype_include,
                                financial_chart.panel_method,
                                financial_chart.period,
                                financial_chart.yago_period,
                                financial_chart.financial_start_dt,
                                financial_chart.financial_end_dt,
                                financial_chart.yago_financial_start_dt,
                                financial_chart.yago_financial_end_dt,
                                financial_chart.reported_sales,
                                financial_chart.yago_reported_sales,
                                financial_chart.reported_growth,
                                financial_chart.spend,
                                financial_chart.yago_spend,
                                financial_chart.estimated_growth,
                                financial_chart.latest_reported_num,
                                financial_chart.recommended_panel,
                                financial_chart.actual_financial_start_dt,
                                financial_chart.actual_financial_end_dt,
                                financial_chart.actual_yago_financial_start_dt,
                                financial_chart.actual_yago_financial_end_dt,
                                financial_chart.quarter_number,
                                financial_chart.current_qtr_length,
                                financial_chart.yago_qtr_length,
                                financial_chart.two_yago_qtr_length,
                                financial_chart.days_into_quarter,
                                reported_metric.reported_metric_summary,
                                CASE WHEN financial_chart.latest_reported_num = 1 THEN financial_chart.reported_growth
                                     WHEN financial_chart.reported_growth is null and financial_chart.estimated_growth is not null THEN consensus.consensus_metric
                                     ELSE null
                                     END as consensus_growth,

                 {% if param_gap_calc._parameter_value == '1' %}

                 financial_chart.one_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '2' %}

                 financial_chart.two_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '3' %}

                 financial_chart.three_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '4' %}

                 financial_chart.four_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '5' %}

                 financial_chart.five_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '6' %}

                 financial_chart.six_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '7' %}

                 financial_chart.seven_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == '8' %}

                 financial_chart.eight_predicted_reported as predicted_reported

                 {% elsif param_gap_calc._parameter_value == 'All' %}

                 financial_chart.all_predicted_reported as predicted_reported

                 {% endif %}


                 FROM ${forecast_financial_chart.SQL_TABLE_NAME} financial_chart

                 LEFT JOIN (SELECT distinct symbol, symbol_id, consensus_period, consensus_metric
                            FROM ${ground_truth_financial.SQL_TABLE_NAME}

                            WHERE consensus_period is not null) consensus

                 on consensus.consensus_period = financial_chart.period
                 and consensus.symbol = financial_chart.symbol

                 LEFT JOIN (SELECT distinct symbol, reported_metric_summary
                            FROM ${ground_truth_financial.SQL_TABLE_NAME}) reported_metric

                 on reported_metric.symbol = financial_chart.symbol

                 WHERE 1=1

                 {% if param_panel_type._parameter_value == 'Emax' %}

                 AND panel_type = "EMAX"

                 {% elsif param_panel_type._parameter_value == 'Constind' %}

                 AND panel_type = "CONSTIND"

                 {% elsif param_panel_type._parameter_value == 'Recommended' %}

                 AND recommended_panel = 1

                 {% endif %}

                 {% if param_cardtype._parameter_value == 'debit' %}

                 AND cardtype = "DEBIT"

                 {% elsif param_cardtype._parameter_value == 'debit_credit' %}

                 AND cardtype = "CREDIT + DEBIT"

                 {% elsif param_cardtype._parameter_value == 'credit' %}

                 AND cardtype = "CREDIT"

                 {% elsif param_cardtype._parameter_value == 'recommended' %}

                 AND cardtype = "RECOMMENDED"

                 {% endif %}


                                         ;;

    }

    parameter: param_panel_type {
      label: "Panel Type"
      type: unquoted
      allowed_value: { label: "Enhanced Max Card" value: "Emax" }
      allowed_value: { label: "Constant Individual" value: "Constind" }
      allowed_value: { label: "Recommended" value: "Recommended" }
      default_value: "Recommended"
    }

    parameter: param_cardtype {
      label: "Cardtype"
      type: unquoted
      allowed_value: { label: "Debit + Credit" value: "debit_credit" }
      allowed_value: { label: "Credit Only" value: "credit" }
      allowed_value: { label: "Debit Only" value: "debit" }
      allowed_value: { label: "Recommended" value: "recommended" }
      default_value: "recommended"
    }

    parameter: param_gap_calc {
      label: "Number of Quarters Gap for Implied Reported"
      type: unquoted
      allowed_value: { label: "1 (recommended)" value: "1" }
      allowed_value: { label: "Average Last 2 Qtr" value: "2" }
      allowed_value: { label: "Average Last 3 Qtr" value: "3" }
      allowed_value: { label: "Average Last 4 Qtr" value: "4" }
      allowed_value: { label: "Average Last 5 Qtr" value: "5" }
      allowed_value: { label: "Average Last 6 Qtr" value: "6" }
      allowed_value: { label: "Average Last 7 Qtr" value: "7" }
      allowed_value: { label: "Average Last 8 Qtr" value: "8" }
      allowed_value: { label: "Average All Visible Qtr" value: "All" }
      default_value: "1"
    }

    dimension: symbol {
      label: "Symbol"
      type: string
      sql: ${TABLE}.symbol ;;
    }

    dimension: period {
      label: "Period"
      type: string
      sql: ${TABLE}.period ;;
    }

    dimension: yago_period {
      label: "YAGO Period"
      type: string
      sql: ${TABLE}.yago_period ;;
    }

    dimension: merger_type {
      label: "Merger Type"
      type: string
      sql: ${TABLE}.merger_type ;;
    }

    dimension: reported_metric_summary {
      label: "Sales Measure (summary)"
      type: string
      sql: ${TABLE}.reported_metric_summary ;;
    }

    dimension: panel_type {
      label: "Panel Type"
      type: string
      sql: ${TABLE}.panel_type ;;
    }

    dimension: cardtype {
      label: "Cardtype"
      type: string
      sql: ${TABLE}.cardtype ;;
    }

    dimension: panel_method {
      label: "Panel Method"
      type: string
      sql: ${TABLE}.panel_method ;;
    }

    dimension: cardtype_include {
      label: "Cardtype Include"
      type: string
      sql: ${TABLE}.cardtype_include ;;
    }

    dimension: recommended_panel {
      label: "Recommended Panel"
      type: string
      sql: ${TABLE}.recommended_panel ;;
    }

    dimension: row {
      label: "Row"
      type: number
      sql: ${TABLE}.row ;;
    }

    dimension: current_qtr_length {
      label: "Current Quarter Length"
      type: number
      sql: ${TABLE}.current_qtr_length ;;
    }

    dimension: yago_qtr_length {
      label: "YA Quarter Length"
      type: number
      sql: ${TABLE}.yago_qtr_length ;;
    }

    dimension: two_yago_qtr_length {
      label: "2YA Quarter Length"
      type: number
      sql: ${TABLE}.two_yago_qtr_length ;;
    }

    dimension: days_into_quarter {
      label: "Days Into Current Quarter"
      type: number
      sql: ${TABLE}.days_into_quarter ;;
    }

    dimension: quarter_number {
      label: "Quarter Number"
      type: number
      sql: ${TABLE}.quarter_number ;;
    }

    dimension_group: financial_start_dt {
      type: time
      sql: ${TABLE}.financial_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: financial_end_dt {
      type: time
      sql: ${TABLE}.financial_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: yago_financial_start_dt {
      type: time
      sql: ${TABLE}.yago_financial_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: yago_financial_end_dt {
      type: time
      sql: ${TABLE}.yago_financial_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: actual_financial_start_dt {
      label: "Financial Quarter Start"
      type: time
      sql: ${TABLE}.actual_financial_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: actual_financial_end_dt {
      label: "Financial Quarter End"
      type: time
      sql: ${TABLE}.actual_financial_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: actual_yago_financial_start_dt {
      label: "Financial Quarter YA Start"
      type: time
      sql: ${TABLE}.actual_yago_financial_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: actual_yago_financial_end_dt {
      label: "Financial Quarter YA End"
      type: time
      sql: ${TABLE}.actual_yago_financial_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }



    measure:  reported_sales {
      label: "Reported Sales"
      type: sum
      sql: ${TABLE}.reported_sales ;;
      value_format_name: usd_0
    }

    measure:  yago_reported_sales {
      label: "YAGO Reported Sales"
      type: sum
      sql: ${TABLE}.yago_reported_sales ;;
      value_format_name: usd_0
    }

    measure:  reported_growth {
      label: "Reported Growth"
      type: number
      sql: sum(${TABLE}.reported_growth) ;;
      value_format_name: percent_1
    }

    measure:  spend {
      label: "Spend"
      type: sum
      sql: ${TABLE}.spend ;;
      value_format_name: usd_0
    }

    measure:  yago_spend {
      label: "YAGO Spend"
      type: sum
      sql: ${TABLE}.balance_yago_spend_amount ;;
      value_format_name: usd_0
    }

    measure:  estimated_growth {
      label: "Estimated Growth"
      type: number
      sql: sum(${TABLE}.estimated_growth) ;;
      value_format_name: percent_1
    }

    measure:  last_observed_gap {
      label: "Last Observed"
      type: sum
      sql: ${TABLE}.last_observed_gap ;;
      value_format_name: percent_1
    }

    measure:  predicted_reported {
      label: "Predicted Reported"
      type: number
      sql: sum(${TABLE}.predicted_reported);;
      value_format_name: percent_1
    }

    measure:  consensus_growth {
      label: "Consensus Growth"
      type: number
      sql: sum(${TABLE}.consensus_growth);;
      value_format_name: percent_1
    }

    measure:  latest_reported_num{
      label: "Latest Reported Number"
      type: sum
      sql: ${TABLE}.latest_reported_num ;;
    }

  }
