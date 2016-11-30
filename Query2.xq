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


naive版本

declare function local:snapshot( $elements as element()* ) as element()*
{
	for $element in $elements
	return element
		{node-name($element)}
		{
			$element/@*[name(.)!="tend" and name(.)!="tstart"],
			data($element)
		}
};


element employees {
	for $x in doc("v-emps.xml")/employees/employee[@tstart <= "1995-01-06" and "1995-01-06" <= @tend]
	for $deptno in $x/deptno[@tstart <= "1995-01-06" and "1995-01-06" <= @tend]
	for $salary in doc('v-emps.xml')/employees/employee[empno=$x/empno]/salary
	where $salary/text() < 44000 and $salary/@tstart <= "1995-01-06" and $salary/@tend >= "1995-01-06"
	return element employee
	{
		element name{$x/firstname/text(),' ',$x/lastname/text()},
		element salary{$salary/text()},
		element deptno{$deptno/text()}
	}
}

element employees {
	for $x in doc("v-emps.xml")/employees/employee
	for $deptno in $x/deptno
	for $salary in $x/salary
	where $salary/text() < 44000 and $salary/@tstart <= "1995-01-06" and $salary/@tend >= "1995-01-06"
	return element employee
	{
		element name{$x/firstname/text(),' ',$x/lastname/text()},
		element salary{$salary/text()},
		element deptno{$deptno/text()}
	}
}

