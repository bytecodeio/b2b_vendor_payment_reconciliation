- dashboard: vendor_reconciliation_and_aging
  title: "Enterprise B2B Operations: Vendor Reconciliation, Finance & Retail Sales"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Comprehensive 30-tile dashboard covering Retail, Finance, Sales, and Marketing. Cross-examines Iowa wholesale liquor demand against SEC public vendor financial health."

  # ==========================================
  # 10 COMPLEX FILTERS
  # ==========================================
  filters:
  - name: Order Date Range
    title: Order Date Range
    type: date_filter
    default_value: "2016/01/01 to 2020/12/31"

  - name: Financial Period
    title: Financial Period
    type: date_filter
    default_value: "2016/01/01 to 2020/12/31"

  - name: Vendor Name (Iowa)
    title: Vendor Name (Iowa)
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    field: iowa_liquor_sales.vendor_name

  - name: SEC Company Name
    title: SEC Company Name
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    field: sec_financials.company_name

  - name: Store City
    title: Store City
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    field: iowa_liquor_sales.city

  - name: Liquor Category
    title: Liquor Category
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    field: iowa_liquor_sales.category_name

  - name: SEC Document Type
    title: SEC Document Type
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    field: sec_financials.document_type

  - name: Retail Store Name
    title: Retail Store Name
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    field: iowa_liquor_sales.store_name

  - name: Item Description
    title: Item Description
    type: field_filter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    field: iowa_liquor_sales.item_description

  - name: Min Order Value
    title: Min Order Value
    type: number_filter
    default_value: ">0"

  # ==========================================
  # 30 DASHBOARD TILES (Across Multiple Personas)
  # ==========================================
  elements:

  # --- SCORECARDS (Tiles 1-4) ---
  - name: tile_1_revenue
    title: "Total Wholesale Revenue (Retail)"
    type: single_value
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    measures: [iowa_liquor_sales.total_sale_dollars]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name

  - name: tile_2_bottles
    title: "Total Bottles Distributed (Supply Chain)"
    type: single_value
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    measures: [iowa_liquor_sales.total_bottles_sold]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city

  - name: tile_3_aov
    title: "Average Order Value (Sales)"
    type: single_value
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    measures: [iowa_liquor_sales.average_order_value]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Min Order Value: iowa_liquor_sales.average_order_value

  - name: tile_4_ap
    title: "Total Accounts Payable (Finance)"
    type: single_value
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    measures: [sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date
      SEC Company Name: sec_financials.company_name

  # --- MERGED QUERIES (Tiles 5-6) ---
  # Resolved: Listen arrays fully cleaned and sub-queries isolated
  - name: tile_5_merged_reconciliation
    title: "Vendor Reconciliation Matrix (Merged Query)"
    type: table
    merged_queries:
    - model: b2b_vendor_payment_reconciliation
      explore: iowa_liquor_sales
      fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_sale_dollars]
    - model: b2b_vendor_payment_reconciliation
      explore: sec_financials
      fields: [sec_financials.company_name, sec_financials.total_accounts_payable]
      join_fields:
      - field_name: sec_financials.company_name
        source_field_name: iowa_liquor_sales.vendor_name

  - name: tile_6_merged_health
    title: "Vendor Financial Health vs Volume (Merged Query)"
    type: looker_scatter
    merged_queries:
    - model: b2b_vendor_payment_reconciliation
      explore: iowa_liquor_sales
      fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_bottles_sold]
    - model: b2b_vendor_payment_reconciliation
      explore: sec_financials
      fields: [sec_financials.company_name, sec_financials.average_accounts_payable]
      join_fields:
      - field_name: sec_financials.company_name
        source_field_name: iowa_liquor_sales.vendor_name

  # --- FINANCE DEEP DIVE (Tiles 7-10) ---
  - name: tile_7_ap_trend
    title: "Accounts Payable Trend by Quarter"
    type: looker_area
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    dimensions: [sec_financials.period_end_quarter]
    measures: [sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date

  - name: tile_8_ap_by_company
    title: "Top Vendors by Accounts Payable"
    type: looker_bar
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    dimensions: [sec_financials.company_name]
    measures: [sec_financials.total_accounts_payable]
    sorts: [sec_financials.total_accounts_payable desc]
    limit: 10
    listen:
      Financial Period: sec_financials.period_end_date

  - name: tile_9_avg_ap_trend
    title: "Average AP Fluctuation"
    type: looker_line
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    dimensions: [sec_financials.period_end_month]
    measures: [sec_financials.average_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date

  - name: tile_10_doc_type_breakdown
    title: "Filings by Document Type"
    type: looker_pie
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    dimensions: [sec_financials.document_type]
    measures: [sec_financials.total_accounts_payable]
    listen:
      SEC Document Type: sec_financials.document_type

  # --- RETAIL & SUPPLY CHAIN (Tiles 11-16) ---
  - name: tile_11_sales_pivot
    title: "Revenue by Top Cities (Pivoted by Category)"
    type: looker_column
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.city]
    pivots: [iowa_liquor_sales.category_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.total_sale_dollars desc 0]
    limit: 10
    stacking: normal
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
      Liquor Category: iowa_liquor_sales.category_name

  - name: tile_12_bottle_volume
    title: "Bottle Volume Distribution"
    type: looker_pie
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.category_name]
    measures: [iowa_liquor_sales.total_bottles_sold]
    limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name

  - name: tile_13_store_performance
    title: "Top 15 Stores by Revenue"
    type: looker_bar
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.store_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 15
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Retail Store Name: iowa_liquor_sales.store_name

  - name: tile_14_city_volume_map
    title: "Bottle Volume by City"
    type: looker_pie
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.city]
    measures: [iowa_liquor_sales.total_bottles_sold]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city

  - name: tile_15_category_revenue
    title: "Revenue by Liquor Category"
    type: looker_column
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.category_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name

  - name: tile_16_revenue_trend
    title: "Wholesale Revenue Trend Over Time"
    type: looker_line
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.date_month]
    measures: [iowa_liquor_sales.total_sale_dollars]
    listen:
      Order Date Range: iowa_liquor_sales.date_date

  # --- MARKETING & SALES (Tiles 17-22) ---
  - name: tile_17_vendor_market_share
    title: "Vendor Market Share (Revenue)"
    type: looker_pie
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.vendor_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    limit: 8
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name

  - name: tile_18_aov_by_category
    title: "AOV by Category"
    type: looker_bar
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.category_name]
    measures: [iowa_liquor_sales.average_order_value]
    sorts: [iowa_liquor_sales.average_order_value desc]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name

  - name: tile_19_top_items
    title: "Top 10 Best Selling Items"
    type: looker_grid
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.item_description]
    measures: [iowa_liquor_sales.total_sale_dollars, iowa_liquor_sales.total_bottles_sold]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Item Description: iowa_liquor_sales.item_description

  - name: tile_20_aov_trend
    title: "Average Order Value Trend"
    type: looker_area
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.date_quarter]
    measures: [iowa_liquor_sales.average_order_value]
    listen:
      Order Date Range: iowa_liquor_sales.date_date

  - name: tile_21_sales_scatter
    title: "Order Value vs Bottles Sold"
    type: looker_scatter
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.vendor_name]
    measures: [iowa_liquor_sales.average_order_value, iowa_liquor_sales.total_bottles_sold]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name

  - name: tile_22_vendor_pivot
    title: "Vendor Volume Pivoted by Year"
    type: table
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.vendor_name]
    pivots: [iowa_liquor_sales.date_year]
    measures: [iowa_liquor_sales.total_bottles_sold]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name

  # --- CUSTOM FIELDS & TABLE CALCS (Tiles 23-26) ---
  - name: tile_23_margin_proxy
    title: "Store Estimated Profit Margin (Table Calc)"
    type: table
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.store_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    dynamic_fields:
    - table_calculation: estimated_profit_25_pct
      label: "Estimated 25% Profit Proxy"
      expression: "${iowa_liquor_sales.total_sale_dollars} * 0.25"
      value_format_name: usd
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Retail Store Name: iowa_liquor_sales.store_name

  - name: tile_24_yoy_growth
    title: "YoY Revenue Growth (Table Calc)"
    type: looker_column
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.date_year]
    measures: [iowa_liquor_sales.total_sale_dollars]
    dynamic_fields:
    - table_calculation: yoy_growth
      label: "YoY Growth"
      expression: "(${iowa_liquor_sales.total_sale_dollars} / offset(${iowa_liquor_sales.total_sale_dollars}, 1)) - 1"
      value_format_name: percent_2
    listen:
      Order Date Range: iowa_liquor_sales.date_date

  - name: tile_25_aov_variance
    title: "AOV Variance by City"
    type: looker_bar
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.city]
    measures: [iowa_liquor_sales.average_order_value]
    dynamic_fields:
    - table_calculation: variance_from_mean
      label: "Variance from Average"
      expression: "${iowa_liquor_sales.average_order_value} - mean(${iowa_liquor_sales.average_order_value})"
      value_format_name: usd
    limit: 15
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city

  - name: tile_26_bottle_share
    title: "% of Total Bottles by Category"
    type: table
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.category_name]
    measures: [iowa_liquor_sales.total_bottles_sold]
    dynamic_fields:
    - table_calculation: percent_of_total
      label: "% of Total Volume"
      expression: "${iowa_liquor_sales.total_bottles_sold} / sum(${iowa_liquor_sales.total_bottles_sold})"
      value_format_name: percent_2
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name

  # --- ADDITIONAL GRANULAR DEEP DIVES (Tiles 27-30) ---
  - name: tile_27_recent_orders
    title: "50 Most Recent Orders (Raw Data)"
    type: looker_grid
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.date_date, iowa_liquor_sales.store_name, iowa_liquor_sales.vendor_name, iowa_liquor_sales.item_description]
    measures: [iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.date_date desc]
    limit: 50
    listen:
      Order Date Range: iowa_liquor_sales.date_date

  - name: tile_28_city_vendor_matrix
    title: "City vs Vendor Revenue Matrix"
    type: looker_grid
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.city]
    pivots: [iowa_liquor_sales.vendor_name]
    measures: [iowa_liquor_sales.total_sale_dollars]
    limit: 10
    column_limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name

  - name: tile_29_sec_filing_dates
    title: "Recent SEC Filings Volume"
    type: looker_column
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    dimensions: [sec_financials.period_end_month]
    measures: [sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date

  - name: tile_30_executive_summary
    title: "Executive KPI Summary Table"
    type: table
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    dimensions: [iowa_liquor_sales.vendor_name]
    measures: [iowa_liquor_sales.total_sale_dollars, iowa_liquor_sales.total_bottles_sold, iowa_liquor_sales.average_order_value]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
