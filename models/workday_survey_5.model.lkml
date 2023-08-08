connection: "midt_dev_connect_4905"
include: "/views/**/*.view.lkml"


datagroup: workday_survey_2_default_datagroup {
  max_cache_age: "1 hour"}

persist_with: workday_survey_2_default_datagroup
#include: "/Dashboard/*.dashboard.lookml"

################################################################################

explore: manager_emp_hier5  {
  #sql_always_where: ${manager_emp_hier_new_2.NumberOfEmpUnder} >2;;
  join: manager_countof_emp {
    type: left_outer
    sql_on: ${manager_emp_hier5.manager_id}=${manager_countof_emp.ManagerID};;
    #sql_where: ${manager_countof_emp.NumberOfEmpUnder}>2 ;; ---- this is affecting data level ...not as expected output will restrict the data for CEO/HR as well
    relationship: many_to_one
  }
}

explore:survey5
{
  extends: [manager_emp_hier5]
  sql_always_where: {% if _user_attributes['user_designation'] =='CEO,HR'%}
        1=1

    {% elsif _user_attributes['user_designation'] =='Manager'%}
        ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}'
    {% else%}
        false
    {% endif %}   ;;

  join:manager_emp_hier5  {
    type: left_outer
    sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
    relationship: many_to_one
  }

##########################################  access_filter  and ${manager_countof_emp.NumberOfEmpUnder}>2
# access_filter: {
#   field: manager_countof_emp.NumberOfEmpUnder
#   user_attribute: <2
# }

}

###################################### creating user attribute

# explore:survey5
# {
# user_attribute: Emp_designation{
#   type: String
#   description: "Employee Designation"
#   sql_on : ;;
# }
#   join:manager_emp_hier5  {
#     type: left_outer
#     sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
#     relationship: many_to_one
#   }
# }


######################################### trying via access grant

# explore:survey5
# {
#   join:manager_emp_hier5  {
#     type: left_outer
#     sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
#     relationship: many_to_one
#   }
# }


# access_grant: can_view_all{
#     user_attribute: user_designation
#     allowed_values: ["HR","CEO","Manager","Consultant"]

# }


access_grant: can_view {
    user_attribute:user_designation
    allowed_values: ["Manager","CEO,HR"]
}
