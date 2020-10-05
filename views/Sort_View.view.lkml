view: sort_view {
  derived_table: {
    sql:
     SELECT
     metricID,
     MetricCategoryLabel,
     RANK() OVER(PARTITION BY metricID,BannerLabel,MarketCode,TimePeriodLabel,ProductLabel
     ORDER BY CategoryDisplayOrder DESC)
     AS rank_sort
     FROM
     `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`;;
  }

  # ,BannerLabel,MarketCode,TimePeriodLabel,ProductLabel
  dimension: metric_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.metricID ;;
  }

  dimension: metric_category_label {
    type: string
    label: "Response Label"
    hidden: yes
    sql: ${TABLE}.MetricCategoryLabel ;;
  }

  # dimension: category_display_order {
  #   type: number
  #   hidden: yes
  #   group_label: "Sort Fields"
  #   sql: ${TABLE}.CategoryDisplayOrder ;;
  # }

  dimension: rank_sort {
    label: "Sort Index"
    type: number
    sql: ${TABLE}.rank_sort;;
  }
}
