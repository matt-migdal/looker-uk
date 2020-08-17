view: qtd_captured_sales {
  derived_table: {
    sql:

    SELECT 1 as row, "Est. % Total Quarter Sales Captured" as row_name, qtd_spend / full_spend as metric

    FROM

    (SELECT sum(yago_spend_amount) as qtd_spend
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = quarter_length

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

       and {% condition symbol_liquid %} symbol {% endcondition %}) qtd_s

    CROSS JOIN  (SELECT sum(yago_spend_amount) as full_spend
                 FROM ${forecast_date_sums.SQL_TABLE_NAME}

                 WHERE day_count = quarter_length + balance_length

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

                   and {% condition symbol_liquid %} symbol {% endcondition %}) full_s

   UNION ALL

   (SELECT 2 as row, "QTD Panel Growth" as row_name, sum(estimated_growth) as metric
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

      {% if param_quarters._parameter_value == 'current_quarter' %}

      AND quarter_number = 1

      {% elsif param_quarters._parameter_value == 'prev_quarter' %}

      AND quarter_number = 2

      {% elsif param_quarters._parameter_value == '2_prev_quarter' %}

      AND quarter_number = 3

      {% elsif param_quarters._parameter_value == '3_prev_quarter' %}

      AND quarter_number = 4

      {% elsif param_quarters._parameter_value == '4_prev_quarter' %}

      AND quarter_number = 5

      {% elsif param_quarters._parameter_value == '5_prev_quarter' %}

      AND quarter_number = 6

      {% endif %}

      and {% condition symbol_liquid %} symbol {% endcondition %})


    UNION ALL

    (SELECT 3 as row,  "QTD YA Compare" as row_name, sum(yago_spend_amount) / nullif(sum(two_yago_spend_amount), 0) - 1 as metric
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = quarter_length

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

       and {% condition symbol_liquid %} symbol {% endcondition %})

    UNION ALL

    (SELECT 4 as row,  "Balance of Q YA Compare" as row_name, sum(balance_yago_spend_amount) / nullif(sum(balance_two_yago_spend_amount), 0) - 1 as metric
     FROM ${forecast_date_sums.SQL_TABLE_NAME}

     WHERE day_count = quarter_length + 1

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

    parameter: param_quarters {
      label: "Quarter Period"
      type: unquoted
      allowed_value: { label: "Current Quarter" value: "current_quarter" }
      allowed_value: { label: "Previous Quarter" value: "prev_quarter" }
      allowed_value: { label: "2 Previous Quarters" value: "2_prev_quarter" }
      allowed_value: { label: "3 Previous Quarters" value: "3_prev_quarter" }
      allowed_value: { label: "4 Previous Quarters" value: "4_prev_quarter" }
      allowed_value: { label: "5 Previous Quarters" value: "5_prev_quarter" }
      default_value: "current_quarter"
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
