view: by_card_underlying_symbol_reg_constind_seq_rolling {
  derived_table: {
    partition_keys: ["period_start_dt"]
    sql:
          (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
         ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
         ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
         ,  symbol_period_table AS (select
                                          symbol
                                          , period
                                          , period_start_dt
                                          , period_end_dt
                                      from (SELECT distinct symbol, period, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                            WHERE period_type = 'FQ')

                                      union all

                                      select
                                          s.symbol
                                          , c.calendar_qtr as period
                                          , min(c.date) as period_start_dt
                                          , max(c.date) as period_end_dt
                                      from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                      cross join ${calendar.SQL_TABLE_NAME} c
                                          WHERE s.symbol not in
                                              (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                               WHERE period_type = 'FQ')
                                      group by
                                          s.symbol
                                          , c.calendar_qtr)
         ,  max_date_by_period AS (select
                                    max.symbol
                                    , c.period
                                    , c.period_start_dt
                                    , c.period_end_dt
                                    , max.maxdate
                                    , least(max.maxdate,c.period_end_dt) as ptd_end_dt
                                    , case
                                        when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                        then 1
                                        else 0 end as partial_period_flag
                                    , case
                                        when max.maxdate between c.period_start_dt and c.period_end_dt
                                        then 1
                                        else 0 end as latest_period_flag
                                  from max_available_date max
                                  inner join symbol_period_table c
                                      on max.symbol = c.symbol
                                      where c.period_start_dt <= max.maxdate
                                      and c.period_start_dt >= (SELECT * FROM first_trans))
           ,  max_date_by_period_prev AS (select
                                            max.symbol
                                            , max.period
                                            , fp.prev_period
                                            , c.period_start_dt as prev_period_start_dt
                                            , case
                                                when max.partial_period_flag = 1
                                                then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                                else c.period_end_dt end as prev_ptd_end_dt
                                            , max.partial_period_flag
                                        from max_date_by_period max
                                        inner join ${financial_period.SQL_TABLE_NAME} fp
                                            on max.period = fp.period
                                        inner join symbol_period_table c
                                            on c.period = fp.prev_period
                                            and c.symbol = max.symbol
                                        where c.period_start_dt <= max.maxdate
                                            and c.period_start_dt >= (SELECT * FROM first_trans))

            , max_date_combined AS ( SELECT     max.symbol, sb.brand_name, sb.brand_id, cardtype, max.period, prevmax.prev_period, max.period_start_dt, max.ptd_end_dt, max.period_end_dt, prevmax.prev_period_start_dt, prevmax.prev_ptd_end_dt, max.maxdate,
                                               max.partial_period_flag, max.latest_period_flag

                                               from max_date_by_period max
                                               left join max_date_by_period_prev prevmax
                                                 on max.symbol = prevmax.symbol
                                                 and max.period = prevmax.period
                                               left join (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                 on max.symbol = sb.symbol
                                               cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))





    , current_period_sales AS (  select
                                          max.symbol
                                          , max.brand_name as brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.latest_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.ptd_end_dt
                                          , max.period_end_dt
                                          , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                          , round(sum(p.trans_count),2) as trans_count
                                      FROM max_date_combined max
                                      left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on max.symbol = sb.symbol
                                          and max.brand_id = sb.brand_id
                                      left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          on p.brand_id = max.brand_id
                                          and p.symbol = max.symbol
                                          and p.cardtype = max.cardtype
                                          and p.trans_date between max.period_start_dt and max.ptd_end_dt
    #                                       and p.trans_date between sb.start_date and sb.end_date
                                          WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                      group by
                                          max.symbol
                                          , max.brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.period_end_dt
                                          , max.ptd_end_dt
                                          , max.latest_period_flag)



            select
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , "QTR" as period_type
                , "NONE" as merger_type
                , "CONSTIND" as panel_type
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.ptd_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
            from current_period_sales c
            left join max_date_combined max
                on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                           on max.symbol = sd.symbol
            left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                on p.brand_id = c.brand_id
                    and p.symbol = c.symbol
                    and p.cardtype = c.cardtype
                    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    #                 and p.trans_date between sb.start_date and sb.end_date
            join oldest_trans o
            on c.brand_id = o.brand_id
            group by
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , c.trans_count
                , c.latest_period_flag
                , c.period_end_dt
                , o.min_date

                ORDER BY brand_name, cardtype, period)

          ######################################################################
          UNION ALL
          ######################################################################

          (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
         ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
         ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
         ,  symbol_period_table AS (select
                                          symbol
                                          , period
                                          , period_start_dt
                                          , period_end_dt
                                      from (SELECT distinct symbol, period, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                            WHERE period_type = 'FH')

                                     #union all

                                     #select
                                     #    s.symbol
                                     #    , c.calendar_qtr as period
                                     #    , min(c.date) as period_start_dt
                                     #    , max(c.date) as period_end_dt
                                     #from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                     #cross join ${calendar.SQL_TABLE_NAME} c
                                     #    WHERE s.symbol not in
                                     #        (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                     #         WHERE period_type = 'FH')
                                     #group by
                                     #    s.symbol
                                     #     , c.calendar_half
                                    )
         ,  max_date_by_period AS (select
                                    max.symbol
                                    , c.period
                                    , c.period_start_dt
                                    , c.period_end_dt
                                    , max.maxdate
                                    , least(max.maxdate,c.period_end_dt) as ptd_end_dt
                                    , case
                                        when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                        then 1
                                        else 0 end as partial_period_flag
                                    , case
                                        when max.maxdate between c.period_start_dt and c.period_end_dt
                                        then 1
                                        else 0 end as latest_period_flag
                                  from max_available_date max
                                  inner join symbol_period_table c
                                      on max.symbol = c.symbol
                                      where c.period_start_dt <= max.maxdate
                                      and c.period_start_dt >= (SELECT * FROM first_trans))
           ,  max_date_by_period_prev AS (select
                                            max.symbol
                                            , max.period
                                            , fp.prev_period
                                            , c.period_start_dt as prev_period_start_dt
                                            , case
                                                when max.partial_period_flag = 1
                                                then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                                else c.period_end_dt end as prev_ptd_end_dt
                                            , max.partial_period_flag
                                        from max_date_by_period max
                                        inner join ${financial_period.SQL_TABLE_NAME} fp
                                            on max.period = fp.period
                                        inner join symbol_period_table c
                                            on c.period = fp.prev_period
                                            and c.symbol = max.symbol
                                        where c.period_start_dt <= max.maxdate
                                            and c.period_start_dt >= (SELECT * FROM first_trans))

            , max_date_combined AS ( SELECT     max.symbol, sb.brand_name, sb.brand_id, cardtype, max.period, prevmax.prev_period, max.period_start_dt, max.ptd_end_dt, max.period_end_dt, prevmax.prev_period_start_dt, prevmax.prev_ptd_end_dt, max.maxdate,
                                               max.partial_period_flag, max.latest_period_flag

                                               from max_date_by_period max
                                               left join max_date_by_period_prev prevmax
                                                 on max.symbol = prevmax.symbol
                                                 and max.period = prevmax.period
                                               left join (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                 on max.symbol = sb.symbol
                                               cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))





    , current_period_sales AS (  select
                                          max.symbol
                                          , max.brand_name as brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.latest_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.ptd_end_dt
                                          , max.period_end_dt
                                          , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                          , round(sum(p.trans_count),2) as trans_count
                                      FROM max_date_combined max
                                      left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on max.symbol = sb.symbol
                                          and max.brand_id = sb.brand_id
                                      left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          on p.brand_id = max.brand_id
                                          and p.symbol = max.symbol
                                          and p.cardtype = max.cardtype
                                          and p.trans_date between max.period_start_dt and max.ptd_end_dt
    #                                       and p.trans_date between sb.start_date and sb.end_date
                                          WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                      group by
                                          max.symbol
                                          , max.brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.period_end_dt
                                          , max.ptd_end_dt
                                          , max.latest_period_flag)



            select
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , "HALF" as period_type
                , "NONE" as merger_type
                , "CONSTIND" as panel_type
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.ptd_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
            from current_period_sales c
            left join max_date_combined max
                on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                           on max.symbol = sd.symbol
            left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                on p.brand_id = c.brand_id
                    and p.symbol = c.symbol
                    and p.cardtype = c.cardtype
                    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    #                 and p.trans_date between sb.start_date and sb.end_date
            join oldest_trans o
            on c.brand_id = o.brand_id
            group by
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , c.trans_count
                , c.latest_period_flag
                , c.period_end_dt
                , o.min_date

                ORDER BY brand_name, cardtype, period)

          ######################################################################
          UNION ALL
          ######################################################################

          (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
         ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
         ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
         ,  symbol_period_table AS (SELECT
                      s.symbol
                      , c.calendar_qtr as period
                      , min(c.date) as period_start_dt
                      , max(c.date) as period_end_dt
                    from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                    cross join ${calendar.SQL_TABLE_NAME} c
                    group by
                      s.symbol
                      , c.calendar_qtr)
         ,  max_date_by_period AS (select
                                    max.symbol
                                    , c.period
                                    , c.period_start_dt
                                    , c.period_end_dt
                                    , max.maxdate
                                    , least(max.maxdate,c.period_end_dt) as ptd_end_dt
                                    , case
                                        when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                        then 1
                                        else 0 end as partial_period_flag
                                    , case
                                        when max.maxdate between c.period_start_dt and c.period_end_dt
                                        then 1
                                        else 0 end as latest_period_flag
                                  from max_available_date max
                                  inner join symbol_period_table c
                                      on max.symbol = c.symbol
                                      where c.period_start_dt <= max.maxdate
                                      and c.period_start_dt >= (SELECT * FROM first_trans))
           ,  max_date_by_period_prev AS (select
                                            max.symbol
                                            , max.period
                                            , fp.prev_period
                                            , c.period_start_dt as prev_period_start_dt
                                            , case
                                                when max.partial_period_flag = 1
                                                then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                                else c.period_end_dt end as prev_ptd_end_dt
                                            , max.partial_period_flag
                                        from max_date_by_period max
                                        inner join ${financial_period.SQL_TABLE_NAME} fp
                                            on max.period = fp.period
                                        inner join symbol_period_table c
                                            on c.period = fp.prev_period
                                            and c.symbol = max.symbol
                                        where c.period_start_dt <= max.maxdate
                                            and c.period_start_dt >= (SELECT * FROM first_trans))

            , max_date_combined AS ( SELECT     max.symbol, sb.brand_name, sb.brand_id, cardtype, max.period, prevmax.prev_period, max.period_start_dt, max.ptd_end_dt, max.period_end_dt, prevmax.prev_period_start_dt, prevmax.prev_ptd_end_dt, max.maxdate,
                                               max.partial_period_flag, max.latest_period_flag

                                               from max_date_by_period max
                                               left join max_date_by_period_prev prevmax
                                                 on max.symbol = prevmax.symbol
                                                 and max.period = prevmax.period
                                               left join (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                 on max.symbol = sb.symbol
                                               cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))





    , current_period_sales AS (  select
                                          max.symbol
                                          , max.brand_name as brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.latest_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.ptd_end_dt
                                          , max.period_end_dt
                                          , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                          , round(sum(p.trans_count),2) as trans_count
                                      FROM max_date_combined max
                                      left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on max.symbol = sb.symbol
                                          and max.brand_id = sb.brand_id
                                      left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          on p.brand_id = max.brand_id
                                          and p.symbol = max.symbol
                                          and p.cardtype = max.cardtype
                                          and p.trans_date between max.period_start_dt and max.ptd_end_dt
    #                                       and p.trans_date between sb.start_date and sb.end_date
                                          WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                      group by
                                          max.symbol
                                          , max.brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.period_end_dt
                                          , max.ptd_end_dt
                                          , max.latest_period_flag)



            select
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , "CAL_QTR" as period_type
                , "NONE" as merger_type
                , "CONSTIND" as panel_type
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.ptd_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
            from current_period_sales c
            left join max_date_combined max
                on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                           on max.symbol = sd.symbol
            left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                on p.brand_id = c.brand_id
                    and p.symbol = c.symbol
                    and p.cardtype = c.cardtype
                    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    #                 and p.trans_date between sb.start_date and sb.end_date
            join oldest_trans o
            on c.brand_id = o.brand_id
            group by
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , c.trans_count
                , c.latest_period_flag
                , c.period_end_dt
                , o.min_date

                ORDER BY brand_name, cardtype, period)

          ######################################################################
          UNION ALL
          ######################################################################

          (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
         ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
         ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
         ,  symbol_period_table AS (SELECT
                      s.symbol
                      , c.calendar_week as period
                      , min(c.date) as period_start_dt
                      , max(c.date) as period_end_dt
                    from ${calendar.SQL_TABLE_NAME} c
                    cross join (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                    group by symbol, calendar_week)
         ,  max_date_by_period AS (select
                                    max.symbol
                                    , c.period
                                    , c.period_start_dt
                                    , c.period_end_dt
                                    , max.maxdate
                                    , least(max.maxdate,c.period_end_dt) as ptd_end_dt
                                    , case
                                        when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                        then 1
                                        else 0 end as partial_period_flag
                                    , case
                                        when max.maxdate between c.period_start_dt and c.period_end_dt
                                        then 1
                                        else 0 end as latest_period_flag
                                  from max_available_date max
                                  inner join symbol_period_table c
                                      on max.symbol = c.symbol
                                      where c.period_start_dt <= max.maxdate
                                      and c.period_start_dt >= (SELECT * FROM first_trans))
           ,  max_date_by_period_prev AS (select
                                            max.symbol
                                            , max.period
                                            , fp.prev_period
                                            , c.period_start_dt as prev_period_start_dt
                                            , case
                                                when max.partial_period_flag = 1
                                                then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                                else c.period_end_dt end as prev_ptd_end_dt
                                            , max.partial_period_flag
                                        from max_date_by_period max
                                        inner join ${financial_period.SQL_TABLE_NAME} fp
                                            on max.period = fp.period
                                        inner join symbol_period_table c
                                            on c.period = fp.prev_period
                                            and c.symbol = max.symbol
                                        where c.period_start_dt <= max.maxdate
                                            and c.period_start_dt >= (SELECT * FROM first_trans))

            , max_date_combined AS ( SELECT     max.symbol, sb.brand_name, sb.brand_id, cardtype, max.period, prevmax.prev_period, max.period_start_dt, max.ptd_end_dt, max.period_end_dt, prevmax.prev_period_start_dt, prevmax.prev_ptd_end_dt, max.maxdate,
                                               max.partial_period_flag, max.latest_period_flag

                                               from max_date_by_period max
                                               left join max_date_by_period_prev prevmax
                                                 on max.symbol = prevmax.symbol
                                                 and max.period = prevmax.period
                                               left join (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                 on max.symbol = sb.symbol
                                               cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))





    , current_period_sales AS (  select
                                          max.symbol
                                          , max.brand_name as brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.latest_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.ptd_end_dt
                                          , max.period_end_dt
                                          , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                          , round(sum(p.trans_count),2) as trans_count
                                      FROM max_date_combined max
                                      left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on max.symbol = sb.symbol
                                          and max.brand_id = sb.brand_id
                                      left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          on p.brand_id = max.brand_id
                                          and p.symbol = max.symbol
                                          and p.cardtype = max.cardtype
                                          and p.trans_date between max.period_start_dt and max.ptd_end_dt
    #                                       and p.trans_date between sb.start_date and sb.end_date
                                          WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                      group by
                                          max.symbol
                                          , max.brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.period_end_dt
                                          , max.ptd_end_dt
                                          , max.latest_period_flag)



            select
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , "WEEK" as period_type
                , "NONE" as merger_type
                , "CONSTIND" as panel_type
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.ptd_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
            from current_period_sales c
            left join max_date_combined max
                on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                           on max.symbol = sd.symbol
            left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                on p.brand_id = c.brand_id
                    and p.symbol = c.symbol
                    and p.cardtype = c.cardtype
                    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    #                 and p.trans_date between sb.start_date and sb.end_date
            join oldest_trans o
            on c.brand_id = o.brand_id
            group by
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , c.trans_count
                , c.latest_period_flag
                , c.period_end_dt
                , o.min_date

                ORDER BY brand_name, cardtype, period)

          ######################################################################
          UNION ALL
          ######################################################################

          (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
         ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
         ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
         ,  symbol_period_table AS (select
                      s.symbol
                      , c.calendar_month as period
                      , min(c.date) as period_start_dt
                      , max(c.date) as period_end_dt
                    from ${calendar.SQL_TABLE_NAME} c
                    cross join (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                    group by symbol, calendar_month)
         ,  max_date_by_period AS (select
                                    max.symbol
                                    , c.period
                                    , c.period_start_dt
                                    , c.period_end_dt
                                    , max.maxdate
                                    , least(max.maxdate,c.period_end_dt) as ptd_end_dt
                                    , case
                                        when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                        then 1
                                        else 0 end as partial_period_flag
                                    , case
                                        when max.maxdate between c.period_start_dt and c.period_end_dt
                                        then 1
                                        else 0 end as latest_period_flag
                                  from max_available_date max
                                  inner join symbol_period_table c
                                      on max.symbol = c.symbol
                                      where c.period_start_dt <= max.maxdate
                                      and c.period_start_dt >= (SELECT * FROM first_trans))
           ,  max_date_by_period_prev AS (select
                                            max.symbol
                                            , max.period
                                            , fp.prev_period
                                            , c.period_start_dt as prev_period_start_dt
                                            , case
                                                when max.partial_period_flag = 1
                                                then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                                else c.period_end_dt end as prev_ptd_end_dt
                                            , max.partial_period_flag
                                        from max_date_by_period max
                                        inner join ${financial_period.SQL_TABLE_NAME} fp
                                            on max.period = fp.period
                                        inner join symbol_period_table c
                                            on c.period = fp.prev_period
                                            and c.symbol = max.symbol
                                        where c.period_start_dt <= max.maxdate
                                            and c.period_start_dt >= (SELECT * FROM first_trans))

            , max_date_combined AS ( SELECT     max.symbol, sb.brand_name, sb.brand_id, cardtype, max.period, prevmax.prev_period, max.period_start_dt, max.ptd_end_dt, max.period_end_dt, prevmax.prev_period_start_dt, prevmax.prev_ptd_end_dt, max.maxdate,
                                               max.partial_period_flag, max.latest_period_flag

                                               from max_date_by_period max
                                               left join max_date_by_period_prev prevmax
                                                 on max.symbol = prevmax.symbol
                                                 and max.period = prevmax.period
                                               left join (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                 on max.symbol = sb.symbol
                                               cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))





    , current_period_sales AS (  select
                                          max.symbol
                                          , max.brand_name as brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.latest_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.ptd_end_dt
                                          , max.period_end_dt
                                          , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                          , round(sum(p.trans_count),2) as trans_count
                                      FROM max_date_combined max
                                      left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                          on max.symbol = sb.symbol
                                          and max.brand_id = sb.brand_id
                                      left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                          on p.brand_id = max.brand_id
                                          and p.symbol = max.symbol
                                          and p.cardtype = max.cardtype
                                          and p.trans_date between max.period_start_dt and max.ptd_end_dt
    #                                       and p.trans_date between sb.start_date and sb.end_date
                                          WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                      group by
                                          max.symbol
                                          , max.brand_name
                                          , max.brand_id
                                          , max.cardtype
                                          , max.partial_period_flag
                                          , max.period
                                          , max.period_start_dt
                                          , max.period_end_dt
                                          , max.ptd_end_dt
                                          , max.latest_period_flag)



            select
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , "MONTH" as period_type
                , "NONE" as merger_type
                , "CONSTIND" as panel_type
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.ptd_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
            from current_period_sales c
            left join max_date_combined max
                on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                           on max.symbol = sd.symbol
            left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                on p.brand_id = c.brand_id
                    and p.symbol = c.symbol
                    and p.cardtype = c.cardtype
                    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    #                 and p.trans_date between sb.start_date and sb.end_date
            join oldest_trans o
            on c.brand_id = o.brand_id
            group by
                c.symbol
                , c.brand_name
                , c.brand_id
                , c.cardtype
                , c.partial_period_flag
                , sd.panel_method
                , sd.cardtype_include
                , c.period
                , c.period_start_dt
                , c.ptd_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_ptd_end_dt
                , c.trans_count
                , c.latest_period_flag
                , c.period_end_dt
                , o.min_date

                ORDER BY brand_name, cardtype, period)


 ###########################################
                  UNION ALL
                  ###########################################
                  (WITH    max_available_date AS (select symbol, maxdate FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`)
           ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME})
           ,  oldest_trans AS (SELECT brand_id, min(trans_date) as min_date FROM ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} group by brand_id)
          , rolling_cal_base as (
                                   SELECT
                                     "Rolling 7 Days" as period_type
                                     , concat("7 DE ", c.date) as period
                                     , date_sub(c.date, interval 6 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("7 DE ", date_sub(c.date, interval 7 day)) as prev_period
                                     , date_sub(c.date, interval 7+6 day) as prev_start_dt
                                     , date_sub(c.date, interval 7 day) as prev_end_dt
                                     , concat("7 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+6 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE date_sub(c.date, interval 6 day) >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)
                                   UNION ALL

                                   SELECT
                                     "Rolling 35 Days" as period_type
                                     , concat("35 DE ", c.date) as period
                                     , date_sub(c.date, interval 34 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("35 DE ", date_sub(c.date, interval 35 day)) as prev_period
                                     , date_sub(c.date, interval 35+34 day) as prev_start_dt
                                     , date_sub(c.date, interval 35 day) as prev_end_dt
                                     , concat("35 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+34 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE date_sub(c.date, interval 34 day) >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)

                                   UNION ALL

                                   SELECT
                                     "Rolling 91 Days" as period_type
                                     , concat("91 DE ", c.date) as period
                                     , date_sub(c.date, interval 90 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("91 DE ", date_sub(c.date, interval 91 day)) as prev_period
                                     , date_sub(c.date, interval 91+90 day) as prev_start_dt
                                     , date_sub(c.date, interval 91 day) as prev_end_dt
                                     , concat("91 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+90 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE date_sub(c.date, interval 90 day) >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)

                                    UNION ALL

                                    SELECT
                                     "Rolling 182 Days" as period_type
                                     , concat("182 DE ", c.date) as period
                                     , date_sub(c.date, interval 181 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("182 DE ", date_sub(c.date, interval 182 day)) as prev_period
                                     , date_sub(c.date, interval 182+181 day) as prev_start_dt
                                     , date_sub(c.date, interval 182 day) as prev_end_dt
                                     , concat("182 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+181 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE date_sub(c.date, interval 181 day) >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)

                                  UNION ALL

                                    SELECT
                                     "Rolling 364 Days" as period_type
                                     , concat("364 DE ", c.date) as period
                                     , date_sub(c.date, interval 363 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("364 DE ", date_sub(c.date, interval 364 day)) as prev_period
                                     , date_sub(c.date, interval 364+363 day) as prev_start_dt
                                     , date_sub(c.date, interval 364 day) as prev_end_dt
                                     , concat("364 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+363 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE date_sub(c.date, interval 363 day) >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)
                                  )
           ,  symbol_period_table AS (select
                                            s.symbol
                                            , s.brand_name
                                            , s. brand_id
                                            , c.period_type
                                            , period
                                            , cardtype
                                            , period_start_dt
                                            , period_end_dt
                                            , prev_period
                                            , prev_start_dt as prev_period_start_dt
                                            , prev_end_dt as prev_period_end_dt
                                            , ya_period
                                            , ya_start_dt as ya_period_start_dt
                                            , ya_end_dt as ya_period_end_dt
                                            , case
                                              when max.maxdate between c.period_start_dt and c.period_end_dt
                                              then 1
                                              else 0 end as latest_period_flag

                                        from (SELECT distinct symbol, brand_name, brand_id FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                        left join max_available_date max
                                          on s.symbol = max.symbol
                                        cross join (SELECT * FROM rolling_cal_base) c
                                        cross join (SELECT "CREDIT" as cardtype UNION ALL SELECT "DEBIT" as cardtype))


      , current_period_sales AS (  select
                                            max.symbol
                                            , max.brand_name as brand_name
                                            , max.brand_id
                                            , max.cardtype
                                            , max.period
                                            , max.period_start_dt
                                            , max.period_end_dt
                                            , max.latest_period_flag
                                            , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                          , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                          , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                          , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                          , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                          , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                          , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                          , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                          , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                                            , round(sum(p.trans_count),2) as trans_count
                                        FROM symbol_period_table max
                                        left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                            on max.symbol = sb.symbol
                                            and max.brand_id = sb.brand_id
                                        left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                                            on p.brand_id = max.brand_id
                                            and p.symbol = max.symbol
                                            and p.cardtype = max.cardtype
                                            and p.trans_date between max.period_start_dt and max.period_end_dt
                                            and p.trans_date between sb.start_date and sb.end_date
                                            WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                        group by
                                            max.symbol
                                            , max.brand_name
                                            , max.brand_id
                                            , max.cardtype
                                            , max.period
                                            , max.latest_period_flag
                                            , max.period_start_dt
                                            , max.period_end_dt)



              select
                   c.symbol
                  , c.brand_name
                  , c.brand_id
                  , c.cardtype
                  , 0 as partial_period_flag
                  , period_type
                  , "NONE" as merger_type
                  , "CONSTIND" as panel_type
                  , sd.panel_method
                  , sd.cardtype_include
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt as ptd_end_dt
                , round(c.gbp_spend_amount,2) as gbp_spend_amount
                , round(c.cad_spend_amount,2) as cad_spend_amount
                , round(c.usd_spend_amount,2) as usd_spend_amount
                , round(c.eur_spend_amount,2) as eur_spend_amount
                , round(c.dkk_spend_amount,2) as dkk_spend_amount
                , round(c.nok_spend_amount,2) as nok_spend_amount
                , round(c.jpy_spend_amount,2) as jpy_spend_amount
                , round(c.sek_spend_amount,2) as sek_spend_amount
                , round(c.pln_spend_amount,2) as pln_spend_amount
                , max.prev_period
                , max.prev_period_start_dt
                , max.prev_period_end_dt as prev_ptd_end_dt
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount),2) END as prev_gbp_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount),2) END as prev_cad_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount),2) END as prev_usd_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount),2) END as prev_eur_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount),2) END as prev_dkk_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount),2) END as prev_nok_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount),2) END as prev_jpy_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount),2) END as prev_sek_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount),2) END as prev_pln_spend_amount
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(p.gbp_spend_amount),0)-1 END as ptd_spend_yoy
                , round(c.trans_count,2) as trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.trans_count),2) END as prev_trans_count
                , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(p.trans_count),0)-1 END as ptd_trans_yoy
                , c.latest_period_flag as latest_period_flag
                , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
                , c.period_end_dt
              from current_period_sales c
              left join symbol_period_table max
                  on max.symbol = c.symbol and max.period = c.period and max.brand_id = c.brand_id and c.cardtype = max.cardtype
                  left join (SELECT distinct symbol, brand_name, brand_id, start_date, end_date FROM ${ground_truth_brand.SQL_TABLE_NAME}) sb
                                                on max.symbol = sb.symbol
                                                and max.brand_id = sb.brand_id
                  left join (SELECT distinct symbol, panel_method, cardtype_include FROM ${ground_truth_brand.SQL_TABLE_NAME}) sd
                                                 on max.symbol = sd.symbol
              left join ${dist_day_sym_brand_cardtype_constind_currency.SQL_TABLE_NAME} p
                  on p.brand_id = c.brand_id
                      and p.symbol = c.symbol
                      and p.cardtype = c.cardtype
                      and p.trans_date between max.prev_period_start_dt and max.prev_period_end_dt
                      and p.trans_date between sb.start_date and sb.end_date
              join oldest_trans o
              on c.brand_id = o.brand_id
              group by
                  c.symbol
                  , c.brand_name
                  , c.brand_id
                  , c.cardtype
                  , period_type
                  , sd.panel_method
                  , sd.cardtype_include
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt,
                  c.gbp_spend_amount,
                  c.cad_spend_amount,
                  c.usd_spend_amount,
                  c.eur_spend_amount,
                  c.dkk_spend_amount,
                  c.nok_spend_amount,
                  c.jpy_spend_amount,
                  c.sek_spend_amount,
                  c.pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_period_end_dt
                  , c.trans_count
                  , c.period_end_dt
                  , c.latest_period_flag
                  , o.min_date

                  ORDER BY brand_name, cardtype, period)
                  ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }

    dimension: period {
      sql: ${TABLE}.period ;;
    }


    dimension: period_type {
      sql: ${TABLE}.period_type ;;
    }

  }
