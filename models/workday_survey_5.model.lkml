connection: "midt_dev_connect_4905"
include: "/views/**/*.view.lkml"


datagroup: workday_survey_2_default_datagroup {
  max_cache_age: "1 hour"}

persist_with: workday_survey_2_default_datagroup
include: "/Dashboard/*.dashboard.lookml"

explore:survey5
{

  sql_always_where: {% if ${manager_emp_hier5.employee_id}=='{{ _user_attributes[email] }}' and  ${manager_emp_hier5.designation} =='CEO' %}
        1=1
    {% else %}
        ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}'
    {% endif %}   ;;

# sql_always_where: case when  ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}' and ${manager_emp_hier5.designation} ='CEO' then 1=1
# else ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}' end;;

  join:manager_emp_hier5  {
     type: left_outer
    sql_on: ${survey5.employee_id}=${manager_emp_hier5.employee_id};;
    relationship: many_to_one
  }
}
# ${manager_emp_hier5.employee_id}='{{ _user_attributes['email'] }}' and ${manager_emp_hier5.designation} ='CEO'
# access_grant: can_view_all{
#     user_attribute: user_designation
#     allowed_values: ["HR","CEO","Manager","Consultant"]

# }

# access_grant: can_view_managerSelf {
#     user_attribute:user_designation
#     allowed_values: ["Manager"]
# }
