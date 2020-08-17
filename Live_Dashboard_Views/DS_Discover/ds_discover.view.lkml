view: ds_discover {
  derived_table: {
    sql:

                WITH base_data as (SELECT
                                financial_chart.symbol,
                                financial_chart.merger_type,
                                financial_chart.panel_type,
                                financial_chart.cardtype,
                                financial_chart.cardtype_include,
                                financial_chart.panel_method,
                                financial_chart.period,
                                financial_chart.reported_growth,
                                financial_chart.estimated_growth,

                 {% if param_gap_calc._parameter_value == '1' %}

                 financial_chart.one_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '2' %}

                 financial_chart.two_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '3' %}

                 financial_chart.three_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '4' %}

                 financial_chart.four_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '5' %}

                 financial_chart.five_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '6' %}

                 financial_chart.six_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '7' %}

                 financial_chart.seven_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == '8' %}

                 financial_chart.eight_predicted_reported as predicted_reported,

                 {% elsif param_gap_calc._parameter_value == 'All' %}

                 financial_chart.all_predicted_reported as predicted_reported,

                 {% endif %}

                                financial_chart.recommended_panel,
                                financial_chart.days_into_quarter,
                                financial_chart.current_qtr_length,
                                financial_chart.quarter_number,
                                financial_chart.latest_reported_num,
                                financial_chart.yago_financial_start_dt,
                                reported_metric.reported_metric_summary,
                                reported_metric.ownership_status,
                                consensus.consensus_metric,
                                ver.version

                                            FROM ${forecast_financial_chart.SQL_TABLE_NAME} financial_chart

                          LEFT JOIN (SELECT distinct symbol, symbol_id, consensus_period, consensus_metric FROM ${ground_truth_financial.SQL_TABLE_NAME}

                                      WHERE consensus_period is not null) consensus

                                            on consensus.consensus_period = financial_chart.period
                                            and consensus.symbol = financial_chart.symbol

                            LEFT JOIN (SELECT distinct symbol, reported_metric_summary, ownership_status FROM ${ground_truth_financial_all_sym.SQL_TABLE_NAME}) reported_metric #FROM ${ground_truth_financial.SQL_TABLE_NAME}) reported_metric

                    on reported_metric.symbol = financial_chart.symbol

                    CROSS JOIN (SELECT max(version) as version FROM ${dist_day_sym_cardtype_emax_currency.SQL_TABLE_NAME}) ver --replace with dist_day_sym_emax_currency once created

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

                                              {% endif %})

   SELECT

          fins.symbol, fins.panel_type, fins.reported_metric_summary, fins.ownership_status, corrs.corr,

          pct_cap.est_pct_cap, compare.qtd_compare, balance.balance_of_q,

          week_one.week_one_growth, week_one.period as week_one_period, week_one.period_day as week_one_period_day,

          month_one.month_one_growth, month_one.period as month_one_period, month_one.period_day as month_one_period_day,

          qtr_one.qtr_one_growth, qtr_one.period as qtr_one_period, qtr_one.period_day as qtr_one_period_day,

          week_two.week_two_growth, week_three.week_three_growth, week_four.week_four_growth,

          month_two.month_two_growth, month_three.month_three_growth, month_four.month_four_growth,

          qtr_two.qtr_two_growth, qtr_three.qtr_three_growth, qtr_four.qtr_four_growth


   FROM (SELECT distinct symbol, panel_type, reported_metric_summary, ownership_status  FROM base_data) fins

   LEFT JOIN (SELECT symbol, corr(estimated_growth, reported_growth) as corr

              FROM

              (SELECT
              symbol,
              period,
              sum(estimated_growth) AS estimated_growth,
              sum(reported_growth)  AS reported_growth
              FROM base_data

              WHERE yago_financial_start_dt >= date_sub(version, interval 1330 day)
              GROUP BY symbol, period
              ORDER BY symbol , period)

              GROUP BY symbol) corrs

              on corrs.symbol = fins.symbol

    LEFT JOIN (SELECT qtd_s.symbol, qtd_gbp_spend / full_gbp_spend as est_pct_cap

                                        FROM

                                        (SELECT symbol,
                                                sum(yago_gbp_spend_amount) as qtd_gbp_spend,
                                                sum(yago_usd_spend_amount) as qtd_usd_spend,
                                                sum(yago_cad_spend_amount) as qtd_cad_spend,
                                                sum(yago_eur_spend_amount) as qtd_eur_spend,
                                                sum(yago_dkk_spend_amount) as qtd_dkk_spend,
                                                sum(yago_nok_spend_amount) as qtd_nok_spend,
                                                sum(yago_jpy_spend_amount) as qtd_jpy_spend,
                                                sum(yago_sek_spend_amount) as qtd_sek_spend,
                                                sum(yago_pln_spend_amount) as qtd_pln_spend
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

                                                                      AND merger_type = "M&A"

                                                                      AND quarters = "Current Quarter"

                                                                      GROUP BY symbol) qtd_s

                                                 LEFT JOIN  (SELECT symbol,
                                                                    #sum(yago_spend_amount) as full_spend
                                                                    sum(yago_gbp_spend_amount) as full_gbp_spend,
                                                                    sum(yago_usd_spend_amount) as full_usd_spend,
                                                                    sum(yago_cad_spend_amount) as full_cad_spend,
                                                                    sum(yago_eur_spend_amount) as full_eur_spend,
                                                                    sum(yago_dkk_spend_amount) as full_dkk_spend,
                                                                    sum(yago_nok_spend_amount) as full_nok_spend,
                                                                    sum(yago_jpy_spend_amount) as full_jpy_spend,
                                                                    sum(yago_sek_spend_amount) as full_sek_spend,
                                                                    sum(yago_pln_spend_amount) as full_pln_spend
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

                                                                      AND merger_type = "M&A"

                                                                      AND quarters = "Current Quarter"

                                                                      GROUP BY symbol) full_s

                                                                      on full_s.symbol = qtd_s.symbol) pct_cap


                                                                      on pct_cap.symbol = fins.symbol

     LEFT JOIN       (SELECT symbol, sum(yago_gbp_spend_amount) / nullif(sum(two_yago_gbp_spend_amount), 0) - 1 as qtd_compare
                      FROM ${forecast_date_sums.SQL_TABLE_NAME}

                                                                    WHERE day_count = quarter_length

                                                                      {% if param_panel_type._parameter_value == 'Normalized' %}

                                                                      AND panel_type = "NORMALIZED"

                                                                      {% elsif param_panel_type._parameter_value == 'Emax' %}

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

                                                                      AND merger_type = "M&A"

                                                                      AND quarters = "Current Quarter"

                                                                      GROUP BY symbol) compare

                                                                      on compare.symbol = fins.symbol



      LEFT JOIN                    (SELECT symbol, sum(balance_yago_gbp_spend_amount) / nullif(sum(balance_two_yago_gbp_spend_amount), 0) - 1 as balance_of_q FROM ${forecast_date_sums.SQL_TABLE_NAME}

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

                                                                      AND merger_type = "M&A"

                                                                      AND quarters = "Current Quarter"

                                                                      GROUP BY symbol) balance

                                                                      on balance.symbol = fins.symbol


     LEFT JOIN                      ( SELECT week_one_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as week_one_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "WEEK"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 1    )  week_one

                                    on week_one.symbol = fins.symbol


 LEFT JOIN                      ( SELECT month_one_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as month_one_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "MONTH"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 1    )  month_one

                                    on month_one.symbol = fins.symbol


 LEFT JOIN                     ( SELECT qtr_one_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as qtr_one_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "QTR"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 1    )  qtr_one

                                    on qtr_one.symbol = fins.symbol


LEFT JOIN                      ( SELECT week_two_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as week_two_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "WEEK"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 2    )  week_two

                                    on week_two.symbol = fins.symbol




LEFT JOIN                      ( SELECT week_three_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as week_three_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "WEEK"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 3    )  week_three

                                    on week_three.symbol = fins.symbol




LEFT JOIN                      ( SELECT week_four_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as week_four_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "WEEK"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 4    )  week_four

                                    on week_four.symbol = fins.symbol



LEFT JOIN                      ( SELECT month_two_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as month_two_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "MONTH"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 2    )  month_two

                                    on month_two.symbol = fins.symbol




LEFT JOIN                      ( SELECT month_three_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as month_three_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "MONTH"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 3    )  month_three

                                    on month_three.symbol = fins.symbol




LEFT JOIN                      ( SELECT month_four_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as month_four_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "MONTH"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 4    )  month_four

                                    on month_four.symbol = fins.symbol



LEFT JOIN                      ( SELECT qtr_two_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as qtr_two_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "QTR"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 2    )  qtr_two

                                    on qtr_two.symbol = fins.symbol




LEFT JOIN                      ( SELECT qtr_three_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as qtr_three_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "QTR"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 3    )  qtr_three

                                    on qtr_three.symbol = fins.symbol




LEFT JOIN                      ( SELECT qtr_four_growth, symbol, period, period_day

                                        FROM

                                        (SELECT row_number() over(partition by symbol order by symbol, period DESC) as period_count, *

                                        FROM

                                        (SELECT sum(gbp_spend_amount) / sum(prev_gbp_spend_amount) - 1 as qtr_four_growth, symbol, period, period_day

                                        FROM ${by_card_underlying_symbol_yy.SQL_TABLE_NAME}

                                              WHERE 1=1

                                              AND merger_type = "M&A"

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

                                              AND period_type = "QTR"

                                              GROUP BY symbol, period, period_day )

                                              )

                                        WHERE period_count = 4    )  qtr_four

                                    on qtr_four.symbol = fins.symbol




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
      allowed_value: { label: "Debit + Credit" value: "debit_credit" }
      allowed_value: { label: "Credit Only" value: "credit" }
      allowed_value: { label: "Debit Only" value: "debit" }
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
      default_value: "1"
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
    }

    dimension: symbol {
      label: "Symbol"
      type: string
      sql: ${TABLE}.symbol ;;
    }

    dimension: reported_metric_summary {
      label: "Sales Measure (summary)"
      type: string
      sql: ${TABLE}.reported_metric_summary ;;
    }

    dimension: ownership_status {
      label: "Listed Status"
      type: string
      sql: ${TABLE}.ownership_status ;;
    }

    dimension: week_one_period {
      label: "In-Progress W"
      type: string
      sql: ${TABLE}.week_one_period ;;
    }

    dimension: month_one_period {
      label: "In-Progress M"
      type: string
      sql: ${TABLE}.month_one_period ;;
    }

    dimension: qtr_one_period {
      label: "In-Progress Q"
      type: string
      sql: ${TABLE}.qtr_one_period ;;
    }

    dimension: week_one_period_day {
      label: "W Days Into Period"
      type: number
      sql: ${TABLE}.week_one_period_day ;;
    }

    dimension: month_one_period_day {
      label: "M Days Into Period"
      type: number
      sql: ${TABLE}.month_one_period_day ;;
    }

    dimension: qtr_one_period_day {
      label: "Q Days Into Period"
      type: number
      sql: ${TABLE}.qtr_one_period_day ;;
    }

    dimension: week_one_growth {
      label: "WTD Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.week_one_growth ;;
    }

    dimension: week_two_growth {
      label: "Last W Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.week_two_growth ;;
    }

    dimension: week_three_growth {
      label: "2W's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.week_three_growth ;;
    }

    dimension: week_four_growth {
      label: "3W's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.week_four_growth ;;
    }

    dimension: month_one_growth {
      label: "MTD Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.month_one_growth ;;
    }

    dimension: month_two_growth {
      label: "Last M Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.month_two_growth ;;
    }

    dimension: month_three_growth {
      label: "2M's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.month_three_growth ;;
    }

    dimension: month_four_growth {
      label: "3M's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.month_four_growth ;;
    }

    dimension: qtr_one_growth {
      label: "QTD Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtr_one_growth ;;
    }

    dimension: qtr_two_growth {
      label: "Last Q Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtr_two_growth ;;
    }

    dimension: qtr_three_growth {
      label: "2Q's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtr_three_growth ;;
    }

    dimension: qtr_four_growth {
      label: "3Q's Ago Y/y Growth"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtr_four_growth ;;
    }

    dimension: panel_type {
      label: "Panel Type"
      type: string
      sql: ${TABLE}.panel_type ;;
    }

    dimension: corr {
      label: "Correlation"
      type: number
      value_format_name: percent_0
      sql: ${TABLE}.corr ;;
    }

    dimension: corr_filter {
      label: "Correlation Filter"
      type: number
      value_format_name: percent_0
      sql: ${TABLE}.corr * 100 ;;
    }

    dimension: est_pct_cap {
      label: "Est % of Q Captured"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.est_pct_cap ;;
    }

    dimension: qtd_compare {
      label: "QTD Compare"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtd_compare ;;
    }

    dimension: balance_of_q {
      label: "Balance of Q Compare"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.balance_of_q ;;
    }


    dimension: wtd_vs_lastw {
      label: "Accel/Decel WTD vs. last W"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.week_one_growth - ${TABLE}.week_two_growth ;;
    }

    dimension: mtd_vs_lastm {
      label: "Accel/Decel MTD vs. last M"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.month_one_growth - ${TABLE}.month_two_growth ;;
    }

    dimension: qtd_vs_lastq {
      label: "Accel/Decel QTD vs. last Q"
      type: number
      value_format_name: percent_1
      sql: ${TABLE}.qtr_one_growth - ${TABLE}.qtr_two_growth ;;
    }


  }
