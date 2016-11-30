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