connection: "uk_daily_signal"

# include all the views
include: "/Dashboards/**/*.*"
include: "/Base_Tables/**/*.*"
include: "/Joined_Tables/**/*.*"
include: "/Live_Dashboard_Views/**/*.*"

datagroup: ce_transact_uk_daily_signal_default_datagroup {
  sql_trigger: SELECT sum(spend_amount) FROM `ce-cloud-services.ce_transact_uk_daily_signal.dist_period_sym_emax` ;;
  max_cache_age: "1 hour"
}

persist_with: ce_transact_uk_daily_signal_default_datagroup

explore: ds_discover {}

explore: financial_forecast_graph {}

explore: implied_growth {}

explore: qtd_captured_sales {}

explore: qtd_chart {}

explore: symbol_comparison {}

explore: forecast_date_intervals {}

explore: forecast_date_sums {}

explore: symbol_financials {}

explore: forecast_financial_chart {}

explore: calendar {}

explore: bu_discover {}


explore: bu_brand_comparison {}
