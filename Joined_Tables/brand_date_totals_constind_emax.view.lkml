view: brand_date_totals_constind_emax {
  derived_table: {
    sql:

          (WITH
              panel_min_max_date as (
              SELECT
                min(trans_date) as first_trans
                , max(trans_date) as last_trans
              FROM ${dist_day_brand_emax_currency.SQL_TABLE_NAME}
             ),
             max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_emax_currency.SQL_TABLE_NAME}),
              min_trans_date AS (SELEcT brand_id, min(TRANS_DATE) as min_date FROM ${dist_day_brand_emax_currency.SQL_TABLE_NAME} GROUP BY brand_id),
              rolling_cal_base as (
                  SELECT
                    "Discrete 7 Days" as period_type
                    , concat("7 DE ", last_trans) as period
                    , concat("7 DE ", date_sub(last_trans, interval 7 day)) as prev_period
                    , concat("7 DE ", date_sub(last_trans, interval 7+7 day)) as two_prev_period
                    , date_sub(last_trans, interval 6 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 7+6 day) as prev_start_date
                    , date_sub(last_trans, interval 7 day) as prev_end_date
                    , date_sub(last_trans, interval 364+6 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 7+7+6 day) as two_prev_start_date
                    , date_sub(last_trans, interval 7+7 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+7*2+6 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+7*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 7*3+6 day) as three_prev_start_date
                    , date_sub(last_trans, interval 7*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364+ 7*3+6 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 7*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 7*4+6 day) as four_prev_start_date
                    , date_sub(last_trans, interval 7*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364+ 7+6 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 7 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 35 Days" as period_type
                    , concat("35 DE ", last_trans) as period
                    , concat("35 DE ", date_sub(last_trans, interval 35 day)) as prev_period
                    , concat("35 DE ", date_sub(last_trans, interval 35+35 day)) as two_prev_period
                    , date_sub(last_trans, interval 34 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 35+34 day) as prev_start_date
                    , date_sub(last_trans, interval 35 day) as prev_end_date
                    , date_sub(last_trans, interval 364+34 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 35+35+34 day) as two_prev_start_date
                    , date_sub(last_trans, interval 35+35 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+35*2+34 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+35*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 35*3+34 day) as three_prev_start_date
                    , date_sub(last_trans, interval 35*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364+ 35*3+34 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 35*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 35*4+34 day) as four_prev_start_date
                    , date_sub(last_trans, interval 35*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364 + 35+34 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 35 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 91 Days" as period_type
                    , concat("91 DE ", last_trans) as period
                    , concat("91 DE ", date_sub(last_trans, interval 91 day)) as prev_period
                    , concat("91 DE ", date_sub(last_trans, interval 91+91 day)) as two_prev_period
                    , date_sub(last_trans, interval 90 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 91+90 day) as prev_start_date
                    , date_sub(last_trans, interval 91 day) as prev_end_date
                    , date_sub(last_trans, interval 364+90 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 91+91+90 day) as two_prev_start_date
                    , date_sub(last_trans, interval 91+91 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+91*2+90 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+91*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 91*3+90 day) as three_prev_start_date
                    , date_sub(last_trans, interval 91*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364 + 91*3+90 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 91*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 91*4+90 day) as four_prev_start_date
                    , date_sub(last_trans, interval 91*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364 + 91+90 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 91 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 182 Days" as period_type
                     , concat("182 DE ", last_trans) as period
                    , concat("182 DE ", date_sub(last_trans, interval 182 day)) as prev_period
                    , concat("182 DE ", date_sub(last_trans, interval 182+182 day)) as two_prev_period
                     , date_sub(last_trans, interval 181 day) as start_date
                     , last_trans as end_date
                     , date_sub(last_trans, interval 182+181 day) as prev_start_date
                     , date_sub(last_trans, interval 182 day) as prev_end_date
                     , date_sub(last_trans, interval 364+181 day) as ya_start_date
                     , date_sub(last_trans, interval 364 day) as ya_end_date
                     , date_sub(last_trans, interval 182+182+181 day) as two_prev_start_date
                     , date_sub(last_trans, interval 182+182 day) as two_prev_end_date
                     , date_sub(last_trans, interval 364+182*2+181 day) as two_prev_ya_start_date
                     , date_sub(last_trans, interval 364+182*2 day) as two_prev_ya_end_date
                     , date_sub(last_trans, interval 182*3+181 day) as three_prev_start_date
                     , date_sub(last_trans, interval 182*3 day) as three_prev_end_date
                     , date_sub(last_trans, interval 364+ 182*3+181 day) as three_prev_ya_start_date
                     , date_sub(last_trans, interval 364 + 182*3 day) as three_prev_ya_end_date
                     , date_sub(last_trans, interval 182*4+181 day) as four_prev_start_date
                     , date_sub(last_trans, interval 182*4 day) as four_prev_end_date
                     , date_sub(last_trans, interval 364 + 182+181 day) as prev_ya_start_date
                     , date_sub(last_trans, interval 364 + 182 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 364 Days" as period_type
                    , concat("364 DE ", last_trans) as period
                    , concat("364 DE ", date_sub(last_trans, interval 364 day)) as prev_period
                    , concat("364 DE ", date_sub(last_trans, interval 364+364 day)) as two_prev_period
                    , date_sub(last_trans, interval 364-1 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 364+363 day) as prev_start_date
                    , date_sub(last_trans, interval 364 day) as prev_end_date
                    , date_sub(last_trans, interval 364+363 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 364+364+363 day) as two_prev_start_date
                    , date_sub(last_trans, interval 364+364 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+364*2+363 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+364*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 364*3+363 day) as three_prev_start_date
                    , date_sub(last_trans, interval 364*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364 + 364*3+363 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364+ 364*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 364*4+363 day) as four_prev_start_date
                    , date_sub(last_trans, interval 364*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364*2+363 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 364 day) as prev_ya_end_date
                  FROM panel_min_max_date
                  )

                  ,  brand_period_table AS (select
                                                      s.brand_name
                                                      , s. brand_id
                                                      , c.period_type
                                                      , period
                                                      , prev_period
                                                      , two_prev_period
                                                      , start_date
                                                      , end_date
                                                      , prev_start_date
                                                      , prev_end_date
                                                      , ya_start_date
                                                      , ya_end_date
                                                      , two_prev_start_date
                                                      , two_prev_end_date
                                                      , two_prev_ya_start_date
                                                      , two_prev_ya_end_date
                                                      , three_prev_start_date
                                                      , three_prev_end_date
                                                      , three_prev_ya_start_date
                                                      , three_prev_ya_end_date
                                                      , four_prev_start_date
                                                      , four_prev_end_date
                                                      , prev_ya_start_date
                                                      , prev_ya_end_date
                                                      , case
                                                        when max.maxdate between c.start_date and date_sub(c.end_date, interval 1 day)
                                                        then 1
                                                        else 0 end as partial_period_flag
                                                      , case
                                                        when max.maxdate between c.start_date and c.end_date
                                                        then 1
                                                        else 0 end as latest_period_flag

                                                  from (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_emax_currency.SQL_TABLE_NAME}) s
                                                  cross join max_available_date max
                                                  cross join (SELECT * FROM rolling_cal_base) c)


                , current_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_period
                                                      , max.two_prev_period
                                                      , max.start_date
                                                      , max.end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.start_date and max.end_date
                                                 join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_period
                                                      , max.two_prev_period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.start_date
                                                      , max.end_date)
                   , ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.ya_start_date
                                                      , max.ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.ya_start_date and max.ya_end_date
                                                   join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.ya_start_date
                                                      , max.ya_end_date)
                    , two_ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_ya_start_date
                                                      , max.prev_ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.prev_ya_start_date and max.prev_ya_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.prev_ya_start_date
                                                      , max.prev_ya_end_date)
                    , three_ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.two_prev_ya_start_date
                                                      , max.two_prev_ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.two_prev_ya_start_date and max.two_prev_ya_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.two_prev_ya_start_date
                                                      , max.two_prev_ya_end_date)
                  , prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_start_date
                                                      , max.prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.prev_start_date and max.prev_end_date
                                                   join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.prev_start_date
                                                      , max.prev_end_date)
                    , two_prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.two_prev_start_date
                                                      , max.two_prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.two_prev_start_date and max.two_prev_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.two_prev_start_date
                                                      , max.two_prev_end_date)
                    , three_prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.three_prev_start_date
                                                      , max.three_prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_emax_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.three_prev_start_date and max.three_prev_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.three_prev_start_date
                                                      , max.three_prev_end_date)



                        select
                            c.brand_name
                            , c.brand_id
                            , industry.industry_name
                            , industry.subindustry_name
                            , c.partial_period_flag
                            , c.period_type
                            , "NONE" as merger_type
                            , "EMAX" as panel_type
                            , c.period
                            , c.prev_period
                            , c.two_prev_period
                            , c.start_date
                            , c.end_date as ptd_end_date
                             , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                                      , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                                      , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                                      , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                                      , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                                      , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                                      , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                                      , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                                      , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                            , max.ya_start_date
                            , max.ya_end_date as ya_ptd_end_date
                            , max.two_prev_ya_start_date
                            , max.two_prev_ya_end_date
                            , max.three_prev_ya_start_date
                            , max.three_prev_ya_end_date

                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.gbp_spend_amount,2) END as ya_spend_amount_gbp
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.gbp_spend_amount/nullif(y.gbp_spend_amount,0)-1 END as ptd_spend_yoy_gbp
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.gbp_spend_amount,2) END as two_ya_spend_amount_gbp
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.gbp_spend_amount/nullif(ty.gbp_spend_amount,0)-1 END as two_ptd_spend_yoy_gbp
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.gbp_spend_amount,2) END as three_ya_spend_amount_gbp
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.gbp_spend_amount/nullif(thy.gbp_spend_amount,0)-1 END as three_ptd_spend_yoy_gbp

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.gbp_spend_amount,2) END as prev_spend_amount_gbp
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.gbp_spend_amount/nullif(p.gbp_spend_amount,0)-1 END as ptd_spend_seq_gbp
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.gbp_spend_amount,2) END as two_prev_spend_amount_gbp
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.gbp_spend_amount/nullif(tp.gbp_spend_amount,0)-1 END as two_ptd_spend_seq_gbp
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.gbp_spend_amount,2) END as three_prev_spend_amount_gbp
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.gbp_spend_amount/nullif(thp.gbp_spend_amount,0)-1 END as three_ptd_spend_seq_gbp


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.cad_spend_amount,2) END as ya_spend_amount_cad
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.cad_spend_amount/nullif(y.cad_spend_amount,0)-1 END as ptd_spend_yoy_cad
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.cad_spend_amount,2) END as two_ya_spend_amount_cad
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.cad_spend_amount/nullif(ty.cad_spend_amount,0)-1 END as two_ptd_spend_yoy_cad
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.cad_spend_amount,2) END as three_ya_spend_amount_cad
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.cad_spend_amount/nullif(thy.cad_spend_amount,0)-1 END as three_ptd_spend_yoy_cad

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.cad_spend_amount,2) END as prev_spend_amount_cad
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.cad_spend_amount/nullif(p.cad_spend_amount,0)-1 END as ptd_spend_seq_cad
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.cad_spend_amount,2) END as two_prev_spend_amount_cad
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.cad_spend_amount/nullif(tp.cad_spend_amount,0)-1 END as two_ptd_spend_seq_cad
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.cad_spend_amount,2) END as three_prev_spend_amount_cad
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.cad_spend_amount/nullif(thp.cad_spend_amount,0)-1 END as three_ptd_spend_seq_cad


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.usd_spend_amount,2) END as ya_spend_amount_usd
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.usd_spend_amount/nullif(y.usd_spend_amount,0)-1 END as ptd_spend_yoy_usd
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.usd_spend_amount,2) END as two_ya_spend_amount_usd
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.usd_spend_amount/nullif(ty.usd_spend_amount,0)-1 END as two_ptd_spend_yoy_usd
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.usd_spend_amount,2) END as three_ya_spend_amount_usd
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.usd_spend_amount/nullif(thy.usd_spend_amount,0)-1 END as three_ptd_spend_yoy_usd

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.usd_spend_amount,2) END as prev_spend_amount_usd
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.usd_spend_amount/nullif(p.usd_spend_amount,0)-1 END as ptd_spend_seq_usd
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.usd_spend_amount,2) END as two_prev_spend_amount_usd
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.usd_spend_amount/nullif(tp.usd_spend_amount,0)-1 END as two_ptd_spend_seq_usd
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.usd_spend_amount,2) END as three_prev_spend_amount_usd
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.usd_spend_amount/nullif(thp.usd_spend_amount,0)-1 END as three_ptd_spend_seq_usd


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.eur_spend_amount,2) END as ya_spend_amount_eur
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.eur_spend_amount/nullif(y.eur_spend_amount,0)-1 END as ptd_spend_yoy_eur
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.eur_spend_amount,2) END as two_ya_spend_amount_eur
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.eur_spend_amount/nullif(ty.eur_spend_amount,0)-1 END as two_ptd_spend_yoy_eur
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.eur_spend_amount,2) END as three_ya_spend_amount_eur
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.eur_spend_amount/nullif(thy.eur_spend_amount,0)-1 END as three_ptd_spend_yoy_eur

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.eur_spend_amount,2) END as prev_spend_amount_eur
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.eur_spend_amount/nullif(p.eur_spend_amount,0)-1 END as ptd_spend_seq_eur
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.eur_spend_amount,2) END as two_prev_spend_amount_eur
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.eur_spend_amount/nullif(tp.eur_spend_amount,0)-1 END as two_ptd_spend_seq_eur
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.eur_spend_amount,2) END as three_prev_spend_amount_eur
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.eur_spend_amount/nullif(thp.eur_spend_amount,0)-1 END as three_ptd_spend_seq_eur


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.dkk_spend_amount,2) END as ya_spend_amount_dkk
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.dkk_spend_amount/nullif(y.dkk_spend_amount,0)-1 END as ptd_spend_yoy_dkk
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.dkk_spend_amount,2) END as two_ya_spend_amount_dkk
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.dkk_spend_amount/nullif(ty.dkk_spend_amount,0)-1 END as two_ptd_spend_yoy_dkk
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.dkk_spend_amount,2) END as three_ya_spend_amount_dkk
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.dkk_spend_amount/nullif(thy.dkk_spend_amount,0)-1 END as three_ptd_spend_yoy_dkk

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.dkk_spend_amount,2) END as prev_spend_amount_dkk
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.dkk_spend_amount/nullif(p.dkk_spend_amount,0)-1 END as ptd_spend_seq_dkk
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.dkk_spend_amount,2) END as two_prev_spend_amount_dkk
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.dkk_spend_amount/nullif(tp.dkk_spend_amount,0)-1 END as two_ptd_spend_seq_dkk
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.dkk_spend_amount,2) END as three_prev_spend_amount_dkk
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.dkk_spend_amount/nullif(thp.dkk_spend_amount,0)-1 END as three_ptd_spend_seq_dkk


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.nok_spend_amount,2) END as ya_spend_amount_nok
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.nok_spend_amount/nullif(y.nok_spend_amount,0)-1 END as ptd_spend_yoy_nok
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.nok_spend_amount,2) END as two_ya_spend_amount_nok
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.nok_spend_amount/nullif(ty.nok_spend_amount,0)-1 END as two_ptd_spend_yoy_nok
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.nok_spend_amount,2) END as three_ya_spend_amount_nok
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.nok_spend_amount/nullif(thy.nok_spend_amount,0)-1 END as three_ptd_spend_yoy_nok

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.nok_spend_amount,2) END as prev_spend_amount_nok
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.nok_spend_amount/nullif(p.nok_spend_amount,0)-1 END as ptd_spend_seq_nok
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.nok_spend_amount,2) END as two_prev_spend_amount_nok
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.nok_spend_amount/nullif(tp.nok_spend_amount,0)-1 END as two_ptd_spend_seq_nok
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.nok_spend_amount,2) END as three_prev_spend_amount_nok
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.nok_spend_amount/nullif(thp.nok_spend_amount,0)-1 END as three_ptd_spend_seq_nok


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.jpy_spend_amount,2) END as ya_spend_amount_jpy
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.jpy_spend_amount/nullif(y.jpy_spend_amount,0)-1 END as ptd_spend_yoy_jpy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.jpy_spend_amount,2) END as two_ya_spend_amount_jpy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.jpy_spend_amount/nullif(ty.jpy_spend_amount,0)-1 END as two_ptd_spend_yoy_jpy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.jpy_spend_amount,2) END as three_ya_spend_amount_jpy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.jpy_spend_amount/nullif(thy.jpy_spend_amount,0)-1 END as three_ptd_spend_yoy_jpy

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.jpy_spend_amount,2) END as prev_spend_amount_jpy
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.jpy_spend_amount/nullif(p.jpy_spend_amount,0)-1 END as ptd_spend_seq_jpy
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.jpy_spend_amount,2) END as two_prev_spend_amount_jpy
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.jpy_spend_amount/nullif(tp.jpy_spend_amount,0)-1 END as two_ptd_spend_seq_jpy
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.jpy_spend_amount,2) END as three_prev_spend_amount_jpy
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.jpy_spend_amount/nullif(thp.jpy_spend_amount,0)-1 END as three_ptd_spend_seq_jpy


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.sek_spend_amount,2) END as ya_spend_amount_sek
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.sek_spend_amount/nullif(y.sek_spend_amount,0)-1 END as ptd_spend_yoy_sek
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.sek_spend_amount,2) END as two_ya_spend_amount_sek
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.sek_spend_amount/nullif(ty.sek_spend_amount,0)-1 END as two_ptd_spend_yoy_sek
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.sek_spend_amount,2) END as three_ya_spend_amount_sek
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.sek_spend_amount/nullif(thy.sek_spend_amount,0)-1 END as three_ptd_spend_yoy_sek

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.sek_spend_amount,2) END as prev_spend_amount_sek
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.sek_spend_amount/nullif(p.sek_spend_amount,0)-1 END as ptd_spend_seq_sek
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.sek_spend_amount,2) END as two_prev_spend_amount_sek
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.sek_spend_amount/nullif(tp.sek_spend_amount,0)-1 END as two_ptd_spend_seq_sek
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.sek_spend_amount,2) END as three_prev_spend_amount_sek
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.sek_spend_amount/nullif(thp.sek_spend_amount,0)-1 END as three_ptd_spend_seq_sek


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.pln_spend_amount,2) END as ya_spend_amount_pln
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.pln_spend_amount/nullif(y.pln_spend_amount,0)-1 END as ptd_spend_yoy_pln
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.pln_spend_amount,2) END as two_ya_spend_amount_pln
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.pln_spend_amount/nullif(ty.pln_spend_amount,0)-1 END as two_ptd_spend_yoy_pln
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.pln_spend_amount,2) END as three_ya_spend_amount_pln
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.pln_spend_amount/nullif(thy.pln_spend_amount,0)-1 END as three_ptd_spend_yoy_pln

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.pln_spend_amount,2) END as prev_spend_amount_pln
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.pln_spend_amount/nullif(p.pln_spend_amount,0)-1 END as ptd_spend_seq_pln
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.pln_spend_amount,2) END as two_prev_spend_amount_pln
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.pln_spend_amount/nullif(tp.pln_spend_amount,0)-1 END as two_ptd_spend_seq_pln
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.pln_spend_amount,2) END as three_prev_spend_amount_pln
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.pln_spend_amount/nullif(thp.pln_spend_amount,0)-1 END as three_ptd_spend_seq_pln








                            , round(c.trans_count,2) as trans_count
                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.trans_count,2) END as ya_trans_count
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.trans_count/nullif(y.trans_count,0)-1 END as ptd_trans_yoy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.trans_count,2) END as two_ya_trans_count
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.trans_count/nullif(ty.trans_count,0)-1 END as two_ptd_trans_yoy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.trans_count,2) END as three_ya_trans_count
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.trans_count/nullif(thy.trans_count,0)-1 END as three_ptd_trans_yoy

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.trans_count,2) END as prev_trans_count
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.trans_count/nullif(p.trans_count,0)-1 END as ptd_trans_seq
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.trans_count,2) END as two_prev_trans_count
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.trans_count/nullif(tp.trans_count,0)-1 END as two_ptd_trans_seq
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.trans_count,2) END as three_prev_trans_count
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.trans_count/nullif(thp.trans_count,0)-1 END as three_ptd_trans_seq
                            , c.latest_period_flag as latest_period_flag
                            , date_diff(c.end_date, c.start_date, day)+1 as period_day
                            , c.end_date
                        from current_period_sales c
                        left join brand_period_table max
                            on max.period = c.period and max.brand_id = c.brand_id
                        left join ya_period_sales y
                            on y.brand_id = c.brand_id
                            and y.period = c.period
                        left join two_ya_period_sales ty
                            on ty.brand_id = c.brand_id
                            and ty.period = c.period
                        left join three_ya_period_sales thy
                            on thy.brand_id = c.brand_id
                            and thy.period = c.period
                        left join prev_period_sales p
                            on p.brand_id = c.brand_id
                            and p.period = c.period
                        left join two_prev_period_sales tp
                            on tp.brand_id = c.brand_id
                            and tp.period = c.period
                        left join three_prev_period_sales thp
                            on thp.brand_id = c.brand_id
                            and thp.period = c.period
                        join min_trans_date o
                            on c.brand_id = o.brand_id
                        join (select distinct brand_id, subindustry_id from `ce-cloud-services.ce_transact_ground_truth.brand`) brand
                        on max.brand_id = brand.brand_id
                        join (select distinct subindustry_id, industry_name, subindustry_name from `ce-cloud-services.ce_transact_ground_truth.industry_list`) industry
                        on brand.subindustry_id = industry.subindustry_id
                        group by
                            c.brand_name
                            , c.brand_id
                            , industry.industry_name
                            , industry.subindustry_name
                            , c.partial_period_flag
                            , period_type
                            , c.period
                            , c.prev_period
                            , c.two_prev_period
                            , c.start_date
                            , c.end_date
                            , c.gbp_spend_amount
                            , c.cad_spend_amount
                            , c.usd_spend_amount
                            , c.eur_spend_amount
                            , c.dkk_spend_amount
                            , c.nok_spend_amount
                            , c.jpy_spend_amount
                            , c.sek_spend_amount
                            , c.pln_spend_amount
                            , y.gbp_spend_amount
                            , y.cad_spend_amount
                            , y.usd_spend_amount
                            , y.eur_spend_amount
                            , y.dkk_spend_amount
                            , y.nok_spend_amount
                            , y.jpy_spend_amount
                            , y.sek_spend_amount
                            , y.pln_spend_amount
                            , y.trans_count
                            , ty.gbp_spend_amount
                            , ty.cad_spend_amount
                            , ty.usd_spend_amount
                            , ty.eur_spend_amount
                            , ty.dkk_spend_amount
                            , ty.nok_spend_amount
                            , ty.jpy_spend_amount
                            , ty.sek_spend_amount
                            , ty.pln_spend_amount
                            , ty.trans_count
                            , thy.gbp_spend_amount
                            , thy.cad_spend_amount
                            , thy.usd_spend_amount
                            , thy.eur_spend_amount
                            , thy.dkk_spend_amount
                            , thy.nok_spend_amount
                            , thy.jpy_spend_amount
                            , thy.sek_spend_amount
                            , thy.pln_spend_amount
                            , thy.trans_count
                            , p.gbp_spend_amount
                            , p.cad_spend_amount
                            , p.usd_spend_amount
                            , p.eur_spend_amount
                            , p.dkk_spend_amount
                            , p.nok_spend_amount
                            , p.jpy_spend_amount
                            , p.sek_spend_amount
                            , p.pln_spend_amount
                            , p.trans_count
                            , tp.gbp_spend_amount
                            , tp.cad_spend_amount
                            , tp.usd_spend_amount
                            , tp.eur_spend_amount
                            , tp.dkk_spend_amount
                            , tp.nok_spend_amount
                            , tp.jpy_spend_amount
                            , tp.sek_spend_amount
                            , tp.pln_spend_amount
                            , tp.trans_count
                            , thp.gbp_spend_amount
                            , thp.cad_spend_amount
                            , thp.usd_spend_amount
                            , thp.eur_spend_amount
                            , thp.dkk_spend_amount
                            , thp.nok_spend_amount
                            , thp.jpy_spend_amount
                            , thp.sek_spend_amount
                            , thp.pln_spend_amount
                            , thp.trans_count
                            , max.ya_start_date
                            , max.ya_end_date
                            , max.prev_ya_start_date
                            , max.prev_ya_end_date
                            , max.two_prev_ya_start_date
                            , max.two_prev_ya_end_date
                            , max.three_prev_ya_start_date
                            , max.three_prev_ya_end_date
                            , max.prev_start_date
                            , max.prev_end_date
                            , max.two_prev_start_date
                            , max.two_prev_end_date
                            , max.three_prev_start_date
                            , max.three_prev_end_date
                            , c.trans_count
                            , c.end_date
                            , c.latest_period_flag
                            , o.min_date

                            ORDER BY brand_name, period)


      #####################################
                            UNION ALL
                           #####################################

          (WITH
              panel_min_max_date as (
              SELECT
                min(trans_date) as first_trans
                , max(trans_date) as last_trans
              FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}
             ),
             max_available_date AS (select max(trans_date) as maxdate from ${dist_day_brand_constind_currency.SQL_TABLE_NAME}),
              min_trans_date AS (SELEcT brand_id, min(TRANS_DATE) as min_date FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME} GROUP BY brand_id),
              rolling_cal_base as (
                  SELECT
                    "Discrete 7 Days" as period_type
                    , concat("7 DE ", last_trans) as period
                    , concat("7 DE ", date_sub(last_trans, interval 7 day)) as prev_period
                    , concat("7 DE ", date_sub(last_trans, interval 7+7 day)) as two_prev_period
                    , date_sub(last_trans, interval 6 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 7+6 day) as prev_start_date
                    , date_sub(last_trans, interval 7 day) as prev_end_date
                    , date_sub(last_trans, interval 364+6 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 7+7+6 day) as two_prev_start_date
                    , date_sub(last_trans, interval 7+7 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+7*2+6 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+7*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 7*3+6 day) as three_prev_start_date
                    , date_sub(last_trans, interval 7*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364+ 7*3+6 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 7*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 7*4+6 day) as four_prev_start_date
                    , date_sub(last_trans, interval 7*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364+ 7+6 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 7 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 35 Days" as period_type
                    , concat("35 DE ", last_trans) as period
                    , concat("35 DE ", date_sub(last_trans, interval 35 day)) as prev_period
                    , concat("35 DE ", date_sub(last_trans, interval 35+35 day)) as two_prev_period
                    , date_sub(last_trans, interval 34 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 35+34 day) as prev_start_date
                    , date_sub(last_trans, interval 35 day) as prev_end_date
                    , date_sub(last_trans, interval 364+34 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 35+35+34 day) as two_prev_start_date
                    , date_sub(last_trans, interval 35+35 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+35*2+34 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+35*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 35*3+34 day) as three_prev_start_date
                    , date_sub(last_trans, interval 35*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364+ 35*3+34 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 35*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 35*4+34 day) as four_prev_start_date
                    , date_sub(last_trans, interval 35*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364 + 35+34 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 35 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 91 Days" as period_type
                    , concat("91 DE ", last_trans) as period
                    , concat("91 DE ", date_sub(last_trans, interval 91 day)) as prev_period
                    , concat("91 DE ", date_sub(last_trans, interval 91+91 day)) as two_prev_period
                    , date_sub(last_trans, interval 90 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 91+90 day) as prev_start_date
                    , date_sub(last_trans, interval 91 day) as prev_end_date
                    , date_sub(last_trans, interval 364+90 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 91+91+90 day) as two_prev_start_date
                    , date_sub(last_trans, interval 91+91 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+91*2+90 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+91*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 91*3+90 day) as three_prev_start_date
                    , date_sub(last_trans, interval 91*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364 + 91*3+90 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 91*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 91*4+90 day) as four_prev_start_date
                    , date_sub(last_trans, interval 91*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364 + 91+90 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 91 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 182 Days" as period_type
                     , concat("182 DE ", last_trans) as period
                     , concat("182 DE ", date_sub(last_trans, interval 182 day)) as prev_period
                     , concat("182 DE ", date_sub(last_trans, interval 182+182 day)) as two_prev_period
                     , date_sub(last_trans, interval 181 day) as start_date
                     , last_trans as end_date
                     , date_sub(last_trans, interval 182+181 day) as prev_start_date
                     , date_sub(last_trans, interval 182 day) as prev_end_date
                     , date_sub(last_trans, interval 364+181 day) as ya_start_date
                     , date_sub(last_trans, interval 364 day) as ya_end_date
                     , date_sub(last_trans, interval 182+182+181 day) as two_prev_start_date
                     , date_sub(last_trans, interval 182+182 day) as two_prev_end_date
                     , date_sub(last_trans, interval 364+182*2+181 day) as two_prev_ya_start_date
                     , date_sub(last_trans, interval 364+182*2 day) as two_prev_ya_end_date
                     , date_sub(last_trans, interval 182*3+181 day) as three_prev_start_date
                     , date_sub(last_trans, interval 182*3 day) as three_prev_end_date
                     , date_sub(last_trans, interval 364+ 182*3+181 day) as three_prev_ya_start_date
                     , date_sub(last_trans, interval 364 + 182*3 day) as three_prev_ya_end_date
                     , date_sub(last_trans, interval 182*4+181 day) as four_prev_start_date
                     , date_sub(last_trans, interval 182*4 day) as four_prev_end_date
                     , date_sub(last_trans, interval 364 + 182+181 day) as prev_ya_start_date
                     , date_sub(last_trans, interval 364 + 182 day) as prev_ya_end_date
                  FROM panel_min_max_date

                  UNION ALL

                  SELECT
                    "Discrete 364 Days" as period_type
                    , concat("364 DE ", last_trans) as period
                    , concat("364 DE ", date_sub(last_trans, interval 364 day)) as prev_period
                    , concat("364 DE ", date_sub(last_trans, interval 364+364 day)) as two_prev_period
                    , date_sub(last_trans, interval 364-1 day) as start_date
                    , last_trans as end_date
                    , date_sub(last_trans, interval 364+363 day) as prev_start_date
                    , date_sub(last_trans, interval 364 day) as prev_end_date
                    , date_sub(last_trans, interval 364+363 day) as ya_start_date
                    , date_sub(last_trans, interval 364 day) as ya_end_date
                    , date_sub(last_trans, interval 364+364+363 day) as two_prev_start_date
                    , date_sub(last_trans, interval 364+364 day) as two_prev_end_date
                    , date_sub(last_trans, interval 364+364*2+363 day) as two_prev_ya_start_date
                    , date_sub(last_trans, interval 364+364*2 day) as two_prev_ya_end_date
                    , date_sub(last_trans, interval 364*3+363 day) as three_prev_start_date
                    , date_sub(last_trans, interval 364*3 day) as three_prev_end_date
                    , date_sub(last_trans, interval 364 + 364*3+363 day) as three_prev_ya_start_date
                    , date_sub(last_trans, interval 364+ 364*3 day) as three_prev_ya_end_date
                    , date_sub(last_trans, interval 364*4+363 day) as four_prev_start_date
                    , date_sub(last_trans, interval 364*4 day) as four_prev_end_date
                    , date_sub(last_trans, interval 364*2+363 day) as prev_ya_start_date
                    , date_sub(last_trans, interval 364 + 364 day) as prev_ya_end_date
                  FROM panel_min_max_date
                  )

                  ,  brand_period_table AS (select
                                                      s.brand_name
                                                      , s. brand_id
                                                      , c.period_type
                                                      , period
                                                      , prev_period
                                                      , two_prev_period
                                                      , start_date
                                                      , end_date
                                                      , prev_start_date
                                                      , prev_end_date
                                                      , ya_start_date
                                                      , ya_end_date
                                                      , two_prev_start_date
                                                      , two_prev_end_date
                                                      , two_prev_ya_start_date
                                                      , two_prev_ya_end_date
                                                      , three_prev_start_date
                                                      , three_prev_end_date
                                                      , three_prev_ya_start_date
                                                      , three_prev_ya_end_date
                                                      , four_prev_start_date
                                                      , four_prev_end_date
                                                      , prev_ya_start_date
                                                      , prev_ya_end_date
                                                      , case
                                                        when max.maxdate between c.start_date and date_sub(c.end_date, interval 1 day)
                                                        then 1
                                                        else 0 end as partial_period_flag
                                                      , case
                                                        when max.maxdate between c.start_date and c.end_date
                                                        then 1
                                                        else 0 end as latest_period_flag

                                                  from (SELECT distinct brand_name, brand_id FROM ${dist_day_brand_constind_currency.SQL_TABLE_NAME}) s
                                                  cross join max_available_date max
                                                  cross join (SELECT * FROM rolling_cal_base) c)


                , current_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_period
                                                      , max.two_prev_period
                                                      , max.start_date
                                                      , max.end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.start_date and max.end_date
                                                 join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_period
                                                      , max.two_prev_period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.start_date
                                                      , max.end_date)
                   , ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.ya_start_date
                                                      , max.ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.ya_start_date and max.ya_end_date
                                                   join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.ya_start_date
                                                      , max.ya_end_date)
                    , two_ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_ya_start_date
                                                      , max.prev_ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.prev_ya_start_date and max.prev_ya_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.prev_ya_start_date
                                                      , max.prev_ya_end_date)
                    , three_ya_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.two_prev_ya_start_date
                                                      , max.two_prev_ya_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.two_prev_ya_start_date and max.two_prev_ya_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.two_prev_ya_start_date
                                                      , max.two_prev_ya_end_date)
                  , prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.prev_start_date
                                                      , max.prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.prev_start_date and max.prev_end_date
                                                   join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.prev_start_date
                                                      , max.prev_end_date)
                    , two_prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.two_prev_start_date
                                                      , max.two_prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.two_prev_start_date and max.two_prev_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.two_prev_start_date
                                                      , max.two_prev_end_date)
                    , three_prev_period_sales AS (  select
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.three_prev_start_date
                                                      , max.three_prev_end_date
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
                                                  FROM brand_period_table max
                                                  left join ${dist_day_brand_constind_currency.SQL_TABLE_NAME} p
                                                      on p.brand_id = max.brand_id
                                                      and p.trans_date between max.three_prev_start_date and max.three_prev_end_date
                                                  join min_trans_date m
                                                    on m.brand_id = max.brand_id
                                                  WHERE max.start_date >= m.min_date
                                                  group by
                                                      max.brand_name
                                                      , max.brand_id
                                                      , max.period_type
                                                      , max.period
                                                      , max.partial_period_flag
                                                      , max.latest_period_flag
                                                      , max.three_prev_start_date
                                                      , max.three_prev_end_date)



                        select
                            c.brand_name
                            , c.brand_id
                            , industry.industry_name
                            , industry.subindustry_name
                            , c.partial_period_flag
                            , c.period_type
                            , "NONE" as merger_type
                            , "CONSTIND" as panel_type
                            , c.period
                            , c.prev_period
                            , c.two_prev_period
                            , c.start_date
                            , c.end_date as ptd_end_date
                             , round(sum(p.gbp_spend_amount),2) as gbp_spend_amount
                                                      , round(sum(p.cad_spend_amount),2) as cad_spend_amount
                                                      , round(sum(p.usd_spend_amount),2) as usd_spend_amount
                                                      , round(sum(p.eur_spend_amount),2) as eur_spend_amount
                                                      , round(sum(p.dkk_spend_amount),2) as dkk_spend_amount
                                                      , round(sum(p.nok_spend_amount),2) as nok_spend_amount
                                                      , round(sum(p.jpy_spend_amount),2) as jpy_spend_amount
                                                      , round(sum(p.sek_spend_amount),2) as sek_spend_amount
                                                      , round(sum(p.pln_spend_amount),2) as pln_spend_amount
                            , max.ya_start_date
                            , max.ya_end_date as ya_ptd_end_date
                            , max.two_prev_ya_start_date
                            , max.two_prev_ya_end_date
                            , max.three_prev_ya_start_date
                            , max.three_prev_ya_end_date
, CASE WHEN max.ya_start_date >= o.min_date THEN round(y.gbp_spend_amount,2) END as ya_spend_amount_gbp
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.gbp_spend_amount/nullif(y.gbp_spend_amount,0)-1 END as ptd_spend_yoy_gbp
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.gbp_spend_amount,2) END as two_ya_spend_amount_gbp
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.gbp_spend_amount/nullif(ty.gbp_spend_amount,0)-1 END as two_ptd_spend_yoy_gbp
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.gbp_spend_amount,2) END as three_ya_spend_amount_gbp
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.gbp_spend_amount/nullif(thy.gbp_spend_amount,0)-1 END as three_ptd_spend_yoy_gbp

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.gbp_spend_amount,2) END as prev_spend_amount_gbp
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.gbp_spend_amount/nullif(p.gbp_spend_amount,0)-1 END as ptd_spend_seq_gbp
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.gbp_spend_amount,2) END as two_prev_spend_amount_gbp
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.gbp_spend_amount/nullif(tp.gbp_spend_amount,0)-1 END as two_ptd_spend_seq_gbp
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.gbp_spend_amount,2) END as three_prev_spend_amount_gbp
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.gbp_spend_amount/nullif(thp.gbp_spend_amount,0)-1 END as three_ptd_spend_seq_gbp


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.cad_spend_amount,2) END as ya_spend_amount_cad
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.cad_spend_amount/nullif(y.cad_spend_amount,0)-1 END as ptd_spend_yoy_cad
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.cad_spend_amount,2) END as two_ya_spend_amount_cad
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.cad_spend_amount/nullif(ty.cad_spend_amount,0)-1 END as two_ptd_spend_yoy_cad
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.cad_spend_amount,2) END as three_ya_spend_amount_cad
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.cad_spend_amount/nullif(thy.cad_spend_amount,0)-1 END as three_ptd_spend_yoy_cad

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.cad_spend_amount,2) END as prev_spend_amount_cad
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.cad_spend_amount/nullif(p.cad_spend_amount,0)-1 END as ptd_spend_seq_cad
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.cad_spend_amount,2) END as two_prev_spend_amount_cad
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.cad_spend_amount/nullif(tp.cad_spend_amount,0)-1 END as two_ptd_spend_seq_cad
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.cad_spend_amount,2) END as three_prev_spend_amount_cad
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.cad_spend_amount/nullif(thp.cad_spend_amount,0)-1 END as three_ptd_spend_seq_cad


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.usd_spend_amount,2) END as ya_spend_amount_usd
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.usd_spend_amount/nullif(y.usd_spend_amount,0)-1 END as ptd_spend_yoy_usd
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.usd_spend_amount,2) END as two_ya_spend_amount_usd
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.usd_spend_amount/nullif(ty.usd_spend_amount,0)-1 END as two_ptd_spend_yoy_usd
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.usd_spend_amount,2) END as three_ya_spend_amount_usd
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.usd_spend_amount/nullif(thy.usd_spend_amount,0)-1 END as three_ptd_spend_yoy_usd

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.usd_spend_amount,2) END as prev_spend_amount_usd
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.usd_spend_amount/nullif(p.usd_spend_amount,0)-1 END as ptd_spend_seq_usd
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.usd_spend_amount,2) END as two_prev_spend_amount_usd
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.usd_spend_amount/nullif(tp.usd_spend_amount,0)-1 END as two_ptd_spend_seq_usd
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.usd_spend_amount,2) END as three_prev_spend_amount_usd
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.usd_spend_amount/nullif(thp.usd_spend_amount,0)-1 END as three_ptd_spend_seq_usd


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.eur_spend_amount,2) END as ya_spend_amount_eur
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.eur_spend_amount/nullif(y.eur_spend_amount,0)-1 END as ptd_spend_yoy_eur
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.eur_spend_amount,2) END as two_ya_spend_amount_eur
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.eur_spend_amount/nullif(ty.eur_spend_amount,0)-1 END as two_ptd_spend_yoy_eur
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.eur_spend_amount,2) END as three_ya_spend_amount_eur
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.eur_spend_amount/nullif(thy.eur_spend_amount,0)-1 END as three_ptd_spend_yoy_eur

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.eur_spend_amount,2) END as prev_spend_amount_eur
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.eur_spend_amount/nullif(p.eur_spend_amount,0)-1 END as ptd_spend_seq_eur
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.eur_spend_amount,2) END as two_prev_spend_amount_eur
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.eur_spend_amount/nullif(tp.eur_spend_amount,0)-1 END as two_ptd_spend_seq_eur
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.eur_spend_amount,2) END as three_prev_spend_amount_eur
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.eur_spend_amount/nullif(thp.eur_spend_amount,0)-1 END as three_ptd_spend_seq_eur


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.dkk_spend_amount,2) END as ya_spend_amount_dkk
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.dkk_spend_amount/nullif(y.dkk_spend_amount,0)-1 END as ptd_spend_yoy_dkk
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.dkk_spend_amount,2) END as two_ya_spend_amount_dkk
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.dkk_spend_amount/nullif(ty.dkk_spend_amount,0)-1 END as two_ptd_spend_yoy_dkk
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.dkk_spend_amount,2) END as three_ya_spend_amount_dkk
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.dkk_spend_amount/nullif(thy.dkk_spend_amount,0)-1 END as three_ptd_spend_yoy_dkk

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.dkk_spend_amount,2) END as prev_spend_amount_dkk
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.dkk_spend_amount/nullif(p.dkk_spend_amount,0)-1 END as ptd_spend_seq_dkk
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.dkk_spend_amount,2) END as two_prev_spend_amount_dkk
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.dkk_spend_amount/nullif(tp.dkk_spend_amount,0)-1 END as two_ptd_spend_seq_dkk
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.dkk_spend_amount,2) END as three_prev_spend_amount_dkk
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.dkk_spend_amount/nullif(thp.dkk_spend_amount,0)-1 END as three_ptd_spend_seq_dkk


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.nok_spend_amount,2) END as ya_spend_amount_nok
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.nok_spend_amount/nullif(y.nok_spend_amount,0)-1 END as ptd_spend_yoy_nok
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.nok_spend_amount,2) END as two_ya_spend_amount_nok
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.nok_spend_amount/nullif(ty.nok_spend_amount,0)-1 END as two_ptd_spend_yoy_nok
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.nok_spend_amount,2) END as three_ya_spend_amount_nok
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.nok_spend_amount/nullif(thy.nok_spend_amount,0)-1 END as three_ptd_spend_yoy_nok

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.nok_spend_amount,2) END as prev_spend_amount_nok
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.nok_spend_amount/nullif(p.nok_spend_amount,0)-1 END as ptd_spend_seq_nok
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.nok_spend_amount,2) END as two_prev_spend_amount_nok
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.nok_spend_amount/nullif(tp.nok_spend_amount,0)-1 END as two_ptd_spend_seq_nok
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.nok_spend_amount,2) END as three_prev_spend_amount_nok
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.nok_spend_amount/nullif(thp.nok_spend_amount,0)-1 END as three_ptd_spend_seq_nok


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.jpy_spend_amount,2) END as ya_spend_amount_jpy
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.jpy_spend_amount/nullif(y.jpy_spend_amount,0)-1 END as ptd_spend_yoy_jpy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.jpy_spend_amount,2) END as two_ya_spend_amount_jpy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.jpy_spend_amount/nullif(ty.jpy_spend_amount,0)-1 END as two_ptd_spend_yoy_jpy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.jpy_spend_amount,2) END as three_ya_spend_amount_jpy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.jpy_spend_amount/nullif(thy.jpy_spend_amount,0)-1 END as three_ptd_spend_yoy_jpy

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.jpy_spend_amount,2) END as prev_spend_amount_jpy
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.jpy_spend_amount/nullif(p.jpy_spend_amount,0)-1 END as ptd_spend_seq_jpy
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.jpy_spend_amount,2) END as two_prev_spend_amount_jpy
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.jpy_spend_amount/nullif(tp.jpy_spend_amount,0)-1 END as two_ptd_spend_seq_jpy
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.jpy_spend_amount,2) END as three_prev_spend_amount_jpy
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.jpy_spend_amount/nullif(thp.jpy_spend_amount,0)-1 END as three_ptd_spend_seq_jpy


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.sek_spend_amount,2) END as ya_spend_amount_sek
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.sek_spend_amount/nullif(y.sek_spend_amount,0)-1 END as ptd_spend_yoy_sek
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.sek_spend_amount,2) END as two_ya_spend_amount_sek
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.sek_spend_amount/nullif(ty.sek_spend_amount,0)-1 END as two_ptd_spend_yoy_sek
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.sek_spend_amount,2) END as three_ya_spend_amount_sek
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.sek_spend_amount/nullif(thy.sek_spend_amount,0)-1 END as three_ptd_spend_yoy_sek

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.sek_spend_amount,2) END as prev_spend_amount_sek
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.sek_spend_amount/nullif(p.sek_spend_amount,0)-1 END as ptd_spend_seq_sek
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.sek_spend_amount,2) END as two_prev_spend_amount_sek
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.sek_spend_amount/nullif(tp.sek_spend_amount,0)-1 END as two_ptd_spend_seq_sek
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.sek_spend_amount,2) END as three_prev_spend_amount_sek
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.sek_spend_amount/nullif(thp.sek_spend_amount,0)-1 END as three_ptd_spend_seq_sek


                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.pln_spend_amount,2) END as ya_spend_amount_pln
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.pln_spend_amount/nullif(y.pln_spend_amount,0)-1 END as ptd_spend_yoy_pln
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.pln_spend_amount,2) END as two_ya_spend_amount_pln
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.pln_spend_amount/nullif(ty.pln_spend_amount,0)-1 END as two_ptd_spend_yoy_pln
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.pln_spend_amount,2) END as three_ya_spend_amount_pln
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.pln_spend_amount/nullif(thy.pln_spend_amount,0)-1 END as three_ptd_spend_yoy_pln

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.pln_spend_amount,2) END as prev_spend_amount_pln
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.pln_spend_amount/nullif(p.pln_spend_amount,0)-1 END as ptd_spend_seq_pln
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.pln_spend_amount,2) END as two_prev_spend_amount_pln
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.pln_spend_amount/nullif(tp.pln_spend_amount,0)-1 END as two_ptd_spend_seq_pln
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.pln_spend_amount,2) END as three_prev_spend_amount_pln
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.pln_spend_amount/nullif(thp.pln_spend_amount,0)-1 END as three_ptd_spend_seq_pln








                            , round(c.trans_count,2) as trans_count
                            , CASE WHEN max.ya_start_date >= o.min_date THEN round(y.trans_count,2) END as ya_trans_count
                            , CASE WHEN max.ya_start_date >= o.min_date THEN c.trans_count/nullif(y.trans_count,0)-1 END as ptd_trans_yoy
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN round(ty.trans_count,2) END as two_ya_trans_count
                            , CASE WHEN max.prev_ya_start_date >= o.min_date THEN p.trans_count/nullif(ty.trans_count,0)-1 END as two_ptd_trans_yoy
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN round(thy.trans_count,2) END as three_ya_trans_count
                            , CASE WHEN max.two_prev_ya_start_date >= o.min_date THEN tp.trans_count/nullif(thy.trans_count,0)-1 END as three_ptd_trans_yoy

                            , CASE WHEN max.prev_start_date >= o.min_date THEN round(p.trans_count,2) END as prev_trans_count
                            , CASE WHEN max.prev_start_date >= o.min_date THEN c.trans_count/nullif(p.trans_count,0)-1 END as ptd_trans_seq
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN round(tp.trans_count,2) END as two_prev_trans_count
                            , CASE WHEN max.two_prev_start_date >= o.min_date THEN p.trans_count/nullif(tp.trans_count,0)-1 END as two_ptd_trans_seq
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN round(thp.trans_count,2) END as three_prev_trans_count
                            , CASE WHEN max.three_prev_start_date >= o.min_date THEN tp.trans_count/nullif(thp.trans_count,0)-1 END as three_ptd_trans_seq
                            , c.latest_period_flag as latest_period_flag
                            , date_diff(c.end_date, c.start_date, day)+1 as period_day
                            , c.end_date
                        from current_period_sales c
                        left join brand_period_table max
                            on max.period = c.period and max.brand_id = c.brand_id
                        left join ya_period_sales y
                            on y.brand_id = c.brand_id
                            and y.period = c.period
                        left join two_ya_period_sales ty
                            on ty.brand_id = c.brand_id
                            and ty.period = c.period
                        left join three_ya_period_sales thy
                            on thy.brand_id = c.brand_id
                            and thy.period = c.period
                        left join prev_period_sales p
                            on p.brand_id = c.brand_id
                            and p.period = c.period
                        left join two_prev_period_sales tp
                            on tp.brand_id = c.brand_id
                            and tp.period = c.period
                        left join three_prev_period_sales thp
                            on thp.brand_id = c.brand_id
                            and thp.period = c.period
                        join min_trans_date o
                            on c.brand_id = o.brand_id
                        join (select distinct brand_id, subindustry_id from `ce-cloud-services.ce_transact_ground_truth.brand`) brand
                        on max.brand_id = brand.brand_id
                        join (select distinct subindustry_id, industry_name, subindustry_name from `ce-cloud-services.ce_transact_ground_truth.industry_list`) industry
                        on brand.subindustry_id = industry.subindustry_id
                        group by
                            c.brand_name
                            , c.brand_id
                            , industry.industry_name
                            , industry.subindustry_name
                            , c.partial_period_flag
                            , period_type
                            , c.period
                            , c.prev_period
                            , c.two_prev_period
                            , c.start_date
                            , c.end_date
                            , c.gbp_spend_amount
                            , c.cad_spend_amount
                            , c.usd_spend_amount
                            , c.eur_spend_amount
                            , c.dkk_spend_amount
                            , c.nok_spend_amount
                            , c.jpy_spend_amount
                            , c.sek_spend_amount
                            , c.pln_spend_amount
                            , y.gbp_spend_amount
                            , y.cad_spend_amount
                            , y.usd_spend_amount
                            , y.eur_spend_amount
                            , y.dkk_spend_amount
                            , y.nok_spend_amount
                            , y.jpy_spend_amount
                            , y.sek_spend_amount
                            , y.pln_spend_amount
                            , y.trans_count
                            , ty.gbp_spend_amount
                            , ty.cad_spend_amount
                            , ty.usd_spend_amount
                            , ty.eur_spend_amount
                            , ty.dkk_spend_amount
                            , ty.nok_spend_amount
                            , ty.jpy_spend_amount
                            , ty.sek_spend_amount
                            , ty.pln_spend_amount
                            , ty.trans_count
                            , thy.gbp_spend_amount
                            , thy.cad_spend_amount
                            , thy.usd_spend_amount
                            , thy.eur_spend_amount
                            , thy.dkk_spend_amount
                            , thy.nok_spend_amount
                            , thy.jpy_spend_amount
                            , thy.sek_spend_amount
                            , thy.pln_spend_amount
                            , thy.trans_count
                            , p.gbp_spend_amount
                            , p.cad_spend_amount
                            , p.usd_spend_amount
                            , p.eur_spend_amount
                            , p.dkk_spend_amount
                            , p.nok_spend_amount
                            , p.jpy_spend_amount
                            , p.sek_spend_amount
                            , p.pln_spend_amount
                            , p.trans_count
                            , tp.gbp_spend_amount
                            , tp.cad_spend_amount
                            , tp.usd_spend_amount
                            , tp.eur_spend_amount
                            , tp.dkk_spend_amount
                            , tp.nok_spend_amount
                            , tp.jpy_spend_amount
                            , tp.sek_spend_amount
                            , tp.pln_spend_amount
                            , tp.trans_count
                            , thp.gbp_spend_amount
                            , thp.cad_spend_amount
                            , thp.usd_spend_amount
                            , thp.eur_spend_amount
                            , thp.dkk_spend_amount
                            , thp.nok_spend_amount
                            , thp.jpy_spend_amount
                            , thp.sek_spend_amount
                            , thp.pln_spend_amount
                            , thp.trans_count
                            , max.ya_start_date
                            , max.ya_end_date
                            , max.prev_ya_start_date
                            , max.prev_ya_end_date
                            , max.two_prev_ya_start_date
                            , max.two_prev_ya_end_date
                            , max.three_prev_ya_start_date
                            , max.three_prev_ya_end_date
                            , max.prev_start_date
                            , max.prev_end_date
                            , max.two_prev_start_date
                            , max.two_prev_end_date
                            , max.three_prev_start_date
                            , max.three_prev_end_date
                            , c.trans_count
                            , c.end_date
                            , c.latest_period_flag
                            , o.min_date

                            ORDER BY brand_name, period) ;;
    partition_keys: ["start_date"]
    cluster_keys: ["panel_type", "period_type"]
    datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
  }

  dimension: industry {
    sql: ${TABLE}.industry_name ;;
  }}
