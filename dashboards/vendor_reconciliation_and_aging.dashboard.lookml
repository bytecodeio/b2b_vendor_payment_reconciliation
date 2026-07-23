---
- dashboard: enterprise_b2b_operations_vendor_reconciliation_finance__retail_sales
  title: 'Enterprise B2B Operations: Vendor Reconciliation, Finance & Retail Sales'
  preferred_viewer: dashboards-next
  description: Comprehensive 30-tile dashboard covering Retail, Finance, Sales, and
    Marketing. Cross-examines Iowa wholesale liquor demand against SEC public vendor
    financial health.
  preferred_slug: qBojuUwCVVfTullYBqQ7tq
  theme_name: ''
  layout_granularity: granular
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Total Wholesale Revenue (Retail)
    name: Total Wholesale Revenue (Retail)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: single_value
    fields: [iowa_liquor_sales.total_sale_dollars]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 0
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Total Bottles Distributed (Supply Chain)
    name: Total Bottles Distributed (Supply Chain)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: single_value
    fields: [iowa_liquor_sales.total_bottles_sold]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
    row: 0
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Average Order Value (Sales)
    name: Average Order Value (Sales)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: single_value
    fields: [iowa_liquor_sales.average_order_value]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Min Order Value: iowa_liquor_sales.average_order_value
    row: 0
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Total Accounts Payable (Finance)
    name: Total Accounts Payable (Finance)
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: single_value
    fields: [sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date
      SEC Company Name: sec_financials.company_name
    row: 12
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - name: Vendor Reconciliation Matrix (Merged Query)
    title: Vendor Reconciliation Matrix (Merged Query)
    merged_queries:
    - model: b2b_vendor_payment_reconciliation
      explore: iowa_liquor_sales
      type: table
      fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_sale_dollars]
      join_fields: []
    - model: b2b_vendor_payment_reconciliation
      explore: sec_financials
      type: table
      fields: [sec_financials.company_name, sec_financials.total_accounts_payable]
      join_fields:
      - field_name: sec_financials.company_name
        source_field_name: iowa_liquor_sales.vendor_name
    type: table
    column_limit: 50
    row: 12
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - name: Vendor Financial Health vs Volume (Merged Query)
    title: Vendor Financial Health vs Volume (Merged Query)
    merged_queries:
    - model: b2b_vendor_payment_reconciliation
      explore: iowa_liquor_sales
      type: table
      fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_bottles_sold]
      join_fields: []
    - model: b2b_vendor_payment_reconciliation
      explore: sec_financials
      type: table
      fields: [sec_financials.company_name, sec_financials.average_accounts_payable]
      join_fields:
      - field_name: sec_financials.company_name
        source_field_name: iowa_liquor_sales.vendor_name
    type: looker_scatter
    column_limit: 50
    row: 12
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Accounts Payable Trend by Quarter
    name: Accounts Payable Trend by Quarter
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: looker_area
    fields: [sec_financials.period_end_quarter, sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date
    row: 24
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Top Vendors by Accounts Payable
    name: Top Vendors by Accounts Payable
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: looker_bar
    fields: [sec_financials.company_name, sec_financials.total_accounts_payable]
    sorts: [sec_financials.total_accounts_payable desc]
    limit: 10
    listen:
      Financial Period: sec_financials.period_end_date
    row: 24
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Average AP Fluctuation
    name: Average AP Fluctuation
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: looker_line
    fields: [sec_financials.period_end_month, sec_financials.average_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date
    row: 24
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Filings by Document Type
    name: Filings by Document Type
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: looker_pie
    fields: [sec_financials.document_type, sec_financials.total_accounts_payable]
    listen:
      SEC Document Type: sec_financials.document_type
    row: 36
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Revenue by Top Cities (Pivoted by Category)
    name: Revenue by Top Cities (Pivoted by Category)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_column
    fields: [iowa_liquor_sales.city, iowa_liquor_sales.total_sale_dollars, iowa_liquor_sales.category_name]
    pivots: [iowa_liquor_sales.category_name]
    sorts: [iowa_liquor_sales.total_sale_dollars desc 0]
    limit: 10
    stacking: normal
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
      Liquor Category: iowa_liquor_sales.category_name
    row: 36
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Bottle Volume Distribution
    name: Bottle Volume Distribution
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_pie
    fields: [iowa_liquor_sales.category_name, iowa_liquor_sales.total_bottles_sold]
    limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name
    row: 36
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Top 15 Stores by Revenue
    name: Top 15 Stores by Revenue
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_bar
    fields: [iowa_liquor_sales.store_name, iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 15
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Retail Store Name: iowa_liquor_sales.store_name
    row: 48
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Bottle Volume by City
    name: Bottle Volume by City
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_pie
    fields: [iowa_liquor_sales.city, iowa_liquor_sales.total_bottles_sold]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
    row: 48
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Revenue by Liquor Category
    name: Revenue by Liquor Category
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_column
    fields: [iowa_liquor_sales.category_name, iowa_liquor_sales.total_sale_dollars]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name
    row: 48
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Wholesale Revenue Trend Over Time
    name: Wholesale Revenue Trend Over Time
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_line
    fields: [iowa_liquor_sales.date_month, iowa_liquor_sales.total_sale_dollars]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
    row: 60
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Vendor Market Share (Revenue)
    name: Vendor Market Share (Revenue)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_pie
    fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_sale_dollars]
    limit: 8
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 60
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: AOV by Category
    name: AOV by Category
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_bar
    fields: [iowa_liquor_sales.category_name, iowa_liquor_sales.average_order_value]
    sorts: [iowa_liquor_sales.average_order_value desc]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name
    row: 60
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Top 10 Best Selling Items
    name: Top 10 Best Selling Items
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_grid
    fields: [iowa_liquor_sales.item_description, iowa_liquor_sales.total_sale_dollars,
      iowa_liquor_sales.total_bottles_sold]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Item Description: iowa_liquor_sales.item_description
    row: 72
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Average Order Value Trend
    name: Average Order Value Trend
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_area
    fields: [iowa_liquor_sales.date_quarter, iowa_liquor_sales.average_order_value]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
    row: 72
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Order Value vs Bottles Sold
    name: Order Value vs Bottles Sold
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_scatter
    fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.average_order_value,
      iowa_liquor_sales.total_bottles_sold]
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 72
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: Vendor Volume Pivoted by Year
    name: Vendor Volume Pivoted by Year
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: table
    fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_bottles_sold,
      iowa_liquor_sales.date_year]
    pivots: [iowa_liquor_sales.date_year]
    limit: 10
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 84
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Store Estimated Profit Margin (Table Calc)
    name: Store Estimated Profit Margin (Table Calc)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: table
    fields: [iowa_liquor_sales.store_name, iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 10
    dynamic_fields:
    - table_calculation: estimated_profit_25_pct
      label: Estimated 25% Profit Proxy
      expression: "${iowa_liquor_sales.total_sale_dollars} * 0.25"
      value_format_name: usd
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Retail Store Name: iowa_liquor_sales.store_name
    row: 84
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: YoY Revenue Growth (Table Calc)
    name: YoY Revenue Growth (Table Calc)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_column
    fields: [iowa_liquor_sales.date_year, iowa_liquor_sales.total_sale_dollars]
    dynamic_fields:
    - table_calculation: yoy_growth
      label: YoY Growth
      expression: "(${iowa_liquor_sales.total_sale_dollars} / offset(${iowa_liquor_sales.total_sale_dollars},\
        \ 1)) - 1"
      value_format_name: percent_2
    listen:
      Order Date Range: iowa_liquor_sales.date_date
    row: 84
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: AOV Variance by City
    name: AOV Variance by City
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_bar
    fields: [iowa_liquor_sales.city, iowa_liquor_sales.average_order_value]
    limit: 15
    dynamic_fields:
    - table_calculation: variance_from_mean
      label: Variance from Average
      expression: "${iowa_liquor_sales.average_order_value} - mean(${iowa_liquor_sales.average_order_value})"
      value_format_name: usd
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
    row: 96
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: "% of Total Bottles by Category"
    name: "% of Total Bottles by Category"
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: table
    fields: [iowa_liquor_sales.category_name, iowa_liquor_sales.total_bottles_sold]
    dynamic_fields:
    - table_calculation: percent_of_total
      label: "% of Total Volume"
      expression: "${iowa_liquor_sales.total_bottles_sold} / sum(${iowa_liquor_sales.total_bottles_sold})"
      value_format_name: percent_2
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Liquor Category: iowa_liquor_sales.category_name
    row: 96
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: 50 Most Recent Orders (Raw Data)
    name: 50 Most Recent Orders (Raw Data)
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_grid
    fields: [iowa_liquor_sales.date_date, iowa_liquor_sales.store_name, iowa_liquor_sales.vendor_name,
      iowa_liquor_sales.item_description, iowa_liquor_sales.total_sale_dollars]
    sorts: [iowa_liquor_sales.date_date desc]
    limit: 50
    listen:
      Order Date Range: iowa_liquor_sales.date_date
    row: 96
    col: 48
    width: 24
    height: 12
    tab_name: ''
  - title: City vs Vendor Revenue Matrix
    name: City vs Vendor Revenue Matrix
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: looker_grid
    fields: [iowa_liquor_sales.city, iowa_liquor_sales.total_sale_dollars, iowa_liquor_sales.vendor_name]
    pivots: [iowa_liquor_sales.vendor_name]
    limit: 10
    column_limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Store City: iowa_liquor_sales.city
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 108
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Recent SEC Filings Volume
    name: Recent SEC Filings Volume
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    type: looker_column
    fields: [sec_financials.period_end_month, sec_financials.total_accounts_payable]
    listen:
      Financial Period: sec_financials.period_end_date
    row: 108
    col: 24
    width: 24
    height: 12
    tab_name: ''
  - title: Executive KPI Summary Table
    name: Executive KPI Summary Table
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    type: table
    fields: [iowa_liquor_sales.vendor_name, iowa_liquor_sales.total_sale_dollars,
      iowa_liquor_sales.total_bottles_sold, iowa_liquor_sales.average_order_value]
    sorts: [iowa_liquor_sales.total_sale_dollars desc]
    limit: 5
    listen:
      Order Date Range: iowa_liquor_sales.date_date
      Vendor Name (Iowa): iowa_liquor_sales.vendor_name
    row: 108
    col: 48
    width: 24
    height: 12
    tab_name: ''
  filters:
  - name: Order Date Range
    title: Order Date Range
    type: date_filter
    default_value: 3 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
  - name: Financial Period
    title: Financial Period
    type: date_filter
    default_value: 3 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
  - name: Vendor Name (Iowa)
    title: Vendor Name (Iowa)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    listens_to_filters: []
    field: iowa_liquor_sales.vendor_name
  - name: SEC Company Name
    title: SEC Company Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    listens_to_filters: []
    field: sec_financials.company_name
  - name: Store City
    title: Store City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    listens_to_filters: []
    field: iowa_liquor_sales.city
  - name: Liquor Category
    title: Liquor Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    listens_to_filters: []
    field: iowa_liquor_sales.category_name
  - name: SEC Document Type
    title: SEC Document Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: sec_financials
    listens_to_filters: []
    field: sec_financials.document_type
  - name: Retail Store Name
    title: Retail Store Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    listens_to_filters: []
    field: iowa_liquor_sales.store_name
  - name: Item Description
    title: Item Description
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: b2b_vendor_payment_reconciliation
    explore: iowa_liquor_sales
    listens_to_filters: []
    field: iowa_liquor_sales.item_description
  - name: Min Order Value
    title: Min Order Value
    type: number_filter
    default_value: ">0"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
