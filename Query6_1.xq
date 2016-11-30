declare function local:employee_time($c as xs:date, $deptno as xs:string) as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee[deptno = $deptno and @tstart <= $c and @tend > $c]
	return $employee
};

declare function local:get_employees($deptno as xs:string) as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee[deptno = $deptno]
	order by $employee/deptno[deptno = $deptno]/@tstart ascending
	return $employee
};

element department_employee_count_historty {
	for $deptno in distinct-values(doc('v-emps.xml')/employees/employee/deptno/text())
	let $employees := local:get_employees($deptno)
	return element one_department {
		for $timepoint in distinct-values($employees/@tstart)
		order by $timepoint ascending
		let $employee_count := count(local:employee_time($timepoint, $deptno))
		return element employee_count {
			element deptno{$deptno},
			element date{$timepoint},
			element count{xs:int($employee_count)}
		}
	}
}