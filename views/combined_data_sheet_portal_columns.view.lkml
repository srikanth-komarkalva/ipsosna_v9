view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`
    ;;

  dimension: banner_color_hex_code {
    type: string
    sql: ${TABLE}.BannerColorHexCode ;;
  }

  dimension: banner_display_order {
    type: number
    sql: ${TABLE}.BannerDisplayOrder ;;
  }

  dimension: banner_group_label {
    type: string
    sql: ${TABLE}.BannerGroupLabel ;;
  }

  dimension: banner_id {
    type: number
    sql: ${TABLE}.BannerId ;;
  }

  dimension: banner_label {
    type: string
    sql: ${TABLE}.BannerLabel ;;
  }

  dimension: category_display_order {
    type: number
    sql: ${TABLE}.CategoryDisplayOrder ;;
  }

  dimension: effective_base {
    type: number
    sql: ${TABLE}.EffectiveBase ;;
  }

  dimension: market_code {
    type: string
    sql: ${TABLE}.MarketCode ;;
  }

  dimension: market_id {
    type: number
    sql: ${TABLE}.MarketId ;;
  }

  dimension: metric_category_id {
    type: number
    sql: ${TABLE}.MetricCategoryId ;;
  }

  dimension: metric_category_label {
    type: string
    sql: ${TABLE}.MetricCategoryLabel ;;
  }

  dimension: metric_code {
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
    type: number
    sql: ${TABLE}.SigTestCodes ;;
  }

  dimension: sig_test_number_of_items_compared_against {
    type: number
    sql: ${TABLE}.SigTestNumberOfItemsComparedAgainst ;;
  }

  dimension: sig_test_primary {
    type: string
    sql: ${TABLE}.SigTestPrimary ;;
  }

  dimension: sig_test_secondary {
    type: string
    sql: ${TABLE}.SigTestSecondary ;;
  }

  dimension: time_period_id {
    type: number
    sql: ${TABLE}.TimePeriodId ;;
  }

  dimension: time_period_label {
    type: string
    sql: ${TABLE}.TimePeriodLabel ;;
  }

  measure: un_wt_base {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.UnWtBase ;;
  }

  measure: un_wt_count {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.UnWtCount ;;
  }

  measure: wt_base {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.WtBase ;;
  }

  measure: wt_count {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.WtCount ;;
  }

  dimension: wt_percent {
    type: number
    sql: ${TABLE}.WtPercent ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
