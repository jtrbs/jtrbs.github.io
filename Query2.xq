element employees {
	for $x in doc("v-emps.xml")/employees/employee[@tstart <= "1995-01-01" and "1995-01-01" <= @tend]
	for $salary in doc('v-emps.xml')/employees/employee[empno=$x/empno]/salary
	for $dep in doc('v-depts.xml')/departments/department[deptno=$x/deptno]
	where $salary/text() > 44000 and $salary/@tstart <= "1995-01-01" and $salary/@tend >= "1995-01-01"
	return element employee
	{
		element name{$x/firstname/text(),' ',$x/lastname/text()},
		element salary{$salary/text()},
		element deptname{$dep/deptname/text()}
	}
}