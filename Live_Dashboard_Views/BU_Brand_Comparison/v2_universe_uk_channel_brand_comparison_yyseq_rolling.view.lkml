view: v2_universe_uk_channel_brand_comparison_yyseq_rolling {
  derived_table: {
    sql: SELECT

                brand_name,
                brand_id,
                /* channel, */
                partial_period_flag,
                period_type,
                merger_type,
                panel_type,
                panel_method,
                period,
                period_start_dt,
                ptd_end_dt
              , prev_period
              , prev_period_start_dt
              , prev_ptd_end_dt
              , trans_count
              , prev_trans_count
              , ptd_trans_yoy
              , latest_period_flag
              , period_day
              , period_end_dt


          {% if currency._parameter_value == 'gbp' %}
             , gbp_spend_amount as spend_amount
             , prev_spend_amount_gbp as prev_spend_amount
             , ptd_spend_yoy_gbp as ptd_spend_yoy
             , avg_tkt_gbp as avg_tkt
             , prev_avg_tkt_gbp as prev_avg_tkt
             , ptd_avg_tkt_yoy_gbp as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'cad' %}
             , cad_spend_amount as spend_amount
             , prev_spend_amount_cad as prev_spend_amount
             , ptd_spend_yoy_cad as ptd_spend_yoy
             , avg_tkt_cad as avg_tkt
             , prev_avg_tkt_cad as prev_avg_tkt
             , ptd_avg_tkt_yoy_cad as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'usd' %}
             , usd_spend_amount as spend_amount
             , prev_spend_amount_usd as prev_spend_amount
             , ptd_spend_yoy_usd as ptd_spend_yoy
             , avg_tkt_usd as avg_tkt
             , prev_avg_tkt_usd as prev_avg_tkt
             , ptd_avg_tkt_yoy_usd as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'eur' %}
             , eur_spend_amount as spend_amount
             , prev_spend_amount_eur as prev_spend_amount
             , ptd_spend_yoy_eur as ptd_spend_yoy
             , avg_tkt_eur as avg_tkt
             , prev_avg_tkt_eur as prev_avg_tkt
             , ptd_avg_tkt_yoy_eur as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'dkk' %}
             , dkk_spend_amount as spend_amount
             , prev_spend_amount_dkk as prev_spend_amount
             , ptd_spend_yoy_dkk as ptd_spend_yoy
             , avg_tkt_dkk as avg_tkt
             , prev_avg_tkt_dkk as prev_avg_tkt
             , ptd_avg_tkt_yoy_dkk as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'nok' %}
             , nok_spend_amount as spend_amount
             , prev_spend_amount_nok as prev_spend_amount
             , ptd_spend_yoy_nok as ptd_spend_yoy
             , avg_tkt_nok as avg_tkt
             , prev_avg_tkt_nok as prev_avg_tkt
             , ptd_avg_tkt_yoy_nok as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'jpy' %}
             , jpy_spend_amount as spend_amount
             , prev_spend_amount_jpy as prev_spend_amount
             , ptd_spend_yoy_jpy as ptd_spend_yoy
             , avg_tkt_jpy as avg_tkt
             , prev_avg_tkt_jpy as prev_avg_tkt
             , ptd_avg_tkt_yoy_jpy as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'sek' %}
             , sek_spend_amount as spend_amount
             , prev_spend_amount_sek as prev_spend_amount
             , ptd_spend_yoy_sek as ptd_spend_yoy
             , avg_tkt_sek as avg_tkt
             , prev_avg_tkt_sek as prev_avg_tkt
             , ptd_avg_tkt_yoy_sek as ptd_avg_tkt_yoy
          {% elsif currency._parameter_value == 'pln' %}
             , pln_spend_amount as spend_amount
             , prev_spend_amount_pln as prev_spend_amount
             , ptd_spend_yoy_pln as ptd_spend_yoy
             , avg_tkt_pln as avg_tkt
             , prev_avg_tkt_pln as prev_avg_tkt
             , ptd_avg_tkt_yoy_pln as ptd_avg_tkt_yoy
          {% endif %}


                                  FROM

                                  {% if param_growth._parameter_value == 'yy_g' %}

                                  ${v2_universe_by_card_channel_underlying_brand_fix_yy_rolling.SQL_TABLE_NAME}

                                  {% elsif param_growth._parameter_value == 'seq_g' %}

                                  ${v2_universe_by_card_channel_underlying_brand_fix_seq_rolling.SQL_TABLE_NAME}

                                  {% endif %}

                                        WHERE 1=1

                                          {% if param_panel_type._parameter_value == 'Emax' %}

                                          AND panel_type = "EMAX"

                                          {% elsif param_panel_type._parameter_value == 'Constind' %}

                                          AND panel_type = "CONSTIND"

                                          {% endif %}

                                          {% if param_period_type._parameter_value == 'CAL_QTR' %}

                                          AND period_type = "CAL_QTR"

                                          {% elsif param_period_type._parameter_value == 'MONTH' %}

                                          AND period_type = "MONTH"

                                          {% elsif param_period_type._parameter_value == 'WEEK' %}

                                          AND period_type = "WEEK"

                                          {% elsif param_period_type._parameter_value == '7_Rolling_Days' %}

                                          AND period_type = "Rolling 7 Days"

                                          {% elsif param_period_type._parameter_value == '35_Rolling_Days' %}

                                          AND period_type = "Rolling 35 Days"

                                          {% elsif param_period_type._parameter_value == '91_Rolling_Days' %}

                                          AND period_type = "Rolling 91 Days"

                                          {% elsif param_period_type._parameter_value == "7D_Bucket" %}

                                          AND period_type = "Discrete 7 Days"

                                          {% elsif param_period_type._parameter_value == "35D_Bucket" %}

                                          AND period_type = "Discrete 35 Days"

                                          {% elsif param_period_type._parameter_value == "91D_Bucket" %}

                                          AND period_type = "Discrete 91 Days"

                                          {% elsif param_period_type._parameter_value == "6M_Bucket" %}

                                          AND period_type = "Discrete 182 Days"

                                          {% elsif param_period_type._parameter_value == "1Y_Bucket" %}

                                          AND period_type = "Discrete 364 Days"

                                          {% endif %}

                                     ;;

    }

    parameter: param_growth {
      label: "Type of Growth"
      type: unquoted
      allowed_value: { label: "Year-over-Year" value: "yy_g" }
      allowed_value: { label: "Sequential" value: "seq_g" }
      default_value: "yy_g"
    }

    parameter: param_panel_type {
      label: "Panel Type"
      type: unquoted
      allowed_value: { label: "Enhanced Max" value: "Emax"}
      allowed_value: { label: "Constant Individual" value: "Constind"}
      default_value: "Emax"
    }

    parameter: param_cardtype {
      label: "Cardtype"
      type: unquoted
      allowed_value: { label: "Debit + Credit" value: "debit_credit" }
      allowed_value: { label: "Credit Only" value: "credit" }
      allowed_value: { label: "Debit Only" value: "debit" }
      default_value: "debit_credit"
    }

    parameter: param_period_type {
      label: "Period Type"
      type: unquoted
      allowed_value: { label: "Calendar Week" value: "WEEK" }
      allowed_value: { label: "Calendar Month" value: "MONTH" }
      allowed_value: { label: "Calendar Quarter" value: "CAL_QTR" }
      allowed_value: { label: "Discrete 7 Days" value: "7D_Bucket"}
      allowed_value: { label: "Discrete 35 Days" value: "35D_Bucket"}
      allowed_value: { label: "Discrete 91 Days" value: "91D_Bucket"}
      allowed_value: { label: "Discrete 182 Days" value: "6M_Bucket"}
      allowed_value: { label: "Discrete 364 Days" value: "1Y_Bucket"}
      allowed_value: { label: "Rolling 7 Days" value: "7_Rolling_Days"}
      allowed_value: { label: "Rolling 35 Days" value: "35_Rolling_Days"}
      allowed_value: { label: "Rolling 91 Days" value: "91_Rolling_Days"}
      default_value: "MONTH"
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

    dimension: channel {
      type: string
      sql: ${TABLE}.channel ;;
    }

    dimension: cardtype {
      type: string
      sql: ${TABLE}.cardtype ;;
    }

    dimension: number_of_symbols {
      type: number
      sql: ${TABLE}.number_of_symbols ;;
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
          ELSE ${TABLE}.period_type
          end ;;
    }

    dimension: merger_type {
      type: string
      sql: ${TABLE}.merger_type ;;
    }

    dimension: panel_type {
      type: string
      sql: case
          when ${TABLE}.panel_type = "NORMALIZED" then "Max Card"
          when ${TABLE}.panel_type = "CONSTANT" then "Constant Card"
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

    dimension: prev_period {
      type: string
      sql: ${TABLE}.prev_period ;;
    }

    dimension_group: prev_period_start_dt {
      type: time
      sql: ${TABLE}.prev_period_start_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    dimension_group: prev_ptd_end_dt {
      type: time
      sql: ${TABLE}.prev_ptd_end_dt ;;
      timeframes: [date]
      convert_tz: no
      datatype: date
    }

    measure: prev_spend_amount {
      type: sum
      sql: ${TABLE}.prev_spend_amount ;;
      value_format_name: usd_0
    }

    measure: ptd_spend_yoy {
      label: "Spend Amount % Growth"
      type: number
      sql: ${spend_amount} / nullif(${prev_spend_amount},0) - 1 ;;
      value_format_name: percent_1
    }

    measure: trans_count {
      label: "# of Transactions"
      type: sum
      sql: ${TABLE}.trans_count ;;
      value_format_name: decimal_0
    }

    measure: prev_trans_count {
      type: sum
      sql: ${TABLE}.prev_trans_count ;;
      value_format_name: decimal_0
    }

    measure: ptd_trans_yoy {
      type: number
      sql: ${trans_count} / nullif(${prev_trans_count},0) - 1 ;;
      value_format_name: percent_1
    }

    measure: avg_tkt {
      type: number
      sql: ${spend_amount} / nullif(${trans_count},0) ;;
      value_format_name: usd
    }

    measure: prev_avg_tkt {
      type: number
      sql: ${prev_spend_amount} / nullif(${prev_trans_count},0) ;;
      value_format_name: usd
    }

    measure: ptd_avg_tkt_yoy {
      type: number
      sql: (${spend_amount} / nullif(${trans_count},0)) / nullif((${prev_spend_amount} / nullif(${prev_trans_count},0),0)) ;;
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
