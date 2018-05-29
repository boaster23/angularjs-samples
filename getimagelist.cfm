
<cfquery name="get_all" datasource="fitSQL" cachedwithin="#createTimeSpan(1,0,0,0)#">
SQL REMOVED
</cfquery>

	<cfset result=ArrayNew(1)>

 	<cfloop query="get_all" group="profileid">
    	<Cfset strResult=StructNew()>
        <cfset strResult.arrSector=ArrayNew(1)>
        <cfset strResult.arrKeyword=ArrayNew(1)>
        <cfset strResult.arrMinority=ArrayNew(1)>
        <cfset strResult.arrEthnicity=ArrayNew(1)>
    	<cfset strResult.completeName='#trim(firstname)# #trim(surname)#'>
        <cfset strResult.organisation='#employerText#'>
        <cfset strResult.profileid='#profileid#'>
        
        <cfset strResult.jobrole="#catname#">
        <cfset strResult.genderID='#genderID#'>
        <cfset strResult.profileUrl="/#profileID#/0/jobroles/#jobrolecategoryid#/#trim(firstname)# #trim(surname)#">
        <cfset strResult.smItemUrl="/profiles/thumb/#urlencodedformat(NPIserverPath)#">
        <cfset strResult.lgItemUrl="/profiles/#urlencodedformat(NPIserverPath)#">
        <cfset strResult.title="#trim(firstname)# #trim(surname)# at work">
		<cfset lstSectorID="">
        <cfset lstKeywordID="">
 		<cfset lstJobrole="">
        <cfset lstEthnicityID="">
		<cfloop>
    		<cfset lstSectorID=ListAppend(lstSectorID,SectorCategoryID)>
    		<cfset lstKeywordID=ListAppend(lstKeywordID,keywordID)>
            <cfset lstEthnicityID=ListAppend(lstEthnicityID,ethnicityID)>
            <cfif ListLen(lstJobRole) is 0>
    			<cfset lstJobRole=ListAppend(lstJobrole,catname)>
            </cfif>
		</cfloop>	
         <cfset lstSectorID=ListRemoveDuplicates(lstSectorID)>
         <cfset lstKeywordID=ListRemoveDuplicates(lstKeywordID)>
         <cfset lstEthnicityID=ListRemoveDuplicates(lstEthnicityID)>
         <cfset strResult.arrSector=ListToArray(lstSectorID)>
         <cfset strResult.arrKeyword=ListToArray(lstKeywordID)>
         <cfset strResult.arrEthnicity=ListToArray(lstEthnicityID)>
         <cfif jobroletext is not ''>
   			<cfset jobtitleinuselarge='#jobroletext#'>
	 	 <cfelseif ListFirst(lstJobRole) is not "">
    		<cfset jobtitleinuselarge='#lstJobRole#'>
	 	 <cfelse>
   	 		<cfset jobtitleinuselarge='#jobtitle#'>
	 	 </cfif>
         <cfset strResult.jobTitle='#jobtitleinuselarge#'>
         <cfset ArrayAppend(result,strResult)>
	</cfloop> 


<cfoutput>#serializeJSON(result)#</cfoutput> 
