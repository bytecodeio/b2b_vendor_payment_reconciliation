connection: "bigquery_public_data"

include: "/views/*.view"
include: "/dashboards/vendor_reconciliation_and_aging.dashboard.lookml"

explore: iowa_liquor_sales {
  label: "1. Retail Liquor Supply Chain"
  description: "Explore wholesale liquor purchases by retail stores across Iowa. Use this to analyze demand forecasting, vendor volume, and state distribution trends."

}

explore: sec_financials {
  label: "2. Vendor Financial Health (SEC)"
  description: "Explore quarterly and annual financial statement data from the SEC. Use this to reconcile vendor financial health, accounts payable, and corporate cash flow."

  sql_always_where: ${sec_financials.period_end_original_raw} < (TIMESTAMP('2021-01-01 00:00:00', 'America/Los_Angeles'))
  AND ${sec_financials.measure_tag} IN ('OperatingExpenses', 'CostOfRevenue', 'CostsAndExpenses')
  AND (${sec_financials.number_of_quarters} = 0 OR ${sec_financials.number_of_quarters} IS NULL) ;;
}
