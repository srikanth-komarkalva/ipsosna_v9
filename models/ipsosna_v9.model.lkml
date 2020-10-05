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

  join: sort_view {
    view_label: "YouTube B2B Explore"
    relationship: one_to_one
    type: inner
    sql_on: ${combined_data_sheet_portal_columns.metric_id} = ${sort_view.metric_id}
            and
            ${combined_data_sheet_portal_columns.metric_category_label} = ${sort_view.metric_category_label};;
  }
}
