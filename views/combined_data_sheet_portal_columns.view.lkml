view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`
   ;;

#Defining parameters for Dynamic column selection in Cross tab charts
  parameter: attribute_selector1 {
    label: "Banner Selector 1"
#     description: "Banner selector for crosstabs"
    type: unquoted

    allowed_value: {
      label: "Brand"
      value: "ProductLabel"
    }

    allowed_value: {
      label: "Country"
      value: "MarketCode"
    }

    allowed_value: {
      label: "Wave"
      value: "TimePeriodLabel"
    }
  }

  parameter: attribute_selector2 {
#     description: "Banner selector for crosstabs"
    label: "Banner Selector 2"
    type: unquoted

    allowed_value: {
      label: "Brand"
      value: "ProductLabel"
    }

    allowed_value: {
      label: "Country"
      value: "MarketCode"
    }

    allowed_value: {
      label: "Wave"
      value: "TimePeriodLabel"
    }
  }

  dimension: attribute_selector1_dim {
    group_label: "Banner Analysis"
    label: "Banner Selector 1"
    order_by_field: attribute_selector1_sort
    description: "To be used with the Banner Selector filters"
    label_from_parameter: attribute_selector1
    sql: ${TABLE}.{% parameter attribute_selector1 %};;
  }

  dimension: attribute_selector2_dim {
    group_label: "Banner Analysis"
    label: "Banner Selector 2"
    order_by_field: attribute_selector2_sort
    description: "To be used with the Banner Selector filters"
    label_from_parameter: attribute_selector2
    sql: ${TABLE}.{% parameter attribute_selector2 %};;
  }

  dimension: attribute_selector1_sort {
    hidden: yes
    sql:
    {% if attribute_selector1._parameter_value == 'TimePeriodLabel' %}
      ${wave_date}
    {% else %}
      ${attribute_selector1_dim}
    {% endif %};;
  }

  dimension: attribute_selector2_sort {
    hidden: yes
    sql:
    {% if attribute_selector2._parameter_value == 'TimePeriodLabel' %}
      ${wave_date}
    {% else %}
      ${attribute_selector2_dim}
    {% endif %};;
  }

  dimension: banner_color_hex_code {
    hidden: yes
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

  measure: rank_order {
    hidden: yes
    type: number
    description: "For Top Metrics Top-2 box"
    group_label: "For Developers"
    sql: RANK() OVER (PARTITION BY MetricCode ORDER BY CategoryDisplayOrder DESC) ;;
  }

  measure: Top_2_Percent {
    type: number
    group_label: "For Developers"
    value_format_name: percent_0
    sql: (sum(${wt_percent}) OVER (PARTITION BY MetricCode ORDER BY CategoryDisplayOrder DESC))/100 ;;
  }

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
    # order_by_field: sort_view.rank_sort
    sql: ${TABLE}.MetricCategoryLabel ;;
  }

  dimension: metric_code {
    label: "Metric Code"
   group_label: "Question Information"
    order_by_field: metric_display_order
    type: string
    sql: ${TABLE}.MetricCode ;;
  }

  dimension: metric_without_brand {
    type: string
    group_label: "Question Information"
    sql: REPLACE(${metric_code},CONCAT('_',${product_label}),'') ;;
  }

  dimension: metric_without_brand_new {
    type: string
    group_label: "Question Information"
    sql:  CONCAT(
          SPLIT(${metric_code}, '_')[SAFE_OFFSET(0)],"_",
          SPLIT(${metric_code}, '_')[SAFE_OFFSET(1)])
          ;;
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
    hidden: yes
    sql: ${TABLE}.SigTestCodes ;;
  }

  dimension: sig_test_number_of_items_compared_against {
    type: number
    hidden: yes
    group_label: "Sig Test Attributes"
    sql: ${TABLE}.SigTestNumberOfItemsComparedAgainst ;;
  }

  dimension: sig_test_primary {
    label: "Stat Test Primary"
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
    sql: CAST(SUBSTR(${time_period_label},4,4) AS INT64);;
  }

  dimension: wave_month_part {
    hidden: yes
    group_label: "Demographic Fields"
    type: string
    sql: SUBSTR(${time_period_label},1,2);;
  }

  dimension: wave_month {
    hidden: yes
    group_label: "Demographic Fields"
    type: number
    sql: CAST(
          CASE ${wave_month_part}
          WHEN 'Q1' THEN 1
          WHEN 'Q2' THEN 2
          WHEN 'Q3' THEN 3
          WHEN 'Q4' THEN 4
          END
          AS INT64) ;;
  }

  dimension: wave_date {
    label: "Wave (Date)"
    group_label: "Demographic Fields"
    type: date
    sql: CAST(date(${wave_year},${wave_month},1) as TIMESTAMP) ;;
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

  dimension: sig_test_choice {
    label: "Significance Dim"
    type: string
    group_label: "Sig Test Attributes"
    sql:
    CASE ${significance_dropdown_dim}
    WHEN "WoW" THEN ${sig_test_primary}
    WHEN "YoY" THEN ${sig_test_secondary}
    END ;;

    html:
    {% if value == 'Increase' %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ 'Increase' }}</p>
    {% elsif value == 'Decrease' %}
    <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{ 'Decrease' }}</p>
    {% elsif value == 'No change' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ 'No change' }}</p>
    {% elsif value == 'N/A' %}
    <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{ 'N/A' }}</p>
    {% endif %} ;;
  }

  dimension: Sig_Sort {
    label: "Significance Sort"
    type: number
    group_label: "Sig Test Attributes"
    sql:
    CASE ${sig_test_choice}
    WHEN "Increase" THEN 1
    WHEN "Decrease" THEN 3
    WHEN "No change" THEN 2
    WHEN "N/A" THEN 4
    END ;;
  }

  measure: Weighted_Pct {
    label: "Weighted Percent"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
  }

  measure: Weighted_Pct_Crosstab {
    label: "Weighted Percent"
    group_label: "For Developers"
    description: "Weighted % for Crosstab report"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% endif %}
    ;;
  }

  measure: Weighted_Pct_Line {
    label: "Weighted Percent"
    group_label: "For Developers"
    description: "Weighted % for Trend chart"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">Increase</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <br> Significance: <p style="color: black; background-color: tomato; font-size:100%; text-align:center">Decrease</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">No change</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">N/A</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">Increase</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: tomato; font-size:100%; text-align:center">Decrease</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">No change</p></br>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <br>Significance: <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">N/A</p></br>

    {% endif %}
    ;;
  }

  measure: effective_base {
    type: sum
    label: "Effective Base"
    value_format_name: decimal_0
    sql: ${TABLE}.EffectiveBase ;;
  }

  measure: stat_result {
    label: "Significance"
    group_label: "For Developers"
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
    html:
    {% if value == 1 %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ 'Increase' }}</p>
    {% elsif value == -1 %}
    <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{ 'Decrease' }}</p>
    {% elsif value == 0 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ 'No change' }}</p>
    {% elsif value == 2 %}
    <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{ 'N/A' }}</p>
    {% endif %} ;;
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
