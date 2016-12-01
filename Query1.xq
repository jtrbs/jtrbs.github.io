element employment_history {
	for $x in doc('v-emps.xml')/employees/employee[firstname='Anneke' and lastname= 'Preusig']/deptno
	let $deptno := $x/text(), $tstart := $x/@tstart/data(), $tend := $x/@tend/data()
	return element employment {
		element deptno{$deptno},
		element tstart{$tstart},
		element tend{$tend}
	}
}