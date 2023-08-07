view: manager_countof_emp {
  #sql_table_name: `WORKDAY_SURVEY.manager_emp_hier3` ;;
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT ManagerID ,count(EmployeeID) as NumberOfEmpUnder FROM `sab-dev-proj-dev-dw-4905.WORKDAY_SURVEY.manager_emp_hier4` group by ManagerID
      ;;
  }

#   # Define your dimensions and measures here, like this:

  dimension: ManagerID {
    description: "Unique ManagerID"
    type: string
    primary_key: yes
    sql: ${TABLE}.ManagerID ;;
  }
  dimension: NumberOfEmpUnder {
    description: "The total number of emp under manager"
    type: number
    hidden: yes
    sql: ${TABLE}.NumberOfEmpUnder ;;
  }


  measure: Total_Num_Emp {
    type: sum
    sql:${NumberOfEmpUnder}  ;;

  }
}
