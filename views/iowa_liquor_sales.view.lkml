view: iowa_liquor_sales {
  sql_table_name: `bigquery-public-data.iowa_liquor_sales.sales` ;;

  # --- Primary Key ---
  dimension: invoice_and_item_number {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.invoice_and_item_number ;;
  }

  # --- Hidden Technical Fields ---
  dimension: store_number {
    hidden: yes
    type: string
    sql: ${TABLE}.store_number ;;
  }

  dimension: vendor_number {
    hidden: yes
    type: string
    sql: ${TABLE}.vendor_number ;;
  }

  dimension: category {
    hidden: yes
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: county_number {
    hidden: yes
    type: string
    sql: ${TABLE}.county_number ;;
  }

  # --- Dimensions ---
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
    label: "Order"
    description: "The date the wholesale liquor order was placed."
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
    label: "Retail Store Name"
    description: "The name of the retail store purchasing the liquor."
    tags: ["Purchaser", "Retailer", "Customer"]
  }

  dimension: vendor_name {
    type: string
    sql: ${TABLE}.vendor_name ;;
    label: "Liquor Vendor (Supplier)"
    description: "The name of the vendor supplying the liquor (e.g., Diageo, Jim Beam)."
    tags: ["Supplier", "Distributor", "Brand Owner"]
    drill_fields: [item_description, category_name]
  }

  # --- Added Missing Dimension to Resolve Drill Error ---
  dimension: item_description {
    type: string
    sql: ${TABLE}.item_description ;;
    label: "Item Description"
    description: "The name/description of the specific liquor item purchased."
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
    label: "Liquor Category"
    description: "The category of liquor (e.g., Vodka, Whiskey)."
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    label: "Store City"
    description: "The Iowa city where the retail store is located."
  }

  dimension: sale_dollars {
    type: number
    hidden: yes
    sql: ${TABLE}.sale_dollars ;;
  }

  dimension: state_bottle_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.state_bottle_cost ;;
  }

  dimension: bottles_sold {
    type: number
    hidden: yes
    sql: ${TABLE}.bottles_sold ;;
  }

  # --- Measures ---
  measure: total_sale_dollars {
    type: sum
    sql: ${sale_dollars} ;;
    value_format_name: usd
    label: "Total Wholesale Revenue"
    description: "Total dollars spent by retailers on wholesale liquor."
    drill_fields: [vendor_name, store_name, total_sale_dollars]
  }

  measure: total_bottles_sold {
    type: sum
    sql: ${bottles_sold} ;;
    label: "Total Bottles Distributed"
    description: "The total volume of bottles moved through the supply chain."
  }

  measure: average_order_value {
    type: average
    sql: ${sale_dollars} ;;
    value_format_name: usd
    label: "Average Order Value (AOV)"
    description: "Average wholesale purchase amount per invoice item."
  }
}
