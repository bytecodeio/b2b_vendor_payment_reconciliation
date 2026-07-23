
view: sec_financials {
  sql_table_name: `bigquery-public-data.sec_quarterly_financials.quick_summary` ;;

  # --- Primary Key ---
  dimension: submission_number {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.submission_number ;;
  }

  # --- Dimensions ---
  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
    label: "Filing Company (Vendor)"
    description: "The official SEC registered name of the company."
    tags: ["Corporation", "Enterprise", "Vendor"]
  }

  dimension: measure_tag {
    type: string
    sql: ${TABLE}.measure_tag ;;
    hidden: yes
  }

  dimension: number_of_quarters {
    type: number
    sql: ${TABLE}.number_of_quarters ;;
    hidden: yes
  }

  dimension_group: period_end {
    type: time
    timeframes: [raw, date, month, quarter, year]
    #sql: ${TABLE}.period_end_date ;;
    sql: TIMESTAMP( DATE_ADD(  PARSE_DATE('%Y%m%d', CAST(${TABLE}.period_end_date AS STRING)), INTERVAL (EXTRACT(YEAR FROM CURRENT_DATE()) - 2020) YEAR)) ;;
    label: "Financial Period End"
    description: "The end date for the reported financial month."
  }

  dimension_group: period_end_original {
    hidden: yes
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: PARSE_TIMESTAMP('%Y%m%d', CAST(${TABLE}.period_end_date AS STRING))  ;;
    label: "Financial Period End Original"
    description: "The dynamically shifted end date for the reported financial quarter/year."
  }

  dimension: document_type {
    type: string
    sql: ${TABLE}.form ;;
    label: "SEC Form Type"
    description: "The type of SEC filing (e.g., 10-K, 10-Q)."
  }

  dimension: accounts_payable {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.value AS FLOAT64) ;;
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
