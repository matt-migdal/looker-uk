
view: bu_discover {
  derived_table: {
    sql: SELECT
         brand_name
          , brand_id
          , industry_name
          , subindustry_name
          , period_type
          , merger_type
          , panel_type
          , period
          , prev_period
          , two_prev_period
          , start_date
          , ptd_end_date

          {% if currency._parameter_value == 'gbp' %}
          , gbp_spend_amount as spend_amount
          , ya_spend_amount_gbp as ya_spend_amount
          , ptd_spend_yoy_gbp as ptd_spend_yoy
          , two_ya_spend_amount_gbp as two_ya_spend_amount
          , two_ptd_spend_yoy_gbp as two_ptd_spend_yoy
          , three_ya_spend_amount_gbp as three_ya_spend_amount
          , three_ptd_spend_yoy_gbp as three_ptd_spend_yoy

          , prev_spend_amount_gbp as prev_spend_amount
          , ptd_spend_seq_gbp as ptd_spend_seq
          , two_prev_spend_amount_gbp as two_prev_spend_amount
          , two_ptd_spend_seq_gbp as two_ptd_spend_seq
          , three_prev_spend_amount_gbp as three_prev_spend_amount
          , three_ptd_spend_seq_gbp as three_ptd_spend_seq

          , ptd_spend_seq_gbp - two_ptd_spend_seq_gbp as ptd_spend_seq_accel
          , ptd_spend_yoy_gbp - two_ptd_spend_yoy_gbp as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'cad' %}
          , cad_spend_amount as spend_amount
          , ya_spend_amount_cad as ya_spend_amount
          , ptd_spend_yoy_cad as ptd_spend_yoy
          , two_ya_spend_amount_cad as two_ya_spend_amount
          , two_ptd_spend_yoy_cad as two_ptd_spend_yoy
          , three_ya_spend_amount_cad as three_ya_spend_amount
          , three_ptd_spend_yoy_cad as three_ptd_spend_yoy

          , prev_spend_amount_cad as prev_spend_amount
          , ptd_spend_seq_cad as ptd_spend_seq
          , two_prev_spend_amount_cad as two_prev_spend_amount
          , two_ptd_spend_seq_cad as two_ptd_spend_seq
          , three_prev_spend_amount_cad as three_prev_spend_amount
          , three_ptd_spend_seq_cad as three_ptd_spend_seq

          , ptd_spend_seq_cad - two_ptd_spend_seq_cad as ptd_spend_seq_accel
          , ptd_spend_yoy_cad - two_ptd_spend_yoy_cad as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'usd' %}
          , usd_spend_amount as spend_amount
          , ya_spend_amount_usd as ya_spend_amount
          , ptd_spend_yoy_usd as ptd_spend_yoy
          , two_ya_spend_amount_usd as two_ya_spend_amount
          , two_ptd_spend_yoy_usd as two_ptd_spend_yoy
          , three_ya_spend_amount_usd as three_ya_spend_amount
          , three_ptd_spend_yoy_usd as three_ptd_spend_yoy

          , prev_spend_amount_usd as prev_spend_amount
          , ptd_spend_seq_usd as ptd_spend_seq
          , two_prev_spend_amount_usd as two_prev_spend_amount
          , two_ptd_spend_seq_usd as two_ptd_spend_seq
          , three_prev_spend_amount_usd as three_prev_spend_amount
          , three_ptd_spend_seq_usd as three_ptd_spend_seq

          , ptd_spend_seq_usd - two_ptd_spend_seq_usd as ptd_spend_seq_accel
          , ptd_spend_yoy_usd - two_ptd_spend_yoy_usd as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'eur' %}
          , eur_spend_amount as spend_amount
          , ya_spend_amount_eur as ya_spend_amount
          , ptd_spend_yoy_eur as ptd_spend_yoy
          , two_ya_spend_amount_eur as two_ya_spend_amount
          , two_ptd_spend_yoy_eur as two_ptd_spend_yoy
          , three_ya_spend_amount_eur as three_ya_spend_amount
          , three_ptd_spend_yoy_eur as three_ptd_spend_yoy

          , prev_spend_amount_eur as prev_spend_amount
          , ptd_spend_seq_eur as ptd_spend_seq
          , two_prev_spend_amount_eur as two_prev_spend_amount
          , two_ptd_spend_seq_eur as two_ptd_spend_seq
          , three_prev_spend_amount_eur as three_prev_spend_amount
          , three_ptd_spend_seq_eur as three_ptd_spend_seq

          , ptd_spend_seq_eur - two_ptd_spend_seq_eur as ptd_spend_seq_accel
          , ptd_spend_yoy_eur - two_ptd_spend_yoy_eur as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'dkk' %}
          , dkk_spend_amount as spend_amount
          , ya_spend_amount_dkk as ya_spend_amount
          , ptd_spend_yoy_dkk as ptd_spend_yoy
          , two_ya_spend_amount_dkk as two_ya_spend_amount
          , two_ptd_spend_yoy_dkk as two_ptd_spend_yoy
          , three_ya_spend_amount_dkk as three_ya_spend_amount
          , three_ptd_spend_yoy_dkk as three_ptd_spend_yoy

          , prev_spend_amount_dkk as prev_spend_amount
          , ptd_spend_seq_dkk as ptd_spend_seq
          , two_prev_spend_amount_dkk as two_prev_spend_amount
          , two_ptd_spend_seq_dkk as two_ptd_spend_seq
          , three_prev_spend_amount_dkk as three_prev_spend_amount
          , three_ptd_spend_seq_dkk as three_ptd_spend_seq

          , ptd_spend_seq_dkk - two_ptd_spend_seq_dkk as ptd_spend_seq_accel
          , ptd_spend_yoy_dkk - two_ptd_spend_yoy_dkk as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'nok' %}
          , nok_spend_amount as spend_amount
          , ya_spend_amount_nok as ya_spend_amount
          , ptd_spend_yoy_nok as ptd_spend_yoy
          , two_ya_spend_amount_nok as two_ya_spend_amount
          , two_ptd_spend_yoy_nok as two_ptd_spend_yoy
          , three_ya_spend_amount_nok as three_ya_spend_amount
          , three_ptd_spend_yoy_nok as three_ptd_spend_yoy

          , prev_spend_amount_nok as prev_spend_amount
          , ptd_spend_seq_nok as ptd_spend_seq
          , two_prev_spend_amount_nok as two_prev_spend_amount
          , two_ptd_spend_seq_nok as two_ptd_spend_seq
          , three_prev_spend_amount_nok as three_prev_spend_amount
          , three_ptd_spend_seq_nok as three_ptd_spend_seq

          , ptd_spend_seq_nok - two_ptd_spend_seq_nok as ptd_spend_seq_accel
          , ptd_spend_yoy_nok - two_ptd_spend_yoy_nok as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'jpy' %}
          , jpy_spend_amount as spend_amount
          , ya_spend_amount
          , ptd_spend_yoy
          , two_ya_spend_amount
          , two_ptd_spend_yoy
          , three_ya_spend_amount
          , three_ptd_spend_yoy

          , prev_spend_amount
          , ptd_spend_seq
          , two_prev_spend_amount
          , two_ptd_spend_seq
          , three_prev_spend_amount
          , three_ptd_spend_seq

          , ptd_spend_seq_jpy - two_ptd_spend_seq_jpy as ptd_spend_seq_accel
          , ptd_spend_yoy_jpy - two_ptd_spend_yoy_jpy as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'sek' %}
          , sek_spend_amount as spend_amount
          , ya_spend_amount
          , ptd_spend_yoy
          , two_ya_spend_amount
          , two_ptd_spend_yoy
          , three_ya_spend_amount
          , three_ptd_spend_yoy

          , prev_spend_amount
          , ptd_spend_seq
          , two_prev_spend_amount
          , two_ptd_spend_seq
          , three_prev_spend_amount
          , three_ptd_spend_seq

          , ptd_spend_seq_sek - two_ptd_spend_seq_sek as ptd_spend_seq_accel
          , ptd_spend_yoy_sek - two_ptd_spend_yoy_sek as ptd_spend_yoy_accel
          {% elsif currency._parameter_value == 'pln' %}
          , pln_spend_amount as spend_amount
          , ya_spend_amount_pln as ya_spend_amount
          , ptd_spend_yoy_pln as ptd_spend_yoy
          , two_ya_spend_amount_pln as two_ya_spend_amount
          , two_ptd_spend_yoy_pln as two_ptd_spend_yoy
          , three_ya_spend_amount_pln as three_ya_spend_amount
          , three_ptd_spend_yoy_pln as three_ptd_spend_yoy

          , prev_spend_amount_pln as prev_spend_amount
          , ptd_spend_seq_pln as ptd_spend_seq
          , two_prev_spend_amount_pln as two_prev_spend_amount
          , two_ptd_spend_seq_pln as two_ptd_spend_seq
          , three_prev_spend_amount_pln as three_prev_spend_amount
          , three_ptd_spend_seq_pln as three_ptd_spend_seq

          , ptd_spend_seq_pln - two_ptd_spend_seq_pln as ptd_spend_seq_accel
          , ptd_spend_yoy_pln - two_ptd_spend_yoy_pln as ptd_spend_yoy_accel
          {% endif %}

          , ya_start_date
          , ya_ptd_end_date
          , two_prev_ya_start_date
          , two_prev_ya_end_date
          , three_prev_ya_start_date
          , three_prev_ya_end_date

          , trans_count
          , ya_trans_count
          , ptd_trans_yoy
          , two_ya_trans_count
          , two_ptd_trans_yoy
          , three_ya_trans_count
          , three_ptd_trans_yoy
          , ptd_trans_seq - two_ptd_trans_seq as ptd_trans_seq_accel
          , ptd_trans_yoy - two_ptd_trans_yoy as ptd_trans_yoy_accel


          , prev_trans_count
          , ptd_trans_seq
          , two_prev_trans_count
          , two_ptd_trans_seq
          , three_prev_trans_count
          , three_ptd_trans_seq

       FROM ${brand_date_totals_constind_emax.SQL_TABLE_NAME}

  WHERE 1=1

  {% if param_panel_type._parameter_value == 'Emax' %}

                              AND panel_type = "EMAX"

                              {% elsif param_panel_type._parameter_value == 'Constind' %}

                              AND panel_type = "CONSTIND"

                              {% endif %}

  AND   period_type = CASE WHEN {% parameter period_length %} = 7 THEN 'Discrete 7 Days'
                           WHEN {% parameter period_length %} = 35 THEN 'Discrete 35 Days'
                           WHEN {% parameter period_length %} = 91 THEN 'Discrete 91 Days'
                           WHEN {% parameter period_length %} = 182 THEN 'Discrete 182 Days'
                           WHEN {% parameter period_length %} = 364 THEN 'Discrete 364 Days'
                      END
  GROUP BY
        brand_name
          , brand_id
          , industry_name
          , subindustry_name
          , period_type
          , merger_type
          , panel_type
          , period
          , prev_period
          , two_prev_period
          , start_date
          , ptd_end_date
          , spend_amount
          , ya_start_date
          , ya_ptd_end_date
          , two_prev_ya_start_date
          , two_prev_ya_end_date
          , three_prev_ya_start_date
          , three_prev_ya_end_date
          , ya_spend_amount
          , ptd_spend_yoy
          , two_ya_spend_amount
          , two_ptd_spend_yoy
          , three_ya_spend_amount
          , three_ptd_spend_yoy
          , trans_count
          , ya_trans_count
          , ptd_trans_yoy
          , two_ya_trans_count
          , two_ptd_trans_yoy
          , three_ya_trans_count
          , three_ptd_trans_yoy

          , prev_spend_amount
          , ptd_spend_seq
          , two_prev_spend_amount
          , two_ptd_spend_seq
          , three_prev_spend_amount
          , three_ptd_spend_seq
          , prev_trans_count
          , ptd_trans_seq
          , two_prev_trans_count
          , two_ptd_trans_seq
          , three_prev_trans_count
          , three_ptd_trans_seq
          , ptd_trans_seq_accel
          , ptd_trans_yoy_accel
          , ptd_spend_seq_accel
          , ptd_spend_yoy_accel
  ;;
  }

  parameter: param_metric {
    label: "Metric for Growth"
    type: string
    allowed_value: { label: "Spend Amount" value: "spend" }
    allowed_value: { label: "Number of Transactions" value: "trans_count" }
    #default_value: "simple"
  }

  parameter: param_panel_type {
    label: "Panel Type"
    type: unquoted
    allowed_value: { label: "Enhanced Max" value: "Emax"}
    allowed_value: { label: "Constant Individual" value: "Constind"}
    default_value: "Emax"
  }

  parameter: period_length {
    label: "Sales Threshold Period"
    type: unquoted
    allowed_value: { label: "Discrete 7 Days" value: "7"}
    allowed_value: { label: "Discrete 35 Days" value: "35"}
    allowed_value: { label: "Discrete 91 Days" value: "91"}
    allowed_value: { label: "Discrete 182 Days" value: "182"}
    allowed_value: { label: "Discrete 364 Days" value: "364"}
    #default_value: "simple"
  }

  parameter: growth_type {
    label: "Type of Growth"
    type: string
    allowed_value: { label: "Year over Year" value: "yoy"}
    allowed_value: { label: "Sequential" value: "seq"}
    #default_value: "simple"
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

  dimension: brand_name {
    label: "Brand Name"
    type: string
    sql: ${TABLE}.brand_name ;;
    suggest_explore: brand_date_totals_constind_emax
    suggest_dimension: brand_date_totals_constind_emax.brand_name
  }

  dimension: industry_name {
    label: "Industry Name"
    type: string
    sql: ${TABLE}.industry_name ;;
    suggest_explore: brand_date_totals_constind_emax
    suggest_dimension: brand_date_totals_constind_emax.industry_name
  }

  dimension: subindustry_name {
    label: "Subindustry Name"
    type:  string
    sql:  ${TABLE}.subindustry_name ;;
    suggest_explore: brand_date_totals_constind_emax
    suggest_dimension: brand_date_totals_constind_emax.subindustry_name
  }

  dimension: panel_type {
    label: "Panel Type"
    type:  string
    sql:  ${TABLE}.panel_type ;;
  }

  dimension: period {
    label: "Last Period"
    type: string
    sql: ${TABLE}.period ;;
  }

  dimension: prev_period {
    label: "Two Periods Ago"
    type: string
    sql: ${TABLE}.prev_period ;;
  }

  dimension: two_prev_period {
    label: "Three Periods Ago"
    type: string
    sql: ${TABLE}.two_prev_period ;;
  }

  #########################################################
  ## these dimensions are created to be used as filters in the dashboard for minimum spend/transactions

  dimension: spend_amount {
    label: "Spend for Last Period"
    type: number
    sql: ${TABLE}.spend_amount  ;;
    value_format_name: decimal_0
  }

  dimension: trans_count {
    label: "Number of Transactions for Last Period"
    type: number
    sql: ${TABLE}.trans_count ;;
    value_format_name: decimal_0
  }

  ###############################################################
  #growth

  dimension: one_pa_growth {
    label: "Growth for Last Period"
    type: number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.ptd_spend_seq
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.ptd_trans_seq
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ptd_spend_yoy
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ptd_trans_yoy
              END;;
    value_format_name: percent_1
  }

  dimension: two_pa_growth {
    label: "Growth for Two Periods Ago"
    type: number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_ptd_spend_seq
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_ptd_trans_seq
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ptd_spend_yoy
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ptd_trans_yoy
              END;;
    value_format_name: percent_1
  }

  dimension: three_pa_growth {
    label: "Growth for Three Periods Ago"
    type: number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_ptd_spend_seq
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_ptd_trans_seq
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_ptd_spend_yoy
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_ptd_trans_yoy
              END;;
    value_format_name: percent_1
  }


  ##############################################################
  #acceleration

  dimension: one_pa_acceleration {
    label: "Accel/Decel for Last Period vs. Two Periods Ago"
    type: number
    sql:CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.ptd_spend_seq_accel
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.ptd_trans_seq_accel
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ptd_spend_yoy_accel
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ptd_trans_yoy_accel
              END;;
    value_format_name: percent_1
  }

  #measure: two_pa_acceleration {
  #  type: number
  #  label: "Acceleration of y/y Growth Two Periods Ago"
  #  sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_ptd_spend_seq_accel
  #            WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_ptd_trans_seq_accel
  #            WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ptd_spend_yoy_accel
  #            WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ptd_trans_yoy_accel
  #            END;;
  #  value_format_name: percent_1
  #}

  # to calculate three periods ago acceleration we will need to add in sums and growth for four periods ago
  # dimension: three_pa_acceleration {
  #   type: number
  #   label: "Acceleration of y/y Growth Three Periods Ago"
  #   sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_pa_spend_amount_yoy_acceleration
  #        WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_pa_trans_count_yoy_acceleration
  #        WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_pa_spend_amount_seq_acceleration
  #        WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_pa_trans_count_seq_acceleration
  #        END;;
  #   value_format_name: percent_1
  # }


  #################################################################
  ## additional period totals

  dimension: one_pa_total {
    type: number
    label: "Sum of Metric Last Period"
    sql: CASE WHEN {% parameter param_metric %} = 'spend' THEN ${TABLE}.spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' THEN ${TABLE}.trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: two_pa_total {
    type: number
    label: "Sum of Metric Two Periods Ago"
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.ya_trans_count
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.prev_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.prev_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: three_pa_total {
    type: number
    label: "Sum of Metric Three Periods Ago"
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.two_ya_trans_count
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_prev_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.two_prev_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: four_pa_total {
    type: number
    label: "Sum of Metric Four Periods Ago"
    sql: CASE WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'yoy' THEN ${TABLE}.three_ya_trans_count
              WHEN {% parameter param_metric %} = 'spend' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_prev_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' AND {% parameter growth_type %} = 'seq' THEN ${TABLE}.three_prev_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: one_pa_ya_total {
    type:  number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' THEN ${TABLE}.ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' THEN ${TABLE}.ya_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: two_pa_ya_total {
    type:  number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' THEN ${TABLE}.two_ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' THEN ${TABLE}.two_ya_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: three_pa_ya_total {
    type:  number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' THEN ${TABLE}.three_ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' THEN ${TABLE}.three_ya_trans_count
              END;;
    value_format_name: decimal_0
  }

  dimension: four_pa_ya_total {
    type:  number
    sql: CASE WHEN {% parameter param_metric %} = 'spend' THEN ${TABLE}.four_pa_ya_spend_amount
              WHEN {% parameter param_metric %} = 'trans_count' THEN ${TABLE}.four_pa_ya_trans_count
              END;;
    value_format_name: decimal_0
  }

  measure: max_ptd_end_dt {
    label: "Latest Date of Data"
    type: date
    sql: max(${TABLE}.ptd_end_date) ;;
  }

}
