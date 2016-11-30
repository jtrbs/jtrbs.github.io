My Answer:

declare function local:employee_time($c as xs:date) as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee[@tstart <= $c and @tend > $c]
	return $employee
};

declare function local:get_employees() as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee
	order by $employee/@tstart ascending
	return $employee
};

element company_employee_count_historty {
	let $employees := local:get_employees()
	for $timepoint in distinct-values($employees/@tstart)
	order by $timepoint ascending
	let $employee_count := count(local:employee_time($timepoint))
	return element employee_count
	{
		element date{$timepoint},
		element count{xs:int($employee_count)}
	}
}



********************************************************************************************************


declare function local:S_amount($c as xs:date) as xs:int*
{
	for $salary in doc('v-emps.xml')/employees/employee/salary[@tstart <= $c and @tend > $c]
	let $salaryValue := xs:int($salary/text())
	return $salaryValue
};
declare function local:getsalaries() as element()*
{
	for $salary in doc('v-emps.xml')/employees/employee/salary
	order by $salary/@tstart ascending
	return $salary
};

element salary_company_avg{
	let $salaries:=local:getsalaries()
	for $timepoint in distinct-values($salaries/@tstart)
	order by $timepoint ascending
	let $salarie_amount := avg(local:S_amount($timepoint))
	return element average_salary
	{
		element period{$timepoint},
		element salary{xs:int($salarie_amount)}
		
		
	}
}