element employees {
	for $x in doc("v-emps.xml")/employees/employee
	for $deptno in $x/deptno[@tstart <= "1995-01-06" and "1995-01-06" <= @tend]
	for $salary in $x/salary
	where $salary/text() < 44000 and $salary/@tstart <= "1995-01-06" and $salary/@tend >= "1995-01-06"
	return element employee
	{
		element name{$x/firstname/text(),' ',$x/lastname/text()},
		element salary{$salary/text()},
		element deptno{$deptno/text()}
	}
}