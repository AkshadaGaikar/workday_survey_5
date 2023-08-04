connection: "midt_dev_connect_4905"
include: "/views/**/*.view.lkml"


datagroup: workday_survey_2_default_datagroup {
  max_cache_age: "1 hour"}

persist_with: workday_survey_2_default_datagroup
#include: "/Dashboard/*.dashboard.lookml"

explore:survey5
{
  join:manager_emp_hier5  {
     type: left_outer
    sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
    relationship: many_to_one
  }
}
# access_grant: can_view_all{
#   allowed_values: ["HR","CEO","Manager","Consultant"]
#   user_attribute: user_designation
# }

# access_grant: can_view_managerSelf {
#   allowed_values: ["Manager"]
#   user_attribute: user_designation
# }
