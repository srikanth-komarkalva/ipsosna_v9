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
}
