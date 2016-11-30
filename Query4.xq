declare function local:untilnow($x as xs:date) as xs:date{
	if(fn:year-from-date($x) = 9999) 
	then fn:adjust-date-to-timezone( current-date( ), () )
	else 
		xs:date($x)
};

element duration {
	for $emp in doc("v-emps.xml")/employees/employee
	let $longest_period:=$emp/salary[every $x in $emp/salary satisfies (
			local:untilnow(@tend)-local:untilnow(@tstart) >= (local:untilnow($x/@tend)-local:untilnow($x/@tstart))
		)]
	return element employee{
		for $each in $longest_period
		return element longest_period {
			element name{$emp/firstname/text()," ",$emp/lastname/text()},
			element tstart {data($each/@tstart)},
			element tend {local:untilnow($each/@tend)},
			element salary {$each/text()}
		}
	}
}