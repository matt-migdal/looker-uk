view: forecast_date_sums {
  derived_table: {
    partition_keys: ["current_period_start_dt"]
    cluster_keys: ["panel_type", "cardtype", "merger_type", "periods"]
    sql:

    SELECT current_spend.symbol,
           current_spend.period_type,
                  current_spend.period,
                  current_spend.merger_type,
                  current_spend.panel_type,
                  current_spend.cardtype,
                  current_spend.panel_method,
                  current_spend.cardtype_include,

                  CASE WHEN current_spend.cardtype_include = "CREDIT_DEBIT" THEN 1
                       WHEN current_spend.cardtype_include = current_spend.cardtype THEN 1
                       ELSE 0
                       END as recommended_cardtype,

                  CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1
                       ELSE 0
                       END as recommended_panel,

                  current_spend.day_count,
                  current_spend.reverse_day_count,
                  current_spend.periods,
                  current_spend.period_length,
                  current_spend.balance_length,
                  current_spend.current_period_start_dt,
                  current_spend.current_cum_end_dt,
                  current_spend.current_sum_include,
                  current_spend.yago_period_start_dt,
                  current_spend.yago_cum_end_dt,
                  current_spend.yago_sum_include,
                  current_spend.two_yago_period_start_dt,
                  current_spend.two_yago_cum_end_dt,
                  current_spend.two_yago_sum_include,
                  current_spend.balance_yago_cum_start_dt,
                  current_spend.balance_yago_period_end_dt,
                  current_spend.balance_yago_sum_include,
                  current_spend.balance_two_yago_cum_start_dt,
                  current_spend.balance_two_yago_period_end_dt,
                  current_spend.balance_two_yago_sum_include,
                  #current_spend_amount,
                  current_gbp_spend_amount,
                  current_cad_spend_amount,
                  current_usd_spend_amount,
                  current_eur_spend_amount,
                  current_dkk_spend_amount,
                  current_nok_spend_amount,
                  current_jpy_spend_amount,
                  current_sek_spend_amount,
                  current_pln_spend_amount,
                  #yago_spend_amount,
                  yago_gbp_spend_amount,
                  yago_cad_spend_amount,
                  yago_usd_spend_amount,
                  yago_eur_spend_amount,
                  yago_dkk_spend_amount,
                  yago_nok_spend_amount,
                  yago_jpy_spend_amount,
                  yago_sek_spend_amount,
                  yago_pln_spend_amount,
                  #two_yago_spend_amount,
                  two_yago_gbp_spend_amount,
                  two_yago_cad_spend_amount,
                  two_yago_usd_spend_amount,
                  two_yago_eur_spend_amount,
                  two_yago_dkk_spend_amount,
                  two_yago_nok_spend_amount,
                  two_yago_jpy_spend_amount,
                  two_yago_sek_spend_amount,
                  two_yago_pln_spend_amount,
                  #balance_yago_spend_amount,
                  balance_yago_gbp_spend_amount,
                  balance_yago_cad_spend_amount,
                  balance_yago_usd_spend_amount,
                  balance_yago_eur_spend_amount,
                  balance_yago_dkk_spend_amount,
                  balance_yago_nok_spend_amount,
                  balance_yago_jpy_spend_amount,
                  balance_yago_sek_spend_amount,
                  balance_yago_pln_spend_amount,
                  #balance_two_yago_spend_amount,
                  balance_two_yago_gbp_spend_amount,
                  balance_two_yago_cad_spend_amount,
                  balance_two_yago_usd_spend_amount,
                  balance_two_yago_eur_spend_amount,
                  balance_two_yago_dkk_spend_amount,
                  balance_two_yago_nok_spend_amount,
                  balance_two_yago_jpy_spend_amount,
                  balance_two_yago_sek_spend_amount,
                  balance_two_yago_pln_spend_amount,

                  current_gbp_spend_amount / nullif(yago_gbp_spend_amount, 0) as current_yoy_gbp,
                  yago_gbp_spend_amount / nullif(two_yago_gbp_spend_amount, 0) as yago_yoy_gbp,
                  balance_yago_gbp_spend_amount / nullif(balance_two_yago_gbp_spend_amount, 0) as balance_yoy_gbp

            FROM


                (SELECT all_date_ranges.*,
                        spend.cardtype,
                        #sum(spend_amount) as current_spend_amount,
                        sum(gbp_spend_amount) as current_gbp_spend_amount,
                        sum(cad_spend_amount) as current_cad_spend_amount,
                        sum(usd_spend_amount) as current_usd_spend_amount,
                        sum(eur_spend_amount) as current_eur_spend_amount,
                        sum(dkk_spend_amount) as current_dkk_spend_amount,
                        sum(nok_spend_amount) as current_nok_spend_amount,
                        sum(jpy_spend_amount) as current_jpy_spend_amount,
                        sum(sek_spend_amount) as current_sek_spend_amount,
                        sum(pln_spend_amount) as current_pln_spend_amount,
                        merger_type,
                        panel_type,
                        spend.panel_method,
                        spend.cardtype_include
                 FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

                 LEFT JOIN (select
                                  p.symbol
                                  , p.cardtype
                                  , p.trans_date
                                  , "M&A" as merger_type
                                  , "EMAX" as panel_type
                                  , sd.panel_method
                                  , sd.cardtype_include
                                  , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                  , round(p.cad_spend_amount,2) as cad_spend_amount
                                  , round(p.usd_spend_amount,2) as usd_spend_amount
                                  , round(p.eur_spend_amount,2) as eur_spend_amount
                                  , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                  , round(p.nok_spend_amount,2) as nok_spend_amount
                                  , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                  , round(p.sek_spend_amount,2) as sek_spend_amount
                                  , round(p.pln_spend_amount,2) as pln_spend_amount

                            from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                            inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                        FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                            on p.symbol = sb.symbol
                            and p.brand_id = sb.brand_id
                            and p.trans_date between sb.start_date and sb.end_date
                            left join (SELECT distinct symbol, panel_method, cardtype_include
                                       FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                            on p.symbol = sd.symbol) spend

                 on spend.symbol = all_date_ranges.symbol
                 and trans_date between current_period_start_dt and current_cum_end_dt

                 GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                 ORDER BY symbol, day_count) current_spend

            LEFT JOIN (SELECT all_date_ranges.*,
                              spend.cardtype,
                              #sum(spend_amount) as yago_spend_amount,
                              sum(gbp_spend_amount) as yago_gbp_spend_amount,
                              sum(cad_spend_amount) as yago_cad_spend_amount,
                              sum(usd_spend_amount) as yago_usd_spend_amount,
                              sum(eur_spend_amount) as yago_eur_spend_amount,
                              sum(dkk_spend_amount) as yago_dkk_spend_amount,
                              sum(nok_spend_amount) as yago_nok_spend_amount,
                              sum(jpy_spend_amount) as yago_jpy_spend_amount,
                              sum(sek_spend_amount) as yago_sek_spend_amount,
                              sum(pln_spend_amount) as yago_pln_spend_amount,
                              merger_type,
                              panel_type,
                              spend.panel_method,
                              spend.cardtype_include
                       FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

                       LEFT JOIN (select
                                        p.symbol
                                        , p.cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                  from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                  on p.symbol = sb.symbol
                                  and p.brand_id = sb.brand_id
                                  and p.trans_date between sb.start_date and sb.end_date
                                  left join (SELECT distinct symbol, panel_method, cardtype_include
                                             FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                  on p.symbol = sd.symbol) spend

                        on spend.symbol = all_date_ranges.symbol
                        and trans_date between yago_period_start_dt and yago_cum_end_dt

                        GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                        ORDER BY symbol, day_count) yago_spend

            on current_spend.symbol = yago_spend.symbol
            and current_spend.cardtype = yago_spend.cardtype
            and current_spend.day_count = yago_spend.day_count
            and current_spend.periods = yago_spend.periods

            LEFT JOIN (SELECT all_date_ranges.*,
                              spend.cardtype,
                              #sum(spend_amount) as two_yago_spend_amount,
                              sum(gbp_spend_amount) as two_yago_gbp_spend_amount,
                              sum(cad_spend_amount) as two_yago_cad_spend_amount,
                              sum(usd_spend_amount) as two_yago_usd_spend_amount,
                              sum(eur_spend_amount) as two_yago_eur_spend_amount,
                              sum(dkk_spend_amount) as two_yago_dkk_spend_amount,
                              sum(nok_spend_amount) as two_yago_nok_spend_amount,
                              sum(jpy_spend_amount) as two_yago_jpy_spend_amount,
                              sum(sek_spend_amount) as two_yago_sek_spend_amount,
                              sum(pln_spend_amount) as two_yago_pln_spend_amount,
                              merger_type,
                              panel_type,
                              spend.panel_method,
                              spend.cardtype_include
                       FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

                       LEFT JOIN (select
                                        p.symbol
                                        , p.cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                  from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                  on p.symbol = sb.symbol
                                  and p.brand_id = sb.brand_id
                                  and p.trans_date between sb.start_date and sb.end_date
                                  left join (SELECT distinct symbol, panel_method, cardtype_include
                                             FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                  on p.symbol = sd.symbol) spend

                        on spend.symbol = all_date_ranges.symbol
                        and trans_date between two_yago_period_start_dt and two_yago_cum_end_dt

                        GROUP BY symbol,
                                 period_type,
                                 period,
                                 day_count,
                                 reverse_day_count,
                                 periods,
                                 period_length,
                                 balance_length,
                                 current_period_start_dt,
                                 current_cum_end_dt,
                                 current_sum_include,
                                 yago_period_start_dt,
                                 yago_cum_end_dt,
                                 yago_sum_include,
                                 two_yago_period_start_dt,
                                 two_yago_cum_end_dt,
                                 two_yago_sum_include,
                                 balance_yago_cum_start_dt,
                                 balance_yago_period_end_dt,
                                 balance_yago_sum_include,
                                 balance_two_yago_cum_start_dt,
                                 balance_two_yago_period_end_dt,
                                 balance_two_yago_sum_include,
                                 merger_type,
                                 panel_type,
                                 spend.cardtype,
                                 spend.panel_method,
                                 spend.cardtype_include
                        ORDER BY symbol, day_count) two_yago_spend

            on current_spend.symbol = two_yago_spend.symbol
            and current_spend.cardtype = two_yago_spend.cardtype
            and current_spend.day_count = two_yago_spend.day_count
            and current_spend.periods = two_yago_spend.periods

            LEFT JOIN (SELECT all_date_ranges.*,
                              spend.cardtype,
                              #sum(spend_amount) as balance_yago_spend_amount,
                              sum(gbp_spend_amount) as balance_yago_gbp_spend_amount,
                              sum(cad_spend_amount) as balance_yago_cad_spend_amount,
                              sum(usd_spend_amount) as balance_yago_usd_spend_amount,
                              sum(eur_spend_amount) as balance_yago_eur_spend_amount,
                              sum(dkk_spend_amount) as balance_yago_dkk_spend_amount,
                              sum(nok_spend_amount) as balance_yago_nok_spend_amount,
                              sum(jpy_spend_amount) as balance_yago_jpy_spend_amount,
                              sum(sek_spend_amount) as balance_yago_sek_spend_amount,
                              sum(pln_spend_amount) as balance_yago_pln_spend_amount,
                              merger_type,
                              panel_type,
                              spend.panel_method,
                              spend.cardtype_include
                       FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

                       LEFT JOIN (select
                                        p.symbol
                                        , p.cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                  from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                  on p.symbol = sb.symbol
                                  and p.brand_id = sb.brand_id
                                  and p.trans_date between sb.start_date and sb.end_date
                                  left join (SELECT distinct symbol, panel_method, cardtype_include
                                             FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                  on p.symbol = sd.symbol) spend

                        on spend.symbol = all_date_ranges.symbol
                        and trans_date between balance_yago_cum_start_dt and  balance_yago_period_end_dt

                        GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                        ORDER BY symbol, day_count) balance_yago_spend

            on current_spend.symbol = balance_yago_spend.symbol
            and current_spend.cardtype = balance_yago_spend.cardtype
            and current_spend.day_count = balance_yago_spend.day_count
            and current_spend.periods = balance_yago_spend.periods

            LEFT JOIN (SELECT all_date_ranges.*,
                              spend.cardtype,
                              #sum(spend_amount) as balance_two_yago_spend_amount,
                              sum(gbp_spend_amount) as balance_two_yago_gbp_spend_amount,
                              sum(cad_spend_amount) as balance_two_yago_cad_spend_amount,
                              sum(usd_spend_amount) as balance_two_yago_usd_spend_amount,
                              sum(eur_spend_amount) as balance_two_yago_eur_spend_amount,
                              sum(dkk_spend_amount) as balance_two_yago_dkk_spend_amount,
                              sum(nok_spend_amount) as balance_two_yago_nok_spend_amount,
                              sum(jpy_spend_amount) as balance_two_yago_jpy_spend_amount,
                              sum(sek_spend_amount) as balance_two_yago_sek_spend_amount,
                              sum(pln_spend_amount) as balance_two_yago_pln_spend_amount,
                              merger_type,
                              panel_type,
                              spend.panel_method,
                              spend.cardtype_include
                      FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

                      LEFT JOIN (select
                                        p.symbol
                                        , p.cardtype
                                        , p.trans_date
                                        , "M&A" as merger_type
                                        , "EMAX" as panel_type
                                        , sd.panel_method
                                        , sd.cardtype_include
                                        , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                        , round(p.cad_spend_amount,2) as cad_spend_amount
                                        , round(p.usd_spend_amount,2) as usd_spend_amount
                                        , round(p.eur_spend_amount,2) as eur_spend_amount
                                        , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                        , round(p.nok_spend_amount,2) as nok_spend_amount
                                        , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                        , round(p.sek_spend_amount,2) as sek_spend_amount
                                        , round(p.pln_spend_amount,2) as pln_spend_amount

                                from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                                inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                            FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                on p.symbol = sb.symbol
                                and p.brand_id = sb.brand_id
                                and p.trans_date between sb.start_date and sb.end_date
                                left join (SELECT distinct symbol, panel_method, cardtype_include
                                           FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                on p.symbol = sd.symbol) spend

                      on spend.symbol = all_date_ranges.symbol
                      and trans_date between balance_two_yago_cum_start_dt and  balance_two_yago_period_end_dt

                      GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                      ORDER BY symbol, day_count) balance_two_yago_spend

            on current_spend.symbol = balance_two_yago_spend.symbol
            and current_spend.cardtype = balance_two_yago_spend.cardtype
            and current_spend.day_count = balance_two_yago_spend.day_count
            and current_spend.periods = balance_two_yago_spend.periods

    ####################################################
    UNION ALL
    ####################################################

    SELECT current_spend.symbol,
           current_spend.period_type,
           current_spend.period,
           current_spend.merger_type,
           current_spend.panel_type,
           current_spend.cardtype,
           current_spend.panel_method,
           current_spend.cardtype_include,

           CASE WHEN current_spend.cardtype_include = "CREDIT_DEBIT" THEN 1
                WHEN current_spend.cardtype_include = current_spend.cardtype THEN 1
                ELSE 0
                END as recommended_cardtype,

           CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1
                ELSE 0
                END as recommended_panel,

           current_spend.day_count,
           current_spend.reverse_day_count,
           current_spend.periods,
           current_spend.period_length,
           current_spend.balance_length,
           current_spend.current_period_start_dt,
           current_spend.current_cum_end_dt,
           current_spend.current_sum_include,
           current_spend.yago_period_start_dt,
           current_spend.yago_cum_end_dt,
           current_spend.yago_sum_include,
           current_spend.two_yago_period_start_dt,
           current_spend.two_yago_cum_end_dt,
           current_spend.two_yago_sum_include,
           current_spend.balance_yago_cum_start_dt,
           current_spend.balance_yago_period_end_dt,
           current_spend.balance_yago_sum_include,
           current_spend.balance_two_yago_cum_start_dt,
           current_spend.balance_two_yago_period_end_dt,
           current_spend.balance_two_yago_sum_include,
           #current_spend_amount,
           current_gbp_spend_amount,
           current_cad_spend_amount,
           current_usd_spend_amount,
           current_eur_spend_amount,
           current_dkk_spend_amount,
           current_nok_spend_amount,
           current_jpy_spend_amount,
           current_sek_spend_amount,
           current_pln_spend_amount,
           #yago_spend_amount,
           yago_gbp_spend_amount,
           yago_cad_spend_amount,
           yago_usd_spend_amount,
           yago_eur_spend_amount,
           yago_dkk_spend_amount,
           yago_nok_spend_amount,
           yago_jpy_spend_amount,
           yago_sek_spend_amount,
           yago_pln_spend_amount,
           #two_yago_spend_amount,
           two_yago_gbp_spend_amount,
           two_yago_cad_spend_amount,
           two_yago_usd_spend_amount,
           two_yago_eur_spend_amount,
           two_yago_dkk_spend_amount,
           two_yago_nok_spend_amount,
           two_yago_jpy_spend_amount,
           two_yago_sek_spend_amount,
           two_yago_pln_spend_amount,
           #balance_yago_spend_amount,
           balance_yago_gbp_spend_amount,
           balance_yago_cad_spend_amount,
           balance_yago_usd_spend_amount,
           balance_yago_eur_spend_amount,
           balance_yago_dkk_spend_amount,
           balance_yago_nok_spend_amount,
           balance_yago_jpy_spend_amount,
           balance_yago_sek_spend_amount,
           balance_yago_pln_spend_amount,
           #balance_two_yago_spend_amount,
           balance_two_yago_gbp_spend_amount,
           balance_two_yago_cad_spend_amount,
           balance_two_yago_usd_spend_amount,
           balance_two_yago_eur_spend_amount,
           balance_two_yago_dkk_spend_amount,
           balance_two_yago_nok_spend_amount,
           balance_two_yago_jpy_spend_amount,
           balance_two_yago_sek_spend_amount,
           balance_two_yago_pln_spend_amount,

           current_gbp_spend_amount / nullif(yago_gbp_spend_amount, 0) as current_yoy_gbp,
           yago_gbp_spend_amount / nullif(two_yago_gbp_spend_amount, 0) as yago_yoy_gbp,
           balance_yago_gbp_spend_amount / nullif(balance_two_yago_gbp_spend_amount, 0) as balance_yoy_gbp

    FROM


        (SELECT all_date_ranges.*,
                spend.cardtype,
                #sum(spend_amount) as current_spend_amount,
                sum(gbp_spend_amount) as current_gbp_spend_amount,
                sum(cad_spend_amount) as current_cad_spend_amount,
                sum(usd_spend_amount) as current_usd_spend_amount,
                sum(eur_spend_amount) as current_eur_spend_amount,
                sum(dkk_spend_amount) as current_dkk_spend_amount,
                sum(nok_spend_amount) as current_nok_spend_amount,
                sum(jpy_spend_amount) as current_jpy_spend_amount,
                sum(sek_spend_amount) as current_sek_spend_amount,
                sum(pln_spend_amount) as current_pln_spend_amount,
                merger_type,
                panel_type,
                spend.panel_method,
                spend.cardtype_include
        FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

        LEFT JOIN (select
                          p.symbol
                          , p.cardtype
                          , p.trans_date
                          , "M&A" as merger_type
                          , "CONSTIND" as panel_type
                          , sd.panel_method
                          , sd.cardtype_include
                          , round(p.gbp_spend_amount,2) as gbp_spend_amount
                          , round(p.cad_spend_amount,2) as cad_spend_amount
                          , round(p.usd_spend_amount,2) as usd_spend_amount
                          , round(p.eur_spend_amount,2) as eur_spend_amount
                          , round(p.dkk_spend_amount,2) as dkk_spend_amount
                          , round(p.nok_spend_amount,2) as nok_spend_amount
                          , round(p.jpy_spend_amount,2) as jpy_spend_amount
                          , round(p.sek_spend_amount,2) as sek_spend_amount
                          , round(p.pln_spend_amount,2) as pln_spend_amount

                  from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                  inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                  on p.symbol = sb.symbol
                  and p.brand_id = sb.brand_id
                  and p.trans_date between sb.start_date and sb.end_date
                  left join (SELECT distinct symbol, panel_method, cardtype_include
                             FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                  on p.symbol = sd.symbol) spend

        on spend.symbol = all_date_ranges.symbol
        and trans_date between current_period_start_dt and current_cum_end_dt

        GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
        ORDER BY symbol, day_count) current_spend

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as yago_spend_amount,
                      sum(gbp_spend_amount) as yago_gbp_spend_amount,
                      sum(cad_spend_amount) as yago_cad_spend_amount,
                      sum(usd_spend_amount) as yago_usd_spend_amount,
                      sum(eur_spend_amount) as yago_eur_spend_amount,
                      sum(dkk_spend_amount) as yago_dkk_spend_amount,
                      sum(nok_spend_amount) as yago_nok_spend_amount,
                      sum(jpy_spend_amount) as yago_jpy_spend_amount,
                      sum(sek_spend_amount) as yago_sek_spend_amount,
                      sum(pln_spend_amount) as yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
               FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

               LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "M&A" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                          from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                          inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                      FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                          on p.symbol = sb.symbol
                          and p.brand_id = sb.brand_id
                          and p.trans_date between sb.start_date and sb.end_date
                          left join (SELECT distinct symbol, panel_method, cardtype_include
                                     FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                          on p.symbol = sd.symbol) spend

                 on spend.symbol = all_date_ranges.symbol
                 and trans_date between yago_period_start_dt and yago_cum_end_dt

                 GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                 ORDER BY symbol, day_count) yago_spend

    on current_spend.symbol = yago_spend.symbol
    and current_spend.cardtype = yago_spend.cardtype
    and current_spend.day_count = yago_spend.day_count
    and current_spend.periods = yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as two_yago_spend_amount,
                      sum(gbp_spend_amount) as two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "M&A" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        and p.trans_date between sb.start_date and sb.end_date
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between two_yago_period_start_dt and two_yago_cum_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) two_yago_spend

    on current_spend.symbol = two_yago_spend.symbol
    and current_spend.cardtype = two_yago_spend.cardtype
    and current_spend.day_count = two_yago_spend.day_count
    and current_spend.periods = two_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as balance_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                              p.symbol
                              , p.cardtype
                              , p.trans_date
                              , "M&A" as merger_type
                              , "CONSTIND" as panel_type
                              , sd.panel_method
                              , sd.cardtype_include
                              , round(p.gbp_spend_amount,2) as gbp_spend_amount
                              , round(p.cad_spend_amount,2) as cad_spend_amount
                              , round(p.usd_spend_amount,2) as usd_spend_amount
                              , round(p.eur_spend_amount,2) as eur_spend_amount
                              , round(p.dkk_spend_amount,2) as dkk_spend_amount
                              , round(p.nok_spend_amount,2) as nok_spend_amount
                              , round(p.jpy_spend_amount,2) as jpy_spend_amount
                              , round(p.sek_spend_amount,2) as sek_spend_amount
                              , round(p.pln_spend_amount,2) as pln_spend_amount

                          from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                          inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                      FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                          on p.symbol = sb.symbol
                          and p.brand_id = sb.brand_id
                          and p.trans_date between sb.start_date and sb.end_date
                          left join (SELECT distinct symbol, panel_method, cardtype_include
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                          on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_yago_cum_start_dt and  balance_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_yago_spend

    on current_spend.symbol = balance_yago_spend.symbol
    and current_spend.cardtype = balance_yago_spend.cardtype
    and current_spend.day_count = balance_yago_spend.day_count
    and current_spend.periods = balance_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as balance_two_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "M&A" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        and p.trans_date between sb.start_date and sb.end_date
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_two_yago_cum_start_dt and  balance_two_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_two_yago_spend

    on current_spend.symbol = balance_two_yago_spend.symbol
    and current_spend.cardtype = balance_two_yago_spend.cardtype
    and current_spend.day_count = balance_two_yago_spend.day_count
    and current_spend.periods = balance_two_yago_spend.periods

    ####################################################
    UNION ALL
    ####################################################

    SELECT current_spend.symbol,
           current_spend.period_type,
           current_spend.period,
           current_spend.merger_type,
           current_spend.panel_type,
           current_spend.cardtype,
           current_spend.panel_method,
           current_spend.cardtype_include,

           CASE WHEN current_spend.cardtype_include = "CREDIT_DEBIT" THEN 1
                WHEN current_spend.cardtype_include = current_spend.cardtype THEN 1
                ELSE 0
                END as recommended_cardtype,

           CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1
                ELSE 0
                END as recommended_panel,

           current_spend.day_count,
           current_spend.reverse_day_count,
           current_spend.periods,
           current_spend.period_length,
           current_spend.balance_length,
           current_spend.current_period_start_dt,
           current_spend.current_cum_end_dt,
           current_spend.current_sum_include,
           current_spend.yago_period_start_dt,
           current_spend.yago_cum_end_dt,
           current_spend.yago_sum_include,
           current_spend.two_yago_period_start_dt,
           current_spend.two_yago_cum_end_dt,
           current_spend.two_yago_sum_include,
           current_spend.balance_yago_cum_start_dt,
           current_spend.balance_yago_period_end_dt,
           current_spend.balance_yago_sum_include,
           current_spend.balance_two_yago_cum_start_dt,
           current_spend.balance_two_yago_period_end_dt,
           current_spend.balance_two_yago_sum_include,
           #current_spend_amount,
           current_gbp_spend_amount,
           current_cad_spend_amount,
           current_usd_spend_amount,
           current_eur_spend_amount,
           current_dkk_spend_amount,
           current_nok_spend_amount,
           current_jpy_spend_amount,
           current_sek_spend_amount,
           current_pln_spend_amount,
           #yago_spend_amount,
           yago_gbp_spend_amount,
           yago_cad_spend_amount,
           yago_usd_spend_amount,
           yago_eur_spend_amount,
           yago_dkk_spend_amount,
           yago_nok_spend_amount,
           yago_jpy_spend_amount,
           yago_sek_spend_amount,
           yago_pln_spend_amount,
           #two_yago_spend_amount,
           two_yago_gbp_spend_amount,
           two_yago_cad_spend_amount,
           two_yago_usd_spend_amount,
           two_yago_eur_spend_amount,
           two_yago_dkk_spend_amount,
           two_yago_nok_spend_amount,
           two_yago_jpy_spend_amount,
           two_yago_sek_spend_amount,
           two_yago_pln_spend_amount,
           #balance_yago_spend_amount,
           balance_yago_gbp_spend_amount,
           balance_yago_cad_spend_amount,
           balance_yago_usd_spend_amount,
           balance_yago_eur_spend_amount,
           balance_yago_dkk_spend_amount,
           balance_yago_nok_spend_amount,
           balance_yago_jpy_spend_amount,
           balance_yago_sek_spend_amount,
           balance_yago_pln_spend_amount,
           #balance_two_yago_spend_amount,
           balance_two_yago_gbp_spend_amount,
           balance_two_yago_cad_spend_amount,
           balance_two_yago_usd_spend_amount,
           balance_two_yago_eur_spend_amount,
           balance_two_yago_dkk_spend_amount,
           balance_two_yago_nok_spend_amount,
           balance_two_yago_jpy_spend_amount,
           balance_two_yago_sek_spend_amount,
           balance_two_yago_pln_spend_amount,

           current_gbp_spend_amount / nullif(yago_gbp_spend_amount, 0) as current_yoy_gbp,
           yago_gbp_spend_amount / nullif(two_yago_gbp_spend_amount, 0) as yago_yoy_gbp,
           balance_yago_gbp_spend_amount / nullif(balance_two_yago_gbp_spend_amount, 0) as balance_yoy_gbp

    FROM


        (SELECT all_date_ranges.*,
                spend.cardtype,
                #sum(spend_amount) as current_spend_amount,
                sum(gbp_spend_amount) as current_gbp_spend_amount,
                sum(cad_spend_amount) as current_cad_spend_amount,
                sum(usd_spend_amount) as current_usd_spend_amount,
                sum(eur_spend_amount) as current_eur_spend_amount,
                sum(dkk_spend_amount) as current_dkk_spend_amount,
                sum(nok_spend_amount) as current_nok_spend_amount,
                sum(jpy_spend_amount) as current_jpy_spend_amount,
                sum(sek_spend_amount) as current_sek_spend_amount,
                sum(pln_spend_amount) as current_pln_spend_amount,
                merger_type,
                panel_type,
                spend.panel_method,
                spend.cardtype_include
        FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

        LEFT JOIN (select
                          p.symbol
                          , p.cardtype
                          , p.trans_date
                          , "Pro Forma" as merger_type
                          , "EMAX" as panel_type
                          , sd.panel_method
                          , sd.cardtype_include
                          , round(p.gbp_spend_amount,2) as gbp_spend_amount
                          , round(p.cad_spend_amount,2) as cad_spend_amount
                          , round(p.usd_spend_amount,2) as usd_spend_amount
                          , round(p.eur_spend_amount,2) as eur_spend_amount
                          , round(p.dkk_spend_amount,2) as dkk_spend_amount
                          , round(p.nok_spend_amount,2) as nok_spend_amount
                          , round(p.jpy_spend_amount,2) as jpy_spend_amount
                          , round(p.sek_spend_amount,2) as sek_spend_amount
                          , round(p.pln_spend_amount,2) as pln_spend_amount

                  from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                  inner join (SELECT distinct symbol,
                                              brand_name,
                                              brand_id,
                                              start_date,
                                              end_date
                              FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                  on p.symbol = sb.symbol
                  and p.brand_id = sb.brand_id
                  left join (SELECT distinct symbol,
                                             panel_method,
                                             cardtype_include
                             FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                  on p.symbol = sd.symbol) spend

        on spend.symbol = all_date_ranges.symbol
        and trans_date between current_period_start_dt and current_cum_end_dt

        GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
        ORDER BY symbol, day_count) current_spend

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as yago_spend_amount,
                      sum(gbp_spend_amount) as yago_gbp_spend_amount,
                      sum(cad_spend_amount) as yago_cad_spend_amount,
                      sum(usd_spend_amount) as yago_usd_spend_amount,
                      sum(eur_spend_amount) as yago_eur_spend_amount,
                      sum(dkk_spend_amount) as yago_dkk_spend_amount,
                      sum(nok_spend_amount) as yago_nok_spend_amount,
                      sum(jpy_spend_amount) as yago_jpy_spend_amount,
                      sum(sek_spend_amount) as yago_sek_spend_amount,
                      sum(pln_spend_amount) as yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
               FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

               LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "EMAX" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                          from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                          inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                      FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                          on p.symbol = sb.symbol
                          and p.brand_id = sb.brand_id
                          left join (SELECT distinct symbol, panel_method, cardtype_include
                                     FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                          on p.symbol = sd.symbol) spend

                 on spend.symbol = all_date_ranges.symbol
                 and trans_date between yago_period_start_dt and yago_cum_end_dt

                 GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                 ORDER BY symbol, day_count) yago_spend

    on current_spend.symbol = yago_spend.symbol
    and current_spend.cardtype = yago_spend.cardtype
    and current_spend.day_count = yago_spend.day_count
    and current_spend.periods = yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as two_yago_spend_amount,
                      sum(gbp_spend_amount) as two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "EMAX" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between two_yago_period_start_dt and two_yago_cum_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) two_yago_spend

    on current_spend.symbol = two_yago_spend.symbol
    and current_spend.cardtype = two_yago_spend.cardtype
    and current_spend.day_count = two_yago_spend.day_count
    and current_spend.periods = two_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as balance_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "EMAX" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_yago_cum_start_dt and  balance_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_yago_spend

    on current_spend.symbol = balance_yago_spend.symbol
    and current_spend.cardtype = balance_yago_spend.cardtype
    and current_spend.day_count = balance_yago_spend.day_count
    and current_spend.periods = balance_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as balance_two_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "EMAX" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_emax_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_two_yago_cum_start_dt and  balance_two_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_two_yago_spend

    on current_spend.symbol = balance_two_yago_spend.symbol
    and current_spend.cardtype = balance_two_yago_spend.cardtype
    and current_spend.day_count = balance_two_yago_spend.day_count
    and current_spend.periods = balance_two_yago_spend.periods

    ####################################################
    UNION ALL
    ####################################################

    SELECT current_spend.symbol,
           current_spend.period_type,
           current_spend.period,
           current_spend.merger_type,
           current_spend.panel_type,
           current_spend.cardtype,
           current_spend.panel_method,
           current_spend.cardtype_include,

           CASE WHEN current_spend.cardtype_include = "CREDIT_DEBIT" THEN 1
                WHEN current_spend.cardtype_include = current_spend.cardtype THEN 1
                ELSE 0
                END as recommended_cardtype,

           CASE WHEN current_spend.panel_type = current_spend.panel_method THEN 1
                ELSE 0
                END as recommended_panel,

           current_spend.day_count,
           current_spend.reverse_day_count,
           current_spend.periods,
           current_spend.period_length,
           current_spend.balance_length,
           current_spend.current_period_start_dt,
           current_spend.current_cum_end_dt,
           current_spend.current_sum_include,
           current_spend.yago_period_start_dt,
           current_spend.yago_cum_end_dt,
           current_spend.yago_sum_include,
           current_spend.two_yago_period_start_dt,
           current_spend.two_yago_cum_end_dt,
           current_spend.two_yago_sum_include,
           current_spend.balance_yago_cum_start_dt,
           current_spend.balance_yago_period_end_dt,
           current_spend.balance_yago_sum_include,
           current_spend.balance_two_yago_cum_start_dt,
           current_spend.balance_two_yago_period_end_dt,
           current_spend.balance_two_yago_sum_include,
           #current_spend_amount,
           current_gbp_spend_amount,
           current_cad_spend_amount,
           current_usd_spend_amount,
           current_eur_spend_amount,
           current_dkk_spend_amount,
           current_nok_spend_amount,
           current_jpy_spend_amount,
           current_sek_spend_amount,
           current_pln_spend_amount,
           #yago_spend_amount,
           yago_gbp_spend_amount,
           yago_cad_spend_amount,
           yago_usd_spend_amount,
           yago_eur_spend_amount,
           yago_dkk_spend_amount,
           yago_nok_spend_amount,
           yago_jpy_spend_amount,
           yago_sek_spend_amount,
           yago_pln_spend_amount,
           #two_yago_spend_amount,
           two_yago_gbp_spend_amount,
           two_yago_cad_spend_amount,
           two_yago_usd_spend_amount,
           two_yago_eur_spend_amount,
           two_yago_dkk_spend_amount,
           two_yago_nok_spend_amount,
           two_yago_jpy_spend_amount,
           two_yago_sek_spend_amount,
           two_yago_pln_spend_amount,
           #balance_yago_spend_amount,
           balance_yago_gbp_spend_amount,
           balance_yago_cad_spend_amount,
           balance_yago_usd_spend_amount,
           balance_yago_eur_spend_amount,
           balance_yago_dkk_spend_amount,
           balance_yago_nok_spend_amount,
           balance_yago_jpy_spend_amount,
           balance_yago_sek_spend_amount,
           balance_yago_pln_spend_amount,
           #balance_two_yago_spend_amount,
           balance_two_yago_gbp_spend_amount,
           balance_two_yago_cad_spend_amount,
           balance_two_yago_usd_spend_amount,
           balance_two_yago_eur_spend_amount,
           balance_two_yago_dkk_spend_amount,
           balance_two_yago_nok_spend_amount,
           balance_two_yago_jpy_spend_amount,
           balance_two_yago_sek_spend_amount,
           balance_two_yago_pln_spend_amount,

           current_gbp_spend_amount / nullif(yago_gbp_spend_amount, 0) as current_yoy_gbp,
           yago_gbp_spend_amount / nullif(two_yago_gbp_spend_amount, 0) as yago_yoy_gbp,
           balance_yago_gbp_spend_amount / nullif(balance_two_yago_gbp_spend_amount, 0) as balance_yoy_gbp

    FROM


          (SELECT all_date_ranges.*,
                  spend.cardtype,
                  #sum(spend_amount) as current_spend_amount,
                  sum(gbp_spend_amount) as current_gbp_spend_amount,
                  sum(cad_spend_amount) as current_cad_spend_amount,
                  sum(usd_spend_amount) as current_usd_spend_amount,
                  sum(eur_spend_amount) as current_eur_spend_amount,
                  sum(dkk_spend_amount) as current_dkk_spend_amount,
                  sum(nok_spend_amount) as current_nok_spend_amount,
                  sum(jpy_spend_amount) as current_jpy_spend_amount,
                  sum(sek_spend_amount) as current_sek_spend_amount,
                  sum(pln_spend_amount) as current_pln_spend_amount,
                  merger_type,
                  panel_type,
                  spend.panel_method,
                  spend.cardtype_include
           FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

           LEFT JOIN (select
                            p.symbol
                            , p.cardtype
                            , p.trans_date
                            , "Pro Forma" as merger_type
                            , "CONSTIND" as panel_type
                            , sd.panel_method
                            , sd.cardtype_include
                            , round(p.gbp_spend_amount,2) as gbp_spend_amount
                            , round(p.cad_spend_amount,2) as cad_spend_amount
                            , round(p.usd_spend_amount,2) as usd_spend_amount
                            , round(p.eur_spend_amount,2) as eur_spend_amount
                            , round(p.dkk_spend_amount,2) as dkk_spend_amount
                            , round(p.nok_spend_amount,2) as nok_spend_amount
                            , round(p.jpy_spend_amount,2) as jpy_spend_amount
                            , round(p.sek_spend_amount,2) as sek_spend_amount
                            , round(p.pln_spend_amount,2) as pln_spend_amount

                      from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                      inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                      on p.symbol = sb.symbol
                      and p.brand_id = sb.brand_id
                      left join (SELECT distinct symbol, panel_method, cardtype_include
                                FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                      on p.symbol = sd.symbol) spend

           on spend.symbol = all_date_ranges.symbol
           and trans_date between current_period_start_dt and current_cum_end_dt

           GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
           ORDER BY symbol, day_count) current_spend

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as yago_spend_amount,
                      sum(gbp_spend_amount) as yago_gbp_spend_amount,
                      sum(cad_spend_amount) as yago_cad_spend_amount,
                      sum(usd_spend_amount) as yago_usd_spend_amount,
                      sum(eur_spend_amount) as yago_eur_spend_amount,
                      sum(dkk_spend_amount) as yago_dkk_spend_amount,
                      sum(nok_spend_amount) as yago_nok_spend_amount,
                      sum(jpy_spend_amount) as yago_jpy_spend_amount,
                      sum(sek_spend_amount) as yago_sek_spend_amount,
                      sum(pln_spend_amount) as yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

                 on spend.symbol = all_date_ranges.symbol
                 and trans_date between yago_period_start_dt and yago_cum_end_dt

                 GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
                 ORDER BY symbol, day_count) yago_spend

    on current_spend.symbol = yago_spend.symbol
    and current_spend.cardtype = yago_spend.cardtype
    and current_spend.day_count = yago_spend.day_count
    and current_spend.periods = yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as two_yago_spend_amount,
                      sum(gbp_spend_amount) as two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
               FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                   FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between two_yago_period_start_dt and two_yago_cum_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) two_yago_spend

    on current_spend.symbol = two_yago_spend.symbol
    and current_spend.cardtype = two_yago_spend.cardtype
    and current_spend.day_count = two_yago_spend.day_count
    and current_spend.periods = two_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*,
                      spend.cardtype,
                      #sum(spend_amount) as balance_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_yago_pln_spend_amount,
                      merger_type, panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_yago_cum_start_dt and  balance_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_yago_spend

    on current_spend.symbol = balance_yago_spend.symbol
    and current_spend.cardtype = balance_yago_spend.cardtype
    and current_spend.day_count = balance_yago_spend.day_count
    and current_spend.periods = balance_yago_spend.periods

    LEFT JOIN (SELECT all_date_ranges.*, spend.cardtype,
                      #sum(spend_amount) as balance_two_yago_spend_amount,
                      sum(gbp_spend_amount) as balance_two_yago_gbp_spend_amount,
                      sum(cad_spend_amount) as balance_two_yago_cad_spend_amount,
                      sum(usd_spend_amount) as balance_two_yago_usd_spend_amount,
                      sum(eur_spend_amount) as balance_two_yago_eur_spend_amount,
                      sum(dkk_spend_amount) as balance_two_yago_dkk_spend_amount,
                      sum(nok_spend_amount) as balance_two_yago_nok_spend_amount,
                      sum(jpy_spend_amount) as balance_two_yago_jpy_spend_amount,
                      sum(sek_spend_amount) as balance_two_yago_sek_spend_amount,
                      sum(pln_spend_amount) as balance_two_yago_pln_spend_amount,
                      merger_type,
                      panel_type,
                      spend.panel_method,
                      spend.cardtype_include
              FROM ${forecast_date_intervals.SQL_TABLE_NAME} all_date_ranges

              LEFT JOIN (select
                                p.symbol
                                , p.cardtype
                                , p.trans_date
                                , "Pro Forma" as merger_type
                                , "CONSTIND" as panel_type
                                , sd.panel_method
                                , sd.cardtype_include
                                , round(p.gbp_spend_amount,2) as gbp_spend_amount
                                , round(p.cad_spend_amount,2) as cad_spend_amount
                                , round(p.usd_spend_amount,2) as usd_spend_amount
                                , round(p.eur_spend_amount,2) as eur_spend_amount
                                , round(p.dkk_spend_amount,2) as dkk_spend_amount
                                , round(p.nok_spend_amount,2) as nok_spend_amount
                                , round(p.jpy_spend_amount,2) as jpy_spend_amount
                                , round(p.sek_spend_amount,2) as sek_spend_amount
                                , round(p.pln_spend_amount,2) as pln_spend_amount

                        from ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                        inner join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date
                                    FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                        on p.symbol = sb.symbol
                        and p.brand_id = sb.brand_id
                        left join (SELECT distinct symbol, panel_method, cardtype_include
                                  FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                        on p.symbol = sd.symbol) spend

              on spend.symbol = all_date_ranges.symbol
              and trans_date between balance_two_yago_cum_start_dt and  balance_two_yago_period_end_dt

              GROUP BY symbol, period_type, period, day_count, reverse_day_count, periods, period_length, balance_length, current_period_start_dt, current_cum_end_dt, current_sum_include, yago_period_start_dt, yago_cum_end_dt, yago_sum_include, two_yago_period_start_dt, two_yago_cum_end_dt, two_yago_sum_include, balance_yago_cum_start_dt, balance_yago_period_end_dt, balance_yago_sum_include, balance_two_yago_cum_start_dt, balance_two_yago_period_end_dt, balance_two_yago_sum_include, merger_type, panel_type, spend.cardtype, spend.panel_method, spend.cardtype_include
              ORDER BY symbol, day_count) balance_two_yago_spend

    on current_spend.symbol = balance_two_yago_spend.symbol
    and current_spend.cardtype = balance_two_yago_spend.cardtype
    and current_spend.day_count = balance_two_yago_spend.day_count
    and current_spend.periods = balance_two_yago_spend.periods


     ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
    }

    dimension: symbol {
      sql: ${TABLE}.symbol ;;
    }}
