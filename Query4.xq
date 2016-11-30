http://web.cs.ucla.edu/classes/fall16/cs240A/XMLproject/v-emps.xml
http://web.cs.ucla.edu/classes/fall16/cs240A/XMLproject/v-depts.xml

My Answer:

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

********************************************************************************************************


declare function local:outnow($c as xs:date) as xs:date{
	if(fn:year-from-date($c)=9999) then fn:adjust-date-to-timezone( current-date( ), () )
	else 
		xs:date($c)
};
declare function local:format($c as xs:string)as xs:date{
	if($c="1993-06-`24") then  xs:date("1993-06-24") 
	else
	 xs:date($c)
};

element duration {
	for $e in doc("v-emps.xml")/employees/employee
	let $largesttime:=$e/salary[every $x in $e/salary satisfies (local:outnow(@tend)-local:outnow(local:format(@tstart)))>=(local:outnow($x/@tend)-local:outnow(local:format($x/@tstart)))]
	return element one_employee{
	
	
		
			for $each in $largesttime
			return element eachperiod{
				element name{$e/firstname/text()," ",$e/lastname/text()},
				element lon_start {data($each/@tstart)},
				element lon_end	{local:outnow($each/@tend)},
				element salary {$each/text()}
			}
		
	}
}

<employees>
{
  for $emp in doc("v-emps.xml")//employee
  let $durations := $emp/salary[
    every $x in $emp/salary satisfies (
      util:tillnow(@tend)-util:tillnow(@tstart)) >= (util:tillnow($x/@tend) - util:tillnow($x/@tstart)
    )
  ]
  return element 
  {node-name($emp)}
  {
      <salary_periods>{
        for $each in $durations
        return <each_salary_period>{
        <name>{$emp/firstname/text()," ",$emp/lastname/text()}</name>,
        <from> {data($each/@tstart)}</from>,
        <to> {util:tillnow($each/@tend)}</to>,
        <salary> {$each/text()}</salary>
      }</each_salary_period>
    }</salary_periods>
  }
}
</employees>