connection: "youtubeb2b_preaggregated_datasheet"

# include all the views
include: "/views/**/*.view"

datagroup: ipsosna_v9_default_datagroup {
  sql_trigger: SELECT TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(),hour) ;;
  max_cache_age: "24 hours"
}

persist_with: ipsosna_v9_default_datagroup

explore: combined_data_sheet_portal_columns {
  label: "YouTube B2B Explore"
  view_label: "YouTube B2B Explore"
  query: YouTube_B2B_Quick_Start {
    dimensions: [combined_data_sheet_portal_columns.metric_label_without_brand,
      combined_data_sheet_portal_columns.metric_category_label,
      combined_data_sheet_portal_columns.attribute_selector1_dim,
      combined_data_sheet_portal_columns.attribute_selector2_dim]
    measures: [combined_data_sheet_portal_columns.wt_count,combined_data_sheet_portal_columns.Weighted_Pct_Crosstab, combined_data_sheet_portal_columns.stat_result ]
    label: "YouTube B2B Quick Start"
    description: "Hello Users, Please use this Quick Start explore to start analyzing your data in YouTube B2B!!"
    pivots: [combined_data_sheet_portal_columns.attribute_selector1_dim, combined_data_sheet_portal_columns.attribute_selector2_dim]
    filters: [combined_data_sheet_portal_columns.attribute_selector1: "countryCode",
      combined_data_sheet_portal_columns.attribute_selector2: "timePeriodLabel",
      combined_data_sheet_portal_columns.market_code: "US",
      combined_data_sheet_portal_columns.metric_code: "Brand_Fam",
      combined_data_sheet_portal_columns.product_label: "Youtube",
      combined_data_sheet_portal_columns.banner_label: "Total",
      combined_data_sheet_portal_columns.significance_dropdown: "WoW"]
    limit: 100
  }




}
