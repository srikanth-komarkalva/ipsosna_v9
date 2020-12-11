view: combined_data_sheet_portal_columns {
  sql_table_name: `mgcp-1192365-ipsos-gbht-srf617.YouTubeB2B2020Q2V2.tblOutputDatasheet`;;

# Parameters Section

  parameter: attribute_selector1 {
    label: "Banner Selector 1"
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
      value: "timePeriodLabel"
    }
  }

  parameter: attribute_selector2 {
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
      value: "timePeriodLabel"
    }
  }

  parameter: attribute_selector3 {
    label: "Country/Sub Group Selector"
    type: unquoted

    allowed_value: {
      label: "Country"
      value: "countryCode"
    }
    allowed_value: {
      label: "Demographic"
      value: "demoCode"
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

  dimension: attribute_selector3_dim {
    group_label: "Banner Analysis"
    label: "Country/Sub Group Selector"
    description: "To be used with the Banner Selector filters"
    label_from_parameter: attribute_selector3
    sql: ${TABLE}.{% parameter attribute_selector3 %};;
  }

  dimension: attribute_selector1_sort {
    hidden: yes
    sql:
    {% if attribute_selector1._parameter_value == 'timePeriodLabel' %}
      ${time_period_order}
    {% else %}
      ${attribute_selector1_dim}
    {% endif %};;
  }

  dimension: attribute_selector2_sort {
    hidden: yes
    sql:
    {% if attribute_selector2._parameter_value == 'timePeriodLabel' %}
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
    label: "Demographic Unformatted"
    type: string
    group_label: "Demographic Fields"
    sql: ${TABLE}.demoCode ;;
  }

  dimension: sub_group {
    label: "Demographic"
    type: string
    group_label: "Demographic Fields"
    sql:  CASE ${banner_label}
    WHEN 'Type~Advertiser - meaning you advertise your companys products or services (including in-house agency)'  THEN 'Advertiser'
    WHEN 'Type~Agency - meaning you advise clients on how and where to spend their advertising dollars' THEN 'Agency'
    ELSE ${banner_label}
    END;;
  }

  dimension: market_code {
    label: "Country"
    type: string
    group_label: "Demographic Fields"
    sql: ${TABLE}.countryCode ;;
  }

  dimension: dynamic_title_1 {
    label: "Funnel Metrics Title"
    group_label: "Developer Fields (not for use)"
    type: string
    sql: ${market_code} ;;
    html:
    <body>
    <div style="position: fixed; top: 0px; width:100%; height: 50px;color: black; font-size:150%;text-align:center;overflow-y: hidden">
        Google at a glance
    </div>
    <div style="position: fixed; top: 0px; width:100%; height: 25px;color: dimgrey; font-size:100%;text-align:center;overflow-y: hidden">
        Funnel Metrics: {{rendered_value}}
    </div>
    </body>;;
  }

  dimension: dynamic_title_2 {
    label: "Funnel Metrics Title"
    group_label: "Developer Fields (not for use)"
    type: string
    sql: ${market_code} ;;
  }

  filter: dynamic_title_3 {
    type: string
    suggest_dimension: market_code
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
    sql: ${TABLE}.timePeriodLabel ;;
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
    hidden: yes
    sql: CAST(date(${wave_year},${wave_month},1) as TIMESTAMP) ;;
  }

# Sort fields Section

  dimension: metric_display_order {
    type: number
    label: "Metric Order"
    group_label: "Sort Fields"
    sql: ${TABLE}.metricOrder;;
  }

  dimension: rank {
    type: number
    label: "Rank"
    group_label: "Sort Fields"
    sql: ${TABLE}.rankBrand;;
  }

  dimension: rank_demo {
    type: number
    label: "Rank"
    group_label: "Sort Fields"
    sql: ${TABLE}.rankDemo;;
  }

  measure: rank_wt_pct {
    type: number
    label: "Rank by %"
    group_label: "Sort Fields"
    sql: RANK() OVER(PARTITION BY ${time_period_label} ORDER BY ${rank_score} DESC) ;;
  }

  dimension: rank_label {
    type: string
    label: "Rank Label"
    group_label: "Sort Fields"
    sql: ${TABLE}.rankBrandLabel;;
  }

  dimension: rank_demo_label {
    type: string
    label: "Rank Label"
    group_label: "Sort Fields"
    sql: ${TABLE}.rankDemoLabel;;
  }

  dimension: wtMetric {
    type: number
    label: "Weight Metric"
    group_label: "For Developers"
    sql: ${TABLE}.wtMetric ;;

  }

  measure: rank_score {
    type: sum
    label: "Rank Score for Brand"
    group_label: "Sort Fields"
    value_format_name: decimal_1
    sql: ${TABLE}.rankBrandScore;;
  }

  dimension: rank_demo_score {
    type: number
    label: "Rank Score"
    group_label: "Sort Fields"
    sql: ${TABLE}.rankDemoScore;;
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

  dimension: metric_code {
    label: "Question Metric"
    group_label: "Question Information"
    order_by_field: metric_display_order
    type: string
    sql: ${TABLE}.metricCodeSegment ;;
  }

  dimension: metric_code_funnel_new {
    label: "Funnel Metric for Google"
    group_label: "For Developers"
    order_by_field: funnel_sort_google_new
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Perf_Consider" THEN "Consideration"
    WHEN "Perf_Purchase" THEN "Purchase Intent"
    WHEN "Perf_Prefer" THEN "Preference"
    ELSE ${metric_code}
    END;;
    html:
    <div style="word-wrap:break-word;overflow-wrap: break-word;width:100px;text-align:left;justify-content:center;"></div>{{ rendered_value }};;
  }

  dimension: funnel_sort_google_new {
    group_label: "For Developers"
    type: string
    label: "Funnel Sort for Google "
    sql:
    CASE ${metric_code_funnel_new}
    WHEN "Consideration" THEN 1
    WHEN "Purchase Intent" THEN 2
    WHEN "Preference" THEN 3
    ELSE 0
    END
    ;;
  }

  dimension: metric_code_funnel_yt_new {
    label: "Funnel Metric for YouTube"
    group_label: "For Developers"
    order_by_field: funnel_sort_youtube_new
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Brand_Consider" THEN "Consideration"
    WHEN "Brand_Purchase" THEN "Purchase Intent"
    WHEN "Brand_Prefer" THEN "Preference"
    ELSE ${metric_code}
    END;;
    html:
    <div style="word-wrap:break-word;overflow-wrap: break-word;width:100px;text-align:left;justify-content:center;"></div>{{ rendered_value }};;
  }

  dimension: funnel_sort_youtube_new {
    group_label: "For Developers"
    type: string
    label: "Funnel Sort for YouTube "
    sql:
    CASE ${metric_code_funnel_yt_new}
    WHEN "Consideration" THEN 1
    WHEN "Purchase Intent" THEN 2
    WHEN "Preference" THEN 3
    ELSE 0
    END
    ;;
  }


  dimension: metric_code_funnel {
    label: "Funnel Metric (Google)"
    group_label: "For Developers"
    order_by_field: metric_display_order
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Perf_Fam" THEN "Familiarity"
    WHEN "Perf_Partner_Goals" THEN "Comprehension"
    WHEN "Perf_Preferred" THEN "Usage"
    ELSE ${metric_code}
    END;;
    html:
    <div style="word-wrap:break-word;overflow-wrap: break-word;width:100px;text-align:left;justify-content:center;"></div>{{ rendered_value }};;
  }

  dimension: metric_code_funnel_youtube {
    label: "Funnel Metric (YouTube)"
    group_label: "For Developers"
    order_by_field: metric_display_order
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Brand_Fam" THEN "Familiarity"
    WHEN "Brand_Easy" THEN "Comprehension"
    WHEN "Brand_Biz_Results" THEN "Usage"
    ELSE ${metric_code}
    END;;
    html:
    <div style="word-wrap:break-word;overflow-wrap: break-word;width:100px;text-align:left;justify-content:center;"></div>{{ rendered_value }};;
  }

  dimension: funnel_sort {
    group_label: "For Developers"
    type: string
    label: "Funnel Sort YouTube"
    sql:
    CASE ${metric_code_funnel_youtube}
    WHEN "Familiarity" THEN 1
    WHEN "Comprehension" THEN 2
    WHEN "Usage" THEN 3
    ELSE 0
    END
    ;;
  }

  dimension: funnel_sort_google {
    group_label: "For Developers"
    type: string
    label: "Funnel Sort Google"
    sql:
    CASE ${metric_code_funnel}
    WHEN "Familiarity" THEN 1
    WHEN "Comprehension" THEN 2
    WHEN "Usage" THEN 3
    ELSE 0
    END
    ;;
  }

  dimension: metric_code_funnel_functional {
    description: "Funnel Metric (Functional - Google)"
    label: "Metric"
    group_label: "For Developers"
    order_by_field: metric_display_order
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Perf_In_Store" THEN "Drives Sales"
    WHEN "Perf_Target" THEN "Targets the right audiences for my business"
    WHEN "Perf_Partner_Goals" THEN "Understands my business goals"
    WHEN "Perf_Partner_Growth" THEN "Partner in driving business growth"
    ELSE ${metric_code}
    END;;
    html:
     <h1 style="font-size:100%;
    word-wrap: break-word;
    word-break: break-word;
    text-align:left;
    justify-content:center;
    width:200 px">{{ rendered_value }}</h1> ;;
  }

  dimension: metric_code_funnel_functional_youtube {
    description: "Funnel Metric (Functional - YouTube)"
    label: "Metric"
    group_label: "For Developers"
    order_by_field: metric_display_order
    type: string
    sql:
    CASE ${metric_code}
    WHEN "Brand_Biz_Results" THEN "Drives Sales"
    WHEN "Brand_Audiences" THEN "Targets the right audiences for my business"
    WHEN "Brand_Easy" THEN "Shows products and services at their best"
    WHEN "Brand_Ad_Results" THEN "Provides affordable solutions to promote my business"
    ELSE ${metric_code}
    END;;
    html:
     <h1 style="font-size:100%;
    word-wrap: break-word;
    word-break: break-word;
    text-align:left;
    justify-content:center;
    width:200 px">{{ rendered_value }}</h1> ;;
  }

  dimension: metric_category_label {
    type: string
    label: "Response Label"
    group_label: "Question Information"
    order_by_field: category_display_order
    sql: ${TABLE}.responseLabel ;;
  }

  dimension: metric_id {
    type: number
    hidden: yes
    group_label: "Question Information"
    primary_key: yes
    sql: ${TABLE}.metricID ;;
  }

  dimension: product_id {
    group_label: "Question Information"
    type: number
    hidden: yes
    sql: ${TABLE}.brandCode ;;
  }

  dimension: metric_label {
    type: string
    group_label: "Question Information"
    hidden: yes
    sql: ${TABLE}.metricLabel ;;
  }

  dimension: metric_label_without_brand {
    type: string
    label: "Metric Label"
    group_label: "For Developers"
    sql: ${TABLE}.metricLabel ;;
    # sql:  SPLIT(${metric_label}, '-')[SAFE_OFFSET(1)] ;;
    html:
    <h1 style="font-size:100%;
    word-wrap: break-word;
    word-break: break-word;
    text-align:left;
    justify-content: center;
    width:200 px">{{ rendered_value }}</h1> ;;
  }

  dimension: product_label {
    type: string
    label: "Brand"
    order_by_field: product_display_order
    group_label: "Question Information"
    sql: ${TABLE}.brandLabel ;;
  }


  dimension: product_label_pivot {
    label: "Brand (Pivot)"
    group_label: "For Developers"
    order_by_field: product_display_order
    type: string
    sql:
    CASE ${product_label}
    WHEN "Facebook" THEN "Facebook"
    WHEN "Instagram" THEN "Instagram"
    WHEN "YouTube" THEN "YouTube"
    WHEN "Cable_TV" THEN "Cable TV"
    WHEN "Broadcast_TV" THEN "Broadcast TV"
    WHEN "Twitter" THEN "Twitter"
    ELSE ${product_label}
    END;;
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
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ 'Increase' }}
    <img src="https://www.pinclipart.com/picdir/big/106-1068494_green-fire-png-www-imgkid-com-the-image.png"
    style="width:10px;height:10px;float:right;display:inline-block;white-space: nowrap">
    </p>
    {% elsif value == -1 %}
    <p style="color: black; background-color: tomato; font-size:100%; text-align:center">{{ 'Decrease' }}
    <img src="https://www.pinclipart.com/picdir/big/100-1008699_clipart-shapes-triangle-red-arrow-down-png-download.png"
    style="width:10px;height:10px;float:right;display:inline-block;white-space: nowrap">
    </p>
    {% elsif value == 0 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ 'No change' }}
    <a href="https://icon-library.net/icon/no-change-icon-0.html" title="No Change Icon #285813">
    <img src="https://www.flaticon.com/svg/static/icons/svg/54/54771.svg"
    style="width:10px;height:10px;float:right;display:inline-block;white-space: nowrap"></a>
    </p>
    {% elsif value == 2 %}
    <p style="color: black; background-color: lightgrey; font-size:100%; text-align:center">{{ 'N/A' }}
    <img src="https://cdn3.iconfinder.com/data/icons/meteocons/512/n-a-512.png"
    style="width:15px;height:15px;float:right;display:inline-block;white-space: nowrap">
    </p>
    {% endif %} ;;
  }

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
    sql: round(${TABLE}.wtBase) ;;
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

    {% elsif stat_result._value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    (% else %}
    Weighted Pct: {{wt_percent._value}}

    {% endif %}
    ;;
  }
  # https://www.pinclipart.com/picdir/big/106-1068494_green-fire-png-www-imgkid-com-the-image.png
  # https://www.pinclipart.com/picdir/big/539-5393483_triangle-tree-clipart-graphic-black-and-white-green.png

  measure: Weighted_Pct_with_Sig {
    label: "Weighted Percent with Sig Arrows"
    group_label: "For Developers"
    description: "Weighted % for Bar with Significance"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    <div>
    <p style="color: black;font-size:100%;text-align:centre;white-space: nowrap">{{rendered_value}}
    <img src="https://www.pinclipart.com/picdir/big/106-1068494_green-fire-png-www-imgkid-com-the-image.png"
    style="width:10px;height:10px;float:right;display:inline-block;white-space: nowrap">
    </p>
    </div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    <div>
    <p style="color: black;font-size:100%;text-align:centre;white-space: nowrap">{{rendered_value}}
    <img src="https://www.pinclipart.com/picdir/big/100-1008699_clipart-shapes-triangle-red-arrow-down-png-download.png"
    style="width:10px;height:10px;float:right;display:inline-block;white-space: nowrap">
    </p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>


    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}} </p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}} </p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    {% elsif stat_result._value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    (% else %}
    Weighted Pct: {{wt_percent._value}}

    {% endif %}
    ;;
  }

  measure: Weighted_Pct_Funnel {
    label: "Weighted Percent"
    group_label: "For Developers"
    description: "Weighted % for Funnel"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(${wt_base},0) ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    <div><p style="color: black; background-color: lightgreen; font-size:125%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    <div><p style="color: black; background-color: tomato; font-size:125%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    <div><p style="color: white; font-size:100%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    <div><p style="color: white; font-size:100%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    <div><p style="color: black; background-color: lightgreen; font-size:125%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    <div><p style="color: black; background-color: tomato; font-size:125%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    <div><p style="color: white; font-size:100%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    <div><p style="color: white; font-size:100%; text-align:center;border: 2px blue; padding: 25px">{{rendered_value}}</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif stat_result._value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{rendered_value}}</p>

    (% else %}
    Weighted Pct: {{wt_percent._value}}

    {% endif %}
    ;;
  }

  measure: Weighted_Pct_Line {
    label: "Weighted Percent"
    group_label: "For Developers"
    description: "Weighted % for Trend chart"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(round(${wt_base}),0) ;;
    # sql:  ${wt_percent} ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank Score: <p style="color: white; font-size:100%; text-align:center">{{rank_score._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: tomato; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank Score: <p style="color: white; font-size:100%; text-align:center">{{rank_score._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:center">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank Score: <p style="color: white; font-size:100%; text-align:center">{{rank_score._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:center">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank Score: <p style="color: white; font-size:100%; text-align:center">{{rank_score._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: lightgreen; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: tomato; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: white; font-size:100%; text-align:center">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: white; font-size:100%; text-align:center">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:center">{{rank_wt_pct._value}}</p></div>

    {% endif %}
    ;;
  }

  measure: Weighted_Pct_Line_ {
    label: "Weighted Percent"
    group_label: "For Developers"
    description: "Weighted % for Trend chart without Rank"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(round(${wt_base}),0) ;;
    # sql:  ${wt_percent} ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: tomato; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:center">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:center">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: lightgreen; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: tomato; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: white; font-size:100%; text-align:center">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    Weighted Pct: {{rendered_value}}
    <div>Significance (YoY): <p style="color: white; font-size:100%; text-align:center">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:center">{{wt_base._value}}</p></div>

    {% endif %}
    ;;
  }

  measure: Weighted_Pct_brand_snapshot {
    label: "Weighted Percent (Brand Snapshot)"
    group_label: "For Developers"
    description: "Weighted % for Trend chart"
    type: number
    value_format_name: percent_0
    sql: ${wt_count}/NULLIF(round(${wt_base}),0) ;;
    html:
    {% if significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 1 %}
    {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == -1 %}
    {{rendered_value}}
    <div> Significance (WoW): <p style="color: black; background-color: tomato; font-size:100%; text-align:center;border: 1px blue; padding: 3px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 0 %}
    {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:left">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'WoW' and stat_result._value == 2 %}
    {{rendered_value}}
    <div>Significance (WoW): <p style="color: white; font-size:100%; text-align:left">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 1 %}
    {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: lightgreen; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Increase</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == -1 %}
    {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; background-color: tomato; font-size:125%; text-align:center;border: 2px blue; padding: 25px">Decrease</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 0 %}
    {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; font-size:100%; text-align:left">No change</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    Rank: <div style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</div>

    {% elsif significance_dropdown_dim._rendered_value == 'YoY' and stat_result._value == 2 %}
    {{rendered_value}}
    <div>Significance (YoY): <p style="color: black; font-size:100%; text-align:left">N/A</p></div>
    <div>Weighted Base: <p style="color: white; font-size:100%; text-align:left">{{wt_base._value}}</p></div>
    <div>Rank: <p style="color: white; font-size:100%; text-align:left">{{rank_label._value}}</p></div>

    (% elsif is_null(stat_result._value) %}
    Weighted Pct: {{wt_percent._value}}

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
    ELSE 2
    END ;;
    html:
    {% if value == 1 %}
    <p style="color: black; font-size:100%; text-align:center">{{ 'Increase' }}</p>
    {% elsif value == -1 %}
    <p style="color: black; font-size:100%; text-align:center">{{ 'Decrease' }}</p>
    {% elsif value == 0 %}
    <p style="color: black; font-size:100%; text-align:center">{{ 'No change' }}</p>
    {% elsif value == 2 %}
    <p style="color: black; font-size:100%; text-align:center">{{ 'N/A' }}</p>
    {% endif %} ;;
  }

  measure: wt_percent {
    type: sum
    group_label: "For Developers"
    label: "Weighted Percent (original)"
    value_format_name: percent_0
    sql: (${TABLE}.wtMetric)/100 ;;
  }
}
