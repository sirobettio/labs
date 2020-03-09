/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/
cas casauto;
caslib _all_ assign;

libname mytest cas caslib=TESTDATA;

/* 
Use casutil to:
- drop a table in a caslib
- load a table in a caslib
- save a table in a caslib
- list files in a caslib 
*/
proc casutil incaslib="TESTDATA";
   list files; 
   droptable casdata="IRIS" incaslib="TESTDATA" quiet;
run;

data mytest.iris;
   set sashelp.iris;
run; 
proc print data=TESTDATA.iris(obs=5) ; run;

proc casutil incaslib="TESTDATA" outcaslib="TESTDATA"; 
   save casdata="iris" replace; 
run;

proc casutil incaslib="TESTDATA";
   list files; 
run;

/* 
Use cas to:
- load a table in a caslib
- call the simple.correlation function
*/
proc cas;
	table.loadtable caslib="TESTDATA" path="iris.sashdat" casOut={name="IRIS"};
	simple.correlation result=x table={groupBy={"Species"}, name="IRIS", orderBy={"SepalLength"}};
run;
	print x;
run; 


proc gradboost data=TESTDATA.iris outmodel=TESTDATA.gradboost_model;
	input sepalLength sepalWidth petalLength petalWidth / level = interval;
	target Species /level=nominal;
	output out=TESTDATA.score_at_runtime;
	ods output FitStatistics=fit_at_runtime;
run;
