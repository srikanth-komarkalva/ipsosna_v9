view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`
    ;;

  dimension: banner_color_hex_code {
    hidden: yes
    type: string
    sql: ${TABLE}.BannerColorHexCode ;;
  }

  dimension: banner_display_order {
    hidden: yes
    type: number
    sql: ${TABLE}.BannerDisplayOrder ;;
  }

  dimension: banner_group_label {
    type: string
    hidden: yes
    sql: ${TABLE}.BannerGroupLabel ;;
  }

  dimension: banner_id {
    hidden: yes
    type: number
    sql: ${TABLE}.BannerId ;;
  }

  dimension: banner_label {
    label: "Banner Label"
    type: string
    sql: ${TABLE}.BannerLabel ;;
  }

  dimension: category_display_order {
    type: number
    sql: ${TABLE}.CategoryDisplayOrder ;;
  }

  dimension: market_code {
    label: "Country"
    type: string
    sql: ${TABLE}.MarketCode ;;
  }

  dimension: market_id {
    hidden: yes
    type: number
    sql: ${TABLE}.MarketId ;;
  }

  dimension: metric_category_id {
    hidden: yes
    type: number
    sql: ${TABLE}.MetricCategoryId ;;
  }

  dimension: metric_category_label {
    type: string
    label: "Response Label"
#     order_by_field: category_display_order
    sql: ${TABLE}.MetricCategoryLabel ;;
  }

  dimension: metric_code {
    label: "Metric Code"
    order_by_field: metric_display_order
    type: string
    sql: ${TABLE}.MetricCode ;;
  }

  dimension: metric_display_order {
    type: number
    sql: ${TABLE}.MetricDisplayOrder ;;
  }

  dimension: metric_group_id {
    type: string
    sql: ${TABLE}.MetricGroupId ;;
  }

  dimension: metric_group_label {
    type: string
    sql: ${TABLE}.MetricGroupLabel ;;
  }

  dimension: metric_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.metricID ;;
  }

  dimension: metric_label {
    type: string
    sql: ${TABLE}.MetricLabel ;;
  }

  dimension: product_color_hex_code {
    group_item_label: "Portal Attributes"
    type: string
    sql: ${TABLE}.ProductColorHexCode ;;
  }

  dimension: product_display_order {
    type: number
    sql: ${TABLE}.ProductDisplayOrder ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.ProductId ;;
  }

  dimension: product_label {
    type: string
    sql: ${TABLE}.ProductLabel ;;
  }

  dimension: rank_desc {
    type: number
    sql: ${TABLE}.RankDesc ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.Score ;;
  }

  dimension: sig_test_codes {
    group_item_label: "Sig Test Attributes"
    type: number
    sql: ${TABLE}.SigTestCodes ;;
  }

  dimension: sig_test_number_of_items_compared_against {
    type: number
    group_item_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestNumberOfItemsComparedAgainst ;;
  }

  dimension: sig_test_primary {
    label: "Stat Test Result"
    type: string
    group_item_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestPrimary ;;
  }

  dimension: sig_test_secondary {
    type: string
    group_item_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestSecondary ;;
  }

  dimension: time_period_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TimePeriodId ;;
  }

  dimension: time_period_label {
    type: string
    label: "Wave"
    sql: ${TABLE}.TimePeriodLabel ;;
  }

  measure: un_wt_base {
    label: "Un Weighted Base"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.UnWtBase ;;
  }

  measure: un_wt_count {
    label: "Un Weighted Count"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.UnWtCount ;;
  }

  measure: wt_base {
    label: "Weighted Base"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.WtBase ;;
  }

  measure: wt_count {
    label: "Weighted Count"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.WtCount ;;
  }

  measure: effective_base {
    type: sum
    label: "Effective Base"
    sql: ${TABLE}.EffectiveBase ;;
  }

  measure: stat_result {
    type: sum
    sql: CASE ${sig_test_primary}
          WHEN 'Increase' THEN 1
          WHEN 'Decrease' THEN -1
          WHEN 'No change' THEN 0
          WHEN 'N/A' THEN 2
          END
    ;;
  }

  dimension: wt_percent {
    type: number
    hidden: yes
    sql: ${TABLE}.WtPercent ;;
  }
}
