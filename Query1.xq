declare function local:untilnow($x as xs:date) as xs:date{
	if(fn:year-from-date($x) = 9999) 
	then fn:adjust-date-to-timezone( current-date( ), () )
	else 
		xs:date($x)
};

element employment_history {
	for $x in doc('v-emps.xml')/employees/employee[firstname='Anneke' and lastname= 'Preusig']/deptno
	let $deptno := $x/text(), $tstart := $x/@tstart/data(), $tend := local:untilnow($x/@tend/data())
	return element employment {
		element deptno{$deptno},
		element tstart{$tstart},
		element tend{$tend}
	}
}