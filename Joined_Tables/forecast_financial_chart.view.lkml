view: forecast_financial_chart {
  derived_table: {
    sql:

        SELECT
                  finished_growth.row,
                  finished_growth.symbol,
                  finished_growth.merger_type,
                  finished_growth.panel_type,
                  finished_growth.cardtype,
                  finished_growth.cardtype_include,
                  finished_growth.panel_method,
                  finished_growth.period,
                  finished_growth.yago_period,
                  finished_growth.financial_start_dt,
                  finished_growth.financial_end_dt,
                  finished_growth.yago_financial_start_dt,
                  finished_growth.yago_financial_end_dt,
                  finished_growth.reported_sales,
                  finished_growth.yago_reported_sales,
                  finished_growth.reported_growth,
                  finished_growth.reported_sales_currency,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.gbp_spend END as gbp_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.usd_spend END as usd_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.eur_spend END as eur_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.cad_spend END as cad_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.dkk_spend END as dkk_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.nok_spend END as nok_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.jpy_spend END as jpy_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.sek_spend END as sek_spend,
                  CASE WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.pln_spend END as pln_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_gbp_spend END as yago_gbp_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_usd_spend END as yago_usd_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_eur_spend END as yago_eur_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_cad_spend END as yago_cad_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_dkk_spend END as yago_dkk_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_nok_spend END as yago_nok_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_jpy_spend END as yago_jpy_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_sek_spend END as yago_sek_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.yago_pln_spend END as yago_pln_spend,
                  CASE WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME}) and panel_type = "CONSTIND" THEN null
                       WHEN finished_growth.yago_financial_start_dt < (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME}) and panel_type = "EMAX" THEN null
                       ELSE finished_growth.estimated_growth END as estimated_growth,
                  gbp_estimated_growth,
                  usd_estimated_growth,
                  eur_estimated_growth,
                  cad_estimated_growth,
                  dkk_estimated_growth,
                  nok_estimated_growth,
                  jpy_estimated_growth,
                  sek_estimated_growth,
                  pln_estimated_growth,
                  finished_growth.latest_reported_num,

                  finished_growth.one_predicted_reported,
                  finished_growth.two_predicted_reported,
                  finished_growth.three_predicted_reported,
                  finished_growth.four_predicted_reported,
                  finished_growth.five_predicted_reported,
                  finished_growth.six_predicted_reported,
                  finished_growth.seven_predicted_reported,
                  finished_growth.eight_predicted_reported,
                  finished_growth.all_predicted_reported,

                  finished_growth.one_observed_gap,
                  finished_growth.two_observed_gap,
                  finished_growth.three_observed_gap,
                  finished_growth.four_observed_gap,
                  finished_growth.five_observed_gap,
                  finished_growth.six_observed_gap,
                  finished_growth.seven_observed_gap,
                  finished_growth.eight_observed_gap,
                  finished_growth.all_observed_gap,

                  finished_growth.recommended_panel,
                  finished_growth.actual_financial_start_dt,
                  finished_growth.actual_financial_end_dt,
                  finished_growth.actual_yago_financial_start_dt,
                  finished_growth.actual_yago_financial_end_dt,
                  finished_growth.actual_two_yago_financial_start_dt,
                  finished_growth.actual_two_yago_financial_end_dt,

                  finished_growth.observed_gap,

                  q_nums.quarter_number,
                  date_diff(finished_growth.actual_financial_end_dt, finished_growth.actual_financial_start_dt, day) + 1 as current_qtr_length,
                  date_diff(finished_growth.actual_yago_financial_end_dt, finished_growth.actual_yago_financial_start_dt, day) + 1 as yago_qtr_length,
                  date_diff(finished_growth.actual_two_yago_financial_end_dt, finished_growth.actual_two_yago_financial_start_dt, day) + 1 as two_yago_qtr_length,
                  date_diff(finished_growth.financial_end_dt, finished_growth.financial_start_dt, day) + 1 as days_into_quarter

        FROM

        (

        SELECT *,

                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

                current_spend.gbp_spend / yago_spend.gbp_spend - 1 as gbp_estimated_growth,
                current_spend.usd_spend / yago_spend.usd_spend - 1 as usd_estimated_growth,
                current_spend.eur_spend / yago_spend.eur_spend - 1 as eur_estimated_growth,
                current_spend.cad_spend / yago_spend.cad_spend - 1 as cad_estimated_growth,
                current_spend.dkk_spend / yago_spend.dkk_spend - 1 as dkk_estimated_growth,
                current_spend.nok_spend / yago_spend.nok_spend - 1 as nok_estimated_growth,
                current_spend.jpy_spend / yago_spend.jpy_spend - 1 as jpy_estimated_growth,
                current_spend.sek_spend / yago_spend.sek_spend - 1 as sek_estimated_growth,
                current_spend.pln_spend / yago_spend.pln_spend - 1 as pln_estimated_growth
        FROM

            (SELECT current_spend.row,
                    current_spend.symbol,
                    current_spend.merger_type,
                    current_spend.panel_type,
                    current_spend.cardtype,
                    current_spend.cardtype_include,
                    current_spend.panel_method,
                    current_spend.period,
                    current_spend.yago_period,
                    current_spend.financial_start_dt,
                    current_spend.financial_end_dt,
                    current_spend.yago_financial_start_dt,
                    current_spend.yago_financial_end_dt,
                    current_spend.reported_sales,
                    current_spend.yago_reported_sales,
                    current_spend.reported_growth,
                    current_spend.reported_sales_currency,
                    current_spend.gbp_spend,
                    current_spend.usd_spend,
                    current_spend.eur_spend,
                    current_spend.cad_spend,
                    current_spend.dkk_spend,
                    current_spend.nok_spend,
                    current_spend.jpy_spend,
                    current_spend.sek_spend,
                    current_spend.pln_spend,
                    yago_spend.gbp_spend as yago_gbp_spend,
                    yago_spend.usd_spend as yago_usd_spend,
                    yago_spend.eur_spend as yago_eur_spend,
                    yago_spend.cad_spend as yago_cad_spend,
                    yago_spend.dkk_spend as yago_dkk_spend,
                    yago_spend.nok_spend as yago_nok_spend,
                    yago_spend.jpy_spend as yago_jpy_spend,
                    yago_spend.sek_spend as yago_sek_spend,
                    yago_spend.pln_spend as yago_pln_spend,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                    current_spend.latest_reported_num,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                    FROM

                        (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.latest_reported_num,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt,
                                financials.actual_two_yago_financial_start_dt,
                                financials.actual_two_yago_financial_end_dt

                         FROM ${symbol_financials.SQL_TABLE_NAME} financials

                         LEFT JOIN (select
                                        p.symbol
                                        , "CREDIT + DEBIT" as cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "CONSTIND" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                    from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                               FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol) current_spend

                         on financials.symbol = current_spend.symbol
                         and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                         GROUP BY financials.row,
                                  financials.symbol,
                                  current_spend.merger_type,
                                  current_spend.panel_type,
                                  current_spend.cardtype,
                                  current_spend.cardtype_include,
                                  current_spend.panel_method,
                                  financials.period,
                                  financials.yago_period,
                                  financials.financial_start_dt,
                                  financials.financial_end_dt,
                                  financials.yago_financial_start_dt,
                                  financials.yago_financial_end_dt,
                                  financials.reported_sales,
                                  financials.yago_reported_sales,
                                  financials.reported_sales_currency,
                                  financials.latest_reported_num,
                                  financials.actual_financial_start_dt,
                                  financials.actual_financial_end_dt,
                                  financials.actual_yago_financial_start_dt,
                                  financials.actual_yago_financial_end_dt,
                                  financials.actual_two_yago_financial_start_dt,
                                  financials.actual_two_yago_financial_end_dt

                         ORDER BY symbol, period) current_spend

                    LEFT JOIN (SELECT financials.row,
                                      financials.symbol,
                                      current_spend.merger_type,
                                      current_spend.panel_type,
                                      current_spend.cardtype,
                                      current_spend.cardtype_include,
                                      current_spend.panel_method,
                                      financials.period,
                                      financials.yago_period,
                                      financials.financial_start_dt,
                                      financials.financial_end_dt,
                                      financials.yago_financial_start_dt,
                                      financials.yago_financial_end_dt,
                                      financials.reported_sales,
                                      financials.yago_reported_sales ,
                                      financials.reported_sales_currency,
                                      sum(current_spend.gbp_spend_amount) as gbp_spend,
                                      sum(current_spend.usd_spend_amount) as usd_spend,
                                      sum(current_spend.cad_spend_amount) as cad_spend,
                                      sum(current_spend.eur_spend_amount) as eur_spend,
                                      sum(current_spend.dkk_spend_amount) as dkk_spend,
                                      sum(current_spend.nok_spend_amount) as nok_spend,
                                      sum(current_spend.sek_spend_amount) as sek_spend,
                                      sum(current_spend.jpy_spend_amount) as jpy_spend,
                                      sum(current_spend.pln_spend_amount) as pln_spend,

                                      financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                      financials.actual_financial_start_dt,
                                      financials.actual_financial_end_dt,
                                      financials.actual_yago_financial_start_dt,
                                      financials.actual_yago_financial_end_dt

                              FROM ${symbol_financials.SQL_TABLE_NAME} financials

                              LEFT JOIN (select
                                              p.symbol
                                              , "CREDIT + DEBIT" as cardtype
                                              , p.trans_date
                                              , "M&A" as merger_type
                                              , "CONSTIND" as panel_type
                                              , sd.panel_method
                                              , sd.cardtype_include
                                              , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                              , round(p.usd_spend_amount,2) as usd_spend_amount
                                              , round(p.cad_spend_amount,2) as cad_spend_amount
                                              , round(p.eur_spend_amount,2) as eur_spend_amount
                                              , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                              , round(p.nok_spend_amount,2) as nok_spend_amount
                                              , round(p.sek_spend_amount,2) as sek_spend_amount
                                              , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                              , round(p.pln_spend_amount,2) as pln_spend_amount

                                         from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                         inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                     FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                         on p.symbol = sb.symbol
                                         and p.brand_id = sb.brand_id
                                         and p.trans_date between sb.start_date and sb.end_date
                                         left join (SELECT distinct symbol, panel_method, cardtype_include
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                         on p.symbol = sd.symbol) current_spend

                              on financials.symbol = current_spend.symbol
                              and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                              GROUP BY financials.row,
                                       financials.symbol,
                                       current_spend.merger_type,
                                       current_spend.panel_type,
                                       current_spend.cardtype,
                                       current_spend.cardtype_include,
                                       current_spend.panel_method,
                                       financials.period,
                                       financials.yago_period,
                                       financials.financial_start_dt,
                                       financials.financial_end_dt,
                                       financials.yago_financial_start_dt,
                                       financials.yago_financial_end_dt,
                                       financials.reported_sales,
                                       financials.yago_reported_sales,
                                       financials.reported_sales_currency,
                                       financials.actual_financial_start_dt,
                                       financials.actual_financial_end_dt,
                                       financials.actual_yago_financial_start_dt,
                                       financials.actual_yago_financial_end_dt

                              ORDER BY symbol, period) yago_spend

                    on current_spend.symbol = yago_spend.symbol
                    and current_spend.cardtype = yago_spend.cardtype
                    and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

              CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

              (SELECT current_spend.row,
                      current_spend.symbol,
                      current_spend.merger_type,
                      current_spend.panel_type,
                      current_spend.cardtype,
                      current_spend.cardtype_include,
                      current_spend.panel_method,
                      current_spend.period,
                      current_spend.yago_period,
                      current_spend.financial_start_dt,
                      current_spend.financial_end_dt,
                      current_spend.yago_financial_start_dt,
                      current_spend.yago_financial_end_dt,
                      current_spend.reported_sales,
                      current_spend.yago_reported_sales,
                      current_spend.reported_growth,
                      current_spend.reported_sales_currency,
                      current_spend.gbp_spend,
                      current_spend.usd_spend,
                      current_spend.eur_spend,
                      current_spend.cad_spend,
                      current_spend.dkk_spend,
                      current_spend.nok_spend,
                      current_spend.jpy_spend,
                      current_spend.sek_spend,
                      current_spend.pln_spend,
                      yago_spend.gbp_spend as yago_gbp_spend,
                      yago_spend.usd_spend as yago_usd_spend,
                      yago_spend.eur_spend as yago_eur_spend,
                      yago_spend.cad_spend as yago_cad_spend,
                      yago_spend.dkk_spend as yago_dkk_spend,
                      yago_spend.nok_spend as yago_nok_spend,
                      yago_spend.jpy_spend as yago_jpy_spend,
                      yago_spend.sek_spend as yago_sek_spend,
                      yago_spend.pln_spend as yago_pln_spend,
                      CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                    current_spend.latest_reported_num,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                      FROM

                          (SELECT financials.row,
                                  financials.symbol,
                                  current_spend.merger_type,
                                  current_spend.panel_type,
                                  current_spend.cardtype,
                                  current_spend.cardtype_include,
                                  current_spend.panel_method,
                                  financials.period,
                                  financials.yago_period,
                                  financials.financial_start_dt,
                                  financials.financial_end_dt,
                                  financials.yago_financial_start_dt,
                                  financials.yago_financial_end_dt,
                                  financials.reported_sales,
                                  financials.yago_reported_sales,
                                  financials.reported_sales_currency,
                                  sum(current_spend.gbp_spend_amount) as gbp_spend,
                                  sum(current_spend.usd_spend_amount) as usd_spend,
                                  sum(current_spend.cad_spend_amount) as cad_spend,
                                  sum(current_spend.eur_spend_amount) as eur_spend,
                                  sum(current_spend.dkk_spend_amount) as dkk_spend,
                                  sum(current_spend.nok_spend_amount) as nok_spend,
                                  sum(current_spend.sek_spend_amount) as sek_spend,
                                  sum(current_spend.jpy_spend_amount) as jpy_spend,
                                  sum(current_spend.pln_spend_amount) as pln_spend,

                                  financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                  financials.latest_reported_num,
                                  financials.actual_financial_start_dt,
                                  financials.actual_financial_end_dt,
                                  financials.actual_yago_financial_start_dt,
                                  financials.actual_yago_financial_end_dt,
                                  financials.actual_two_yago_financial_start_dt,
                                  financials.actual_two_yago_financial_end_dt

                          FROM ${symbol_financials.SQL_TABLE_NAME} financials

                          LEFT JOIN (select
                                          p.symbol
                                          , "CREDIT" as cardtype
                                          , p.trans_date
                                          , "M&A" as merger_type
                                          , "CONSTIND" as panel_type
                                          , sd.panel_method
                                          , sd.cardtype_include
                                          , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                          , round(p.usd_spend_amount,2) as usd_spend_amount
                                          , round(p.cad_spend_amount,2) as cad_spend_amount
                                          , round(p.eur_spend_amount,2) as eur_spend_amount
                                          , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                          , round(p.nok_spend_amount,2) as nok_spend_amount
                                          , round(p.sek_spend_amount,2) as sek_spend_amount
                                          , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                          , round(p.pln_spend_amount,2) as pln_spend_amount

                                    from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol

                                    WHERE cardtype = "CREDIT") current_spend

                          on financials.symbol = current_spend.symbol
                          and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                          GROUP BY financials.row,
                                   financials.symbol,
                                   current_spend.merger_type,
                                   current_spend.panel_type,
                                   current_spend.cardtype,
                                   current_spend.cardtype_include,
                                   current_spend.panel_method,
                                   financials.period,
                                   financials.yago_period,
                                   financials.financial_start_dt,
                                   financials.financial_end_dt,
                                   financials.yago_financial_start_dt,
                                   financials.yago_financial_end_dt,
                                   financials.reported_sales,
                                   financials.yago_reported_sales,
                                   financials.reported_sales_currency,
                                   financials.latest_reported_num,
                                   financials.actual_financial_start_dt,
                                   financials.actual_financial_end_dt,
                                   financials.actual_yago_financial_start_dt,
                                   financials.actual_yago_financial_end_dt,
                                   financials.actual_two_yago_financial_start_dt,
                                   financials.actual_two_yago_financial_end_dt

                          ORDER BY symbol, period) current_spend

        LEFT JOIN (SELECT financials.row,
                          financials.symbol,
                          current_spend.merger_type,
                          current_spend.panel_type,
                          current_spend.cardtype,
                          current_spend.cardtype_include,
                          current_spend.panel_method,
                          financials.period,
                          financials.yago_period,
                          financials.financial_start_dt,
                          financials.financial_end_dt,
                          financials.yago_financial_start_dt,
                          financials.yago_financial_end_dt,
                          financials.reported_sales,
                          financials.yago_reported_sales,
                          financials.reported_sales_currency,
                          sum(current_spend.gbp_spend_amount) as gbp_spend,
                          sum(current_spend.usd_spend_amount) as usd_spend,
                          sum(current_spend.cad_spend_amount) as cad_spend,
                          sum(current_spend.eur_spend_amount) as eur_spend,
                          sum(current_spend.dkk_spend_amount) as dkk_spend,
                          sum(current_spend.nok_spend_amount) as nok_spend,
                          sum(current_spend.sek_spend_amount) as sek_spend,
                          sum(current_spend.jpy_spend_amount) as jpy_spend,
                          sum(current_spend.pln_spend_amount) as pln_spend,

                          financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                          financials.actual_financial_start_dt,
                          financials.actual_financial_end_dt,
                          financials.actual_yago_financial_start_dt,
                          financials.actual_yago_financial_end_dt,
                          financials.actual_two_yago_financial_start_dt,
                          financials.actual_two_yago_financial_end_dt

                  FROM ${symbol_financials.SQL_TABLE_NAME} financials

                  LEFT JOIN (select
                                  p.symbol
                                  , "CREDIT" as cardtype
                                  , p.trans_date
                                  , "M&A" as merger_type
                                  , "CONSTIND" as panel_type
                                  , sd.panel_method
                                  , sd.cardtype_include
                                  , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                  , round(p.usd_spend_amount,2) as usd_spend_amount
                                  , round(p.cad_spend_amount,2) as cad_spend_amount
                                  , round(p.eur_spend_amount,2) as eur_spend_amount
                                  , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                  , round(p.nok_spend_amount,2) as nok_spend_amount
                                  , round(p.sek_spend_amount,2) as sek_spend_amount
                                  , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                  , round(p.pln_spend_amount,2) as pln_spend_amount

                              from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                              inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                          FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                              on p.symbol = sb.symbol
                              and p.brand_id = sb.brand_id
                              and p.trans_date between sb.start_date and sb.end_date
                              left join (SELECT distinct symbol, panel_method, cardtype_include
                                        FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                              on p.symbol = sd.symbol

                              WHERE cardtype = "CREDIT") current_spend

                  on financials.symbol = current_spend.symbol
                  and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                  GROUP BY financials.row,
                           financials.symbol,
                           current_spend.merger_type,
                           current_spend.panel_type,
                           current_spend.cardtype,
                           current_spend.cardtype_include,
                           current_spend.panel_method,
                           financials.period,
                           financials.yago_period,
                           financials.financial_start_dt,
                           financials.financial_end_dt,
                           financials.yago_financial_start_dt,
                           financials.yago_financial_end_dt,
                           financials.reported_sales,
                           financials.yago_reported_sales,
                           financials.reported_sales_currency,
                           financials.actual_financial_start_dt,
                           financials.actual_financial_end_dt,
                           financials.actual_yago_financial_start_dt,
                           financials.actual_yago_financial_end_dt,
                           financials.actual_two_yago_financial_start_dt,
                           financials.actual_two_yago_financial_end_dt

                  ORDER BY symbol, period) yago_spend

        on current_spend.symbol = yago_spend.symbol
        and current_spend.cardtype = yago_spend.cardtype
        and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

            (SELECT current_spend.row,
                    current_spend.symbol,
                    current_spend.merger_type,
                    current_spend.panel_type,
                    current_spend.cardtype,
                    current_spend.cardtype_include,
                    current_spend.panel_method,
                    current_spend.period,
                    current_spend.yago_period,
                    current_spend.financial_start_dt,
                    current_spend.financial_end_dt,
                    current_spend.yago_financial_start_dt,
                    current_spend.yago_financial_end_dt,
                    current_spend.reported_sales,
                    current_spend.yago_reported_sales,
                    current_spend.reported_growth,
                    current_spend.reported_sales_currency,
                    current_spend.gbp_spend,
                    current_spend.usd_spend,
                    current_spend.eur_spend,
                    current_spend.cad_spend,
                    current_spend.dkk_spend,
                    current_spend.nok_spend,
                    current_spend.jpy_spend,
                    current_spend.sek_spend,
                    current_spend.pln_spend,
                    yago_spend.gbp_spend as yago_gbp_spend,
                    yago_spend.usd_spend as yago_usd_spend,
                    yago_spend.eur_spend as yago_eur_spend,
                    yago_spend.cad_spend as yago_cad_spend,
                    yago_spend.dkk_spend as yago_dkk_spend,
                    yago_spend.nok_spend as yago_nok_spend,
                    yago_spend.jpy_spend as yago_jpy_spend,
                    yago_spend.sek_spend as yago_sek_spend,
                    yago_spend.pln_spend as yago_pln_spend,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                    current_spend.latest_reported_num,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                    FROM

                          (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.latest_reported_num,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt,
                                financials.actual_two_yago_financial_start_dt,
                                financials.actual_two_yago_financial_end_dt

                          FROM ${symbol_financials.SQL_TABLE_NAME} financials

                          LEFT JOIN (select
                                        p.symbol
                                        , "DEBIT" as cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "CONSTIND" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                  from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                  on p.symbol = sb.symbol
                                  and p.brand_id = sb.brand_id
                                  and p.trans_date between sb.start_date and sb.end_date
                                  left join (SELECT distinct symbol, panel_method, cardtype_include
                                            FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                  on p.symbol = sd.symbol

                                  WHERE cardtype = "DEBIT") current_spend

                          on financials.symbol = current_spend.symbol
                          and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                          GROUP BY financials.row,
                                 financials.symbol,
                                 current_spend.merger_type,
                                 current_spend.panel_type,
                                 current_spend.cardtype,
                                 current_spend.cardtype_include,
                                 current_spend.panel_method,
                                 financials.period,
                                 financials.yago_period,
                                 financials.financial_start_dt,
                                 financials.financial_end_dt,
                                 financials.yago_financial_start_dt,
                                 financials.yago_financial_end_dt,
                                 financials.reported_sales,
                                 financials.yago_reported_sales,
                                 financials.reported_sales_currency,
                                 financials.latest_reported_num,
                                 financials.actual_financial_start_dt,
                                 financials.actual_financial_end_dt,
                                 financials.actual_yago_financial_start_dt,
                                 financials.actual_yago_financial_end_dt,
                                 financials.actual_two_yago_financial_start_dt,
                                 financials.actual_two_yago_financial_end_dt

                          ORDER BY symbol, period) current_spend

                    LEFT JOIN (SELECT financials.row,
                                      financials.symbol,
                                      current_spend.merger_type,
                                      current_spend.panel_type,
                                      current_spend.cardtype,
                                      current_spend.cardtype_include,
                                      current_spend.panel_method,
                                      financials.period,
                                      financials.yago_period,
                                      financials.financial_start_dt,
                                      financials.financial_end_dt,
                                      financials.yago_financial_start_dt,
                                      financials.yago_financial_end_dt,
                                      financials.reported_sales,
                                      financials.yago_reported_sales,
                                      financials.reported_sales_currency,
                                      sum(current_spend.gbp_spend_amount) as gbp_spend,
                                      sum(current_spend.usd_spend_amount) as usd_spend,
                                      sum(current_spend.cad_spend_amount) as cad_spend,
                                      sum(current_spend.eur_spend_amount) as eur_spend,
                                      sum(current_spend.dkk_spend_amount) as dkk_spend,
                                      sum(current_spend.nok_spend_amount) as nok_spend,
                                      sum(current_spend.sek_spend_amount) as sek_spend,
                                      sum(current_spend.jpy_spend_amount) as jpy_spend,
                                      sum(current_spend.pln_spend_amount) as pln_spend,

                                      financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                      financials.actual_financial_start_dt,
                                      financials.actual_financial_end_dt,
                                      financials.actual_yago_financial_start_dt,
                                      financials.actual_yago_financial_end_dt

                                FROM ${symbol_financials.SQL_TABLE_NAME} financials

                                LEFT JOIN (select
                                              p.symbol
                                              , "DEBIT" as cardtype
                                              , p.trans_date
                                              , "M&A" as merger_type
                                              , "CONSTIND" as panel_type
                                              , sd.panel_method
                                              , sd.cardtype_include
                                              , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                              , round(p.usd_spend_amount,2) as usd_spend_amount
                                              , round(p.cad_spend_amount,2) as cad_spend_amount
                                              , round(p.eur_spend_amount,2) as eur_spend_amount
                                              , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                              , round(p.nok_spend_amount,2) as nok_spend_amount
                                              , round(p.sek_spend_amount,2) as sek_spend_amount
                                              , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                              , round(p.pln_spend_amount,2) as pln_spend_amount

                                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                        on p.symbol = sb.symbol
                                        and p.brand_id = sb.brand_id
                                        and p.trans_date between sb.start_date and sb.end_date
                                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                        on p.symbol = sd.symbol

                                        WHERE cardtype = "DEBIT") current_spend

                                on financials.symbol = current_spend.symbol
                                and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                                GROUP BY financials.row,
                                         financials.symbol,
                                         current_spend.merger_type,
                                         current_spend.panel_type,
                                         current_spend.cardtype,
                                         current_spend.cardtype_include,
                                         current_spend.panel_method,
                                         financials.period,
                                         financials.yago_period,
                                         financials.financial_start_dt,
                                         financials.financial_end_dt,
                                         financials.yago_financial_start_dt,
                                         financials.yago_financial_end_dt,
                                         financials.reported_sales,
                                         financials.yago_reported_sales,
                                         financials.reported_sales_currency,
                                         financials.actual_financial_start_dt,
                                         financials.actual_financial_end_dt,
                                         financials.actual_yago_financial_start_dt,
                                         financials.actual_yago_financial_end_dt

                                ORDER BY symbol, period) yago_spend

                    on current_spend.symbol = yago_spend.symbol
                    and current_spend.cardtype = yago_spend.cardtype
                    and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

              (SELECT current_spend.row,
                      current_spend.symbol,
                      current_spend.merger_type,
                      current_spend.panel_type,
                      current_spend.cardtype,
                      current_spend.cardtype_include,
                      current_spend.panel_method,
                      current_spend.period,
                      current_spend.yago_period,
                      current_spend.financial_start_dt,
                      current_spend.financial_end_dt,
                      current_spend.yago_financial_start_dt,
                      current_spend.yago_financial_end_dt,
                      current_spend.reported_sales,
                      current_spend.yago_reported_sales,
                      current_spend.reported_growth,
                      current_spend.reported_sales_currency,
                      current_spend.gbp_spend,
                      current_spend.usd_spend,
                      current_spend.eur_spend,
                      current_spend.cad_spend,
                      current_spend.dkk_spend,
                      current_spend.nok_spend,
                      current_spend.jpy_spend,
                      current_spend.sek_spend,
                      current_spend.pln_spend,
                      yago_spend.gbp_spend as yago_gbp_spend,
                      yago_spend.usd_spend as yago_usd_spend,
                      yago_spend.eur_spend as yago_eur_spend,
                      yago_spend.cad_spend as yago_cad_spend,
                      yago_spend.dkk_spend as yago_dkk_spend,
                      yago_spend.nok_spend as yago_nok_spend,
                      yago_spend.jpy_spend as yago_jpy_spend,
                      yago_spend.sek_spend as yago_sek_spend,
                      yago_spend.pln_spend as yago_pln_spend,
                      CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                      current_spend.latest_reported_num,

                      CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

              FROM

                    (SELECT financials.row,
                            financials.symbol,
                            current_spend.merger_type,
                            current_spend.panel_type,
                            current_spend.cardtype,
                            current_spend.cardtype_include,
                            current_spend.panel_method,
                            financials.period,
                            financials.yago_period,
                            financials.financial_start_dt,
                            financials.financial_end_dt,
                            financials.yago_financial_start_dt,
                            financials.yago_financial_end_dt,
                            financials.reported_sales,
                            financials.yago_reported_sales,
                            financials.reported_sales_currency,
                            sum(current_spend.gbp_spend_amount) as gbp_spend,
                            sum(current_spend.usd_spend_amount) as usd_spend,
                            sum(current_spend.cad_spend_amount) as cad_spend,
                            sum(current_spend.eur_spend_amount) as eur_spend,
                            sum(current_spend.dkk_spend_amount) as dkk_spend,
                            sum(current_spend.nok_spend_amount) as nok_spend,
                            sum(current_spend.sek_spend_amount) as sek_spend,
                            sum(current_spend.jpy_spend_amount) as jpy_spend,
                            sum(current_spend.pln_spend_amount) as pln_spend,

                            financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                            financials.latest_reported_num,
                            financials.actual_financial_start_dt,
                            financials.actual_financial_end_dt,
                            financials.actual_yago_financial_start_dt,
                            financials.actual_yago_financial_end_dt,
                            financials.actual_two_yago_financial_start_dt,
                            financials.actual_two_yago_financial_end_dt

                    FROM ${symbol_financials.SQL_TABLE_NAME} financials

                    LEFT JOIN (SELECT *
                               FROM

                                    (select p.symbol
                                            , "RECOMMENDED" as cardtype
                                            , p.trans_date
                                            , "M&A" as merger_type
                                            , "CONSTIND" as panel_type
                                            , sd.panel_method
                                            , sd.cardtype_include
                                            , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                            , round(p.usd_spend_amount,2) as usd_spend_amount
                                            , round(p.cad_spend_amount,2) as cad_spend_amount
                                            , round(p.eur_spend_amount,2) as eur_spend_amount
                                            , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                            , round(p.nok_spend_amount,2) as nok_spend_amount
                                            , round(p.sek_spend_amount,2) as sek_spend_amount
                                            , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                            , round(p.pln_spend_amount,2) as pln_spend_amount
                                            , CASE WHEN cardtype_include = "CREDIT_DEBIT" THEN 1 WHEN cardtype = cardtype_include THEN 1 ELSE 0 END as recommended_cardtype

                                    from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                               FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol)

                               WHERE recommended_cardtype = 1) current_spend

                    on financials.symbol = current_spend.symbol
                    and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                    GROUP BY financials.row,
                             financials.symbol,
                             current_spend.merger_type,
                             current_spend.panel_type,
                             current_spend.cardtype,
                             current_spend.cardtype_include,
                             current_spend.panel_method,
                             financials.period,
                             financials.yago_period,
                             financials.financial_start_dt,
                             financials.financial_end_dt,
                             financials.yago_financial_start_dt,
                             financials.yago_financial_end_dt,
                             financials.reported_sales,
                             financials.yago_reported_sales,
                             financials.reported_sales_currency,
                             financials.latest_reported_num,
                             financials.actual_financial_start_dt,
                             financials.actual_financial_end_dt,
                             financials.actual_yago_financial_start_dt,
                             financials.actual_yago_financial_end_dt,
                             financials.actual_two_yago_financial_start_dt,
                             financials.actual_two_yago_financial_end_dt

                    ORDER BY symbol, period) current_spend

              LEFT JOIN (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt

                        FROM ${symbol_financials.SQL_TABLE_NAME} financials

                        LEFT JOIN (SELECT *
                                  FROM

                                          (select
                                                p.symbol
                                                , "RECOMMENDED" as cardtype
                                                , p.trans_date
                                                , "M&A" as merger_type
                                                , "CONSTIND" as panel_type
                                                , sd.panel_method
                                                , sd.cardtype_include
                                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                                , round(p.pln_spend_amount,2) as pln_spend_amount
                                                , CASE WHEN cardtype_include = "CREDIT_DEBIT" THEN 1 WHEN cardtype = cardtype_include THEN 1 ELSE 0 END as recommended_cardtype

                                          from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                      FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on p.symbol = sb.symbol
                                          and p.brand_id = sb.brand_id
                                          and p.trans_date between sb.start_date and sb.end_date
                                          left join (SELECT distinct symbol, panel_method, cardtype_include
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                          on p.symbol = sd.symbol)

                                  WHERE recommended_cardtype = 1) current_spend

                        on financials.symbol = current_spend.symbol
                        and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                        GROUP BY financials.row,
                                 financials.symbol,
                                 current_spend.merger_type,
                                 current_spend.panel_type,
                                 current_spend.cardtype,
                                 current_spend.cardtype_include,
                                 current_spend.panel_method, financials.period, financials.yago_period, financials.financial_start_dt, financials.financial_end_dt, financials.yago_financial_start_dt, financials.yago_financial_end_dt, financials.reported_sales, financials.yago_reported_sales, financials.reported_sales_currency, financials.actual_financial_start_dt, financials.actual_financial_end_dt, financials.actual_yago_financial_start_dt, financials.actual_yago_financial_end_dt

                        ORDER BY symbol, period) yago_spend

              on current_spend.symbol = yago_spend.symbol
              and current_spend.cardtype = yago_spend.cardtype
              and current_spend.period = yago_spend.period)

#############################################################
            UNION ALL
            #############################################################

        SELECT *,

               CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

            (SELECT current_spend.row,
                    current_spend.symbol,
                    current_spend.merger_type,
                    current_spend.panel_type,
                    current_spend.cardtype,
                    current_spend.cardtype_include,
                    current_spend.panel_method,
                    current_spend.period,
                    current_spend.yago_period,
                    current_spend.financial_start_dt,
                    current_spend.financial_end_dt,
                    current_spend.yago_financial_start_dt,
                    current_spend.yago_financial_end_dt,
                    current_spend.reported_sales,
                    current_spend.yago_reported_sales,
                    current_spend.reported_growth,
                    current_spend.reported_sales_currency,
                    current_spend.gbp_spend,
                    current_spend.usd_spend,
                    current_spend.eur_spend,
                    current_spend.cad_spend,
                    current_spend.dkk_spend,
                    current_spend.nok_spend,
                    current_spend.jpy_spend,
                    current_spend.sek_spend,
                    current_spend.pln_spend,
                    yago_spend.gbp_spend as yago_gbp_spend,
                    yago_spend.usd_spend as yago_usd_spend,
                    yago_spend.eur_spend as yago_eur_spend,
                    yago_spend.cad_spend as yago_cad_spend,
                    yago_spend.dkk_spend as yago_dkk_spend,
                    yago_spend.nok_spend as yago_nok_spend,
                    yago_spend.jpy_spend as yago_jpy_spend,
                    yago_spend.sek_spend as yago_sek_spend,
                    yago_spend.pln_spend as yago_pln_spend,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                    current_spend.latest_reported_num,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                    FROM

                        (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.latest_reported_num,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt,
                                financials.actual_two_yago_financial_start_dt,
                                financials.actual_two_yago_financial_end_dt

                         FROM ${symbol_financials.SQL_TABLE_NAME} financials

                         LEFT JOIN (select
                                        p.symbol
                                        , "CREDIT + DEBIT" as cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                    from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                               FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol) current_spend

                         on financials.symbol = current_spend.symbol
                         and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                         GROUP BY financials.row,
                                  financials.symbol,
                                  current_spend.merger_type,
                                  current_spend.panel_type,
                                  current_spend.cardtype,
                                  current_spend.cardtype_include,
                                  current_spend.panel_method,
                                  financials.period,
                                  financials.yago_period,
                                  financials.financial_start_dt,
                                  financials.financial_end_dt,
                                  financials.yago_financial_start_dt,
                                  financials.yago_financial_end_dt,
                                  financials.reported_sales,
                                  financials.yago_reported_sales,
                                  financials.reported_sales_currency,
                                  financials.latest_reported_num,
                                  financials.actual_financial_start_dt,
                                  financials.actual_financial_end_dt,
                                  financials.actual_yago_financial_start_dt,
                                  financials.actual_yago_financial_end_dt,
                                  financials.actual_two_yago_financial_start_dt,
                                  financials.actual_two_yago_financial_end_dt

                         ORDER BY symbol, period) current_spend

                    LEFT JOIN (SELECT financials.row,
                                      financials.symbol,
                                      current_spend.merger_type,
                                      current_spend.panel_type,
                                      current_spend.cardtype,
                                      current_spend.cardtype_include,
                                      current_spend.panel_method,
                                      financials.period,
                                      financials.yago_period,
                                      financials.financial_start_dt,
                                      financials.financial_end_dt,
                                      financials.yago_financial_start_dt,
                                      financials.yago_financial_end_dt,
                                      financials.reported_sales,
                                      financials.yago_reported_sales,
                                      financials.reported_sales_currency,
                                      sum(current_spend.gbp_spend_amount) as gbp_spend,
                                      sum(current_spend.usd_spend_amount) as usd_spend,
                                      sum(current_spend.cad_spend_amount) as cad_spend,
                                      sum(current_spend.eur_spend_amount) as eur_spend,
                                      sum(current_spend.dkk_spend_amount) as dkk_spend,
                                      sum(current_spend.nok_spend_amount) as nok_spend,
                                      sum(current_spend.sek_spend_amount) as sek_spend,
                                      sum(current_spend.jpy_spend_amount) as jpy_spend,
                                      sum(current_spend.pln_spend_amount) as pln_spend,

                                      financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                      financials.actual_financial_start_dt,
                                      financials.actual_financial_end_dt,
                                      financials.actual_yago_financial_start_dt,
                                      financials.actual_yago_financial_end_dt

                              FROM ${symbol_financials.SQL_TABLE_NAME} financials

                              LEFT JOIN (select
                                              p.symbol
                                              , "CREDIT + DEBIT" as cardtype
                                              , p.trans_date
                                              , "M&A" as merger_type
                                              , "EMAX" as panel_type
                                              , sd.panel_method
                                              , sd.cardtype_include
                                              , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                              , round(p.usd_spend_amount,2) as usd_spend_amount
                                              , round(p.cad_spend_amount,2) as cad_spend_amount
                                              , round(p.eur_spend_amount,2) as eur_spend_amount
                                              , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                              , round(p.nok_spend_amount,2) as nok_spend_amount
                                              , round(p.sek_spend_amount,2) as sek_spend_amount
                                              , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                              , round(p.pln_spend_amount,2) as pln_spend_amount

                                         from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                         inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                     FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                         on p.symbol = sb.symbol
                                         and p.brand_id = sb.brand_id
                                         and p.trans_date between sb.start_date and sb.end_date
                                         left join (SELECT distinct symbol, panel_method, cardtype_include
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                         on p.symbol = sd.symbol) current_spend

                              on financials.symbol = current_spend.symbol
                              and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                              GROUP BY financials.row,
                                       financials.symbol,
                                       current_spend.merger_type,
                                       current_spend.panel_type,
                                       current_spend.cardtype,
                                       current_spend.cardtype_include,
                                       current_spend.panel_method,
                                       financials.period,
                                       financials.yago_period,
                                       financials.financial_start_dt,
                                       financials.financial_end_dt,
                                       financials.yago_financial_start_dt,
                                       financials.yago_financial_end_dt,
                                       financials.reported_sales,
                                       financials.yago_reported_sales,
                                       financials.reported_sales_currency,
                                       financials.actual_financial_start_dt,
                                       financials.actual_financial_end_dt,
                                       financials.actual_yago_financial_start_dt,
                                       financials.actual_yago_financial_end_dt

                              ORDER BY symbol, period) yago_spend

                    on current_spend.symbol = yago_spend.symbol
                    and current_spend.cardtype = yago_spend.cardtype
                    and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

              CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

              (SELECT current_spend.row,
                      current_spend.symbol,
                      current_spend.merger_type,
                      current_spend.panel_type,
                      current_spend.cardtype,
                      current_spend.cardtype_include,
                      current_spend.panel_method,
                      current_spend.period,
                      current_spend.yago_period,
                      current_spend.financial_start_dt,
                      current_spend.financial_end_dt,
                      current_spend.yago_financial_start_dt,
                      current_spend.yago_financial_end_dt,
                      current_spend.reported_sales,
                      current_spend.yago_reported_sales,
                      current_spend.reported_growth,
                      current_spend.reported_sales_currency,
                      current_spend.gbp_spend,
                      current_spend.usd_spend,
                      current_spend.eur_spend,
                      current_spend.cad_spend,
                      current_spend.dkk_spend,
                      current_spend.nok_spend,
                      current_spend.jpy_spend,
                      current_spend.sek_spend,
                      current_spend.pln_spend,
                      yago_spend.gbp_spend as yago_gbp_spend,
                      yago_spend.usd_spend as yago_usd_spend,
                      yago_spend.eur_spend as yago_eur_spend,
                      yago_spend.cad_spend as yago_cad_spend,
                      yago_spend.dkk_spend as yago_dkk_spend,
                      yago_spend.nok_spend as yago_nok_spend,
                      yago_spend.jpy_spend as yago_jpy_spend,
                      yago_spend.sek_spend as yago_sek_spend,
                      yago_spend.pln_spend as yago_pln_spend,
                      CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                      current_spend.latest_reported_num,

                      CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                      FROM

                          (SELECT financials.row,
                                  financials.symbol,
                                  current_spend.merger_type,
                                  current_spend.panel_type,
                                  current_spend.cardtype,
                                  current_spend.cardtype_include,
                                  current_spend.panel_method,
                                  financials.period,
                                  financials.yago_period,
                                  financials.financial_start_dt,
                                  financials.financial_end_dt,
                                  financials.yago_financial_start_dt,
                                  financials.yago_financial_end_dt,
                                  financials.reported_sales,
                                  financials.yago_reported_sales,
                                  financials.reported_sales_currency,
                                  sum(current_spend.gbp_spend_amount) as gbp_spend,
                                  sum(current_spend.usd_spend_amount) as usd_spend,
                                  sum(current_spend.cad_spend_amount) as cad_spend,
                                  sum(current_spend.eur_spend_amount) as eur_spend,
                                  sum(current_spend.dkk_spend_amount) as dkk_spend,
                                  sum(current_spend.nok_spend_amount) as nok_spend,
                                  sum(current_spend.sek_spend_amount) as sek_spend,
                                  sum(current_spend.jpy_spend_amount) as jpy_spend,
                                  sum(current_spend.pln_spend_amount) as pln_spend,

                                  financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                  financials.latest_reported_num,
                                  financials.actual_financial_start_dt,
                                  financials.actual_financial_end_dt,
                                  financials.actual_yago_financial_start_dt,
                                  financials.actual_yago_financial_end_dt,
                                  financials.actual_two_yago_financial_start_dt,
                                  financials.actual_two_yago_financial_end_dt

                          FROM ${symbol_financials.SQL_TABLE_NAME} financials

                          LEFT JOIN (select
                                          p.symbol
                                          , "CREDIT" as cardtype
                                          , p.trans_date
                                          , "M&A" as merger_type
                                          , "EMAX" as panel_type
                                          , sd.panel_method
                                          , sd.cardtype_include
                                          , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                          , round(p.usd_spend_amount,2) as usd_spend_amount
                                          , round(p.cad_spend_amount,2) as cad_spend_amount
                                          , round(p.eur_spend_amount,2) as eur_spend_amount
                                          , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                          , round(p.nok_spend_amount,2) as nok_spend_amount
                                          , round(p.sek_spend_amount,2) as sek_spend_amount
                                          , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                          , round(p.pln_spend_amount,2) as pln_spend_amount

                                    from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol

                                    WHERE cardtype = "CREDIT") current_spend

                          on financials.symbol = current_spend.symbol
                          and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                          GROUP BY financials.row,
                                   financials.symbol,
                                   current_spend.merger_type,
                                   current_spend.panel_type,
                                   current_spend.cardtype,
                                   current_spend.cardtype_include,
                                   current_spend.panel_method,
                                   financials.period,
                                   financials.yago_period,
                                   financials.financial_start_dt,
                                   financials.financial_end_dt,
                                   financials.yago_financial_start_dt,
                                   financials.yago_financial_end_dt,
                                   financials.reported_sales,
                                   financials.yago_reported_sales,
                                   financials.reported_sales_currency,
                                   financials.latest_reported_num,
                                   financials.actual_financial_start_dt,
                                   financials.actual_financial_end_dt,
                                   financials.actual_yago_financial_start_dt,
                                   financials.actual_yago_financial_end_dt,
                                   financials.actual_two_yago_financial_start_dt,
                                   financials.actual_two_yago_financial_end_dt

                          ORDER BY symbol, period) current_spend

        LEFT JOIN (SELECT financials.row,
                          financials.symbol,
                          current_spend.merger_type,
                          current_spend.panel_type,
                          current_spend.cardtype,
                          current_spend.cardtype_include,
                          current_spend.panel_method,
                          financials.period,
                          financials.yago_period,
                          financials.financial_start_dt,
                          financials.financial_end_dt,
                          financials.yago_financial_start_dt,
                          financials.yago_financial_end_dt,
                          financials.reported_sales,
                          financials.yago_reported_sales,
                          financials.reported_sales_currency,
                          sum(current_spend.gbp_spend_amount) as gbp_spend,
                          sum(current_spend.usd_spend_amount) as usd_spend,
                          sum(current_spend.cad_spend_amount) as cad_spend,
                          sum(current_spend.eur_spend_amount) as eur_spend,
                          sum(current_spend.dkk_spend_amount) as dkk_spend,
                          sum(current_spend.nok_spend_amount) as nok_spend,
                          sum(current_spend.sek_spend_amount) as sek_spend,
                          sum(current_spend.jpy_spend_amount) as jpy_spend,
                          sum(current_spend.pln_spend_amount) as pln_spend,

                          financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                          financials.actual_financial_start_dt,
                          financials.actual_financial_end_dt,
                          financials.actual_yago_financial_start_dt,
                          financials.actual_yago_financial_end_dt,
                          financials.actual_two_yago_financial_start_dt,
                          financials.actual_two_yago_financial_end_dt

                  FROM ${symbol_financials.SQL_TABLE_NAME} financials

                  LEFT JOIN (select
                                  p.symbol
                                  , "CREDIT" as cardtype
                                  , p.trans_date
                                  , "M&A" as merger_type
                                  , "EMAX" as panel_type
                                  , sd.panel_method
                                  , sd.cardtype_include
                                  , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                  , round(p.usd_spend_amount,2) as usd_spend_amount
                                  , round(p.cad_spend_amount,2) as cad_spend_amount
                                  , round(p.eur_spend_amount,2) as eur_spend_amount
                                  , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                  , round(p.nok_spend_amount,2) as nok_spend_amount
                                  , round(p.sek_spend_amount,2) as sek_spend_amount
                                  , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                  , round(p.pln_spend_amount,2) as pln_spend_amount

                              from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                              inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                          FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                              on p.symbol = sb.symbol
                              and p.brand_id = sb.brand_id
                              and p.trans_date between sb.start_date and sb.end_date
                              left join (SELECT distinct symbol, panel_method, cardtype_include
                                        FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                              on p.symbol = sd.symbol

                              WHERE cardtype = "CREDIT") current_spend

                  on financials.symbol = current_spend.symbol
                  and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                  GROUP BY financials.row,
                           financials.symbol,
                           current_spend.merger_type,
                           current_spend.panel_type,
                           current_spend.cardtype,
                           current_spend.cardtype_include,
                           current_spend.panel_method,
                           financials.period,
                           financials.yago_period,
                           financials.financial_start_dt,
                           financials.financial_end_dt,
                           financials.yago_financial_start_dt,
                           financials.yago_financial_end_dt,
                           financials.reported_sales,
                           financials.yago_reported_sales,
                           financials.reported_sales_currency,
                           financials.actual_financial_start_dt,
                           financials.actual_financial_end_dt,
                           financials.actual_yago_financial_start_dt,
                           financials.actual_yago_financial_end_dt,
                           financials.actual_two_yago_financial_start_dt,
                           financials.actual_two_yago_financial_end_dt

                  ORDER BY symbol, period) yago_spend

        on current_spend.symbol = yago_spend.symbol
        and current_spend.cardtype = yago_spend.cardtype
        and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

            (SELECT current_spend.row,
                    current_spend.symbol,
                    current_spend.merger_type,
                    current_spend.panel_type,
                    current_spend.cardtype,
                    current_spend.cardtype_include,
                    current_spend.panel_method,
                    current_spend.period,
                    current_spend.yago_period,
                    current_spend.financial_start_dt,
                    current_spend.financial_end_dt,
                    current_spend.yago_financial_start_dt,
                    current_spend.yago_financial_end_dt,
                    current_spend.reported_sales,
                    current_spend.yago_reported_sales,
                    current_spend.reported_growth,
                    current_spend.reported_sales_currency,
                    current_spend.gbp_spend,
                    current_spend.usd_spend,
                    current_spend.eur_spend,
                    current_spend.cad_spend,
                    current_spend.dkk_spend,
                    current_spend.nok_spend,
                    current_spend.jpy_spend,
                    current_spend.sek_spend,
                    current_spend.pln_spend,
                    yago_spend.gbp_spend as yago_gbp_spend,
                    yago_spend.usd_spend as yago_usd_spend,
                    yago_spend.eur_spend as yago_eur_spend,
                    yago_spend.cad_spend as yago_cad_spend,
                    yago_spend.dkk_spend as yago_dkk_spend,
                    yago_spend.nok_spend as yago_nok_spend,
                    yago_spend.jpy_spend as yago_jpy_spend,
                    yago_spend.sek_spend as yago_sek_spend,
                    yago_spend.pln_spend as yago_pln_spend,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                    END as estimated_growth,
                    current_spend.latest_reported_num,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

                    FROM

                          (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.latest_reported_num,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt,
                                financials.actual_two_yago_financial_start_dt,
                                financials.actual_two_yago_financial_end_dt

                          FROM ${symbol_financials.SQL_TABLE_NAME} financials

                          LEFT JOIN (select
                                        p.symbol
                                        , "DEBIT" as cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                  from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                  on p.symbol = sb.symbol
                                  and p.brand_id = sb.brand_id
                                  and p.trans_date between sb.start_date and sb.end_date
                                  left join (SELECT distinct symbol, panel_method, cardtype_include
                                            FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                  on p.symbol = sd.symbol

                                  WHERE cardtype = "DEBIT") current_spend

                          on financials.symbol = current_spend.symbol
                          and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                          GROUP BY financials.row,
                                 financials.symbol,
                                 current_spend.merger_type,
                                 current_spend.panel_type,
                                 current_spend.cardtype,
                                 current_spend.cardtype_include,
                                 current_spend.panel_method,
                                 financials.period,
                                 financials.yago_period,
                                 financials.financial_start_dt,
                                 financials.financial_end_dt,
                                 financials.yago_financial_start_dt,
                                 financials.yago_financial_end_dt,
                                 financials.reported_sales,
                                 financials.yago_reported_sales,
                                 financials.reported_sales_currency,
                                 financials.latest_reported_num,
                                 financials.actual_financial_start_dt,
                                 financials.actual_financial_end_dt,
                                 financials.actual_yago_financial_start_dt,
                                 financials.actual_yago_financial_end_dt,
                                 financials.actual_two_yago_financial_start_dt,
                                 financials.actual_two_yago_financial_end_dt

                          ORDER BY symbol, period) current_spend

                    LEFT JOIN (SELECT financials.row,
                                      financials.symbol,
                                      current_spend.merger_type,
                                      current_spend.panel_type,
                                      current_spend.cardtype,
                                      current_spend.cardtype_include,
                                      current_spend.panel_method,
                                      financials.period,
                                      financials.yago_period,
                                      financials.financial_start_dt,
                                      financials.financial_end_dt,
                                      financials.yago_financial_start_dt,
                                      financials.yago_financial_end_dt,
                                      financials.reported_sales,
                                      financials.yago_reported_sales,
                                      financials.reported_sales_currency,
                                      sum(current_spend.gbp_spend_amount) as gbp_spend,
                                      sum(current_spend.usd_spend_amount) as usd_spend,
                                      sum(current_spend.cad_spend_amount) as cad_spend,
                                      sum(current_spend.eur_spend_amount) as eur_spend,
                                      sum(current_spend.dkk_spend_amount) as dkk_spend,
                                      sum(current_spend.nok_spend_amount) as nok_spend,
                                      sum(current_spend.sek_spend_amount) as sek_spend,
                                      sum(current_spend.jpy_spend_amount) as jpy_spend,
                                      sum(current_spend.pln_spend_amount) as pln_spend,

                                      financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                      financials.actual_financial_start_dt,
                                      financials.actual_financial_end_dt,
                                      financials.actual_yago_financial_start_dt,
                                      financials.actual_yago_financial_end_dt

                                FROM ${symbol_financials.SQL_TABLE_NAME} financials

                                LEFT JOIN (select
                                              p.symbol
                                              , "DEBIT" as cardtype
                                              , p.trans_date
                                              , "M&A" as merger_type
                                              , "EMAX" as panel_type
                                              , sd.panel_method
                                              , sd.cardtype_include
                                              , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                              , round(p.usd_spend_amount,2) as usd_spend_amount
                                              , round(p.cad_spend_amount,2) as cad_spend_amount
                                              , round(p.eur_spend_amount,2) as eur_spend_amount
                                              , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                              , round(p.nok_spend_amount,2) as nok_spend_amount
                                              , round(p.sek_spend_amount,2) as sek_spend_amount
                                              , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                              , round(p.pln_spend_amount,2) as pln_spend_amount

                                        from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                        on p.symbol = sb.symbol
                                        and p.brand_id = sb.brand_id
                                        and p.trans_date between sb.start_date and sb.end_date
                                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                        on p.symbol = sd.symbol

                                        WHERE cardtype = "DEBIT") current_spend

                                on financials.symbol = current_spend.symbol
                                and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                                GROUP BY financials.row,
                                         financials.symbol,
                                         current_spend.merger_type,
                                         current_spend.panel_type,
                                         current_spend.cardtype,
                                         current_spend.cardtype_include,
                                         current_spend.panel_method,
                                         financials.period,
                                         financials.yago_period,
                                         financials.financial_start_dt,
                                         financials.financial_end_dt,
                                         financials.yago_financial_start_dt,
                                         financials.yago_financial_end_dt,
                                         financials.reported_sales,
                                         financials.yago_reported_sales,
                                         financials.reported_sales_currency,
                                         financials.actual_financial_start_dt,
                                         financials.actual_financial_end_dt,
                                         financials.actual_yago_financial_start_dt,
                                         financials.actual_yago_financial_end_dt

                                ORDER BY symbol, period) yago_spend

                    on current_spend.symbol = yago_spend.symbol
                    and current_spend.cardtype = yago_spend.cardtype
                    and current_spend.period = yago_spend.period)

            #############################################################
            UNION ALL
            #############################################################

        SELECT *,

              CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) ELSE null END as one_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(two_observed_gap) over(PARTITION BY symbol) ELSE null END as two_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(three_observed_gap) over(PARTITION BY symbol) ELSE null END as three_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(four_observed_gap) over(PARTITION BY symbol) ELSE null END as four_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(five_observed_gap) over(PARTITION BY symbol) ELSE null END as five_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(six_observed_gap) over(PARTITION BY symbol) ELSE null END as six_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(seven_observed_gap) over(PARTITION BY symbol) ELSE null END as seven_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(eight_observed_gap) over(PARTITION BY symbol) ELSE null END as eight_predicted_reported,
                CASE WHEN latest_reported_num = 1 THEN estimated_growth + avg(one_observed_gap) over(PARTITION BY symbol) WHEN (reported_growth is null and estimated_growth is not null and reported_sales is null and yago_reported_sales is not null) THEN estimated_growth + avg(all_observed_gap) over(PARTITION BY symbol) ELSE null END as all_predicted_reported,

        FROM

              (SELECT current_spend.row,
                      current_spend.symbol,
                      current_spend.merger_type,
                      current_spend.panel_type,
                      current_spend.cardtype,
                      current_spend.cardtype_include,
                      current_spend.panel_method,
                      current_spend.period,
                      current_spend.yago_period,
                      current_spend.financial_start_dt,
                      current_spend.financial_end_dt,
                      current_spend.yago_financial_start_dt,
                      current_spend.yago_financial_end_dt,
                      current_spend.reported_sales,
                      current_spend.yago_reported_sales,
                      current_spend.reported_growth,
                      current_spend.reported_sales_currency,
                      current_spend.gbp_spend,
                      current_spend.usd_spend,
                      current_spend.eur_spend,
                      current_spend.cad_spend,
                      current_spend.dkk_spend,
                      current_spend.nok_spend,
                      current_spend.jpy_spend,
                      current_spend.sek_spend,
                      current_spend.pln_spend,
                      yago_spend.gbp_spend as yago_gbp_spend,
                      yago_spend.usd_spend as yago_usd_spend,
                      yago_spend.eur_spend as yago_eur_spend,
                      yago_spend.cad_spend as yago_cad_spend,
                      yago_spend.dkk_spend as yago_dkk_spend,
                      yago_spend.nok_spend as yago_nok_spend,
                      yago_spend.jpy_spend as yago_jpy_spend,
                      yago_spend.sek_spend as yago_sek_spend,
                      yago_spend.pln_spend as yago_pln_spend,
                      CASE WHEN current_spend.reported_sales_currency = "GBP" THEN
                              current_spend.gbp_spend / yago_spend.gbp_spend - 1
                         WHEN current_spend.reported_sales_currency = "USD" THEN
                              current_spend.usd_spend / yago_spend.usd_spend - 1
                         WHEN current_spend.reported_sales_currency = "EUR" THEN
                              current_spend.eur_spend / yago_spend.eur_spend - 1
                         WHEN current_spend.reported_sales_currency = "CAD" THEN
                              current_spend.cad_spend / yago_spend.cad_spend - 1
                         WHEN current_spend.reported_sales_currency = "DKK" THEN
                              current_spend.dkk_spend / yago_spend.dkk_spend - 1
                         WHEN current_spend.reported_sales_currency = "NOK" THEN
                              current_spend.nok_spend / yago_spend.nok_spend - 1
                         WHEN current_spend.reported_sales_currency = "JPY" THEN
                              current_spend.jpy_spend / yago_spend.jpy_spend - 1
                         WHEN current_spend.reported_sales_currency = "SEK" THEN
                              current_spend.sek_spend / yago_spend.sek_spend - 1
                         WHEN current_spend.reported_sales_currency = "PLN" THEN
                              current_spend.pln_spend / yago_spend.pln_spend - 1
                      END as estimated_growth,
                      current_spend.latest_reported_num,

                      CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num = 1 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as one_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 2 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as two_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 3 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as three_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 4 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as four_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 5 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as five_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 6 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as six_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 7 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as seven_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 8 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as eight_observed_gap,

                    CASE WHEN current_spend.reported_sales_currency = "GBP" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" AND current_spend.latest_reported_num between 1 and 10 THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                         ELSE null
                    END as all_observed_gap,

                    CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1 ELSE 0 END as recommended_panel,
                    current_spend.actual_financial_start_dt,
                    current_spend.actual_financial_end_dt,
                    current_spend.actual_yago_financial_start_dt,
                    current_spend.actual_yago_financial_end_dt,
                    current_spend.actual_two_yago_financial_start_dt,
                    current_spend.actual_two_yago_financial_end_dt,
                    CASE WHEN current_spend.reported_sales_currency = "GBP" THEN current_spend.reported_growth - (current_spend.gbp_spend / yago_spend.gbp_spend - 1)
                         WHEN current_spend.reported_sales_currency = "USD" THEN current_spend.reported_growth - (current_spend.usd_spend / yago_spend.usd_spend - 1)
                         WHEN current_spend.reported_sales_currency = "EUR" THEN current_spend.reported_growth - (current_spend.eur_spend / yago_spend.eur_spend - 1)
                         WHEN current_spend.reported_sales_currency = "CAD" THEN current_spend.reported_growth - (current_spend.cad_spend / yago_spend.cad_spend - 1)
                         WHEN current_spend.reported_sales_currency = "DKK" THEN current_spend.reported_growth - (current_spend.dkk_spend / yago_spend.dkk_spend - 1)
                         WHEN current_spend.reported_sales_currency = "NOK" THEN current_spend.reported_growth - (current_spend.nok_spend / yago_spend.nok_spend - 1)
                         WHEN current_spend.reported_sales_currency = "JPY" THEN current_spend.reported_growth - (current_spend.jpy_spend / yago_spend.jpy_spend - 1)
                         WHEN current_spend.reported_sales_currency = "SEK" THEN current_spend.reported_growth - (current_spend.sek_spend / yago_spend.sek_spend - 1)
                         WHEN current_spend.reported_sales_currency = "PLN" THEN current_spend.reported_growth - (current_spend.pln_spend / yago_spend.pln_spend - 1)
                    END as observed_gap

              FROM

                    (SELECT financials.row,
                            financials.symbol,
                            current_spend.merger_type,
                            current_spend.panel_type,
                            current_spend.cardtype,
                            current_spend.cardtype_include,
                            current_spend.panel_method,
                            financials.period,
                            financials.yago_period,
                            financials.financial_start_dt,
                            financials.financial_end_dt,
                            financials.yago_financial_start_dt,
                            financials.yago_financial_end_dt,
                            financials.reported_sales,
                            financials.yago_reported_sales,
                            financials.reported_sales_currency,
                            sum(current_spend.gbp_spend_amount) as gbp_spend,
                            sum(current_spend.usd_spend_amount) as usd_spend,
                            sum(current_spend.cad_spend_amount) as cad_spend,
                            sum(current_spend.eur_spend_amount) as eur_spend,
                            sum(current_spend.dkk_spend_amount) as dkk_spend,
                            sum(current_spend.nok_spend_amount) as nok_spend,
                            sum(current_spend.sek_spend_amount) as sek_spend,
                            sum(current_spend.jpy_spend_amount) as jpy_spend,
                            sum(current_spend.pln_spend_amount) as pln_spend,

                            financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                            financials.latest_reported_num,
                            financials.actual_financial_start_dt,
                            financials.actual_financial_end_dt,
                            financials.actual_yago_financial_start_dt,
                            financials.actual_yago_financial_end_dt,
                            financials.actual_two_yago_financial_start_dt,
                            financials.actual_two_yago_financial_end_dt

                    FROM ${symbol_financials.SQL_TABLE_NAME} financials

                    LEFT JOIN (SELECT *
                               FROM

                                    (select p.symbol
                                            , "RECOMMENDED" as cardtype
                                            , p.trans_date
                                            , "M&A" as merger_type
                                            , "EMAX" as panel_type
                                            , sd.panel_method
                                            , sd.cardtype_include
                                            , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                            , round(p.usd_spend_amount,2) as usd_spend_amount
                                            , round(p.cad_spend_amount,2) as cad_spend_amount
                                            , round(p.eur_spend_amount,2) as eur_spend_amount
                                            , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                            , round(p.nok_spend_amount,2) as nok_spend_amount
                                            , round(p.sek_spend_amount,2) as sek_spend_amount
                                            , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                            , round(p.pln_spend_amount,2) as pln_spend_amount
                                            , CASE WHEN cardtype_include = "CREDIT_DEBIT" THEN 1 WHEN cardtype = cardtype_include THEN 1 ELSE 0 END as recommended_cardtype

                                    from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                    inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                    on p.symbol = sb.symbol
                                    and p.brand_id = sb.brand_id
                                    and p.trans_date between sb.start_date and sb.end_date
                                    left join (SELECT distinct symbol, panel_method, cardtype_include
                                               FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                    on p.symbol = sd.symbol)

                               WHERE recommended_cardtype = 1) current_spend

                    on financials.symbol = current_spend.symbol
                    and current_spend.trans_date between financials.financial_start_dt and financials.financial_end_dt

                    GROUP BY financials.row,
                             financials.symbol,
                             current_spend.merger_type,
                             current_spend.panel_type,
                             current_spend.cardtype,
                             current_spend.cardtype_include,
                             current_spend.panel_method,
                             financials.period,
                             financials.yago_period,
                             financials.financial_start_dt,
                             financials.financial_end_dt,
                             financials.yago_financial_start_dt,
                             financials.yago_financial_end_dt,
                             financials.reported_sales,
                             financials.yago_reported_sales,
                             financials.reported_sales_currency,
                             financials.latest_reported_num,
                             financials.actual_financial_start_dt,
                             financials.actual_financial_end_dt,
                             financials.actual_yago_financial_start_dt,
                             financials.actual_yago_financial_end_dt,
                             financials.actual_two_yago_financial_start_dt,
                             financials.actual_two_yago_financial_end_dt

                    ORDER BY symbol, period) current_spend

              LEFT JOIN (SELECT financials.row,
                                financials.symbol,
                                current_spend.merger_type,
                                current_spend.panel_type,
                                current_spend.cardtype,
                                current_spend.cardtype_include,
                                current_spend.panel_method,
                                financials.period,
                                financials.yago_period,
                                financials.financial_start_dt,
                                financials.financial_end_dt,
                                financials.yago_financial_start_dt,
                                financials.yago_financial_end_dt,
                                financials.reported_sales,
                                financials.yago_reported_sales,
                                financials.reported_sales_currency,
                                sum(current_spend.gbp_spend_amount) as gbp_spend,
                                sum(current_spend.usd_spend_amount) as usd_spend,
                                sum(current_spend.cad_spend_amount) as cad_spend,
                                sum(current_spend.eur_spend_amount) as eur_spend,
                                sum(current_spend.dkk_spend_amount) as dkk_spend,
                                sum(current_spend.nok_spend_amount) as nok_spend,
                                sum(current_spend.sek_spend_amount) as sek_spend,
                                sum(current_spend.jpy_spend_amount) as jpy_spend,
                                sum(current_spend.pln_spend_amount) as pln_spend,

                                financials.reported_sales / financials.yago_reported_sales - 1 as reported_growth,
                                financials.actual_financial_start_dt,
                                financials.actual_financial_end_dt,
                                financials.actual_yago_financial_start_dt,
                                financials.actual_yago_financial_end_dt

                        FROM ${symbol_financials.SQL_TABLE_NAME} financials

                        LEFT JOIN (SELECT *
                                  FROM

                                          (select
                                                p.symbol
                                                , "RECOMMENDED" as cardtype
                                                , p.trans_date
                                                , "M&A" as merger_type
                                                , "EMAX" as panel_type
                                                , sd.panel_method
                                                , sd.cardtype_include
                                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                                , round(p.pln_spend_amount,2) as pln_spend_amount
                                                , CASE WHEN cardtype_include = "CREDIT_DEBIT" THEN 1 WHEN cardtype = cardtype_include THEN 1 ELSE 0 END as recommended_cardtype

                                          from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                          inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                                      FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on p.symbol = sb.symbol
                                          and p.brand_id = sb.brand_id
                                          and p.trans_date between sb.start_date and sb.end_date
                                          left join (SELECT distinct symbol, panel_method, cardtype_include
                                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                          on p.symbol = sd.symbol)

                                  WHERE recommended_cardtype = 1) current_spend

                        on financials.symbol = current_spend.symbol
                        and current_spend.trans_date between financials.yago_financial_start_dt and financials.yago_financial_end_dt

                        GROUP BY financials.row,
                                 financials.symbol,
                                 current_spend.merger_type,
                                 current_spend.panel_type,
                                 current_spend.cardtype,
                                 current_spend.cardtype_include,
                                 current_spend.panel_method, financials.period, financials.yago_period, financials.financial_start_dt, financials.financial_end_dt, financials.yago_financial_start_dt, financials.yago_financial_end_dt, financials.reported_sales, financials.reported_sales_currency, financials.yago_reported_sales, financials.actual_financial_start_dt, financials.actual_financial_end_dt, financials.actual_yago_financial_start_dt, financials.actual_yago_financial_end_dt

                        ORDER BY symbol, period) yago_spend

              on current_spend.symbol = yago_spend.symbol
              and current_spend.cardtype = yago_spend.cardtype
              and current_spend.period = yago_spend.period)

          ORDER BY symbol, cardtype, period) finished_growth

    LEFT JOIN (SELECT symbol, period, row_number() over(PARTITION BY symbol ORDER BY period DESC) as quarter_number

               FROM

                    (SELECT distinct symbol, period
                     FROM `ce-cloud-services.ce_transact_uk_daily_signal.dist_period_sym_brand_emax` --replace with _ss table when added

                     WHERE period_type = "QTR"

                     ORDER BY symbol, period DESC)) q_nums

    on q_nums.period = finished_growth.period
    and q_nums.symbol = finished_growth.symbol


    ORDER BY row
         ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
    }

    dimension: panel_type {
      sql: ${TABLE}.panel_type ;;
    }}
