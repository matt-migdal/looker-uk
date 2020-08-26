view: calendar {
  derived_table: {
    sql:

    SELECT

    c.date, c.year, c.month, c.day, c.day_of_year,

    c.weeknum, c.weekday, c.weekdaynum,

    c.calendar_qtr, c.calendar_month, concat("WE", " ", cast(we.week_end as STRING)) as calendar_week,

    c.bank_holiday_flag, c.major_holiday_flag,

    c.calendar_qtr_jan, c.calendar_qtr_feb, c.calendar_month_name, c.calendar_qtr_name, c.calendar_qtr_jan_name, c.calendar_qtr_feb_name,

    c.calendar_half, c.uk_bank_holiday_flag, c.uk_major_holiday_flag

    FROM `ce-cloud-services.ce_transact_uk.calendar` c

    LEFT JOIN (SELECT max(date) as week_end, calendar_week FROM `ce-cloud-services.apollo_reference.calendar` GROUP BY calendar_week) we

    on c.calendar_week = we.calendar_week


              ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }

    dimension: calendar_half {
      sql: ${TABLE}.calendar_half ;;
    }
    }
