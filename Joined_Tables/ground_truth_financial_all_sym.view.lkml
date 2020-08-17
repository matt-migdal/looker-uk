view: ground_truth_financial_all_sym {
  derived_table: {
    sql:
    SELECT
            sd.symbol_id,
            sd.symbol,
            sd.company_name,
            sd.ric,
            sd.isin,
            sd.country_hq,
            sd.country_exchange,
            sd.ownership_status,
            CASE WHEN sd.ownership_status = "Public" THEN 1 ELSE 0 END as public_flag,

            ss.segment_id,
            ss.segment_name,
            ss.primary_flag,

            sfm.financial_id,
            sfm.fundamental,
            sfm.fundamental_shortcoming,
            sfm.suggested_remedy,
            sfm.reported_metric_summary,
            sfm.reported_metric_attrib1,
            sfm.reported_metric_attrib2,
            sfm.reported_metric_attrib3,
            sfm.reported_metric_type,
            sfm.reported_metric_currency,
            sfm.financial_type,
            sfm.period,
            sfm.period_start_dt,
            sfm.period_end_dt,
            sfm.reported_metric,
            sfm.est_date_flag,

            cfm.consensus_id,
            cfm.external_identifier,
            cfm.consensus_source,
            cfm.consensus_note,
            cfm.metric_unit,
            cfm.metric_currency,

            cp.period as consensus_period,
            cp.metric as consensus_metric

    FROM `ce-cloud-services.ce_transact_uk_ground_truth.symbol_detail` sd
    INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.symbol_segment` ss
      ON sd.symbol_id = ss.symbol_id
      AND ss.primary_flag = 1
    LEFT JOIN (SELECT sfm.segment_id,
                      sfm.financial_id,
                      sfm.fundamental,
                      sfm.fundamental_shortcoming,
                      sfm.suggested_remedy,

                      fmd.reported_metric_summary,
                      fmd.reported_metric_attrib1,
                      fmd.reported_metric_attrib2,
                      fmd.reported_metric_attrib3,
                      fmd.reported_metric_type,
                      fmd.reported_metric_currency,
                      fmd.financial_type,

                      smp.period,
                      smp.period_start_dt,
                      smp.period_end_dt,
                      smp.reported_metric,
                      smp.est_date_flag
              FROM `ce-cloud-services.ce_transact_uk_ground_truth.segment_financial_metric` sfm
              INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.financial_metric_detail` fmd
                ON sfm.financial_id = fmd.financial_id and fmd.apollo_uk_publish_flag = 2 and fmd.financial_type = "TOT_REV"
              INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.financial_metric_period` smp
                ON fmd.financial_id = smp.financial_id) sfm
      ON ss.segment_id = sfm.segment_id
    LEFT JOIN `ce-cloud-services.ce_transact_uk_ground_truth.consensus_financial_metric` cfm
      on sfm.financial_id = cfm.financial_id
      and cfm.apollo_uk_publish_flag = 2
    LEFT JOIN `ce-cloud-services.ce_transact_uk_ground_truth.consensus_period`  cp
      on cp.consensus_id = cfm.consensus_id
    WHERE sd.apollo_uk_publish_flag = 2
    and ss.apollo_uk_publish_flag = 2;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
    }}
