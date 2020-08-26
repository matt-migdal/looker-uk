view: forecast_date_intervals {
  derived_table: {
    sql:
               WITH date_intervals as (WITH symbol_dates as ((SELECT row_number() over(ORDER BY p.symbol, p.period_type, p.period) as row_count,
                                                                     p.symbol,
                                                                     p.period_type,
                                                                     p.period,
                                                                     p.period_start_dt,
                                                                     p.period_end_dt,
                                                                     max.max_date,
                                                                     CASE WHEN max_date between period_start_dt and period_end_dt then "Current Period"
                                                                          else null
                                                                          end as current_period
                                                              FROM (select
                                                                          symbol
                                                                          , period_type
                                                                          , period
                                                                          , period_start_dt
                                                                          , period_end_dt
                                                                    from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                                                                          FROM ${ground_truth_financial.SQL_TABLE_NAME})

                                                                    union all

                                                                    select
                                                                          s.symbol
                                                                          , 'FQ' as period_type
                                                                          , c.calendar_qtr as period
                                                                          , min(c.date) as period_start_dt
                                                                          , max(c.date) as period_end_dt
                                                                    from (SELECT distinct symbol
                                                                          FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                                                    cross join ${calendar.SQL_TABLE_NAME} c
                                                                    WHERE s.symbol not in
                                                                            (SELECT distinct symbol
                                                                            FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                                                            WHERE period_type = 'FQ')
                                                                    group by
                                                                        s.symbol
                                                                        , c.calendar_qtr

                                                                    union all

                                                                    select
                                                                          s.symbol
                                                                          , 'FH' as period_type
                                                                          , c.calendar_half as period
                                                                          , min(c.date) as period_start_dt
                                                                          , max(c.date) as period_end_dt
                                                                    from (SELECT distinct symbol
                                                                          FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                                                    cross join ${calendar.SQL_TABLE_NAME} c
                                                                    WHERE s.symbol not in
                                                                            (SELECT distinct symbol
                                                                            FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                                                            WHERE period_type = 'FH')
                                                                    group by
                                                                        s.symbol
                                                                        , c.calendar_half

                                                                    ORDER BY symbol, period) p

                                                              LEFT JOIN
                                                                    (SELECT symbol, maxdate as max_date
                                                                    FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`) max
                                                                    #SELECT symbol, max(trans_date) as max_date FROM `ce-cloud-services.ce_transact_uk_daily_signal.dist_day_sym_brand_cardtype_norm` GROUP BY symbol) max
                                                                    on p.symbol = max.symbol))

        #############################################################

        SELECT *
        FROM

            (SELECT row_count,
                    symbol,
                    period_type,
                    period,
                    period_start_dt,
                    period_end_dt,
                    adj_period_end_dt,
                    period_length,
                    balance_length,
                    yago_period_start_dt,
                    date_add(yago_period_start_dt, interval period_length + balance_length - 1 day) as yago_period_end_dt,
                    date_add(yago_period_start_dt, interval period_length-1 day) as yago_adj_period_end_dt,
                    two_yago_period_start_dt,
                    date_add(two_yago_period_start_dt, interval period_length + balance_length - 1 day) as two_yago_period_end_dt,
                    date_add(two_yago_period_start_dt, interval period_length-1 day) as two_yago_adj_period_end_dt,
                    max_date,
                    coalesce(current_period, previous_period, two_previous_periods, three_previous_periods, four_previous_periods, five_previous_periods) as periods

            FROM

                (SELECT sym_dt.*,
                        yago_period,
                        yago_period_start_dt,
                        yago_period_end_dt,
                        two_yago_period,
                        two_yago_period_start_dt,
                        two_yago_period_end_dt,
                        date_diff(adj_period_end_dt, period_start_dt, day) + 1 as period_length,
                        case when current_period is not null then date_diff(period_end_dt, adj_period_end_dt, day)
                             else 0
                             end as balance_length

                        , CASE WHEN current_q.row_count_current - sym_dt.row_count = 1 THEN "Previous Period"
                               ELSE null
                               END as previous_period

                        , CASE WHEN current_q.row_count_current - sym_dt.row_count = 2 THEN "2 Previous Periods"
                               ELSE null
                               END as two_previous_periods

                        , CASE WHEN current_q.row_count_current - sym_dt.row_count = 3 THEN "3 Previous Periods"
                               ELSE null
                               END as three_previous_periods

                        , CASE WHEN current_q.row_count_current - sym_dt.row_count = 4 THEN "4 Previous Periods"
                               ELSE null
                               END as four_previous_periods

                        , CASE WHEN current_q.row_count_current - sym_dt.row_count = 5 THEN "5 Previous Periods"
                               ELSE null
                               END as five_previous_periods

                FROM

                    (SELECT row_count,
                            symbol,
                            period_type,
                            period,
                            period_start_dt,
                            period_end_dt,
                            case when period_end_dt > max_date then max_date else period_end_dt end as adj_period_end_dt,
                            max_date,
                            current_period
                            FROM symbol_dates) as sym_dt

                LEFT JOIN (SELECT symbol, row_count as row_count_current
                           FROM symbol_dates
                           WHERE current_period = "Current Period") current_q
                on current_q.symbol = sym_dt.symbol

                LEFT JOIN (SELECT row_count as yago_row_count,
                                  symbol as yago_symbol,
                                  period_type as yago_period_type,
                                  period as yago_period,
                                  period_start_dt as yago_period_start_dt,
                                  period_end_dt as yago_period_end_dt
                          FROM symbol_dates) yago
                on yago.yago_symbol = sym_dt.symbol
                and yago.yago_period_type = sym_dt.period_type
                and yago.yago_row_count + 4 = sym_dt.row_count

                LEFT JOIN (SELECT row_count as two_yago_row_count,
                                  symbol as two_yago_symbol,
                                  period_type as two_yago_period_type,
                                  period as two_yago_period,
                                  period_start_dt as two_yago_period_start_dt,
                                  period_end_dt as two_yago_period_end_dt
                                  FROM symbol_dates) two_yago
                on two_yago.two_yago_symbol = sym_dt.symbol
                and two_yago.two_yago_period_type = sym_dt.period_type
                and two_yago.two_yago_row_count + 8 = sym_dt.row_count))

        WHERE periods is not null

        )

        #####################################

           SELECT current_intervals.symbol,
                  current_intervals.period_type,
                  current_intervals.period,
                  current_intervals.day_count,
                  current_intervals.reverse_day_count,
                  current_intervals.periods,
                  current_intervals.period_length,
                  current_intervals.balance_length,

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
                  balance_two_yago_sum_include

                  FROM

                       (SELECT symbol,
                               period_type,
                               period,
                               periods,
                               period_length,
                               balance_length,
                               case when date_diff(c_current.date, period_start_dt, day) + 1 <= period_length then "include"
                                    else "exclude"
                                    end as current_sum_include

                               , period_start_dt as current_period_start_dt,
                               c_current.date as current_cum_end_dt,
                               date_diff(c_current.date, period_start_dt, day) + 1 as day_count,
                               date_diff(period_end_dt, c_current.date, day) + 1 as reverse_day_count

                        FROM date_intervals di
                        INNER JOIN ${calendar.SQL_TABLE_NAME} c_current
                        on c_current.date between di.period_start_dt and di.period_end_dt
                        WHERE periods is not null) current_intervals

                  LEFT JOIN  (SELECT symbol,
                                     period_type,
                                     period,
                                     periods,
                                     period_length,
                                     balance_length,
                                     case when date_diff(c_yago.date, yago_period_start_dt, day) + 1 <= period_length then "include"
                                          else "exclude"
                                          end as yago_sum_include

                                      , yago_period_start_dt as yago_period_start_dt,
                                      c_yago.date as yago_cum_end_dt,
                                      date_diff(c_yago.date, yago_period_start_dt, day) + 1 as day_count

                             FROM date_intervals di

                             INNER JOIN ${calendar.SQL_TABLE_NAME} c_yago
                             on c_yago.date between di.yago_period_start_dt and di.yago_period_end_dt

                             WHERE periods is not null) yago_intervals

                  on current_intervals.symbol = yago_intervals.symbol
                  and current_intervals.period_type = yago_intervals.period_type
                  and current_intervals.period = yago_intervals.period
                  and current_intervals.day_count = yago_intervals.day_count
                  and current_intervals.periods = yago_intervals.periods

                  LEFT JOIN  (SELECT symbol,
                                     period_type,
                                     period,
                                     periods,
                                     period_length,
                                     balance_length,
                                     case when date_diff(c_two_yago.date, two_yago_period_start_dt, day) + 1 <= period_length then "include"
                                          else "exclude"
                                          end as two_yago_sum_include

                                     , two_yago_period_start_dt as two_yago_period_start_dt,
                                     c_two_yago.date as two_yago_cum_end_dt,
                                     date_diff(c_two_yago.date, two_yago_period_start_dt, day) + 1 as day_count

                              FROM date_intervals di

                              INNER JOIN ${calendar.SQL_TABLE_NAME} c_two_yago
                              on c_two_yago.date between di.two_yago_period_start_dt and di.two_yago_period_end_dt

                              WHERE periods is not null) two_yago_intervals

                  on current_intervals.symbol = two_yago_intervals.symbol
                  and current_intervals.period_type = two_yago_intervals.period_type
                  and current_intervals.period = two_yago_intervals.period
                  and current_intervals.day_count = two_yago_intervals.day_count
                  and current_intervals.periods = two_yago_intervals.periods

                  LEFT JOIN  (SELECT symbol,
                                     period_type,
                                     period,
                                     periods,
                                     period_length,
                                     balance_length,
                                     case when date_diff(c_yago_balance.date, yago_period_start_dt, day) + 1 > period_length then "include"
                                          else "exclude"
                                          end as balance_yago_sum_include

                                     , c_yago_balance.date as balance_yago_cum_start_dt,
                                     yago_period_end_dt as balance_yago_period_end_dt,
                                     date_diff(c_yago_balance.date, yago_period_start_dt, day) + 1 as day_count

                             FROM date_intervals di

                             INNER JOIN ${calendar.SQL_TABLE_NAME} c_yago_balance
                             on c_yago_balance.date between di.yago_period_start_dt and di.yago_period_end_dt

                             WHERE periods is not null) balance_yago_intervals

                  on current_intervals.symbol = balance_yago_intervals.symbol
                  and current_intervals.period_type = balance_yago_intervals.period_type
                  and current_intervals.period = balance_yago_intervals.period
                  and current_intervals.day_count = balance_yago_intervals.day_count
                  and current_intervals.periods = balance_yago_intervals.periods

                  LEFT JOIN  (SELECT symbol,
                                     period_type,
                                     period,
                                     periods,
                                     period_length,
                                     balance_length,
                                     case when date_diff(c_two_yago_balance.date, two_yago_period_start_dt, day) + 1 > period_length then "include"
                                          else "exclude"
                                          end as balance_two_yago_sum_include

                                     , c_two_yago_balance.date as balance_two_yago_cum_start_dt,
                                     two_yago_period_end_dt as balance_two_yago_period_end_dt,
                                     date_diff(c_two_yago_balance.date, two_yago_period_start_dt, day) + 1 as day_count

                             FROM date_intervals di

                             INNER JOIN ${calendar.SQL_TABLE_NAME} c_two_yago_balance
                             on c_two_yago_balance.date between di.two_yago_period_start_dt and di.two_yago_period_end_dt

                             WHERE periods is not null) balance_two_yago_intervals

                  on current_intervals.symbol = balance_two_yago_intervals.symbol
                  and current_intervals.symbol = balance_two_yago_intervals.period_type
                  and current_intervals.period = balance_two_yago_intervals.period
                  and current_intervals.day_count = balance_two_yago_intervals.day_count
                  and current_intervals.periods = balance_two_yago_intervals.periods
         ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
    }

    dimension: symbol {
      label: "symbol"
      type: string
      sql: ${TABLE}.symbol ;;
    }



  }
