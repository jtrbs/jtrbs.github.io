declare function local:employee_time($t as xs:date, $deptno as xs:string) as element()*
{
	for $employee in doc('v-emps.xml')/employees/employee/deptno[.= $deptno and ((@tstart <= $t and @tend > $t) or (fn:year-from-date($t) = 9999 and @tend = $t))]
	return $employee
};

declare function local:get_depts($deptno as xs:string) as element()*
{
	for $deptno in doc('v-emps.xml')/employees/employee/deptno[.= $deptno]
	order by $deptno/@tstart ascending
	return $deptno
};

element department_employee_count_historty {
	for $deptno in distinct-values(doc('v-depts.xml')/departments/department/deptno)
	let $depts := local:get_depts($deptno)
	return element one_department {
		for $timepoint in distinct-values(($depts/@tstart, $depts/@tend))
		order by $timepoint ascending
		let $employee_count := count(local:employee_time($timepoint, $deptno))
		return element employee_count {
			element deptno{$deptno},
			element date{$timepoint},
			element count{xs:int($employee_count)}
		}
	}
}