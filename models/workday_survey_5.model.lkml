connection: "midt_dev_connect_4905"
include: "/views/**/*.view.lkml"


datagroup: workday_survey_2_default_datagroup {
  max_cache_age: "1 hour"}

persist_with: workday_survey_2_default_datagroup
#include: "/Dashboard/*.dashboard.lookml"

################################################################################

explore:survey5
{
 #giving a syntax error at front end for BQ
  # sql_always_where: {% if ${manager_emp_hier5.employee_id}=='{{ _user_attributes[email] }}' and  ${manager_emp_hier5.designation} =='CEO' %}
  #       1=1
  #   {% else %}
  #       ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}'
  #   {% endif %}   ;;

#working check else if condition if required
  # sql_always_where: {% if _user_attributes['email'] and  _user_attributes['user_designation'] =='CEO' %}
  #       1=1
  #   {% else %}
  #       ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}'
  #   {% endif %}   ;;


  sql_always_where: {% if _user_attributes['user_designation'] =='CEO,HR'%}
        1=1
    {% elsif _user_attributes['user_designation'] =='Manager'  %}
        ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}'
    {% else%}
        false
    {% endif %}   ;;



#it not working as it check row wise record
# sql_always_where: case when  ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}' and ${manager_emp_hier5.designation} ='CEO' then 1=1
# else ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}' end;;

  join:manager_emp_hier5  {
    type: left_outer
    sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
    relationship: many_to_one
  }
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
