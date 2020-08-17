view: dist_day_sym_brand_cardtype_emax_currency {
  derived_table: {
    sql:

    SELECT base.version,
           base.symbol,
           base.brand_name,
           base.brand_id,
           base.cardtype,
           base.trans_date,
           base.trans_count,
           base.spend_amount as gbp_spend_amount,
           base.spend_amount*cad.exchange_rate as cad_spend_amount,
           base.spend_amount*usd.exchange_rate as usd_spend_amount,
           base.spend_amount*eur.exchange_rate as eur_spend_amount,
           base.spend_amount*dkk.exchange_rate as dkk_spend_amount,
           base.spend_amount*nok.exchange_rate as nok_spend_amount,
           base.spend_amount*jpy.exchange_rate as jpy_spend_amount,
           base.spend_amount*sek.exchange_rate as sek_spend_amount,
           base.spend_amount*pln.exchange_rate as pln_spend_amount,
           base.est_rec_pct
    FROM `ce-cloud-services.ce_transact_uk_daily_signal.dist_day_sym_brand_cardtype_emax` base
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'CAD') cad
    ON base.trans_date = cad.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'USD') usd
    ON base.trans_date = usd.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'EUR') eur
    ON base.trans_date = eur.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'DKK') dkk
    ON base.trans_date = dkk.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'NOK') nok
    ON base.trans_date = nok.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'JPY') jpy
    ON base.trans_date = jpy.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'SEK') sek
    ON base.trans_date = sek.exchange_dt
    LEFT JOIN (select * from `ce-cloud-services.currency_exchange_rate.exchange_rate`
               WHERE base_currency = 'GBP' AND currency_code = 'PLN') pln
    ON base.trans_date = pln.exchange_dt
    ;;
    datagroup_trigger: ce_transact_uk_daily_signal_default_datagroup
  }
}
