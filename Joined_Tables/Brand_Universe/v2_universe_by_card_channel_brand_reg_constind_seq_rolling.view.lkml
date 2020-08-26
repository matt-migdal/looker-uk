view: v2_universe_by_card_channel_brand_reg_constind_seq_rolling {
  derived_table: {
    partition_keys: ["period_start_dt"]
    cluster_keys: ["merger_type"]
    sql:



    (WITH    max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  oldest_trans AS (SELECT brand_id, min(trans_date) min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  GROUP BY brand_id)
    ,  brand_name_period_table AS (SELECT
                                    s.brand_name
                                    , s.brand_id
                                    /* #, s.channel */
                                    , c.calendar_qtr as period
                                    , min(c.date) as period_start_dt
                                    , max(c.date) as period_end_dt
                                    from (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) s
                                    cross join ${calendar.SQL_TABLE_NAME} c
                                    group by
                                    s.brand_name
                                    , s.brand_id
                                    /* #, s.channel */
                                    , c.calendar_qtr)
    ,  max_date_by_period AS (select
                                c.brand_name
                                , c.brand_id
                                /* #, c.channel */
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
                                inner join brand_name_period_table c
                                on c.period_start_dt <= max.maxdate
                                where c.period_start_dt >= (SELECT * FROM first_trans))
    ,  max_date_by_period_prev AS (select
                                    max.brand_name
                                    , max.brand_id
                                    /* #, max.channel */
                                    , max.period
                                    , fp.prev_period
                                    , c.period_start_dt as prev_period_start_dt
                                    , case when max.partial_period_flag = 1
                                    then date_add(c.period_start_dt, interval (date_diff(max.ptd_end_dt,max.period_start_dt,day)) day)
                                    else c.period_end_dt end as prev_ptd_end_dt
                                    , max.partial_period_flag
                                    from max_date_by_period max
                                    inner join ${financial_period.SQL_TABLE_NAME} fp
                                    on max.period = fp.period
                                    inner join brand_name_period_table c
                                    on c.period = fp.prev_period
                                    and c.brand_id = max.brand_id
                                    /* #and c.channel = max.channel */
                                    where c.period_start_dt <= max.maxdate
                                    and c.period_start_dt >= (SELECT * FROM first_trans))

    , max_date_combined AS ( SELECT     max.brand_name,
                                        max.brand_id,
                                        /* channel, */
                                        max.period,
                                        prevmax.prev_period,
                                        max.period_start_dt,
                                        max.ptd_end_dt,
                                        max.period_end_dt,
                                        prevmax.prev_period_start_dt,
                                        prevmax.prev_ptd_end_dt,
                                        max.maxdate,
                                        max.partial_period_flag,
                                        max.latest_period_flag

                             from max_date_by_period max
                             left join max_date_by_period_prev prevmax
                             on max.brand_id = prevmax.brand_id
                             /* #and max.channel = prevmax.channel */
                             and max.period = prevmax.period
                            /* cross join (SELECT "ONLINE" as channel UNION ALL SELECT "OFFLINE/UNKNOWN" as channel) */)





    , current_period_sales AS (  select
                                    max.brand_name
                                    , max.brand_id
                                   /* , max.channel */
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
                                 left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                                 on p.brand_id = max.brand_id
                                 /* and p.channel = max.channel */
                                 and p.trans_date between max.period_start_dt and max.ptd_end_dt
                                 WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                 group by
                                 max.brand_name
                                 , max.brand_id
                                /* , max.channel */
                                 , max.partial_period_flag
                                 , max.period
                                 , max.period_start_dt
                                 , max.period_end_dt
                                 , max.ptd_end_dt
                                 , max.latest_period_flag)



    select
      c.brand_name
      , c.brand_id
     /*  , c.channel */
      , c.partial_period_flag
      , "CAL_QTR" as period_type
      , "NONE" as merger_type
      , "CONSTIND" as panel_type
      , sd.panel_method
      , c.period
      , c.period_start_dt
      , c.ptd_end_dt
      , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
      , round(sum(p.cad_spend_amount),2) as cad_spend_amount
      , round(sum(p.usd_spend_amount),2) as usd_spend_amount
      , round(sum(p.eur_spend_amount),2) as eur_spend_amount
      , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
      , round(sum(p.nok_spend_amount),2) as nok_spend_amount
      , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
      , round(sum(p.sek_spend_amount),2) as sek_spend_amount
      , round(sum(p.pln_spend_amount),2) as pln_spend_amount
      , max.prev_period
      , max.prev_period_start_dt
      , max.prev_ptd_end_dt

      , round(c.trans_count,2) as trans_count
      , round(sum(ifnull(p.trans_count,0)),2) as prev_trans_count
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(ifnull(p.trans_count,0)),0)-1 END as ptd_trans_yoy


      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.gbp_spend_amount,0)),2) END as prev_spend_amount_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(ifnull(p.gbp_spend_amount,0)),0)-1 END as ptd_spend_yoy_gbp
      , round(c.gbp_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.gbp_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_gbp

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.cad_spend_amount,0)),2) END as prev_spend_amount_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.cad_spend_amount/nullif(sum(ifnull(p.cad_spend_amount,0)),0)-1 END as ptd_spend_yoy_cad
      , round(c.cad_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.cad_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_cad

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.usd_spend_amount,0)),2) END as prev_spend_amount_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.usd_spend_amount/nullif(sum(ifnull(p.usd_spend_amount,0)),0)-1 END as ptd_spend_yoy_usd
      , round(c.usd_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.usd_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_usd

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.eur_spend_amount,0)),2) END as prev_spend_amount_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.eur_spend_amount/nullif(sum(ifnull(p.eur_spend_amount,0)),0)-1 END as ptd_spend_yoy_eur
      , round(c.eur_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.eur_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_eur

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.dkk_spend_amount,0)),2) END as prev_spend_amount_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.dkk_spend_amount/nullif(sum(ifnull(p.dkk_spend_amount,0)),0)-1 END as ptd_spend_yoy_dkk
      , round(c.dkk_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.dkk_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_dkk

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.nok_spend_amount,0)),2) END as prev_spend_amount_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.nok_spend_amount/nullif(sum(ifnull(p.nok_spend_amount,0)),0)-1 END as ptd_spend_yoy_nok
      , round(c.nok_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.nok_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_nok

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.jpy_spend_amount,0)),2) END as prev_spend_amount_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.jpy_spend_amount/nullif(sum(ifnull(p.jpy_spend_amount,0)),0)-1 END as ptd_spend_yoy_jpy
      , round(c.jpy_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.jpy_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_jpy

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.sek_spend_amount,0)),2) END as prev_spend_amount_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.sek_spend_amount/nullif(sum(ifnull(p.sek_spend_amount,0)),0)-1 END as ptd_spend_yoy_sek
      , round(c.sek_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.sek_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_sek

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.pln_spend_amount,0)),2) END as prev_spend_amount_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.pln_spend_amount/nullif(sum(ifnull(p.pln_spend_amount,0)),0)-1 END as ptd_spend_yoy_pln
      , round(c.pln_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.pln_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_pln


      , c.latest_period_flag as latest_period_flag
      , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
      , c.period_end_dt
    from current_period_sales c
    left join max_date_combined max
    on max.period = c.period and max.brand_id = c.brand_id /* and max.channel = c.channel */
    left join (SELECT distinct brand_name, brand_id, "EMAX" as panel_method FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) sd
    on max.brand_id = sd.brand_id
    left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
    on p.brand_id = c.brand_id
    /* and p.channel = c.channel */
    and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
    join oldest_trans o
      on c.brand_id = o.brand_id
    group by
    c.brand_name
    , c.brand_id
   /*  , c.channel */
    , c.partial_period_flag
    , sd.panel_method
    , c.period
    , c.period_start_dt
    , c.ptd_end_dt
    , c.gbp_spend_amount
    , c.cad_spend_amount
    , c.usd_spend_amount
    , c.eur_spend_amount
    , c.dkk_spend_amount
    , c.nok_spend_amount
    , c.jpy_spend_amount
    , c.sek_spend_amount
    , c.pln_spend_amount
    , max.prev_period
    , max.prev_period_start_dt
    , max.prev_ptd_end_dt
    , c.trans_count
    , c.latest_period_flag
    , c.period_end_dt
    , o.min_date

    ORDER BY brand_name, period)

    ######################################################################
    UNION ALL
    ######################################################################

    (WITH    max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  oldest_trans AS (SELECT brand_id, min(trans_date) min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  GROUP BY brand_id)
    ,  brand_name_period_table AS (SELECT
                            s.brand_name
                            , s.brand_id
                            /* #, s.channel */
                            , c.calendar_week as period
                            , min(c.date) as period_start_dt
                            , max(c.date) as period_end_dt
                            from ${calendar.SQL_TABLE_NAME} c
                            cross join (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) s
                            group by brand_name, brand_id, calendar_week)
    ,  max_date_by_period AS (select
                              c.brand_name
                              , c.brand_id
                              /* #, c.channel */
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
                              inner join brand_name_period_table c
                              on c.period_start_dt <= max.maxdate
                              where c.period_start_dt >= (SELECT * FROM first_trans))
    ,  max_date_by_period_prev AS (select
                                    max.brand_name
                                    , max.brand_id
                                    /* #, max.channel */
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
                                    inner join brand_name_period_table c
                                    on c.period = fp.prev_period
                                    and c.brand_id = max.brand_id
                                    /* #and c.channel = max.channel */
                                    where c.period_start_dt <= max.maxdate
                                    and c.period_start_dt >= (SELECT * FROM first_trans))

    , max_date_combined AS ( SELECT     max.brand_name,
                                        max.brand_id,
                                        /* channel, */
                                        max.period,
                                        prevmax.prev_period,
                                        max.period_start_dt,
                                        max.ptd_end_dt,
                                        max.period_end_dt,
                                        prevmax.prev_period_start_dt,
                                        prevmax.prev_ptd_end_dt,
                                        max.maxdate,
                                        max.partial_period_flag,
                                        max.latest_period_flag

                            from max_date_by_period max
                            left join max_date_by_period_prev prevmax
                            on max.brand_id = prevmax.brand_id
                            and max.period = prevmax.period
                            /* #and max.channel = prevmax.channel */
                            /* cross join (SELECT "ONLINE" as channel UNION ALL SELECT "OFFLINE/UNKNOWN" as channel) */)





    , current_period_sales AS (  select
                                  max.brand_name
                                  , max.brand_id
                                 /* , max.channel */
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
                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                                  on p.brand_id = max.brand_id
                                  /* and p.channel = max.channel */
                                  and p.trans_date between max.period_start_dt and max.ptd_end_dt
                                  WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                  group by
                                  max.brand_name
                                  , max.brand_id
                                 /* , max.channel */
                                  , max.partial_period_flag
                                  , max.period
                                  , max.period_start_dt
                                  , max.period_end_dt
                                  , max.ptd_end_dt
                                  , max.latest_period_flag)



    select
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , "WEEK" as period_type
                  , "NONE" as merger_type
                  , "CONSTIND" as panel_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.ptd_end_dt
                  , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                  , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                  , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                  , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                  , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                  , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                  , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                  , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                  , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_ptd_end_dt
                  , round(c.trans_count,2) as trans_count
      , round(sum(ifnull(p.trans_count,0)),2) as prev_trans_count
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(ifnull(p.trans_count,0)),0)-1 END as ptd_trans_yoy


      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.gbp_spend_amount,0)),2) END as prev_spend_amount_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(ifnull(p.gbp_spend_amount,0)),0)-1 END as ptd_spend_yoy_gbp
      , round(c.gbp_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.gbp_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_gbp

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.cad_spend_amount,0)),2) END as prev_spend_amount_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.cad_spend_amount/nullif(sum(ifnull(p.cad_spend_amount,0)),0)-1 END as ptd_spend_yoy_cad
      , round(c.cad_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.cad_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_cad

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.usd_spend_amount,0)),2) END as prev_spend_amount_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.usd_spend_amount/nullif(sum(ifnull(p.usd_spend_amount,0)),0)-1 END as ptd_spend_yoy_usd
      , round(c.usd_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.usd_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_usd

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.eur_spend_amount,0)),2) END as prev_spend_amount_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.eur_spend_amount/nullif(sum(ifnull(p.eur_spend_amount,0)),0)-1 END as ptd_spend_yoy_eur
      , round(c.eur_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.eur_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_eur

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.dkk_spend_amount,0)),2) END as prev_spend_amount_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.dkk_spend_amount/nullif(sum(ifnull(p.dkk_spend_amount,0)),0)-1 END as ptd_spend_yoy_dkk
      , round(c.dkk_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.dkk_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_dkk

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.nok_spend_amount,0)),2) END as prev_spend_amount_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.nok_spend_amount/nullif(sum(ifnull(p.nok_spend_amount,0)),0)-1 END as ptd_spend_yoy_nok
      , round(c.nok_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.nok_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_nok

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.jpy_spend_amount,0)),2) END as prev_spend_amount_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.jpy_spend_amount/nullif(sum(ifnull(p.jpy_spend_amount,0)),0)-1 END as ptd_spend_yoy_jpy
      , round(c.jpy_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.jpy_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_jpy

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.sek_spend_amount,0)),2) END as prev_spend_amount_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.sek_spend_amount/nullif(sum(ifnull(p.sek_spend_amount,0)),0)-1 END as ptd_spend_yoy_sek
      , round(c.sek_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.sek_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_sek

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.pln_spend_amount,0)),2) END as prev_spend_amount_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.pln_spend_amount/nullif(sum(ifnull(p.pln_spend_amount,0)),0)-1 END as ptd_spend_yoy_pln
      , round(c.pln_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.pln_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_pln


                  , c.latest_period_flag as latest_period_flag
                  , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
                  , c.period_end_dt
                  from current_period_sales c
                  left join max_date_combined max
                  on max.period = c.period and max.brand_id = c.brand_id /* and max.channel = c.channel */
                  left join (SELECT distinct brand_name, brand_id, "EMAX" as panel_method FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) sd
                  on max.brand_id = sd.brand_id
                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                  on p.brand_id = c.brand_id
                  /* and p.channel = c.channel */
                  and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
                  join oldest_trans o
                    on c.brand_id = o.brand_id
                  group by
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.ptd_end_dt
                  , c.gbp_spend_amount
                  , c.cad_spend_amount
                  , c.usd_spend_amount
                  , c.eur_spend_amount
                  , c.dkk_spend_amount
                  , c.nok_spend_amount
                  , c.jpy_spend_amount
                  , c.sek_spend_amount
                  , c.pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_ptd_end_dt
                  , c.trans_count
                  , c.latest_period_flag
                  , c.period_end_dt
                  , o.min_date

                  ORDER BY brand_name, period)

    ######################################################################
    UNION ALL
    ######################################################################

    (WITH    max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
    ,  oldest_trans AS (SELECT brand_id, min(trans_date) min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  GROUP BY brand_id)
    ,  brand_name_period_table AS (select
                                    s.brand_name
                                    , s.brand_id
                                    /* #, s.channel */
                                    , c.calendar_month as period
                                    , min(c.date) as period_start_dt
                                    , max(c.date) as period_end_dt
                                    from ${calendar.SQL_TABLE_NAME} c
                                    cross join (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) s
                                    group by brand_name, brand_id, calendar_month)
    ,  max_date_by_period AS (select
                              c.brand_name
                              , c.brand_id
                              /* #, c.channel */
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
                              inner join brand_name_period_table c
                              on c.period_start_dt <= max.maxdate
                              where c.period_start_dt >= (SELECT * FROM first_trans))
    ,  max_date_by_period_prev AS (select
                                    max.brand_name
                                    , max.brand_id
                                    /* #, max.channel */
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
                                    inner join brand_name_period_table c
                                    on c.period = fp.prev_period
                                    /* #and c.channel = max.channel */
                                    and c.brand_id = max.brand_id
                                    where c.period_start_dt <= max.maxdate
                                    and c.period_start_dt >= (SELECT * FROM first_trans))

    , max_date_combined AS ( SELECT     max.brand_name,
                                        max.brand_id,
                                        /* channel, */
                                        max.period,
                                        prevmax.prev_period,
                                        max.period_start_dt,
                                        max.ptd_end_dt,
                                        max.period_end_dt,
                                        prevmax.prev_period_start_dt,
                                        prevmax.prev_ptd_end_dt,
                                        max.maxdate,
                                        max.partial_period_flag,
                                        max.latest_period_flag

                            from max_date_by_period max
                            left join max_date_by_period_prev prevmax
                            on max.brand_id = prevmax.brand_id
                            /* #and max.channel = prevmax.channel */
                            and max.period = prevmax.period
                            /* cross join (SELECT "ONLINE" as channel UNION ALL SELECT "OFFLINE/UNKNOWN" as channel) */)





    , current_period_sales AS (  select
                                  max.brand_name
                                  , max.brand_id
                                 /* , max.channel */
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
                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                                  on p.brand_id = max.brand_id
                                  /* and p.channel = max.channel */
                                  and p.trans_date between max.period_start_dt and max.ptd_end_dt
                                  WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                  group by
                                  max.brand_name
                                  , max.brand_id
                                 /* , max.channel */
                                  , max.partial_period_flag
                                  , max.period
                                  , max.period_start_dt
                                  , max.period_end_dt
                                  , max.ptd_end_dt
                                  , max.latest_period_flag)



                select
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , "MONTH" as period_type
                  , "NONE" as merger_type
                  , "CONSTIND" as panel_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.ptd_end_dt
                  , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                  , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                  , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                  , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                  , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                  , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                  , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                  , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                  , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_ptd_end_dt
                  , round(c.trans_count,2) as trans_count
      , round(sum(ifnull(p.trans_count,0)),2) as prev_trans_count
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(ifnull(p.trans_count,0)),0)-1 END as ptd_trans_yoy


      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.gbp_spend_amount,0)),2) END as prev_spend_amount_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(ifnull(p.gbp_spend_amount,0)),0)-1 END as ptd_spend_yoy_gbp
      , round(c.gbp_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.gbp_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_gbp

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.cad_spend_amount,0)),2) END as prev_spend_amount_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.cad_spend_amount/nullif(sum(ifnull(p.cad_spend_amount,0)),0)-1 END as ptd_spend_yoy_cad
      , round(c.cad_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.cad_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_cad

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.usd_spend_amount,0)),2) END as prev_spend_amount_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.usd_spend_amount/nullif(sum(ifnull(p.usd_spend_amount,0)),0)-1 END as ptd_spend_yoy_usd
      , round(c.usd_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.usd_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_usd

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.eur_spend_amount,0)),2) END as prev_spend_amount_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.eur_spend_amount/nullif(sum(ifnull(p.eur_spend_amount,0)),0)-1 END as ptd_spend_yoy_eur
      , round(c.eur_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.eur_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_eur

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.dkk_spend_amount,0)),2) END as prev_spend_amount_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.dkk_spend_amount/nullif(sum(ifnull(p.dkk_spend_amount,0)),0)-1 END as ptd_spend_yoy_dkk
      , round(c.dkk_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.dkk_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_dkk

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.nok_spend_amount,0)),2) END as prev_spend_amount_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.nok_spend_amount/nullif(sum(ifnull(p.nok_spend_amount,0)),0)-1 END as ptd_spend_yoy_nok
      , round(c.nok_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.nok_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_nok

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.jpy_spend_amount,0)),2) END as prev_spend_amount_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.jpy_spend_amount/nullif(sum(ifnull(p.jpy_spend_amount,0)),0)-1 END as ptd_spend_yoy_jpy
      , round(c.jpy_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.jpy_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_jpy

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.sek_spend_amount,0)),2) END as prev_spend_amount_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.sek_spend_amount/nullif(sum(ifnull(p.sek_spend_amount,0)),0)-1 END as ptd_spend_yoy_sek
      , round(c.sek_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.sek_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_sek

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.pln_spend_amount,0)),2) END as prev_spend_amount_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.pln_spend_amount/nullif(sum(ifnull(p.pln_spend_amount,0)),0)-1 END as ptd_spend_yoy_pln
      , round(c.pln_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.pln_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_pln


                  , c.latest_period_flag as latest_period_flag
                  , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
                  , c.period_end_dt
                  from current_period_sales c
                  left join max_date_combined max
                  on max.period = c.period and max.brand_id = c.brand_id /* and max.channel = c.channel */
                  left join (SELECT distinct brand_name, brand_id, "EMAX" as panel_method FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) sd
                  on max.brand_id = sd.brand_id
                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                  on p.brand_id = c.brand_id
                  /* and p.channel = c.channel */
                  and p.trans_date between max.prev_period_start_dt and max.prev_ptd_end_dt
                  join oldest_trans o
                    on c.brand_id = o.brand_id
                  group by
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.ptd_end_dt
                  , c.gbp_spend_amount
                  , c.cad_spend_amount
                  , c.usd_spend_amount
                  , c.eur_spend_amount
                  , c.dkk_spend_amount
                  , c.nok_spend_amount
                  , c.jpy_spend_amount
                  , c.sek_spend_amount
                  , c.pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_ptd_end_dt
                  , c.trans_count
                  , c.latest_period_flag
                  , c.period_end_dt
                  , o.min_date

                  ORDER BY brand_name, period)

    ############################
    UNION ALL
    ############################

 (WITH    max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
           ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
           ,  oldest_trans AS (SELECT brand_id, min(trans_date) min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  GROUP BY brand_id)
          , rolling_cal_base as (
                                   SELECT
                                     "Rolling 7 Days" as period_type
                                     , concat("7 DE ", c.date) as period
                                     , date_sub(c.date, interval 6 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("7 DE ", date_sub(c.date, interval 7 day)) as prev_period
                                     , date_sub(c.date, interval 1+6 day) as prev_start_dt
                                     , date_sub(c.date, interval 1 day) as prev_end_dt
                                     , concat("7 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+6 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt

                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE c.date >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)

                                   UNION ALL

                                   SELECT
                                     "Rolling 35 Days" as period_type
                                     , concat("35 DE ", c.date) as period
                                     , date_sub(c.date, interval 34 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("35 DE ", date_sub(c.date, interval 35 day)) as prev_period
                                     , date_sub(c.date, interval 1+34 day) as prev_start_dt
                                     , date_sub(c.date, interval 1 day) as prev_end_dt
                                     , concat("35 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+34 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE c.date >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)

                                   UNION ALL

                                   SELECT
                                     "Rolling 91 Days" as period_type
                                     , concat("91 DE ", c.date) as period
                                     , date_sub(c.date, interval 90 day) as period_start_dt
                                     , c.date as period_end_dt
                                     , concat("91 DE ", date_sub(c.date, interval 91 day)) as prev_period
                                     , date_sub(c.date, interval 1+90 day) as prev_start_dt
                                     , date_sub(c.date, interval 1 day) as prev_end_dt
                                     , concat("91 DE ", date_sub(c.date, interval 364 day)) as ya_period
                                     , date_sub(c.date, interval 364+90 day) as ya_start_dt
                                     , date_sub(c.date, interval 364 day) as ya_end_dt
                                   FROM `ce-cloud-services.apollo_reference.calendar` c
                                   WHERE c.date >= (SELECT * FROM first_trans)
                                   and c.date <= (SELECT max(maxdate) from max_available_date)
                                )
           ,  symbol_period_table AS (select
                                            s.brand_name
                                            , s.brand_id
                                            /* , channel */
                                            , c.period_type
                                            , period
                                            , period_start_dt
                                            , period_end_dt
                                            , prev_period
                                            , prev_start_dt as prev_period_start_dt
                                            , prev_end_dt as prev_period_end_dt
                                            , ya_period
                                            , ya_start_dt as ya_period_start_dt
                                            , ya_end_dt as ya_period_end_dt
                                            , case
                                              when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                              then 1
                                              else 0 end as partial_period_flag
                                            , case
                                              when max.maxdate between c.period_start_dt and c.period_end_dt
                                              then 1
                                              else 0 end as latest_period_flag

                                        from (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) s
                                        cross join max_available_date max
                                        /* cross join (SELECT "ONLINE" as channel UNION ALL SELECT "OFFLINE/UNKNOWN" as channel) */
                                        cross join (SELECT * FROM rolling_cal_base) c)


      , current_period_sales AS (  select
                                            max.brand_name
                                            , max.brand_id
                                           /* , max.channel */
                                            , max.period_type
                                            , max.period
                                            , max.period_start_dt
                                            , max.period_end_dt
                                            , max.partial_period_flag
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
                                        left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                                            on p.brand_id = max.brand_id
                                            /* and p.channel = max.channel */
                                            and p.trans_date between max.period_start_dt and max.period_end_dt
                                            WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                        group by
                                            max.brand_name
                                            , max.brand_id
                                           /* , max.channel */
                                            , max.period_type
                                            , max.period
                                            , max.partial_period_flag
                                            , max.latest_period_flag
                                            , max.period_start_dt
                                            , max.period_end_dt)



              select
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , c.period_type
                  , "NONE" as merger_type
                  , "CONSTIND" as panel_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt as ptd_end_dt
                  , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                  , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                  , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                  , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                  , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                  , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                  , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                  , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                  , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_period_end_dt as ya_ptd_end_dt
                  , round(c.trans_count,2) as trans_count
      , round(sum(ifnull(p.trans_count,0)),2) as prev_trans_count
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(ifnull(p.trans_count,0)),0)-1 END as ptd_trans_yoy


      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.gbp_spend_amount,0)),2) END as prev_spend_amount_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(ifnull(p.gbp_spend_amount,0)),0)-1 END as ptd_spend_yoy_gbp
      , round(c.gbp_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.gbp_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_gbp

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.cad_spend_amount,0)),2) END as prev_spend_amount_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.cad_spend_amount/nullif(sum(ifnull(p.cad_spend_amount,0)),0)-1 END as ptd_spend_yoy_cad
      , round(c.cad_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.cad_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_cad

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.usd_spend_amount,0)),2) END as prev_spend_amount_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.usd_spend_amount/nullif(sum(ifnull(p.usd_spend_amount,0)),0)-1 END as ptd_spend_yoy_usd
      , round(c.usd_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.usd_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_usd

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.eur_spend_amount,0)),2) END as prev_spend_amount_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.eur_spend_amount/nullif(sum(ifnull(p.eur_spend_amount,0)),0)-1 END as ptd_spend_yoy_eur
      , round(c.eur_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.eur_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_eur

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.dkk_spend_amount,0)),2) END as prev_spend_amount_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.dkk_spend_amount/nullif(sum(ifnull(p.dkk_spend_amount,0)),0)-1 END as ptd_spend_yoy_dkk
      , round(c.dkk_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.dkk_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_dkk

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.nok_spend_amount,0)),2) END as prev_spend_amount_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.nok_spend_amount/nullif(sum(ifnull(p.nok_spend_amount,0)),0)-1 END as ptd_spend_yoy_nok
      , round(c.nok_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.nok_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_nok

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.jpy_spend_amount,0)),2) END as prev_spend_amount_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.jpy_spend_amount/nullif(sum(ifnull(p.jpy_spend_amount,0)),0)-1 END as ptd_spend_yoy_jpy
      , round(c.jpy_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.jpy_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_jpy

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.sek_spend_amount,0)),2) END as prev_spend_amount_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.sek_spend_amount/nullif(sum(ifnull(p.sek_spend_amount,0)),0)-1 END as ptd_spend_yoy_sek
      , round(c.sek_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.sek_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_sek

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.pln_spend_amount,0)),2) END as prev_spend_amount_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.pln_spend_amount/nullif(sum(ifnull(p.pln_spend_amount,0)),0)-1 END as ptd_spend_yoy_pln
      , round(c.pln_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.pln_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_pln


                  , c.latest_period_flag as latest_period_flag
                  , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
                  , c.period_end_dt
              from current_period_sales c
              left join symbol_period_table max
                  on max.period = c.period and max.brand_id = c.brand_id /* and max.channel = c.channel */
              left join (SELECT distinct brand_name, brand_id, "EMAX" as panel_method FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) sd
                  on max.brand_id = sd.brand_id
              left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                  on p.brand_id = c.brand_id
                  /* and p.channel = c.channel */
                  and p.trans_date between max.prev_period_start_dt and max.prev_period_end_dt
              join oldest_trans o
                on c.brand_id = o.brand_id
              group by
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , period_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt
                  , c.gbp_spend_amount
                  , c.cad_spend_amount
                  , c.usd_spend_amount
                  , c.eur_spend_amount
                  , c.dkk_spend_amount
                  , c.nok_spend_amount
                  , c.jpy_spend_amount
                  , c.sek_spend_amount
                  , c.pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_period_end_dt
                  , c.trans_count
                  , c.period_end_dt
                  , c.latest_period_flag
                  , o.min_date

                  ORDER BY brand_name, period)

       ############################
    UNION ALL
    ############################

 (WITH    max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
           ,  first_trans AS (SELECT min(trans_date) FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} )
           ,  oldest_trans AS (SELECT brand_id, min(trans_date) min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  GROUP BY brand_id)
          , rolling_cal_base as ( SELECT
                                     "Discrete 7 Days" as period_type
                                     , concat("7 DE ", end_date) as period
                                     , date_sub(end_date, interval 6 day) as period_start_dt
                                     , end_date as period_end_dt
                                     , concat("7 DE ", date_sub(end_date, interval 7 day)) as prev_period
                                     , date_sub(end_date, interval 7+6 day) as prev_start_dt
                                     , date_sub(end_date, interval 7 day) as prev_end_dt
                                     , concat("7 DE ", date_sub(end_date, interval 364 day)) as ya_period
                                     , date_sub(end_date, interval 364+6 day) as ya_start_dt
                                     , date_sub(end_date, interval 364 day) as ya_end_dt
                                   FROM UNNEST(GENERATE_DATE_ARRAY( (select max(maxdate) from  max_available_date) , (select * from first_trans), INTERVAL -7 day)) as end_date

                                   UNION ALL

                                   SELECT
                                     "Discrete 35 Days" as period_type
                                     , concat("35 DE ", end_date) as period
                                     , date_sub(end_date, interval 34 day) as period_start_dt
                                     , end_date as period_end_dt
                                     , concat("35 DE ", date_sub(end_date, interval 35 day)) as prev_period
                                     , date_sub(end_date, interval 35+34 day) as prev_start_dt
                                     , date_sub(end_date, interval 35 day) as prev_end_dt
                                     , concat("35 DE ", date_sub(end_date, interval 364 day)) as ya_period
                                     , date_sub(end_date, interval 364+34 day) as ya_start_dt
                                     , date_sub(end_date, interval 364 day) as ya_end_dt
                                   FROM UNNEST(GENERATE_DATE_ARRAY( (select max(maxdate) from  max_available_date), (select * from first_trans), INTERVAL -35 day)) as end_date

                                   UNION ALL

                                   SELECT
                                     "Discrete 91 Days" as period_type
                                     , concat("91 DE ", end_date) as period
                                     , date_sub(end_date, interval 90 day) as period_start_dt
                                     , end_date as period_end_dt
                                     , concat("91 DE ", date_sub(end_date, interval 91 day)) as prev_period
                                     , date_sub(end_date, interval 91+90 day) as prev_start_dt
                                     , date_sub(end_date, interval 91 day) as prev_end_dt
                                     , concat("91 DE ", date_sub(end_date, interval 364 day)) as ya_period
                                     , date_sub(end_date, interval 364+90 day) as ya_start_dt
                                     , date_sub(end_date, interval 364 day) as ya_end_dt
                                   FROM UNNEST(GENERATE_DATE_ARRAY( (select max(maxdate) from  max_available_date) , (select * from first_trans), INTERVAL -91 day)) as end_date

                                  UNION ALL

                                   SELECT
                                     "Discrete 182 Days" as period_type
                                      , concat("182 DE ", end_date) as period
                                      , date_sub(end_date, interval 181 day) as period_start_dt
                                      , end_date as period_end_dt
                                      , concat("182 DE ", date_sub(end_date, interval 182 day)) as prev_period
                                      , date_sub(end_date, interval 182+181 day) as prev_start_dt
                                      , date_sub(end_date, interval 182 day) as prev_end_dt
                                      , concat("182 DE ", date_sub(end_date, interval 364 day)) as ya_period
                                      , date_sub(end_date, interval 364+181 day) as ya_start_dt
                                      , date_sub(end_date, interval 364 day) as ya_end_dt
                                   FROM UNNEST(GENERATE_DATE_ARRAY( (select max(maxdate) from  max_available_date) , (select * from first_trans), INTERVAL -182 DAY)) as end_date

                                   UNION ALL

                                   SELECT
                                     "Discrete 364 Days" as period_type
                                     , concat("364 DE ", end_date) as period
                                     , date_sub(end_date, interval 364-1 day) as period_start_dt
                                     , end_date as period_end_dt
                                     , concat("364 DE ", date_sub(end_date, interval 364 day)) as prev_period
                                     , date_sub(end_date, interval 364+363 day) as prev_start_dt
                                     , date_sub(end_date, interval 364 day) as prev_end_dt
                                     , concat("364 DE ", date_sub(end_date, interval 364 day)) as ya_period
                                     , date_sub(end_date, interval 364+363 day) as ya_start_dt
                                     , date_sub(end_date, interval 364 day) as ya_end_dt
                                   FROM UNNEST(GENERATE_DATE_ARRAY( (select max(maxdate) from  max_available_date) , (select * from first_trans), INTERVAL -364 DAY)) as end_date
                                )
           ,  symbol_period_table AS (select
                                            s.brand_name
                                            , s.brand_id
                                            /* , channel */
                                            , c.period_type
                                            , period
                                            , period_start_dt
                                            , period_end_dt
                                            , prev_period
                                            , prev_start_dt as prev_period_start_dt
                                            , prev_end_dt as prev_period_end_dt
                                            , ya_period
                                            , ya_start_dt as ya_period_start_dt
                                            , ya_end_dt as ya_period_end_dt
                                            , case
                                              when max.maxdate between c.period_start_dt and date_sub(c.period_end_dt, interval 1 day)
                                              then 1
                                              else 0 end as partial_period_flag
                                            , case
                                              when max.maxdate between c.period_start_dt and c.period_end_dt
                                              then 1
                                              else 0 end as latest_period_flag

                                        from (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) s
                                        cross join max_available_date max
                                        /* cross join (SELECT "ONLINE" as channel UNION ALL SELECT "OFFLINE/UNKNOWN" as channel) */
                                        cross join (SELECT * FROM rolling_cal_base) c)


      , current_period_sales AS (  select
                                            max.brand_name
                                            , max.brand_id
                                           /* , max.channel */
                                            , max.period_type
                                            , max.period
                                            , max.period_start_dt
                                            , max.period_end_dt
                                            , max.partial_period_flag
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
                                        left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                                            on p.brand_id = max.brand_id
                                            /* and p.channel = max.channel */
                                            and p.trans_date between max.period_start_dt and max.period_end_dt
                                            WHERE max.period_start_dt >= (SELECT * FROM first_trans)
                                        group by
                                            max.brand_name
                                            , max.brand_id
                                           /* , max.channel */
                                            , max.period_type
                                            , max.period
                                            , max.partial_period_flag
                                            , max.latest_period_flag
                                            , max.period_start_dt
                                            , max.period_end_dt)



              select
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , c.period_type
                  , "NONE" as merger_type
                  , "CONSTIND" as panel_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt as ptd_end_dt
                  , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                  , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                  , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                  , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                  , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                  , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                  , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                  , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                  , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_period_end_dt as ya_ptd_end_dt
                  , round(c.trans_count,2) as trans_count
      , round(sum(ifnull(p.trans_count,0)),2) as prev_trans_count
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.trans_count/nullif(sum(ifnull(p.trans_count,0)),0)-1 END as ptd_trans_yoy


      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.gbp_spend_amount,0)),2) END as prev_spend_amount_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.gbp_spend_amount/nullif(sum(ifnull(p.gbp_spend_amount,0)),0)-1 END as ptd_spend_yoy_gbp
      , round(c.gbp_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_gbp
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.gbp_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.gbp_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_gbp

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.cad_spend_amount,0)),2) END as prev_spend_amount_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.cad_spend_amount/nullif(sum(ifnull(p.cad_spend_amount,0)),0)-1 END as ptd_spend_yoy_cad
      , round(c.cad_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_cad
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.cad_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.cad_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_cad

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.usd_spend_amount,0)),2) END as prev_spend_amount_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.usd_spend_amount/nullif(sum(ifnull(p.usd_spend_amount,0)),0)-1 END as ptd_spend_yoy_usd
      , round(c.usd_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_usd
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.usd_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.usd_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_usd

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.eur_spend_amount,0)),2) END as prev_spend_amount_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.eur_spend_amount/nullif(sum(ifnull(p.eur_spend_amount,0)),0)-1 END as ptd_spend_yoy_eur
      , round(c.eur_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_eur
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.eur_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.eur_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_eur

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.dkk_spend_amount,0)),2) END as prev_spend_amount_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.dkk_spend_amount/nullif(sum(ifnull(p.dkk_spend_amount,0)),0)-1 END as ptd_spend_yoy_dkk
      , round(c.dkk_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_dkk
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.dkk_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.dkk_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_dkk

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.nok_spend_amount,0)),2) END as prev_spend_amount_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.nok_spend_amount/nullif(sum(ifnull(p.nok_spend_amount,0)),0)-1 END as ptd_spend_yoy_nok
      , round(c.nok_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_nok
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.nok_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.nok_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_nok

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.jpy_spend_amount,0)),2) END as prev_spend_amount_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.jpy_spend_amount/nullif(sum(ifnull(p.jpy_spend_amount,0)),0)-1 END as ptd_spend_yoy_jpy
      , round(c.jpy_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_jpy
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.jpy_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.jpy_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_jpy

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.sek_spend_amount,0)),2) END as prev_spend_amount_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.sek_spend_amount/nullif(sum(ifnull(p.sek_spend_amount,0)),0)-1 END as ptd_spend_yoy_sek
      , round(c.sek_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_sek
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.sek_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.sek_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_sek

      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(ifnull(p.pln_spend_amount,0)),2) END as prev_spend_amount_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN c.pln_spend_amount/nullif(sum(ifnull(p.pln_spend_amount,0)),0)-1 END as ptd_spend_yoy_pln
      , round(c.pln_spend_amount/nullif(c.trans_count,0),2) as avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2) END as prev_avg_tkt_pln
      , CASE WHEN max.prev_period_start_dt >= o.min_date THEN round(c.pln_spend_amount/nullif(c.trans_count,0),2)/nullif(round(sum(p.pln_spend_amount)/nullif(sum(ifnull(p.trans_count,0)),0),2),0)-1
          END as ptd_avg_tkt_yoy_pln


                  , c.latest_period_flag as latest_period_flag
                  , date_diff(c.period_end_dt, c.period_start_dt, day)+1 as period_day
                  , c.period_end_dt
              from current_period_sales c
              left join symbol_period_table max
                  on max.period = c.period and max.brand_id = c.brand_id /* and max.channel = c.channel */
              left join (SELECT distinct brand_name, brand_id, "EMAX" as panel_method FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} ) sd
                  on max.brand_id = sd.brand_id
              left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME}  p
                  on p.brand_id = c.brand_id
                  /* and p.channel = c.channel */
                  and p.trans_date between max.prev_period_start_dt and max.prev_period_end_dt
              join oldest_trans o
                on c.brand_id = o.brand_id
              group by
                  c.brand_name
                  , c.brand_id
                 /*  , c.channel */
                  , c.partial_period_flag
                  , period_type
                  , sd.panel_method
                  , c.period
                  , c.period_start_dt
                  , c.period_end_dt
                  , c.gbp_spend_amount
                  , c.cad_spend_amount
                  , c.usd_spend_amount
                  , c.eur_spend_amount
                  , c.dkk_spend_amount
                  , c.nok_spend_amount
                  , c.jpy_spend_amount
                  , c.sek_spend_amount
                  , c.pln_spend_amount
                  , max.prev_period
                  , max.prev_period_start_dt
                  , max.prev_period_end_dt
                  , c.trans_count
                  , c.period_end_dt
                  , c.latest_period_flag
                  , o.min_date

                  ORDER BY brand_name, period)
    ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }

    dimension: brand_name {
      type: string
      sql: ${TABLE}.brand_name ;;
    }

  }
