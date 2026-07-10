view: sec_financials {
    # We use a derived table to join the submissions (company info)
    # and numbers (financial metrics) from the new public dataset
    # to perfectly match our dashboard's expected schema.
    derived_table: {
      sql:
      SELECT
        s.adsh AS submission_number,
        CAST(s.cik AS STRING) AS cik,
        s.adsh AS adsh,
        s.name AS company_name,
        CAST(s.period AS TIMESTAMP) AS period_end_date,
        s.form AS document_type,
        CAST(n.value AS FLOAT64) AS accounts_payable
      FROM `bigquery-public-data.sec_quarterly_financials.sub` AS s
      INNER JOIN `bigquery-public-data.sec_quarterly_financials.numbers` AS n
        ON s.adsh = n.adsh
      WHERE n.tag IN ('AccountsPayableCurrent', 'AccountsPayable')
        AND n.qtrs = 0 -- 0 quarters means point-in-time balance sheet items
    ;;
    }

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
