view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`
    ;;

  dimension: banner_color_hex_code {
#     hidden: yes
    group_label: "Portal Attributes"
    type: string
    sql: ${TABLE}.BannerColorHexCode ;;
  }

  dimension: banner_display_order {
#     hidden: yes
    group_label: "Portal Attributes"
    type: number
    sql: ${TABLE}.BannerDisplayOrder ;;
  }

  dimension: banner_group_label {
    type: string
    group_label: "Portal Attributes"
#     hidden: yes
    sql: ${TABLE}.BannerGroupLabel ;;
  }

  dimension: banner_id {
#     hidden: yes
    type: number
    group_label: "Portal Attributes"
    sql: ${TABLE}.BannerId ;;
  }

  dimension: banner_label {
    label: "Banner Label"
    type: string
    group_label: "Demographic Fields"
    sql: ${TABLE}.BannerLabel ;;
  }

  dimension: category_display_order {
    type: number
    group_label: "Sort Fields"
    sql: ${TABLE}.CategoryDisplayOrder ;;
  }

#   dimension: category_display_order_1 {
#     type: number
#     group_label: "Sort Fields"
#     sql: sum(${category_display_order}) OVER ( PARTITION BY
#                     {% if market_code._is_selected %}  ${market_code}, {% endif %}
#                     {% if time_period_label._is_selected %} ${time_period_label}, {% endif %}
#                     1);;
#   }

  dimension: market_code {
    label: "Country"
    type: string
    group_label: "Demographic Fields"
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
    group_label: "Question Information"
#     order_by_field: category_display_order
#     skip_drill_filter: yes
    sql: ${TABLE}.MetricCategoryLabel ;;
  }

  dimension: metric_code {
    label: "Metric Code"
   group_label: "Question Information"
    order_by_field: metric_display_order
    type: string
    sql: ${TABLE}.MetricCode ;;
  }

  dimension: metric_display_order {
    type: number
    group_label: "Sort Fields"
    sql: ${TABLE}.MetricDisplayOrder ;;
  }

  dimension: metric_group_id {
    type: string
    hidden: yes
    group_label: "Question Information"
    sql: ${TABLE}.MetricGroupId ;;
  }

  dimension: metric_group_label {
    type: string
    hidden: yes
    group_label: "Question Information"
    sql: ${TABLE}.MetricGroupLabel ;;
  }

  dimension: metric_id {
    type: number
    group_label: "Question Information"
    primary_key: yes
    sql: ${TABLE}.metricID ;;
  }

  dimension: metric_label {
    type: string
    group_label: "Question Information"
    sql: ${TABLE}.MetricLabel ;;
  }

  dimension: product_color_hex_code {
    group_label: "Portal Attributes"
    type: string
    sql: ${TABLE}.ProductColorHexCode ;;
  }

  dimension: product_display_order {
    type: number
    group_label: "Sort Fields"
    sql: ${TABLE}.ProductDisplayOrder ;;
  }

  dimension: product_id {
    group_label: "Question Information"
    type: number
    sql: ${TABLE}.ProductId ;;
  }

  dimension: product_label {
    type: string
    group_label: "Question Information"
    sql: ${TABLE}.ProductLabel ;;
  }

  dimension: rank_desc {
    type: number
    group_label: "Sort Fields"
    sql: ${TABLE}.RankDesc ;;
  }

  dimension: score {
    type: number
    group_label: "Sig Test Attributes"
    sql: ${TABLE}.Score ;;
  }

  dimension: sig_test_codes {
    group_label: "Sig Test Attributes"
    type: number
    sql: ${TABLE}.SigTestCodes ;;
  }

  dimension: sig_test_number_of_items_compared_against {
    type: number
    group_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestNumberOfItemsComparedAgainst ;;
  }

  dimension: sig_test_primary {
    label: "Stat Test Result"
    type: string
    group_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestPrimary ;;
  }

  dimension: sig_test_secondary {
    type: string
    group_label: "Sig Test Attributes"
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
    order_by_field: wave_date
    group_label: "Demographic Fields"
    sql: ${TABLE}.TimePeriodLabel ;;
  }

  dimension: wave_year {
    hidden: yes
    group_label: "Demographic Fields"
    type: number
    sql: CAST(SUBSTR(${time_period_label},5,4) AS INT64);;
  }

  dimension: wave_month_part {
    hidden: yes
    group_label: "Demographic Fields"
    type: string
    sql: SUBSTR(${time_period_label},1,3);;
  }

  dimension: wave_month {
    hidden: yes
    group_label: "Demographic Fields"
    type: number
    sql: CAST(
          CASE ${time_period_label}
          WHEN 'Jan' THEN 1
          WHEN 'Feb' THEN 2
          WHEN 'Mar' THEN 3
          WHEN 'Apr' THEN 4
          WHEN 'May' THEN 5
          WHEN 'Jun' THEN 6
          WHEN 'Jul' THEN 7
          WHEN 'Aug' THEN 8
          WHEN 'Sep' THEN 9
          WHEN 'Oct' THEN 10
          WHEN 'Nov' THEN 11
          WHEN 'Dec' THEN 12
          ELSE 1
          END
          AS INT64) ;;
  }

  dimension: wave_day_part {
    hidden: yes
    group_label: "Demographic Fields"
    type: string
    sql: SUBSTR(${time_period_label},12,2);;
  }

  dimension: wave_day {
    hidden: yes
    group_label: "Demographic Fields"
    type: number
    sql: CAST(CASE ${wave_day_part}
          WHEN 'W1' THEN 1
          WHEN 'W2' THEN 15
          WHEN 'Ne' THEN 1
          WHEN 'Pa' THEN 1
          ELSE 1
          END AS INT64) ;;
  }

  dimension: wave_date {
    label: "Wave (Date)"
    group_label: "Demographic Fields"
    type: date
    sql: CAST(date(${wave_year},${wave_month},${wave_day}) as TIMESTAMP) ;;
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
    sql:
    CASE ${significance_dropdown_dim}
    WHEN "WoW" THEN
    (     CASE ${sig_test_primary}
          WHEN 'Increase' THEN 1
          WHEN 'Decrease' THEN -1
          WHEN 'No change' THEN 0
          WHEN 'N/A' THEN 2
          END)
    WHEN "YoY" THEN
    (     CASE ${sig_test_secondary}
          WHEN 'Increase' THEN 1
          WHEN 'Decrease' THEN -1
          WHEN 'No change' THEN 0
          WHEN 'N/A' THEN 2
          END)
    END ;;
  }

  measure: wt_percent {
    type: sum
    hidden: yes
    label: "Weighted Percent"
    value_format_name: percent_0
    sql: ${TABLE}.WtPercent ;;
  }

  parameter: significance_dropdown {
    label: "Choose Significance WoW or YoY"
    description: "Choose Significance for crosstabs"
    type: string
    allowed_value: {
      label: "WoW"
      value: "WoW"
    }
    allowed_value: {
      label: "YoY"
      value: "YoY"
    }
  }

#Significance Filter
  dimension: significance_dropdown_dim {
    label: "Significance"
    group_label: "Parameters"
    type: string
    sql: {% parameter significance_dropdown  %};;
  }

}
