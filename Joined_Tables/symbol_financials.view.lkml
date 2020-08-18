view: symbol_financials { #originally titled view: financials
  derived_table: {
    sql:

      SELECT financial_intervals.row,
             financial_intervals.symbol,
             financial_intervals.period,
             financial_intervals.yago_period as yago_period,
             financial_start_dt,

             CASE WHEN max_date between financial_start_dt and financial_end_dt THEN max_date
                  else financial_end_dt
             end as financial_end_dt,

             yago_financial_start_dt,

             CASE WHEN max_date between financial_start_dt and financial_end_dt THEN date_add(yago_financial_start_dt, interval date_diff(max_date, financial_start_dt, day) day)
                  else yago_financial_end_dt
             end as yago_financial_end_dt,

             sf1.reported_sales as reported_sales,
             sf2.reported_sales as yago_reported_sales,
             max_date,
             latest_reported.reported_q_num as latest_reported_num,
             financial_start_dt as actual_financial_start_dt,
             financial_end_dt as actual_financial_end_dt,
             yago_financial_start_dt as actual_yago_financial_start_dt,
             yago_financial_end_dt as actual_yago_financial_end_dt,
             two_yago_financial_start_dt as actual_two_yago_financial_start_dt,
             two_yago_financial_end_dt as actual_two_yago_financial_end_dt

      FROM

          (SELECT current_financials.row, current_financials.symbol, current_financials.period, yago_financials.period as yago_period, current_financials.period_start_dt as financial_start_dt, current_financials.period_end_dt as financial_end_dt, yago_financials.period_start_dt as yago_financial_start_dt,  yago_financials.period_end_dt as yago_financial_end_dt, two_yago_financials.period_start_dt as two_yago_financial_start_dt,  two_yago_financials.period_end_dt as two_yago_financial_end_dt

          FROM

              (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
              FROM

                  (select symbol
                          , period_type
                          , period
                          , period_start_dt
                          , period_end_dt
                   from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                         FROM ${ground_truth_financial.SQL_TABLE_NAME}
                         WHERE period_type = 'FQ')

                   union all

                   select s.symbol
                          , 'FQ' as period_type
                          , c.calendar_qtr as period
                          , min(c.date) as period_start_dt
                          , max(c.date) as period_end_dt
                   from (SELECT distinct symbol
                         FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                   cross join ${calendar.SQL_TABLE_NAME} c
                   WHERE s.symbol not in (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                          )
                   group by s.symbol
                            , c.calendar_qtr

                   ORDER BY symbol, period_type, period)

              ORDER BY symbol, period_type, period) current_financials

          LEFT JOIN (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
                     FROM

                          (select symbol
                                  , period_type
                                  , period
                                  , period_start_dt
                                  , period_end_dt
                           from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                                 FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                 WHERE period_type = 'FQ')

                           union all

                           select s.symbol
                                  , 'FQ' as period_type
                                  , c.calendar_qtr as period
                                  , min(c.date) as period_start_dt
                                  , max(c.date) as period_end_dt
                           from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                           cross join ${calendar.SQL_TABLE_NAME} c
                           WHERE s.symbol not in (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                                  )
                           group by s.symbol
                                    , c.calendar_qtr

                           ORDER BY symbol, period_type, period)

                    ORDER BY symbol, period_type, period) yago_financials

          on current_financials.row = yago_financials.row + 4
          and current_financials.period_type = yago_financials.period_type
          and current_financials.symbol = yago_financials.symbol

          LEFT JOIN (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
                     FROM

                          (select symbol
                                  , period_type
                                  , period
                                  , period_start_dt
                                  , period_end_dt
                          from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                                FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                WHERE period_type = 'FQ')

                                    union all

                                    select
                                        s.symbol
                                        , 'FQ' as period_type
                                        , c.calendar_qtr as period
                                        , min(c.date) as period_start_dt
                                        , max(c.date) as period_end_dt
                                    from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                                    cross join ${calendar.SQL_TABLE_NAME} c
                                        WHERE s.symbol not in
                                            (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME})
                                    group by
                                        s.symbol
                                        , c.calendar_qtr

                                        ORDER BY symbol, period_type, period)

                                        ORDER BY symbol, period_type, period) two_yago_financials

                 on current_financials.row = two_yago_financials.row + 8
                 and current_financials.period_type = two_yago_financials.period_type
                 and current_financials.symbol = two_yago_financials.symbol

      ORDER BY row) financial_intervals

      LEFT JOIN (SELECT distinct symbol, period, reported_metric as reported_sales, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}) sf1

      on sf1.symbol = financial_intervals.symbol
      and sf1.period = financial_intervals.period

      LEFT JOIN (SELECT distinct symbol, period, reported_metric as reported_sales, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}) sf2

      on sf2.symbol = financial_intervals.symbol
      and sf2.period = financial_intervals.yago_period

      LEFT JOIN (SELECT symbol, maxdate as max_date FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`) max

      on max.symbol = financial_intervals.symbol

      LEFT JOIN (

      (SELECT row as reported_q_num, symbol, period_type, period
       FROM

            (SELECT row_number() over(PARTITION BY symbol, period_type ORDER BY period DESC) as row, *
             FROM

                  (SELECT distinct symbol, period_type, period, reported_metric as reported_sales
                   FROM ${ground_truth_financial.SQL_TABLE_NAME}
                   WHERE reported_metric is not null
                   ORDER BY symbol, period_type, period DESC)))) latest_reported

      on latest_reported.symbol = financial_intervals.symbol
      and latest_reported.period = financial_intervals.period

      --ORDER BY row

      #######################
      UNION ALL
      #######################

            SELECT financial_intervals.row,
             financial_intervals.symbol,
             financial_intervals.period,
             financial_intervals.yago_period as yago_period,
             financial_start_dt,

             CASE WHEN max_date between financial_start_dt and financial_end_dt THEN max_date
                  else financial_end_dt
             end as financial_end_dt,

             yago_financial_start_dt,

             CASE WHEN max_date between financial_start_dt and financial_end_dt THEN date_add(yago_financial_start_dt, interval date_diff(max_date, financial_start_dt, day) day)
                  else yago_financial_end_dt
             end as yago_financial_end_dt,

             sf1.reported_sales as reported_sales,
             sf2.reported_sales as yago_reported_sales,
             max_date,
             latest_reported.reported_q_num as latest_reported_num,
             financial_start_dt as actual_financial_start_dt,
             financial_end_dt as actual_financial_end_dt,
             yago_financial_start_dt as actual_yago_financial_start_dt,
             yago_financial_end_dt as actual_yago_financial_end_dt,
             two_yago_financial_start_dt as actual_two_yago_financial_start_dt,
             two_yago_financial_end_dt as actual_two_yago_financial_end_dt

      FROM

          (SELECT current_financials.row, current_financials.symbol, current_financials.period, yago_financials.period as yago_period, current_financials.period_start_dt as financial_start_dt, current_financials.period_end_dt as financial_end_dt, yago_financials.period_start_dt as yago_financial_start_dt,  yago_financials.period_end_dt as yago_financial_end_dt, two_yago_financials.period_start_dt as two_yago_financial_start_dt,  two_yago_financials.period_end_dt as two_yago_financial_end_dt

          FROM

              (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
              FROM

                  (select symbol
                          , period_type
                          , period
                          , period_start_dt
                          , period_end_dt
                   from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                         FROM ${ground_truth_financial.SQL_TABLE_NAME}
                         WHERE period_type = 'FH')

                 # union all

                 # select s.symbol
                 #        , 'FQ' as period_type
                 #        , c.calendar_qtr as period
                 #        , min(c.date) as period_start_dt
                 #        , max(c.date) as period_end_dt
                 # from (SELECT distinct symbol
                 #       FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                 # cross join ${calendar.SQL_TABLE_NAME} c
                 # WHERE s.symbol not in (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                 #                        )
                 # group by s.symbol
                 #          , c.calendar_qtr

                   ORDER BY symbol, period_type, period)

              ORDER BY symbol, period_type, period) current_financials

          LEFT JOIN (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
                     FROM

                          (select symbol
                                  , period_type
                                  , period
                                  , period_start_dt
                                  , period_end_dt
                           from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                                 FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                 WHERE period_type = 'FH')

                        # union all

                        # select s.symbol
                        #        , 'FH' as period_type
                        #        , c.calendar_qtr as period
                        #        , min(c.date) as period_start_dt
                        #        , max(c.date) as period_end_dt
                        # from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                        # cross join ${calendar.SQL_TABLE_NAME} c
                        # WHERE s.symbol not in (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME}
                        #                        )
                        # group by s.symbol
                        #          , c.calendar_qtr

                           ORDER BY symbol, period_type, period)

                    ORDER BY symbol, period_type, period) yago_financials

          on current_financials.row = yago_financials.row + 2
          and current_financials.period_type = yago_financials.period_type
          and current_financials.symbol = yago_financials.symbol

          LEFT JOIN (SELECT row_number() over(ORDER BY symbol, period_type, period) as row, *
                     FROM

                          (select symbol
                                  , period_type
                                  , period
                                  , period_start_dt
                                  , period_end_dt
                          from (SELECT distinct symbol, period_type, period, period_start_dt, period_end_dt
                                FROM ${ground_truth_financial.SQL_TABLE_NAME}
                                WHERE period_type = 'FH')

                               #     union all
#
                               #     select
                               #         s.symbol
                               #         , 'FH' as period_type
                               #         , c.calendar_qtr as period
                               #         , min(c.date) as period_start_dt
                               #         , max(c.date) as period_end_dt
                               #     from (SELECT distinct symbol FROM ${ground_truth_brand.SQL_TABLE_NAME}) s
                               #     cross join ${calendar.SQL_TABLE_NAME} c
                               #         WHERE s.symbol not in
                               #             (SELECT distinct symbol FROM ${ground_truth_financial.SQL_TABLE_NAME})
                               #     group by
                               #         s.symbol
                               #         , c.calendar_qtr

                                        ORDER BY symbol, period_type, period)

                                        ORDER BY symbol, period_type, period) two_yago_financials

                 on current_financials.row = two_yago_financials.row + 4
                 and current_financials.period_type = two_yago_financials.period_type
                 and current_financials.symbol = two_yago_financials.symbol

      ORDER BY row) financial_intervals

      LEFT JOIN (SELECT distinct symbol, period, reported_metric as reported_sales, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}) sf1

      on sf1.symbol = financial_intervals.symbol
      and sf1.period = financial_intervals.period

      LEFT JOIN (SELECT distinct symbol, period, reported_metric as reported_sales, period_start_dt, period_end_dt FROM ${ground_truth_financial.SQL_TABLE_NAME}) sf2

      on sf2.symbol = financial_intervals.symbol
      and sf2.period = financial_intervals.yago_period

      LEFT JOIN (SELECT symbol, maxdate as max_date FROM `ce-cloud-services.ce_transact_uk_daily_signal.symbol_max_date`) max

      on max.symbol = financial_intervals.symbol

      LEFT JOIN (

      (SELECT row as reported_q_num, symbol, period_type, period
       FROM

            (SELECT row_number() over(PARTITION BY symbol, period_type ORDER BY period DESC) as row, *
             FROM

                  (SELECT distinct symbol, period_type, period, reported_metric as reported_sales
                   FROM ${ground_truth_financial.SQL_TABLE_NAME}
                   WHERE reported_metric is not null
                   ORDER BY symbol, period_type, period DESC)))) latest_reported

      on latest_reported.symbol = financial_intervals.symbol
      and latest_reported.period = financial_intervals.period

      ORDER BY row


       ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
    }

    dimension: symbol {
      label: "Symbol"
      type: string
      sql: ${TABLE}.symbol ;;
    }

    dimension: financial_end_dt {
      sql: ${TABLE}.financial_end_dt ;;
    }

  }
