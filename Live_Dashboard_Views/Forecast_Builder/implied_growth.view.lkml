view: implied_growth {
  derived_table: {
    sql:

                      UNION ALL

                      (SELECT 2 as row, "Gap Between Reported and Panel (Last Reported Quarter)" as row_name, max(last_observed_gap) as metric FROM ${forecast_financial_chart.SQL_TABLE_NAME}

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

                                          and {% condition symbol_liquid %} symbol {% endcondition %})

                      UNION ALL

                      SELECT 3 as row, "Implied Reported Growth QTD" as row_name, qtd_g.metric + implied_g.metric as metric FROM

                      (SELECT "QTD Panel Growth" as row_name, sum(estimated_growth) as metric FROM ${forecast_financial_chart.SQL_TABLE_NAME}

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

                                          and {% condition symbol_liquid %} symbol {% endcondition %}) qtd_g

                      CROSS JOIN
                                            (SELECT "Last quarter gap between reported and panel" as row_name, max(last_observed_gap) as metric FROM ${forecast_financial_chart.SQL_TABLE_NAME}

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

                                          and {% condition symbol_liquid %} symbol {% endcondition %}) implied_g

                          UNION ALL

                          SELECT 4 as row, "Implied Deceleration QTD" as row_name, recent_est.metric - before_est.metric as metric FROM

                          (SELECT "Implied Deceleration QTD" as row_name, sum(estimated_growth) as metric FROM ${forecast_financial_chart.SQL_TABLE_NAME}

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

                                          and {% condition symbol_liquid %} symbol {% endcondition %}) recent_est

                CROSS JOIN

                           (SELECT "Implied Deceleration QTD" as row_name, sum(estimated_growth) as metric FROM ${forecast_financial_chart.SQL_TABLE_NAME}

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

                                          AND quarter_number = 2

                                          {% elsif param_quarters._parameter_value == 'prev_quarter' %}

                                          AND quarter_number = 3

                                          {% elsif param_quarters._parameter_value == '2_prev_quarter' %}

                                          AND quarter_number = 4

                                          {% elsif param_quarters._parameter_value == '3_prev_quarter' %}

                                          AND quarter_number = 5

                                          {% elsif param_quarters._parameter_value == '4_prev_quarter' %}

                                          AND quarter_number = 6

                                          {% elsif param_quarters._parameter_value == '5_prev_quarter' %}

                                          AND quarter_number = 7

                                          {% endif %}

                                          and {% condition symbol_liquid %} symbol {% endcondition %}) before_est

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

    parameter: param_merger_type {
      label: "Merger Type"
      type: unquoted
      allowed_value: { label: "M&A" value: "manda" }
      allowed_value: { label: "Pro Forma" value: "proforma" }
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
