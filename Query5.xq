My answer:

declare function local:min( $date1 as xs:string, $date2 as xs:string ) as xs:date
{
	if( xs:date($date1)>xs:date($date2) )
	then
		xs:date($date2)
	else
		xs:date($date1)
};

declare function local:max( $date1 as xs:string, $date2 as xs:string ) as xs:date
{
	if( xs:date($date1)>xs:date($date2) )
	then
		xs:date($date1)
	else
		xs:date($date2)
};

declare function local:overlap( $deptno as element()* ) as element()* {
	for $mgrno indoc("v-depts.xml")/departments/department[deptno=$deptno]/mgrno
	where not ($mgrno/@tend < $deptno/@tstart or $mgrno/@tstart > $deptno/@tend)
	let $tstart:= local:max($mgrno/@tstart,$deptno/@tstart), $tend:= local:min($mgrno/@tend,$deptno/@tend)
	return element manager {
		element mgrno{$mgrno/text()},
		element tstart{$tstart},
		element tend{$tend}
	} 
};

element employees {
	for $employee in doc('v-emps.xml')/employees/employee
	return element employee {
		element name{$employee/firstname/text(),' ',$employee/lastname/text()},
		for $title in $employee/title
		return element title_history {
			element title{$title/text()},
			element tstart{$title/@tstart/data()},
			element tend{$title/@tend/data()}
		},
		for $deptno in $employee/deptno
		let $manager := local:overlap($deptno)    
		return element manager_history {
			$manager
		}
	}
}


***************************************************************************************
element employees {
	return element employee {
		for $employee in doc('v-emps.xml')/employees/employee
			for $mgrno in doc("v-depts.xml")/departments/department[deptno=$employee/deptno]/mgrno
				let $ov := local:overlap($employee/deptno, $mgrno/@tstart, $mgrno/@tend)
		let $title := $employee/title/text(), $tstart := $employee/title/@tstart/data(), $tend := $employee/title/@tend/data()
		return element title_history {
			element name{$x/firstname/text(),' ',$x/lastname/text()},
			element deptno{$deptno},
			element tstart{$tstart},
			element tend{$tend}
		}
	}
}

for $r in doc("v-emps.xml")/employees/employee
for $m in doc("v-depts.xml")/departments
/department[deptno=$r/deptno]
let $ov := local:overlap($r/deptno, $m/mgrno/@tstart, $m/mgrno/@tend)
return (element empf$r/empno, $r/title, $r/deptno,
for $e temp in $r/deptno
for $m temp in $m/mgrno
let $ov :=
local:overlap($e temp, $m temp/@tstart, $m temp/@tend)
where not (empty($ov)) return $m tempg)
g;

***************************************************************************************
declare function local:untilnow($x as xs:date) as xs:date{
	if(fn:year-from-date($x) = 9999) 
	then fn:adjust-date-to-timezone( current-date( ), () )
	else 
		xs:date($x)
};

element employees {
	return element employee {
		for $employee in doc('v-emps.xml')/employees/employee
		let $title := $employee/title/text(), $tstart := $employee/title/@tstart/data(), $tend := local:untilnow($employee/title/@tend/data())
		return element title_history {
			element name{$x/firstname/text(),' ',$x/lastname/text()},
			element deptno{$deptno},
			element tstart{$tstart},
			element tend{$tend}
		}
	}
}


******************************************************************************************

My Answer:

declare function local:now( ) as xs:string
{
	xs:string( fn:adjust-date-to-timezone( current-date( ), () ) )
};

declare function local:uc2now( $x as xs:string ) as xs:date
{
	if( $x="9999-12-31" )
	then
		xs:date( local:now() )
	else
		xs:date($x)
};

declare function local:uc2now_all( $elements as element()* ) as element()*
{
	for $element in $elements
		order by $element/@tstart, $element/@tend
		return element
			{node-name($element)}
			{
				local:slice( $element, '1900-01-01', local:now() ),
				string($element)
			}
};

declare function local:min( $d1 as xs:string, $d2 as xs:string ) as xs:date
{
	if( xs:date($d1)>xs:date($d2) )
	then
		xs:date($d2)
	else
		xs:date($d1)
};

declare function local:max( $d1 as xs:string, $d2 as xs:string ) as xs:date
{
    if( xs:date($d1)>xs:date($d2) )
    then
        xs:date($d1)
    else
        xs:date($d2)
};

declare function local:slice( $element as element(), $start as xs:string, $stop as xs:string ) as attribute()*
{
	attribute tstart {local:max($start,$element/@tstart)},
    attribute tend   {local:min($stop,$element/@tend)},
	$element/@*[name(.)!="tend" and name(.)!="tstart"]
};

declare function local:slice_all( $elements as element()*,
								 $start as xs:string, $stop as xs:string ) as element()*
{
	for $element in $elements
		return 
			element {node-name($element)}
			{
				local:slice($element, $start, $stop),
				string($element)
			}
};

element employees {
	for $employee in doc("v-emps.xml")/employees/employee
	return element
		{node-name($employee)}	
		{
			local:slice( $employee, '1900-01-01', local:now() ),
			local:uc2now_all( (
				$employee/empno,
				$employee/firstname,
				$employee/lastname) ),
			local:uc2now_all( (
				$employee/title,
				$employee/deptno ) ),
			element managers
			{
				for
					$deptno
						in $employee/deptno,
					$manager
						in doc("v-depts.xml")//
								department[deptno=$deptno]/mgrno[@tstart<=$deptno/@tend and $deptno/@tstart<=@tend]
					let $dept_duration := local:slice( $deptno, '1900-01-01', local:now() )
					return 
						local:slice_all( ($manager), string($dept_duration[1]), string($dept_duration[2]) )
			}
		}
}
********************************************************************************************************

element employees
{
for $employee
	in doc("v-emps.xml")//employee
	return element
		{node-name($employee)}	
		{
			local:slice( $employee, '1900-01-01', local:now() ),
			local:uc2now_all( (
				$employee/empno,
				$employee/firstname,
				$employee/lastname) ),
			local:uc2now_all( (
				$employee/title,
				$employee/deptno ) ),
			element managers
			{
				for
					$deptno
						in $employee/deptno,
					$manager
						in doc("v-depts.xml")//
								department[deptno=$deptno]/mgrno[@tstart<=$deptno/@tend and $deptno/@tstart<=@tend]
					let $dept_duration := local:slice( $deptno, '1900-01-01', local:now() )
					return 
						local:slice_all( ($manager), string($dept_duration[1]), string($dept_duration[2]) )
			}
		}
}