

<cfquery name="get_all" datasource="fitSQL" >
SQL REMOVED
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
