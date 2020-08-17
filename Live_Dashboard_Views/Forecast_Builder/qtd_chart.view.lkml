view: qtd_chart {
  derived_table: {
    sql: SELECT *,

                CASE WHEN current_sum_include = "include" then current_spend_amount else null END as current_spend_amount_include,
                CASE WHEN yago_sum_include = "include" then yago_spend_amount else null END as yago_spend_amount_include,
                CASE WHEN two_yago_sum_include = "include" then two_yago_spend_amount else null END as two_yago_spend_amount_include,
                CASE WHEN balance_yago_sum_include = "include" then balance_yago_spend_amount else null END as balance_yago_spend_amount_include,
                CASE WHEN balance_two_yago_sum_include = "include" then balance_two_yago_spend_amount else null END as balance_two_yago_spend_amount_include

                FROM ${forecast_date_sums.SQL_TABLE_NAME}

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



                {% elsif param_cardtype._parameter_value == 'credit' %}

                AND cardtype = "CREDIT"

                {% elsif param_cardtype._parameter_value == 'recommended' %}

                AND recommended_cardtype = 1

                {% endif %}

                {% if param_merger_type._parameter_value == 'manda' %}

                AND merger_type = "M&A"

                {% elsif param_merger_type._parameter_value == 'proforma' %}

                AND merger_type = "Pro Forma"

                {% endif %}

                {% if param_quarters._parameter_value == 'current_quarter' %}

                AND quarters = "Current Quarter"

                {% elsif param_quarters._parameter_value == 'prev_quarter' %}

                AND quarters = "Previous Quarter"

                {% elsif param_quarters._parameter_value == '2_prev_quarter' %}

                AND quarters = "2 Previous Quarters"

                {% elsif param_quarters._parameter_value == '3_prev_quarter' %}

                AND quarters = "3 Previous Quarters"

                {% elsif param_quarters._parameter_value == '4_prev_quarter' %}

                AND quarters = "4 Previous Quarters"

                {% elsif param_quarters._parameter_value == '5_prev_quarter' %}

                AND quarters = "5 Previous Quarters"

                {% endif %}

     ;;

    }

    parameter: param_panel_type {
      label: "Panel Type"
      type: unquoted
      allowed_value: { label: "Recommended" value: "Recommended" }
      allowed_value: { label: "Enhanced Max Card" value: "Emax" }
      allowed_value: { label: "Constant Individual" value: "Constind" }
      default_value: "Recommended"
    }

    parameter: param_cardtype {
      label: "Cardtype"
      type: unquoted
      allowed_value: { label: "Recommended" value: "recommended" }
      allowed_value: { label: "Credit + Debit" value: "debit_credit" }
      allowed_value: { label: "Credit Only" value: "credit" }
      allowed_value: { label: "Debit Only" value: "debit" }
      default_value: "recommended"
    }

    parameter: param_merger_type {
      label: "Merger Type"
      type: unquoted
      allowed_value: { label: "Pro Forma" value: "proforma" }
      allowed_value: { label: "M&A Dates" value: "manda" }
      default_value: "manda"
    }

    parameter: param_quarters {
      label: "Quarter Period"
      type: unquoted
      allowed_value: { label: "Current Quarter" value: "current_quarter" }
      allowed_value: { label: "Previous Quarter" value: "prev_quarter" }
#             allowed_value: { label: "2 Previous Quarters" value: "2_prev_quarter" }
#             allowed_value: { label: "3 Previous Quarters" value: "3_prev_quarter" }
#             allowed_value: { label: "4 Previous Quarters" value: "4_prev_quarter" }
#             allowed_value: { label: "5 Previous Quarters" value: "5_prev_quarter" }
      default_value: "current_quarter"
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

    dimension: merger_type {
      label: "Merger Type"
      type: string
      sql: ${TABLE}.merger_type ;;
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

    dimension: recommended_cardtype {
      label: "Recommended Cardtype"
      type: string
      sql: ${TABLE}.recommended_cardtype ;;
    }


    dimension: recommended_panel {
      label: "Recommended Panel"
      type: string
      sql: ${TABLE}.recommended_panel ;;
    }

    dimension: day_count {
      label: "Days"
      type: number
      sql: ${TABLE}.day_count ;;
    }

    dimension: reverse_day_count {
      label: "Reverse Days"
      type: number
      sql: ${TABLE}.reverse_day_count ;;
    }

    dimension: quarters {
      label: "Quarters"
      type: string
      sql: ${TABLE}.quarters ;;
    }

    dimension: quarter_length {
      label: "Quarter Length"
      type: number
      sql: ${TABLE}.quarter_length ;;
    }

    dimension: balance_length {
      label: "Balance Length"
      type: number
      sql: ${TABLE}.balance_length ;;
    }

    dimension_group: current_period_start_dt {
      type: time
      sql: ${TABLE}.current_period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: current_cum_end_dt {
      type: time
      sql: ${TABLE}.current_cum_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension: current_sum_include {
      type: string
      sql: ${TABLE}.current_sum_include ;;
    }

    dimension_group: yago_period_start_dt {
      type: time
      sql: ${TABLE}.yago_period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: yago_cum_end_dt {
      type: time
      sql: ${TABLE}.yago_cum_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension: yago_sum_include {
      type: string
      sql: ${TABLE}.yago_sum_include ;;
    }

    dimension_group: two_yago_period_start_dt {
      type: time
      sql: ${TABLE}.two_yago_period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: two_yago_cum_end_dt {
      type: time
      sql: ${TABLE}.two_yago_cum_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension: two_yago_sum_include {
      type: string
      sql: ${TABLE}.yago_sum_include ;;
    }

    dimension_group: balance_yago_cum_start_dt {
      type: time
      sql: ${TABLE}.balance_yago_cum_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: balance_yago_period_end_dt {
      type: time
      sql: ${TABLE}.balance_yago_period_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension: balance_yago_sum_include {
      type: string
      sql: ${TABLE}.yago_sum_include ;;
    }

    dimension_group: balance_two_yago_cum_start_dt {
      type: time
      sql: ${TABLE}.balance_two_yago_cum_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: balance_two_yago_period_end_dt {
      type: time
      sql: ${TABLE}.balance_two_yago_period_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension: balance_two_yago_sum_include {
      type: string
      sql: ${TABLE}.yago_sum_include ;;
    }

    measure:  current_spend_amount {
      label: "Current Spend Amount"
      type: sum
      sql: ${TABLE}.current_spend_amount ;;
      value_format_name: usd_0
    }

    measure:  yago_spend_amount {
      label: "Year Ago Spend Amount"
      type: sum
      sql: ${TABLE}.yago_spend_amount ;;
      value_format_name: usd_0
    }

    measure:  two_yago_spend_amount {
      label: "Two Years Ago Spend Amount"
      type: sum
      sql: ${TABLE}.two_yago_spend_amount ;;
      value_format_name: usd_0
    }

    measure:  balance_yago_spend_amount {
      label: "Balance Year Ago Spend Amount"
      type: sum
      sql: ${TABLE}.balance_yago_spend_amount ;;
      value_format_name: usd_0
    }

    measure:  balance_two_yago_spend_amount {
      label: "Balance Two Years Ago Spend Amount"
      type: sum
      sql: ${TABLE}.balance_two_yago_spend_amount ;;
      value_format_name: usd_0
    }

    measure: current_growth{
      type: number
      sql: ${current_spend_amount} / nullif(${yago_spend_amount}, 0) -1 ;;
      value_format_name: percent_1
    }

    measure: yago_growth{
      type: number
      sql: ${yago_spend_amount} / nullif(${two_yago_spend_amount}, 0) -1 ;;
      value_format_name: percent_1
    }

    measure: balance_growth{
      type: number
      sql: ${balance_yago_spend_amount} / nullif(${balance_two_yago_spend_amount}, 0) -1 ;;
      value_format_name: percent_1
    }

    measure:  current_spend_amount_include {
      label: "Current Spend Amount Include"
      type: sum
      sql: ${TABLE}.current_spend_amount_include ;;
      value_format_name: usd_0
    }

    measure:  yago_spend_amount_include {
      label: "Year Ago Spend Amount Include"
      type: sum
      sql: ${TABLE}.yago_spend_amount_include ;;
      value_format_name: usd_0
    }

    measure:  two_yago_spend_amount_include {
      label: "Two Years Ago Spend Amount Include"
      type: sum
      sql: ${TABLE}.two_yago_spend_amount_include ;;
      value_format_name: usd_0
    }

    measure:  balance_yago_spend_amount_include {
      label: "Balance Year Ago Spend Amount Include"
      type: sum
      sql: ${TABLE}.balance_yago_spend_amount_include ;;
      value_format_name: usd_0
    }

    measure:  balance_two_yago_spend_amount_include {
      label: "Balance Two Years Ago Spend Amount Include"
      type: sum
      sql: ${TABLE}.balance_two_yago_spend_amount_include ;;
      value_format_name: usd_0
    }

    measure: current_growth_include{
      type: number
      sql: ${current_spend_amount_include} / nullif(${yago_spend_amount_include}, 0) -1 ;;
      value_format_name: percent_1
    }

    measure: yago_growth_include{
      type: number
      sql: ${yago_spend_amount_include} / nullif(${two_yago_spend_amount_include}, 0) -1 ;;
      value_format_name: percent_1
    }

    measure: balance_growth_include{
      type: number
      sql: ${balance_yago_spend_amount_include} / nullif(${balance_two_yago_spend_amount_include}, 0) -1 ;;
      value_format_name: percent_1
    }

  }
