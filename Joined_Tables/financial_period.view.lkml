view: financial_period {
  derived_table: {
    sql:

    SELECT * FROM `ce-cloud-services.ce_transact_ground_truth.financial_period` WHERE period_type <> "FW"

    UNION ALL


    SELECT period_type, new_period as period, ya_new_period as ya_period, prev_new_period as prev_period  FROM

    (SELECT * FROM `ce-cloud-services.ce_transact_ground_truth.financial_period` WHERE period_type = "FW") fp

    LEFT JOIN

      (SELECT max(date) as new_week_end, calendar_week as new_calendar_week, concat("WE", " ", cast(max(date) as STRING)) as new_period FROM `ce-cloud-services.apollo_reference.calendar` GROUP BY calendar_week) format

      on format.new_calendar_week = fp.period

      LEFT JOIN

      (SELECT max(date) as ya_new_week_end, calendar_week as ya_new_calendar_week, concat("WE", " ", cast(max(date) as STRING)) as ya_new_period FROM `ce-cloud-services.apollo_reference.calendar` GROUP BY calendar_week) ya_format

      on ya_format.ya_new_calendar_week = fp.ya_period

        LEFT JOIN

      (SELECT max(date) as prev_new_week_end, calendar_week as prev_new_calendar_week, concat("WE", " ", cast(max(date) as STRING)) as prev_new_period FROM `ce-cloud-services.apollo_reference.calendar` GROUP BY calendar_week) prev_format

      on prev_format.prev_new_calendar_week = fp.prev_period #fp.ya_period

      WHERE ya_new_period is not null


                  ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }}
