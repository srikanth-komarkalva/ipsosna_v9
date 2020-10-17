view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2V2.tblTempOutput6e59e63b1c3a42dd96fb50f6c82000e1`
   ;;

  # sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2.CombinedDataSheet_PortalColumns`

# Parameters Section

  parameter: attribute_selector1 {
    label: "Banner Selector 1"
#     description: "Banner selector for crosstabs"
    type: unquoted

    allowed_value: {
      label: "Brand"
      value: "brandLabel"
    }

    allowed_value: {
      label: "Country"
      value: "countryCode"
    }

    allowed_value: {
      label: "Wave"
      value: "timePeriodCode"
    }
  }

  parameter: attribute_selector2 {
#     description: "Banner selector for crosstabs"
    label: "Banner Selector 2"
    type: unquoted

    allowed_value: {
      label: "Brand"
      value: "brandLabel"
    }

    allowed_value: {
      label: "Country"
      value: "countryCode"
    }

    allowed_value: {
      label: "Wave"
      value: "timePeriodCode"
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
    {% if attribute_selector1._parameter_value == 'timePeriodCode' %}
      ${time_period_order}
    {% else %}
      ${attribute_selector1_dim}
    {% endif %};;
  }

  dimension: attribute_selector2_sort {
    hidden: yes
    sql:
    {% if attribute_selector2._parameter_value == 'timePeriodCode' %}
      ${time_period_order}
    {% else %}
      ${attribute_selector2_dim}
    {% endif %};;
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

# Demographic Fields Section

  dimension: banner_label {
    label: "Banner Label"
    type: string
    group_label: "Demographic Fields"
    sql: ${TABLE}.demoCode ;;
  }

  dimension: market_code {
    label: "Country"
    type: string
    group_label: "Demographic Fields"
    sql: ${TABLE}.countryCode ;;
  }

  dimension: time_period_id {
    type: number
    hidden: yes
    group_label: "Demographic Fields"
    sql: ${TABLE}.TimePeriodId ;;
  }

  dimension: time_period_label {
    type: string
    label: "Wave"
    order_by_field: time_period_order
    group_label: "Demographic Fields"
    sql: ${TABLE}.timePeriodCode ;;
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

# Sort fields Section

  dimension: metric_display_order {
    type: number
    label: "Metric Order"
    group_label: "Sort Fields"
    sql: ${TABLE}.metricOrder;;
  }

  dimension: category_display_order {
    type: number
    label: "Response Order"
    group_label: "Sort Fields"
    sql: ${TABLE}.responseOrder ;;
  }

  dimension: product_display_order {
    type: number
    label: "Brand Order"
    group_label: "Sort Fields"
    sql: ${TABLE}.brandOrder ;;
  }

  dimension: time_period_order {
    type: number
    label: "Time Period Order"
    group_label: "Sort Fields"
    sql: ${TABLE}.timePeriodOrder;;
  }

# Metrics Section

  dimension: metric_category_label {
    type: string
    label: "Response Label"
    group_label: "Question Information"
    order_by_field: category_display_order
    sql: ${TABLE}.responseLabel ;;
  }

  dimension: metric_code {
    label: "Metric"
   group_label: "Question Information"
    order_by_field: metric_display_order
    type: string
    sql: ${TABLE}.metricCodeSegment ;;
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

  dimension: metric_id {
    type: number
    hidden: yes
    group_label: "Question Information"
    primary_key: yes
    sql: ${TABLE}.metricID ;;
  }

  dimension: metric_label {
    type: string
    group_label: "Question Information"
    sql: ${TABLE}.metricLabel ;;
  }

  dimension: metric_label_without_brand {
    type: string
    group_label: "Question Information"
    sql:  SPLIT(${metric_label}, '-')[SAFE_OFFSET(1)] ;;
  }

  dimension: product_id {
    group_label: "Question Information"
    type: number
    hidden: yes
    sql: ${TABLE}.brandCode ;;
  }

  dimension: product_label {
    type: string
    label: "Brand"
    order_by_field: product_display_order
    group_label: "Question Information"
    sql: ${TABLE}.brandLabel ;;
  }

# Significance Attributes Section

  dimension: sig_test_primary {
    label: "Stat Test Primary"
    type: number
    group_label: "Sig Test Attributes"
    sql: IFNULL(${TABLE}.sigTestWOW,2) ;;
  }

  dimension: sig_test_secondary {
    type: number
    group_label: "Sig Test Attributes"
    sql: IFNULL(${TABLE}.sigTestYOY,2) ;;
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

  # {% if value == 'Increase' %}
  #   <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ 'Increase' }}</p>
  #   {% elsif value == 'Decrease' %}
  #   <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{ 'Decrease' }}</p>
  #   {% elsif value == 'No change' %}
  #   <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ 'No change' }}</p>
  #   {% elsif value == 'N/A' %}
  #   <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{ 'N/A' }}</p>
  #   {% endif %} ;;

  dimension: Sig_Sort {
    label: "Significance Sort"
    type: number
    group_label: "Sig Test Attributes"
    sql:
    CASE ${sig_test_choice}
    WHEN 1 THEN 1
    WHEN -1 THEN 3
    WHEN 0 THEN 2
    ELSE 4
    END ;;
  }

# Weight Measures Section

  measure: un_wt_base {
    label: "Un Weighted Base"
    group_label: "Weight Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.unWtBase ;;
  }

  measure: un_wt_count {
    label: "Un Weighted Count"
    group_label: "Weight Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.unWtCount ;;
  }

  measure: wt_base {
    label: "Weighted Base"
    group_label: "Weight Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.wtBase ;;
  }

  measure: wt_count {
    label: "Weighted Count"
    group_label: "Weight Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.wtCount ;;
  }

  measure: Weighted_Pct {
    label: "Weighted Percent"
    group_label: "Weight Measures"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
  }

  measure: effective_base {
    type: sum
    group_label: "Weight Measures"
    label: "Effective Base"
    value_format_name: decimal_0
    sql: ${TABLE}.effectiveBase ;;
  }

  measure: rank_order {
    # hidden: yes
    type: number
    description: "For Top Metrics Top-2 box"
    group_label: "For Developers"
    sql: RANK() OVER (PARTITION BY metricCodeSegment ORDER BY responseOrder DESC) ;;
  }

  measure: Top_2_Percent {
    type: number
    group_label: "For Developers"
    value_format_name: percent_0
    sql: (sum(${wt_percent}) OVER (PARTITION BY metricCodeSegment ORDER BY responseOrder DESC)) ;;
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



  measure: stat_result {
    label: "Significance"
    group_label: "For Developers"
    type: sum
    sql:
    CASE ${significance_dropdown_dim}
    WHEN "WoW" THEN
    (     CASE IFNULL(${sig_test_primary},2)
          WHEN 1 THEN 1
          WHEN -1 THEN -1
          WHEN 0 THEN 0
          WHEN NULL THEN 2
          ELSE 2
          END)
    WHEN "YoY" THEN
    (     CASE IFNULL(${sig_test_secondary},2)
          WHEN 1 THEN 1
          WHEN -1 THEN -1
          WHEN 0 THEN 0
          WHEN NULL THEN 2
          ELSE 2
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

  # {% if value == 1 %}
  #   <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ 'Increase' }}</p>
  #   {% elsif value == -1 %}
  #   <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{ 'Decrease' }}</p>
  #   {% elsif value == 0 %}
  #   <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ 'No change' }}</p>
  #   {% elsif value == 2 %}
  #   <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{ 'N/A' }}</p>
  #   {% endif %} ;;

  measure: wt_percent {
    type: sum
    group_label: "For Developers"
    label: "Weighted Percent (original)"
    value_format_name: percent_0
    sql: (${TABLE}.wtMetric)/100 ;;
  }
}
