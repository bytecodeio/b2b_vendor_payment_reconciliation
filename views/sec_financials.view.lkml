view: sec_financials {
  sql_table_name: `sec-public-data-bq.sec_public_dataset.financial_statements` ;;

  # --- Primary Key ---
  dimension: submission_number {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.submission_number ;;
  }

  # --- Hidden Technical Fields ---
  dimension: cik {
    hidden: yes
    type: string
    sql: ${TABLE}.cik ;;
  }

  dimension: adsh {
    hidden: yes
    type: string
    sql: ${TABLE}.adsh ;;
  }

  # --- Dimensions ---
  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
    label: "Filing Company (Vendor)"
    description: "The official SEC registered name of the company."
    tags: ["Corporation", "Enterprise", "Vendor"]
  }

  dimension_group: period_end {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.period_end_date ;;
    label: "Financial Period End"
    description: "The end date for the reported financial quarter/year."
  }

  dimension: document_type {
    type: string
    sql: ${TABLE}.document_type ;;
    label: "SEC Form Type"
    description: "The type of SEC filing (e.g., 10-K, 10-Q)."
  }

  dimension: accounts_payable {
    type: number
    hidden: yes
    sql: ${TABLE}.accounts_payable ;;
  }

  # --- Measures ---
  measure: total_accounts_payable {
    type: sum
    sql: ${accounts_payable} ;;
    value_format_name: usd_0
    label: "Reported Accounts Payable"
    description: "Total accounts payable reported by the vendor in their SEC filing."
  }

  measure: average_accounts_payable {
    type: average
    sql: ${accounts_payable} ;;
    value_format_name: usd_0
    label: "Average AP"
    description: "Average accounts payable for selected filings."
  }
}
