view: qtd_captured_sales {
  derived_table: {
    sql:

    SELECT 1 as row, "Est. % Total Period Sales Captured" as row_name, qtd_spend / full_spend as metric

    FROM

    (SELECT
            {% if currency._parameter_value == 'gbp' %}
            sum(yago_gbp_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'usd' %}
            sum(yago_usd_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'eur' %}
            sum(yago_eur_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'cad' %}
            sum(yago_cad_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'dkk' %}
            sum(yago_dkk_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'nok' %}
            sum(yago_nok_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'jpy' %}
            sum(yago_jpy_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'sek' %}
            sum(yago_sek_spend_amount) as qtd_spend
            {% elsif currency._parameter_value == 'pln' %}
            sum(yago_pln_spend_amount) as qtd_spend
            {% endif %}
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = Period_length

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

       {% if param_periods._parameter_value == 'current_period' %}

       AND periods = "Current Period"

       {% elsif param_periods._parameter_value == 'prev_period' %}

       AND periods = "Previous Period"

       {% elsif param_periods._parameter_value == '2_prev_period' %}

       AND periods = "2 Previous Periods"

       {% elsif param_periods._parameter_value == '3_prev_period' %}

       AND periods = "3 Previous Periods"

       {% elsif param_periods._parameter_value == '4_prev_period' %}

       AND periods = "4 Previous Periods"

       {% elsif param_periods._parameter_value == '5_prev_period' %}

       AND periods = "5 Previous Periods"

       {% endif %}

       and {% condition symbol_liquid %} symbol {% endcondition %}) qtd_s

    CROSS JOIN  (SELECT {% if currency._parameter_value == 'gbp' %}
                        sum(yago_gbp_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'usd' %}
                        sum(yago_usd_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'eur' %}
                        sum(yago_eur_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'cad' %}
                        sum(yago_cad_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'dkk' %}
                        sum(yago_dkk_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'nok' %}
                        sum(yago_nok_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'jpy' %}
                        sum(yago_jpy_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'sek' %}
                        sum(yago_sek_spend_amount) as full_spend
                        {% elsif currency._parameter_value == 'pln' %}
                        sum(yago_pln_spend_amount) as full_spend
                        {% endif %}
                 FROM ${forecast_date_sums.SQL_TABLE_NAME}

                 WHERE day_count = Period_length + balance_length

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

                   {% if param_periods._parameter_value == 'current_period' %}

                   AND periods = "Current Period"

                   {% elsif param_periods._parameter_value == 'prev_period' %}

                   AND periods = "Previous Period"

                   {% elsif param_periods._parameter_value == '2_prev_period' %}

                   AND periods = "2 Previous Periods"

                   {% elsif param_periods._parameter_value == '3_prev_period' %}

                   AND periods = "3 Previous Periods"

                   {% elsif param_periods._parameter_value == '4_prev_period' %}

                   AND periods = "4 Previous Periods"

                   {% elsif param_periods._parameter_value == '5_prev_period' %}

                   AND periods = "5 Previous Periods"

                   {% endif %}

                   and {% condition symbol_liquid %} symbol {% endcondition %}) full_s

   UNION ALL

   (SELECT 2 as row, "QTD Panel Growth" as row_name,
           {% if currency._parameter_value == 'gbp' %}
           sum(gbp_estimated_growth) as metric
           {% elsif currency._parameter_value == 'usd' %}
           sum(usd_estimated_growth) as metric
          {% elsif currency._parameter_value == 'eur' %}
           sum(eur_estimated_growth) as metric
          {% elsif currency._parameter_value == 'cad' %}
           sum(cad_estimated_growth) as metric
          {% elsif currency._parameter_value == 'dkk' %}
           sum(dkk_estimated_growth) as metric
          {% elsif currency._parameter_value == 'nok' %}
           sum(nok_estimated_growth) as metric
          {% elsif currency._parameter_value == 'jpy' %}
           sum(jpy_estimated_growth) as metric
          {% elsif currency._parameter_value == 'sek' %}
           sum(sek_estimated_growth) as metric
          {% elsif currency._parameter_value == 'pln' %}
           sum(pln_estimated_growth) as metric
          {% endif %}
    FROM ${forecast_financial_chart.SQL_TABLE_NAME}

    WHERE 1 = 1

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

      {% if param_periods._parameter_value == 'current_period' %}

      AND Period_number = 1

      {% elsif param_periods._parameter_value == 'prev_period' %}

      AND Period_number = 2

      {% elsif param_periods._parameter_value == '2_prev_period' %}

      AND Period_number = 3

      {% elsif param_periods._parameter_value == '3_prev_period' %}

      AND Period_number = 4

      {% elsif param_periods._parameter_value == '4_prev_period' %}

      AND Period_number = 5

      {% elsif param_periods._parameter_value == '5_prev_period' %}

      AND Period_number = 6

      {% endif %}

      and {% condition symbol_liquid %} symbol {% endcondition %})


    UNION ALL

    (SELECT 3 as row,  "QTD YA Compare" as row_name,
            {% if currency._parameter_value == 'gbp' %}
            sum(yago_gbp_spend_amount) / nullif(sum(two_yago_gbp_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'usd' %}
            sum(yago_usd_spend_amount) / nullif(sum(two_yago_usd_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'eur' %}
            sum(yago_eur_spend_amount) / nullif(sum(two_yago_eur_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'cad' %}
            sum(yago_cad_spend_amount) / nullif(sum(two_yago_cad_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'dkk' %}
            sum(yago_dkk_spend_amount) / nullif(sum(two_yago_dkk_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'nok' %}
            sum(yago_nok_spend_amount) / nullif(sum(two_yago_nok_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'jpy' %}
            sum(yago_jpy_spend_amount) / nullif(sum(two_yago_jpy_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'sek' %}
            sum(yago_sek_spend_amount) / nullif(sum(two_yago_sek_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'pln' %}
            sum(yago_pln_spend_amount) / nullif(sum(two_yago_pln_spend_amount), 0) - 1 as metric
            {% endif %}
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = Period_length

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

       {% if param_periods._parameter_value == 'current_period' %}

       AND periods = "Current Period"

       {% elsif param_periods._parameter_value == 'prev_period' %}

       AND periods = "Previous Period"

       {% elsif param_periods._parameter_value == '2_prev_period' %}

       AND periods = "2 Previous Periods"

       {% elsif param_periods._parameter_value == '3_prev_period' %}

       AND periods = "3 Previous Periods"

       {% elsif param_periods._parameter_value == '4_prev_period' %}

       AND periods = "4 Previous Periods"

       {% elsif param_periods._parameter_value == '5_prev_period' %}

       AND periods = "5 Previous Periods"

       {% endif %}

       and {% condition symbol_liquid %} symbol {% endcondition %})

    UNION ALL

    (SELECT 4 as row,  "Balance of Q YA Compare" as row_name,
            {% if currency._parameter_value == 'gbp' %}
            sum(balance_yago_gbp_spend_amount) / nullif(sum(balance_two_yago_gbp_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'usd' %}
            sum(balance_yago_usd_spend_amount) / nullif(sum(balance_two_usd_yago_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'eur' %}
            sum(balance_yago_eur_spend_amount) / nullif(sum(balance_two_yago_eur_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'cad' %}
            sum(balance_yago_cad_spend_amount) / nullif(sum(balance_two_yago_cad_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'dkk' %}
            sum(balance_yago_dkk_spend_amount) / nullif(sum(balance_two_yago_dkk_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'nok' %}
            sum(balance_yago_nok_spend_amount) / nullif(sum(balance_two_yago_nok_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'jpy' %}
            sum(balance_yago_jpy_spend_amount) / nullif(sum(balance_two_yago_jpy_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'sek' %}
            sum(balance_yago_sek_spend_amount) / nullif(sum(balance_two_yago_sek_spend_amount), 0) - 1 as metric
            {% elsif currency._parameter_value == 'pln' %}
            sum(balance_yago_pln_spend_amount) / nullif(sum(balance_two_yago_pln_spend_amount), 0) - 1 as metric
            {% endif %}
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = Period_length + 1

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

       {% if param_periods._parameter_value == 'current_period' %}

       AND periods = "Current Period"

       {% elsif param_periods._parameter_value == 'prev_period' %}

       AND periods = "Previous Period"

       {% elsif param_periods._parameter_value == '2_prev_period' %}

       AND periods = "2 Previous Periods"

       {% elsif param_periods._parameter_value == '3_prev_period' %}

       AND periods = "3 Previous Periods"

       {% elsif param_periods._parameter_value == '4_prev_period' %}

       AND periods = "4 Previous Periods"

       {% elsif param_periods._parameter_value == '5_prev_period' %}

       AND periods = "5 Previous Periods"

       {% endif %}

       and {% condition symbol_liquid %} symbol {% endcondition %})

                                                                 ;;

    }

    parameter: param_panel_type {
      label: "Panel Type"
      type: unquoted
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

    parameter: param_periods {
      label: "Quarter Period" #rename this
      type: unquoted
      allowed_value: { label: "Current Period" value: "current_period" }
      allowed_value: { label: "Previous Period" value: "prev_period" }
      allowed_value: { label: "2 Previous Periods" value: "2_prev_period" }
      allowed_value: { label: "3 Previous Periods" value: "3_prev_period" }
      allowed_value: { label: "4 Previous Periods" value: "4_prev_period" }
      allowed_value: { label: "5 Previous Periods" value: "5_prev_period" }
      default_value: "current_period"
    }

    parameter: period_type {
      type: unquoted
      allowed_value: { label: "Fiscal Quarter" value: "qtr"}
      allowed_value: { label: "Fiscal Half" value: "half"}
    }

  parameter: currency {
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

    dimension: row_name {
      label: "Row Name"
      type: string
      sql: ${TABLE}.row_name ;;
    }

    dimension: row {
      label: "Row"
      type: string
      sql: ${TABLE}.row ;;
    }

#             measure:  qtd_spend {
#               label: "QTD Spend"
#               type: sum
#               sql: ${TABLE}.qtd_spend ;;
#               value_format_name: usd_0
#             }
#
#           measure:  full_spend {
#             label: "Full Spend"
#             type: sum
#             sql: ${TABLE}.full_spend ;;
#             value_format_name: usd_0
#           }

    measure:  metric {
      label: "Metric"
      type: sum
      sql: ${TABLE}.metric ;;
      value_format_name: percent_1
    }

    filter: symbol_liquid{
      type: string
    }

    }
