My Answer:

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


********************************************************************************************************

declare function local:S_values($c as xs:date,$t as xs:string) as xs:int*
{
	for $human in doc('v-emps.xml')/employees/employee
	for $title in $human/title[text()=$t]
	for $salary in $human/salary[@tstart <= $c and @tend > $c and @tstart<=$title/@tend and @tend>=$title/@tstart]
	let $salaryValue := xs:int($salary/text())
	return $salaryValue
};
declare function local:getsalaries($t as xs:string) as element()*
{
	for $human in doc('v-emps.xml')/employees/employee
	for $title in $human/title[text()=$t]
	for $salary in $human/salary[@tstart<=$title/@tend and @tend>=$title/@tstart]
	order by $salary/@tstart ascending
	return $salary
};

element salary_title_avg{
	for $title in distinct-values(doc('v-emps.xml')/employees/employee/title/text())
	let $salaries:=local:getsalaries($title)
	return element onetitle
	{
		
		
			for $timepoint in distinct-values($salaries/@tstart)
			order by $timepoint ascending
			let $salary_amount:= avg(local:S_values($timepoint,$title))
			return element average_amount{
			element title_name{$title},
			element period{$timepoint},
			element salary{xs:int($salary_amount)}
			}
		

		
	}
}