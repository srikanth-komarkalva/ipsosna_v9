connection: "youtubeb2b_preaggregated_datasheet"

# include all the views
include: "/views/**/*.view"

datagroup: ipsosna_v9_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ipsosna_v9_default_datagroup

explore: combined_data_sheet_portal_columns {}
