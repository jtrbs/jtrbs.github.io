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
		element title_history {
			for $title in $employee/title
			return element title{
				element title_name{$title/text()},
				element tstart{$title/@tstart/data()},
				element tend{$title/@tend/data()}
			} 	
		},
		for $deptno in $employee/deptno
		let $manager := local:overlap($deptno)    
		return element manager_history {
			$manager
		}
	}
}
