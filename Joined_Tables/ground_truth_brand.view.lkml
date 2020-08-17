view: ground_truth_brand {
  derived_table: {
    sql:

  SELECT
   sd.symbol_id
 , sd.symbol
 , sd.company_name
 , sd.ric
 , sd.isin
 , sd.country_hq
 , sd.country_exchange
 , sd.ownership_status
 , CASE WHEN sd.ownership_status = "Public" THEN 1 ELSE 0 END as public_flag
 , ss.segment_id
 , ss.segment_name
 , ss.primary_flag
 , ss.apollo_uk_channel_publish_flag as sp_channel_publish_flag -- this is now on a scale of [0,2] instead of [0,1], also the name is still "sp_" even though its coming from symbol_segment, consider changing to "ss_"
 , "SIGNAL2" as product -- hardcoded in after removing segment product
 , "EMAX" as panel_method -- hardcoded in after removing segment product
 , CASE WHEN string_agg(distinct cardtype order by cardtype) = "CREDIT,DEBIT" THEN "CREDIT_DEBIT"
                             ELSE string_agg(distinct cardtype order by cardtype)
                             END
                             as cardtype_include -- now coming from the cross join instead of segment_product
 , sb.brand_id
 , sb.start_dt as start_date
 , sb.end_dt as end_date
 , b.brand_name
 , b.apollo_uk_channel_publish_flag as b_channel_publish_flag
FROM `ce-cloud-services.ce_transact_uk_ground_truth.symbol_detail` sd
INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.symbol_segment` ss
  ON sd.symbol_id = ss.symbol_id
CROSS JOIN unnest(["CREDIT","DEBIT"]) cardtype -- hardcoded in after removing segment_product
INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.segment_brand` sb
  ON sb.segment_id = ss.segment_id
INNER JOIN `ce-cloud-services.ce_transact_uk_ground_truth.brand` b
  ON b.brand_id = sb.brand_id
WHERE ss.primary_flag = 1
  AND sd.apollo_uk_publish_flag = 2
  AND ss.apollo_uk_publish_flag = 2
  AND sb.apollo_uk_publish_flag = 2
  AND b.apollo_uk_publish_flag = 2
GROUP BY
   sd.symbol_id
 , sd.symbol
 , sd.company_name
 , sd.ric
 , sd.isin
 , sd.country_hq
 , sd.country_exchange
 , sd.ownership_status
 , sd.apollo_uk_publish_flag
 , ss.segment_id
 , ss.segment_name
 , ss.primary_flag
 , ss.apollo_uk_channel_publish_flag
 , sb.brand_id
 , sb.start_dt
 , sb.end_dt
 , b.brand_name
 , b.apollo_uk_channel_publish_flag

              ;;

      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }}
