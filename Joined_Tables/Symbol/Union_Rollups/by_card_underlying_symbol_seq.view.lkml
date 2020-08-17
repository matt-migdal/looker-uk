view: by_card_underlying_symbol_seq {
  derived_table: {
    partition_keys: ["period_start_dt"]
    cluster_keys: ["panel_type", "period_type"]
    sql:

       SELECT und.symbol,
              und.brand_name,
              und.brand_id,
              und.cardtype,
              und.partial_period_flag,
              und.period_type,
              und.merger_type,
              und.panel_type,
              und.panel_method,
              und.cardtype_include,
              und.period,
              und.period_start_dt,
              und.ptd_end_dt,
              und.gbp_spend_amount,
              und.cad_spend_amount,
              und.usd_spend_amount,
              und.eur_spend_amount,
              und.dkk_spend_amount,
              und.nok_spend_amount,
              und.jpy_spend_amount,
              und.sek_spend_amount,
              und.pln_spend_amount,
              und.prev_period,
              und.prev_period_start_dt,
              und.prev_ptd_end_dt,
              und.prev_gbp_spend_amount,
              und.prev_cad_spend_amount,
              und.prev_usd_spend_amount,
              und.prev_eur_spend_amount,
              und.prev_dkk_spend_amount,
              und.prev_nok_spend_amount,
              und.prev_jpy_spend_amount,
              und.prev_sek_spend_amount,
              und.prev_pln_spend_amount,
              und.ptd_spend_yoy,
              und.trans_count,
              und.prev_trans_count,
              und.ptd_trans_yoy,
              und.latest_period_flag,
              und.period_day,
              und.period_end_dt,

              sd.company_name,

               CASE WHEN cardtype_include = "CREDIT_DEBIT" THEN 1
                    WHEN cardtype = "CREDIT" AND cardtype_include = "CREDIT" THEN 1
                    WHEN cardtype = "DEBIT" AND cardtype_include = "DEBIT" THEN 1
                    ELSE 0
                    END as recommended_card_type

        FROM

        (SELECT * FROM ${by_card_underlying_symbol_manda_emax_seq_rolling.SQL_TABLE_NAME}

        UNION ALL

        SELECT * FROM ${by_card_underlying_symbol_reg_emax_seq_rolling.SQL_TABLE_NAME}

        UNION ALL

        SELECT * FROM ${by_card_underlying_symbol_manda_constind_seq_rolling.SQL_TABLE_NAME}

        UNION ALL

        SELECT * FROM ${by_card_underlying_symbol_reg_constind_seq_rolling.SQL_TABLE_NAME}) und

        LEFT JOIN `ce-cloud-services.ce_transact_uk_ground_truth.symbol_detail` sd
        on und.symbol = sd.symbol

              ;;

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
      sql: ${spend_amount} / ${prev_spend_amount} - 1 ;;
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
      sql: ${trans_count} / ${prev_trans_count} - 1 ;;
      value_format_name: percent_1
    }

    measure: avg_tkt {
      type: number
      sql: ${spend_amount} / ${trans_count} ;;
      value_format_name: usd
    }

    measure: prev_avg_tkt {
      type: number
      sql: ${prev_spend_amount} / ${prev_trans_count} ;;
      value_format_name: usd
    }

    measure: ptd_avg_tkt_yoy {
      type: number
      sql: (${spend_amount} / ${trans_count}) / (${prev_spend_amount} / ${prev_trans_count}) ;;
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
