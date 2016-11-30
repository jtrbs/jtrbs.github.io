declare function local:get_salaries() as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee[deptno/text()='d005']
	for $dept in $employee/deptno
	where $dept/text()='d005'
	for $salary in $employee/salary[@tstart<=$dept/@tend and @tend>=$dept/@tstart]
	order by $salary/@tstart ascending
	return $salary
};

declare function local:get_salary_value($c as xs:date) as xs:int*
{
	for $employee in doc('v-emps.xml')/employees/employee[deptno/text()='d005']
	for $dept in $employee/deptno
	where $dept/text()='d005'
	for $salary in $employee/salary[@tstart<=$dept/@tend and @tend>=$dept/@tstart]
	where $salary/@tstart<=$c and $salary/@tend>$c
	let $value := xs:int($salary/text())
	return $value
};

element max_salary_history{
	let $salaries:=local:get_salaries()
	for $date in distinct-values($salaries/@tstart)
	order by $date ascending
	let $salary_max:=max(local:get_salary_value($date))
	return element max_salary{
		element date{$date},
		element salary{$salary_max}
	}
}