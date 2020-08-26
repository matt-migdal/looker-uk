view: universe_by_card_channel_underlying_brand_fix_seq_rolling {

  derived_table: {
    sql:

       SELECT und.brand_name,
              und.brand_id,
              /* und.channel, */
              und.partial_period_flag,
              und.period_type,
              und.merger_type,
              und.panel_type,
              und.panel_method,
              und.period,
              und.period_start_dt,
              und.ptd_end_dt,
              und.gbp_spend_amount
              , und.cad_spend_amount
              , und.usd_spend_amount
              , und.eur_spend_amount
              , und.dkk_spend_amount
              , und.nok_spend_amount
              , und.jpy_spend_amount
              , und.sek_spend_amount
              , und.pln_spend_amount
              , und.prev_spend_amount_gbp
              , und.prev_spend_amount_cad
              , und.prev_spend_amount_usd
              , und.prev_spend_amount_eur
              , und.prev_spend_amount_dkk
              , und.prev_spend_amount_nok
              , und.prev_spend_amount_jpy
              , und.prev_spend_amount_sek
              , und.prev_spend_amount_pln
              , und.ptd_spend_yoy_gbp
              , und.ptd_spend_yoy_cad
              , und.ptd_spend_yoy_usd
              , und.ptd_spend_yoy_eur
              , und.ptd_spend_yoy_dkk
              , und.ptd_spend_yoy_nok
              , und.ptd_spend_yoy_jpy
              , und.ptd_spend_yoy_sek
              , und.ptd_spend_yoy_pln
              , und.avg_tkt_gbp
              , und.avg_tkt_cad
              , und.avg_tkt_usd
              , und.avg_tkt_eur
              , und.avg_tkt_dkk
              , und.avg_tkt_nok
              , und.avg_tkt_jpy
              , und.avg_tkt_sek
              , und.avg_tkt_pln
              , und.prev_avg_tkt_gbp
              , und.prev_avg_tkt_cad
              , und.prev_avg_tkt_usd
              , und.prev_avg_tkt_eur
              , und.prev_avg_tkt_dkk
              , und.prev_avg_tkt_nok
              , und.prev_avg_tkt_jpy
              , und.prev_avg_tkt_sek
              , und.prev_avg_tkt_pln
              , und.ptd_avg_tkt_yoy_gbp
              , und.ptd_avg_tkt_yoy_cad
              , und.ptd_avg_tkt_yoy_usd
              , und.ptd_avg_tkt_yoy_eur
              , und.ptd_avg_tkt_yoy_dkk
              , und.ptd_avg_tkt_yoy_nok
              , und.ptd_avg_tkt_yoy_jpy
              , und.ptd_avg_tkt_yoy_sek
              , und.ptd_avg_tkt_yoy_pln
              , und.prev_period
              , und.prev_period_start_dt
              , und.prev_ptd_end_dt
              , und.trans_count
              , und.prev_trans_count
              , und.ptd_trans_yoy
              , und.latest_period_flag
              , und.period_day
              , und.period_end_dt

        FROM

       (
        SELECT brand_name,
                brand_id,
                /* channel, */
                partial_period_flag,
                period_type,
                merger_type,
                panel_type,
                panel_method,
                period,
                period_start_dt,
                ptd_end_dt,
               gbp_spend_amount
              , cad_spend_amount
              , usd_spend_amount
              , eur_spend_amount
              , dkk_spend_amount
              , nok_spend_amount
              , jpy_spend_amount
              , sek_spend_amount
              , pln_spend_amount
              , prev_spend_amount_gbp
              , prev_spend_amount_cad
              , prev_spend_amount_usd
              , prev_spend_amount_eur
              , prev_spend_amount_dkk
              , prev_spend_amount_nok
              , prev_spend_amount_jpy
              , prev_spend_amount_sek
              , prev_spend_amount_pln
              , ptd_spend_yoy_gbp
              , ptd_spend_yoy_cad
              , ptd_spend_yoy_usd
              , ptd_spend_yoy_eur
              , ptd_spend_yoy_dkk
              , ptd_spend_yoy_nok
              , ptd_spend_yoy_jpy
              , ptd_spend_yoy_sek
              , ptd_spend_yoy_pln
              , avg_tkt_gbp
              , avg_tkt_cad
              , avg_tkt_usd
              , avg_tkt_eur
              , avg_tkt_dkk
              , avg_tkt_nok
              , avg_tkt_jpy
              , avg_tkt_sek
              , avg_tkt_pln
              , prev_avg_tkt_gbp
              , prev_avg_tkt_cad
              , prev_avg_tkt_usd
              , prev_avg_tkt_eur
              , prev_avg_tkt_dkk
              , prev_avg_tkt_nok
              , prev_avg_tkt_jpy
              , prev_avg_tkt_sek
              , prev_avg_tkt_pln
              , ptd_avg_tkt_yoy_gbp
              , ptd_avg_tkt_yoy_cad
              , ptd_avg_tkt_yoy_usd
              , ptd_avg_tkt_yoy_eur
              , ptd_avg_tkt_yoy_dkk
              , ptd_avg_tkt_yoy_nok
              , ptd_avg_tkt_yoy_jpy
              , ptd_avg_tkt_yoy_sek
              , ptd_avg_tkt_yoy_pln
              , prev_period
              , prev_period_start_dt
              , prev_ptd_end_dt
              , trans_count
              , prev_trans_count
              , ptd_trans_yoy
              , latest_period_flag
              , period_day
              , period_end_dt
        FROM ${universe_by_card_channel_brand_reg_constind_seq_rolling.SQL_TABLE_NAME} WHERE merger_type = "NONE"

        UNION ALL

        SELECT brand_name,
                brand_id,
                /* channel, */
                partial_period_flag,
                period_type,
                merger_type,
                panel_type,
                panel_method,
                period,
                period_start_dt,
                ptd_end_dt,
                gbp_spend_amount
              , cad_spend_amount
              , usd_spend_amount
              , eur_spend_amount
              , dkk_spend_amount
              , nok_spend_amount
              , jpy_spend_amount
              , sek_spend_amount
              , pln_spend_amount
              , prev_spend_amount_gbp
              , prev_spend_amount_cad
              , prev_spend_amount_usd
              , prev_spend_amount_eur
              , prev_spend_amount_dkk
              , prev_spend_amount_nok
              , prev_spend_amount_jpy
              , prev_spend_amount_sek
              , prev_spend_amount_pln
              , ptd_spend_yoy_gbp
              , ptd_spend_yoy_cad
              , ptd_spend_yoy_usd
              , ptd_spend_yoy_eur
              , ptd_spend_yoy_dkk
              , ptd_spend_yoy_nok
              , ptd_spend_yoy_jpy
              , ptd_spend_yoy_sek
              , ptd_spend_yoy_pln
              , avg_tkt_gbp
              , avg_tkt_cad
              , avg_tkt_usd
              , avg_tkt_eur
              , avg_tkt_dkk
              , avg_tkt_nok
              , avg_tkt_jpy
              , avg_tkt_sek
              , avg_tkt_pln
              , prev_avg_tkt_gbp
              , prev_avg_tkt_cad
              , prev_avg_tkt_usd
              , prev_avg_tkt_eur
              , prev_avg_tkt_dkk
              , prev_avg_tkt_nok
              , prev_avg_tkt_jpy
              , prev_avg_tkt_sek
              , prev_avg_tkt_pln
              , ptd_avg_tkt_yoy_gbp
              , ptd_avg_tkt_yoy_cad
              , ptd_avg_tkt_yoy_usd
              , ptd_avg_tkt_yoy_eur
              , ptd_avg_tkt_yoy_dkk
              , ptd_avg_tkt_yoy_nok
              , ptd_avg_tkt_yoy_jpy
              , ptd_avg_tkt_yoy_sek
              , ptd_avg_tkt_yoy_pln
              , prev_period
              , prev_period_start_dt
              , prev_ptd_end_dt
              , trans_count
              , prev_trans_count
              , ptd_trans_yoy
              , latest_period_flag
              , period_day
              , period_end_dt
        FROM ${universe_by_card_channel_brand_reg_emax_seq_rolling.SQL_TABLE_NAME} WHERE merger_type = "NONE") und

              ;;

      partition_keys: ["period_start_dt"]
      cluster_keys: ["panel_type", "period_type"]
      datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup

    }

    dimension: symbol {
      type: string
      sql: ${TABLE}.symbol ;;
    }

    dimension: brand_name {
      type: string
      sql: ${TABLE}.brand_name ;;
    }

    dimension: brand_id {
      type: number
      sql: ${TABLE}.brand_id ;;
    }

    dimension: cardtype {
      type: string
      sql: ${TABLE}.cardtype ;;
    }

    dimension: partial_period_flag {
      type: number
      sql: ${TABLE}.partial_period_flag ;;
    }

    dimension: period_type {
      type: string
      sql: ${TABLE}.period_type ;;
    }

    dimension: merger_type {
      type: string
      sql: ${TABLE}.merger_type ;;
    }

    dimension: panel_type {
      type: string
      sql: ${TABLE}.panel_type ;;
    }

    dimension: panel_method {
      type: string
      sql: ${TABLE}.panel_method ;;
    }

    dimension: cardtype_include {
      type: string
      sql: ${TABLE}.cardtype_include ;;
    }

    dimension: period {
      type: string
      sql: ${TABLE}.period ;;
    }

    dimension_group: period_start_dt {
      type: time
      sql: ${TABLE}.period_start_dt ;;
      timeframes: [raw]
      convert_tz: no
      datatype: date
    }

    dimension_group: ptd_end_dt {
      type: time
      sql: ${TABLE}.ptd_end_dt ;;
      timeframes: [raw]
      convert_tz: no
      datatype: date
    }

    measure: spend_amount {
      type: sum
      sql: ${TABLE}.spend_amount ;;
      value_format_name: usd_0
    }

    dimension: prev_period {
      type: string
      sql: ${TABLE}.prev_period ;;
    }

    dimension_group: prev_period_start_dt {
      type: time
      sql: ${TABLE}.prev_period_start_dt ;;
      timeframes: [raw]
      convert_tz: no
      datatype: date
    }

    dimension_group: prev_ptd_end_dt {
      type: time
      sql: ${TABLE}.prev_ptd_end_dt ;;
      timeframes: [raw]
      convert_tz: no
      datatype: date
    }

    measure: prev_spend_amount {
      type: sum
      sql: ${TABLE}.prev_spend_amount ;;
      value_format_name: usd_0
    }

    measure: ptd_spend_yoy {
      type: number
      sql: ${spend_amount} / nullif(${prev_spend_amount},0) - 1 ;;
      value_format_name: percent_1
    }

    measure: trans_count {
      type: sum
      sql: ${TABLE}.trans_count ;;
      value_format_name: decimal_0
    }

    measure: prev_trans_count {
      type: sum
      sql: ${TABLE}.prev_trans_count ;;
      value_format_name: decimal_0
    }

    measure: ptd_trans_yoy {
      type: number
      sql: ${trans_count} / nullif(${prev_trans_count},0) - 1 ;;
      value_format_name: percent_1
    }

    measure: avg_tkt {
      type: number
      sql: ${spend_amount} / nullif(${trans_count},0) ;;
      value_format_name: usd
    }

    measure: prev_avg_tkt {
      type: number
      sql: ${prev_spend_amount} / nullif(${prev_trans_count},0) ;;
      value_format_name: usd
    }

    measure: ptd_avg_tkt_yoy {
      type: number
      sql: (${spend_amount} / nullif(${trans_count},0)) / nullif((${prev_spend_amount} / nullif(${prev_trans_count},0)),0) ;;
      value_format_name: percent_1
    }

    dimension: latest_period_flag {
      type: number
      sql: ${TABLE}.latest_period_flag ;;
    }

    dimension: period_day {
      type: number
      sql: ${TABLE}.period_day ;;
    }

    dimension_group: period_end_dt {
      type: time
      sql: ${TABLE}.period_end_dt ;;
      timeframes: [raw]
      convert_tz: no
      datatype: date
    }

  }
