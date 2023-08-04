view: manager_emp_hier5 {
  sql_table_name: `WORKDAY_SURVEY.manager_emp_hier5` ;;
 # required_access_grants: [can_view_all,can_view_managerSelf]
  dimension: designation {
    type: string
    sql: ${TABLE}.Designation ;;

  }
  dimension: employee_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.EmployeeID ;;
  }
  dimension: manager_id {
    type: string
    sql: ${TABLE}.ManagerID ;;
  }





}
