

<cfquery name="get_all" datasource="fitSQL" >
SELECT     dbo.AskSomeoneQuestions.title, dbo.AskSomeoneQuestions.questionid, dbo.AskSomeoneQuestions.question, dbo.AskSomeoneQuestions.dateadded, 
dbo.AskQJnQuals.categoryid AS QualsCategoryID, dbo.AskQJnGeneral.categoryid AS GeneralCategoryID, dbo.AskQJnSubjects.categoryid AS SubjectsCategoryID, 
dbo.AskQJnJobroles.categoryid AS JobRolesCategoryID, dbo.AskSomeoneQuestions.askerschoolregion, dbo.AskSomeoneAnswers.answerid, 
dbo.AskSomeoneAnswers.answer, dbo.Contacts.Firstname, dbo.Contacts.Surname, dbo.Contacts.jobtitle, dbo.Contacts.IndID, dbo.AskQYearLevel.catname AS YearLevelCatname
FROM  dbo.AskSomeoneQuestions INNER JOIN
                      dbo.AskSomeoneAnswers ON dbo.AskSomeoneQuestions.questionid = dbo.AskSomeoneAnswers.questionid INNER JOIN
                      dbo.Contacts ON dbo.AskSomeoneAnswers.indid = dbo.Contacts.IndID INNER JOIN
                      dbo.AskQYearLevel ON dbo.AskSomeoneQuestions.yearlevelid = dbo.AskQYearLevel.yearlevelid LEFT OUTER JOIN
                      dbo.AskQJnJobroles ON dbo.AskSomeoneQuestions.questionid = dbo.AskQJnJobroles.questionid LEFT OUTER JOIN
                      dbo.AskQJnSubjects ON dbo.AskSomeoneQuestions.questionid = dbo.AskQJnSubjects.questionid LEFT OUTER JOIN
                      dbo.AskQJnGeneral ON dbo.AskSomeoneQuestions.questionid = dbo.AskQJnGeneral.questionid LEFT OUTER JOIN
                      dbo.AskQJnQuals ON dbo.AskSomeoneQuestions.questionid = dbo.AskQJnQuals.questionid
ORDER BY questionid desc
</cfquery>

<cfquery name="qnumber" dbtype="query">
	select distinct questionid from get_all order by questionid 
</cfquery>

<cfset rowcount=StructNew()>

<cfloop query="qnumber">
	<cfset rowcount[questionid]=currentrow>
</cfloop>

<cfset result=ArrayNew(1)>

<cfloop query="get_all" group="QuestionID">
    	<Cfset strResult=StructNew()> 
		<cfset strResult.arrQuals=ArrayNew(1)>
        <cfset strResult.arrGeneral=ArrayNew(1)>
        <cfset strResult.arrSubjects=ArrayNew(1)>
        <cfset strResult.arrJobRoles=ArrayNew(1)>
        <cfset strResult.arrAnswerer=ArrayNew(1)>
        <cfset strResult.title='#title#'>
        <cfset strResult.currentrow='#rowcount[questionid]#'>
        <cfset strResult.profileid='#questionid#'>
        <cfset strResult.dateadded='#dateformat(dateadded,"d mmmm yyyy")#'>
		<cfset strResult.question="#question#">
        <cfset strResult.askerschoolregion="#askerschoolregion#">
        <cfset strResult.yearlevelcatname="#yearlevelcatname#">
		<cfset lstQualsID="">
        <cfset lstGeneralID="">
 		<cfset lstSubjectsID="">
        <cfset lstJobRolesID="">
		<cfloop>
    		<cfset lstQualsID=ListAppend(lstQualsID,QualsCategoryID)>
    		<cfset lstGeneralID=ListAppend(lstGeneralID,GeneralCategoryID)>
            <cfset lstSubjectsID=ListAppend(lstSubjectsID,SubjectsCategoryID)>
            <cfset lstJobRolesID=ListAppend(lstjobRolesID,JobRolesCategoryID)>
		</cfloop>
         <cfset lstQualsID=ListRemoveDuplicates(lstQualsID)>
         <cfset lstGeneralID=ListRemoveDuplicates(lstGeneralID)>
         <cfset lstSubjectsID=ListRemoveDuplicates(lstSubjectsID)>
         <cfset lstJobRolesID=ListRemoveDuplicates(lstJobRolesID)>
         <cfset strResult.arrQuals=ListToArray(lstQualsID)>
         <cfset strResult.arrGeneral=ListToArray(lstGeneralID)>
         <cfset strResult.arrSubjects=ListToArray(lstSubjectsID)>
         <cfset strResult.arrJobRoles=ListToArray(lstJobrolesID)>
         <cfset ArrayAppend(result,strResult)>
</cfloop> 

<cfoutput>#serializeJSON(result)#</cfoutput> 
