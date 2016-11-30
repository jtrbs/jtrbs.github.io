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