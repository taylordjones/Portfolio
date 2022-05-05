proc import datafile='/home/u49573381/APE/Community dialogues.xlsx/'
out=CD
dbms=xlsx replace;
sheet="cleaned data";
getnames=yes;

data CD;
	set work.CD;
	label Q1="Which of the Folowing were harmful gender impacts as a result of COVID-19?"
		Q2="How have you most been able to address gender issues in your own life?"
		Q3="How did you lead the response to COVID-19 in your life?"
		Q4="Which area in your life was most affected by COVID-19?"
		Q5="Any follow-up discussions on gendered actions?"
		Contact_ID="ID"
		Rural_Urban_Classification="Area";
	if age=>17 and age=<31 then age_group='young adult';
	if age=>32 and age=<46 then age_group='early adult';
	if age=>47 and age=<61 then age_group='late adult';
	if age=>62 then age_group='senior';
	if age=>17 and age=<37 then agegroup='Age Group 1';
	if age=>38 then agegroup='Age Group 2';
proc format;
	value $Q1_
	"Increased teenage pregnancies and early marriage"=1
	"Increased domestic duties for women"=2
	"Loss of household decision making power for women"=3
	"Increased conflicts among couples and/or violence"=4;
	value $Q2_
	"Through shared domestic responsibilities between men and women"=1
	"Through shared household decision making between men and women"=2
	"Through protecting teenagers from teen pregnancy and early marriage"=3
	"All of the above"=4;
	value $Q3_
	"Continued to meet or support community groups"=1
	"Performed caretaking duties for children and relatives in the home"=2
	"Tried to earn income in different ways"=3
	"None of the above"=4;
	value $Q4_
	"Income and meeting daily basic needs was most affected"=1
	"Women and children’s safety was most affected"=2
	"Mental health was most affected"=3
	"You were not affected by COVID-19 in any of these ways"=4;
	value $Q5_
	"Yes"=1
	"No"=2;	
format Q1 Q1_ Q2 Q2_ Q3 Q3_ Q4 Q4_ Q5 Q5_;
run;

proc print data=cd (obs=10) label;
	var Contact_ID gender age district rural_urban_classification Q1 Q2 Q3 Q4 Q5;
	title "CD";
	format Q1 Q1_ Q2 Q3 Q4 Q5;
	run; 
proc import datafile='/home/u49573381/APE/vawc.xlsx/'
out=VAWC
dbms=xlsx replace;
sheet="cleaned data";
getnames=yes;

data VAWC;
	set work.VAWC;
	label Q1="Which statement do you agre with?"
		Q2="Which actions are you doing to respond to GBV"
		Q3="Which channel is the most appropriate for reporting GBV cases?"
		Q4="Which is the biggest challenge you face in responding to GBV?"
		Q5="How confident are you in your ability to respond to GBV cases?"
		Contact_ID="ID"
		Rural_Urban_Classification="Area";
	if age=>17 and age=<31 then age_group='young adult';
	if age=>32 and age=<46 then age_group='early adult';
	if age=>47 and age=<61 then age_group='late adult';
	if age=>62 then age_group='senior';
	if age=>17 and age=<37 then agegroup='Age Group 1';
	if age=>38 then agegroup='Age Group 2';
run;

/*proc contents data=work.CD; run;
proc contents data=work.VAWC; run;*/

/*check for missing values by column*/
data miss_CD;
	set work.CD;
	miss_n = cmiss(of Q1--Q5);
	label Q1="Which statement do you agre with?"
		Q2="Which actions are you doing to respond to GBV"
		Q3="Which channel is the most appropriate for reporting GBV cases?"
		Q4="Which is the biggest challenge you face in responding to GBV?"
		Q5="How confident are you in your ability to respond to GBV cases?"
		Contact_ID="ID"
		Rural_Urban_Classification="Area";
	if age=>17 and age=<31 then age_group='young adult';
	if age=>32 and age=<46 then age_group='early adult';
	if age=>47 and age=<61 then age_group='late adult';
	if age=>62 then age_group='senior';
	if age=>17 and age=<37 then agegroup='Age Group 1';
	if age=>38 then agegroup='Age Group 2';
	run;
	
proc print data=miss_CD (obs=10) label; 
	var Contact_ID gender age district rural_urban_classification Q1 Q2 Q3 Q4 Q5 miss_n;
	title "Missing Answers-CD";
	format ID Q1 Q2 Q3 Q4 Q5 area Q1_ Q2_ Q3_ Q4_ Q5_;
	run;
/*freq of missing values*/
/*proc freq data=miss_CD;
	tables miss_n/norow nocol;
	title "Missing Answers-CD";
	run;

/*check for missing values by column*/	
data miss_VAWC;
	set work.VAWC;
	miss_n = cmiss(of Q1--Q5);
	label Q1="Which statement do you agre with?"
		Q2="Which actions are you doing to respond to GBV"
		Q3="Which channel is the most appropriate for reporting GBV cases?"
		Q4="Which is the biggest challenge you face in responding to GBV?"
		Q5="How confident are you in your ability to respond to GBV cases?"
		Contact_ID="ID"
		Rural_Urban_Classification="Area";
	if age=>17 and age=<31 then age_group='young adult';
	if age=>32 and age=<46 then age_group='early adult';
	if age=>47 and age=<61 then age_group='late adult';
	if age=>62 then age_group='senior';
	if age=>17 and age=<37 then agegroup='Age Group 1';
	if age=>38 then agegroup='Age Group 2';
	run;
	
/*proc print data=miss_VAWC (obs=10) label; 
	var Contact_ID gender age district rural_urban_classification Q1 Q2 Q3 Q4 Q5 miss_n;
	title "Missing Answers-VAWC";
	format ID Q1 Q2 Q3 Q4 Q5 area Q1_ Q2_ Q3_ Q4_ Q5_;
	run;*/

/*freq of missing values*/
/*proc freq data=miss_VAWC;
	tables miss_n/norow nocol;
	title "Missing Answers-VAWC";
	run;*/
/*freq of CD variables*/
/*proc freq data=CD; 
	tables gender age_group rural_urban_classification Q1 Q2 Q3 Q4 Q5/norow nocol;
	title "Community Dialogue Variable Frequencies";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/*cross tabulation gender by answers*/	
/*proc freq data=CD;
	tables gender*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Gender by Answers-CD";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation age groups by answers*/	
/*proc freq data=CD;
	tables age_group*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Age by Answers-CD";
	format Q1 Q2 Q3 Q4 Q5;
	run;
	
/*cross tabulation area by answers*/		
/*proc freq data=CD;
	tables rural_urban_classification*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Rural/Urban by Answers-CD";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/

/*freq of VAWC variables*/
/*proc freq data=VAWC; 
	tables gender age_group rural_urban_classification Q1 Q2 Q3 Q4 Q5/norow nocol;
	title "VAWC Variable Frequencies";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/*cross tabulation gender by answers*/	
/*proc freq data=vawc;
	tables gender*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Gender by Answers-VAWC";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation age groups by answers*/
/*proc freq data=vawc;
	tables age_group*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Age by Answers-VAWC";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation of area by answers*/
/*proc freq data=VAWC;
	tables rural_urban_classification*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Rural/Urban by Answers-VAWC";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/* freq of new age groups*/
proc freq data=new_CD;
	tables agegroup*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of NEW Age by Answers-CD";
	format Q3;
	run;
	
/*proc freq data=CD;
	tables agegroup;
	title "New Age Groups CD";
	run;
proc freq data=vawc;
	tables agegroup;
	title "New Age Groups VAWC";
	run;
	
proc means data=CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class gender;
	title "Mean of Gender by Answers-CD";
	run;
proc means data=VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class gender;
		title "Mean of Gender by Answers-VAWC";
	run;
proc means data=CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class agegroup;
	title "Mean of Age Group by Answers-CD";
	run;
proc means data=VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class agegroup;
	title "Mean of Age Group by Answers-VAWC";
	run;
proc means data=CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class rural_urban_classification;
	title "Mean of Rural/Urban by Answers-CD";
	run;
proc means data=VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class rural_urban_classification;
	title "Mean of Rural/Urban by Answers-VAWC";
	run;*/
/*significance test*/
/*2-sample t-test to examine if the means of genders are sig different
class: used to compare means of the same variable
test whether there is a sig diff in the survey answers between male and female*/
/*proc ttest data=cd plots=none;
	class gender;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Gender-CD";
	run;
	
proc ttest data=vawc plots=none;
	class gender;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Gender-VAWC";
	run;
	
proc ttest data=cd plots=none;
	class agegroup;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Age Group-CD";
	run;
	
proc ttest data=vawc plots=none;
	class agegroup;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Age Group-VAWC";
	run;	
	
proc ttest data=cd plots=none;
	class rural_urban_classification;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Area-CD";
	run;
	
proc ttest data=vawc plots=none;
	class rural_urban_classification;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Area-VAWC";
	run;*/
/*analysis of only completed surveys*/
data new_CD;
	set work.miss_CD;
	if miss_n>0 then delete;
	run;

data new_VAWC;
	set miss_VAWC;
	if miss_n>0 then delete;
	run;
	
/*proc contents data=new_CD; run;
proc contents data=new_CD; run;*/
/*proc print data=new_CD (obs=10) label; 
	var Contact_ID gender age district rural_urban_classification Q1 Q2 Q3 Q4 Q5;
	title "Missing Answers-VAWC";
	format ID Q1 Q2 Q3 Q4 Q5 area;
	run;
	
proc print data=new_VAWC (obs=10) label; 
	var Contact_ID gender age district rural_urban_classification Q1 Q2 Q3 Q4 Q5;
	title "Missing Answers-VAWC";
	format ID Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/*freq of CD variables*/
/*proc freq data=new_CD; 
	tables gender age_group rural_urban_classification Q1 Q2 Q3 Q4 Q5/norow nocol;
	title "Community Dialogue Variable Frequencies-Completed Survey";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/*cross tabulation gender by answers*/	
/*proc freq data=new_CD;
	tables gender*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Gender by Answers-CD completed";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation age groups by answers*/	
/*proc freq data=new_CD;
	tables age_group*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Age by Answers-CD completed";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation area by answers*/		
/*proc freq data=new_CD;
	tables rural_urban_classification*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Rural/Urban by Answers-CD completed";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/

/*freq of VAWC variables*/
/*proc freq data=new_VAWC; 
	tables gender age_group rural_urban_classification Q1 Q2 Q3 Q4 Q5/norow nocol;
	title "VAWC Variable Frequencies- Completed";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/
/*cross tabulation gender by answers*/	
/*proc freq data=new_vawc;
	tables gender*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Gender by Answers-VAWC completed";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation age groups by answers*/
/*proc freq data=new_vawc;
	tables age_group*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Age by Answers-VAWC completed";
	format Q1 Q2 Q3 Q4 Q5;
	run;*/

/*cross tabulation of area by answers*/
/*proc freq data=new_VAWC;
	tables rural_urban_classification*(Q1 Q2 Q3 Q4 Q5)/norow nocol;
	title "Cross Tabulation of Rural/Urban by Answers-VAWC completed";
	format Q1 Q2 Q3 Q4 Q5 area;
	run;*/

/*proc means data=new_CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class gender;
	title "Mean of Gender by Answers-CD completed";
	run;
proc means data=new_VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class gender;
	title "Mean of Gender by Answers-VAWC completed";
	run;
proc means data=new_CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class agegroup;
	title "Mean of Age Group by Answers-CD completed";
	run;
proc means data=new_VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class agegroup;
	title "Mean of Age Group by Answers-VAWC completed";
	run;
proc means data=new_CD;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	class rural_urban_classification;
	title "Mean of Rural/Urban by Answers-CD completed";
	run;
proc means data=new_VAWC;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer; 
	class rural_urban_classification;
	title "Mean of Rural/Urban by Answers-VAWN completed";
	run;
	*/
/*significance test*/
/*2-sample t-test to examine if the means of genders are sig different
class: used to compare means of the same variable
test whether there is a sig diff in the survey answers between male and female*/
/*proc ttest data=new_cd plots=none;
	class gender;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test-CD completed";
	run;
	
proc ttest data=new_vawc plots=none;
	class gender;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test-VAWC completed";
	run;
proc ttest data=new_cd plots=none;
	class agegroup;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Age Group-CD completed";
	run;
	
proc ttest data=new_vawc plots=none;
	class agegroup;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Age Group-VAWC completed";
	run;

proc ttest data=new_cd plots=none;
	class rural_urban_classification;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Area-CD";
	run;
	
proc ttest data=new_vawc plots=none;
	class rural_urban_classification;
	var Q1_Answer Q2_Answer Q3_Answer Q4_Answer Q5_Answer;
	title "Independent T-Test by Area-VAWC";
	run;*/