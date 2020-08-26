view: symbol_comparison {
  derived_table: {
    sql: SELECT symbol,
              brand_name,
              brand_id,
              cardtype,
              partial_period_flag,
              period_type,
              merger_type,
              panel_type,
              panel_method,
              cardtype_include,
              period,
              period_start_dt,
              ptd_end_dt,
              {% if currency._parameter_value == 'gbp' %}
              gbp_spend_amount as spend_amount,
              prev_gbp_spend_amount as prev_spend_amount,
              gbp_spend_amount/prev_gbp_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'cad' %}
              cad_spend_amount as spend_amount,
              prev_cad_spend_amount as prev_spend_amount,
              cad_spend_amount/prev_cad_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'usd' %}
              usd_spend_amount as spend_amount,
              prev_usd_spend_amount as prev_spend_amount,
              usd_spend_amount/prev_usd_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'eur' %}
              eur_spend_amount as spend_amount,
              prev_eur_spend_amount as prev_spend_amount,
              eur_spend_amount/prev_eur_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'dkk' %}
              dkk_spend_amount as spend_amount,
              prev_dkk_spend_amount as prev_spend_amount,
              dkk_spend_amount/prev_dkk_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'nok' %}
              nok_spend_amount as spend_amount,
              prev_nok_spend_amount as prev_spend_amount,
              nok_spend_amount/prev_nok_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'jpy' %}
              jpy_spend_amount as spend_amount,
              prev_jpy_spend_amount as prev_spend_amount,
              jpy_spend_amount/prev_jpy_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'sek' %}
              sek_spend_amount as spend_amount,
              prev_sek_spend_amount as prev_spend_amount,
              sek_spend_amount/prev_sek_spend_amount - 1 as ptd_spend_yoy,
              {% elsif currency._parameter_value == 'pln' %}
              pln_spend_amount as spend_amount,
              prev_pln_spend_amount as prev_spend_amount,
              pln_spend_amount/prev_pln_spend_amount - 1 as ptd_spend_yoy,
              {% endif %}
              prev_period,
              prev_period_start_dt,
              prev_ptd_end_dt,
              #ptd_spend_yoy,
              trans_count,
              prev_trans_count,
              ptd_trans_yoy,
              latest_period_flag,
              period_day,
              period_end_dt,

              company_name,

              recommended_card_type
              FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

          WHERE 1=1

           {% if param_manda._parameter_value == 'pro_forma' %}

            AND merger_type = "NONE"

            {% elsif param_manda._parameter_value == 'manda' %}

            AND merger_type = "M&A"

            {% endif %}

            {% if param_panel_type._parameter_value == 'Recommended' %}

            AND panel_type = panel_method

            {% elsif param_panel_type._parameter_value == 'Emax' %}

            AND panel_type = "EMAX"

            {% elsif param_panel_type._parameter_value == 'Constind' %}

            AND panel_type = "CONSTIND"

            {% endif %}

            {% if param_cardtype._parameter_value == 'Recommended' %}

            AND recommended_card_type = 1

            {% elsif param_cardtype._parameter_value == 'debit_credit' %}



            {% elsif param_cardtype._parameter_value == 'credit' %}

            AND cardtype = "CREDIT"

            {% elsif param_cardtype._parameter_value == 'debit' %}

            AND cardtype = "DEBIT"

            {% endif %}

            {% if param_period_type._parameter_value == 'QTR' %}

            AND period_type = "QTR"

            {% elsif param_period_type._parameter_value == 'CAL_QTR' %}

            AND period_type = "CAL_QTR"

            {% elsif param_period_type._parameter_value == 'MONTH' %}

            AND period_type = "MONTH"

            {% elsif param_period_type._parameter_value == 'WEEK' %}

            AND period_type = "WEEK"

            {% endif %}

          ;;

    }

    parameter: param_manda {
      label: "M&A Activity"
      type: unquoted
      allowed_value: { label: "Pro Forma" value: "pro_forma" }
      allowed_value: { label: "M&A Dates" value: "manda" }
      default_value: "manda"
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
      allowed_value: { label: "Recommended" value: "Recommended" }
      allowed_value: { label: "Debit + Credit" value: "debit_credit" }
      allowed_value: { label: "Credit Only" value: "credit" }
      allowed_value: { label: "Debit Only" value: "debit" }
      default_value: "Recommended"
    }

    parameter: param_period_type {
      label: "Period Type"
      type: unquoted
      allowed_value: { label: "Fiscal Quarter" value: "QTR" }
      allowed_value: { label: "Fiscal Half" value: "HALF"}
      allowed_value: { label: "Calendar Half" value: "CAL_HALF"}
      allowed_value: { label: "Calendar Quarter" value: "CAL_QTR" }
      allowed_value: { label: "Monthly" value: "MONTH" }
      allowed_value: { label: "Weekly" value: "WEEK" }
      default_value: "CAL_QTR"
    }

  parameter: currency {
    label: "Currency Type"
    type: unquoted
    allowed_value: { label: "Great British Pounds (GBP)" value: "gbp"}
    allowed_value: { label: "United States Dollars (USD)" value: "usd"}
    allowed_value: { label: "Euros (EUR)" value: "eur"}
    allowed_value: { label: "Canadian Dollars (CAD)" value: "cad"}
    allowed_value: { label: "Danish Krone (DKK)" value: "dkk"}
    allowed_value: { label: "Norwegian Krone (NOK)" value: "nok"}
    allowed_value: { label: "Japanese Yen (JPY)" value: "jpy"}
    allowed_value: { label: "Swedish Krona (SEK)" value: "sek"}
    allowed_value: { label: "Polish Zloty (PLN)" value: "pln"}
    default_value: "gbp"
  }

    dimension: symbol {
      type: string
      sql: ${TABLE}.symbol ;;
    }

    dimension: brand_name {
      type: string
      sql: ${TABLE}.brand_name ;;
    }

    dimension: brand_id {
      type: number
      sql: ${TABLE}.brand_id ;;
    }

    dimension: cardtype {
      type: string
      sql: ${TABLE}.cardtype ;;
    }

    dimension: number_of_symbols {
      type: number
      sql: ${TABLE}.number_of_symbols ;;
    }

    dimension: panel_method {
      type: string
      sql: case
          when ${TABLE}.panel_method = "EMAX" then "Enhanced Max Card"
          when ${TABLE}.panel_method = "CONSTIND" then "Constant Individual"
          end ;;
    }

    dimension: cardtype_include {
      type: string
      sql: case
          when ${TABLE}.cardtype_include = "CREDIT_DEBIT" then "Debit + Credit"
          when ${TABLE}.cardtype_include = "CREDIT" then "Credit Only"
          when ${TABLE}.cardtype_include = "DEBIT" then "Debit Only"
          end ;;
    }

    dimension: partial_period_flag {
      type: number
      sql: ${TABLE}.partial_period_flag ;;
    }

    dimension: period_type {
      type: string
      sql: case
          when ${TABLE}.period_type = "WEEK" then "Calendar Week"
          when ${TABLE}.period_type = "MONTH" then "Calendar Month"
          when ${TABLE}.period_type = "CAL_QTR" then "Calendar Quarter"
          when ${TABLE}.period_type = "QTR" then "Fiscal Quarter"
          end ;;
    }

    dimension: merger_type {
      type: string
      sql: case
          when ${TABLE}.merger_type = "NONE" then "Pro Forma"
          when ${TABLE}.merger_type = "M&A" then "M&A Dates"
          end ;;
    }

    dimension: panel_type {
      type: string
      sql: case
          when ${TABLE}.panel_type = "EMAX" then "Enhanced Max Card"
          when ${TABLE}.panel_type = "CONSTIND" then "Constant Individual"
          end ;;
    }

    dimension: period {
      type: string
      sql: ${TABLE}.period ;;
    }

    dimension_group: period_start_dt {
      type: time
      sql: ${TABLE}.period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: ptd_end_dt {
      type: time
      sql: ${TABLE}.ptd_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    measure: spend_amount {
      type: sum
      sql: ${TABLE}.spend_amount ;;
      value_format_name: usd_0
    }

    dimension: ya_period {
      type: string
      sql: ${TABLE}.prev_period ;;
    }

    dimension_group: ya_period_start_dt {
      type: time
      sql: ${TABLE}.prev_period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: ya_ptd_end_dt {
      type: time
      sql: ${TABLE}.prev_ptd_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    measure: ya_spend_amount {
      type: sum
      sql: ${TABLE}.prev_spend_amount ;;
      value_format_name: usd_0
    }

    measure: ptd_spend_yoy {
      type: number
      sql: ${spend_amount} / ${ya_spend_amount} - 1 ;;
      value_format_name: percent_1
    }

    measure: trans_count {
      type: sum
      sql: ${TABLE}.trans_count ;;
      value_format_name: decimal_0
    }

    measure: ya_trans_count {
      type: sum
      sql: ${TABLE}.prev_trans_count ;;
      value_format_name: decimal_0
    }

    measure: ptd_trans_yoy {
      type: number
      sql: ${trans_count} / ${ya_trans_count} - 1 ;;
      value_format_name: percent_1
    }

    measure: avg_tkt {
      type: number
      sql: ${spend_amount} / ${trans_count} ;;
      value_format_name: usd
    }

    measure: ya_avg_tkt {
      type: number
      sql: ${ya_spend_amount} / ${ya_trans_count} ;;
      value_format_name: usd
    }

    measure: ptd_avg_tkt_yoy {
      type: number
      sql: (${spend_amount} / ${trans_count}) / (${ya_spend_amount} / ${ya_trans_count}) ;;
      value_format_name: percent_1
    }

    dimension: latest_period_flag {
      type: number
      sql: ${TABLE}.latest_period_flag ;;
    }

    dimension: period_day {
      type: number
      sql: ${TABLE}.period_day ;;
    }

    dimension_group: period_end_dt {
      type: time
      sql: ${TABLE}.period_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    measure: max_ptd_end_dt {
      type: date
      sql: max(${TABLE}.ptd_end_dt) ;;
    }

  }
