http://web.cs.ucla.edu/classes/fall16/cs240A/XMLproject/v-emps.xml
http://web.cs.ucla.edu/classes/fall16/cs240A/XMLproject/v-depts.xml

My Answer:
element dept_history {
	for $x in doc("v-depts.xml")/departments/department 
	for $mgrno in doc("v-depts.xml")/departments/department[deptno=$x/deptno]/mgrno
	let $tstart:= $mgrno/@tstart/data(), $tend:= $mgrno/@tend/data()
	where not ($tend < "1994-05-01" or $tstart > "1996-05-06")
	return element dept{ 
		element deptno {$x/deptno/text()},
		element deptname {$x/deptname/text()},
		element mgrno {$mgrno/text()},
		element tstart {if ($tstart>"1994-05-01") then $tstart else "1994-05-01"},
		element tend {if ($tend<"1996-05-06") then $tend else "1996-05-06"}
	}
}

********************************************************************************************************

element slicing{
	for $x in doc("v-depts.xml")/departments/department 
	for $y in doc("v-depts.xml")/departments/department[deptno=$x/deptno]/mgrno
	let $s:=$y/@tstart/data(),$e:=$y/@tend/data()
	where not ($e<="1994-05-01" or $s>="1996-05-06")
	return element dept{ 
	element deptno {$x/deptno/text()},
	element deptname {$x/deptname/text()},
	element mgrno {$y/text()},
	element tstart {if ($s>"1994-05-01") then $s else "1994-05-01"},
	element tend {if ($e<"1996-05-06") then $e else "1996-05-06"}

	}
}

declare variable $start := '1994-05-01';
declare variable $end := '1996-05-06';

<departments>
{
  for $dept in doc("v-depts.xml")//department[not( @tstart > $end or $start >= @tend)]
  return element
    {node-name($dept)}
    {
      util:slice($dept,$start,$end),
      util:slice_all($dept/*[not( @tstart > $end or $start >= @tend)], $start, $end )
    }   
}
</departments>