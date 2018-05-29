

<cfquery name="get_all" datasource="fitSQL" >
SQL REMOVED
</cfquery>

<cfset result=ArrayNew(1)>

<cfloop query="get_all" group="EmpProfileID">
    	<Cfset strResult=StructNew()> 
		<cfset strResult.arrSector=ArrayNew(1)>
        <cfset strResult.arrQualities=ArrayNew(1)>
        <cfset strResult.arrOfferings=ArrayNew(1)>
        <cfset strResult.arrQualifications=ArrayNew(1)>
        <cfset strResult.organisation='#name#'>
        <cfset strResult.profileid='#EmpProfileID#'>
  		<cfset strResult.sizeid="#sizeid#">
        <cfset strResult.locationid="#locationid#">
        <cfset strResult.sectorid="#sectorid#">
        <cfset strResult.isPDP="#isPDP#">
        <cfset strResult.profileUrl="/#EmpProfileID#/employers/#EmpProfileID#/#trim(name)#">
        <cfset strResult.smItemUrl="/profiles/#urlencodedformat(NPIserverPath)#">
        <cfset strResult.lgItemUrl="/profiles/#urlencodedformat(LargeServerPath)#">
        <cfset strResult.title="#trim(name)#">
		<cfset lstSectorID="">
        <cfset lstQualityID="">
 		<cfset lstOfferingsID="">
        <cfset lstQualificationsID="">
		<cfloop>
    		<cfset lstSectorID=ListAppend(lstSectorID,SectorCategoryID)>
    		<cfset lstQualityID=ListAppend(lstQualityID,QualityCategoryID)>
            <cfset lstOfferingsID=ListAppend(lstOfferingsID,OffCategoryID)>
            <cfset lstQualificationsID=ListAppend(lstQualificationsID,QualsCategoryID)>
		</cfloop>	
         <cfset lstSectorID=ListRemoveDuplicates(lstSectorID)>
         <cfset lstQualityID=ListRemoveDuplicates(lstQualityID)>
         <cfset lstOfferingsID=ListRemoveDuplicates(lstOfferingsID)>
         <cfset lstQualificationsID=ListRemoveDuplicates(lstQualificationsID)>
         <cfset strResult.arrSector=ListToArray(lstSectorID)>
         <cfset strResult.arrQualities=ListToArray(lstQualityID)>
         <cfset strResult.arrOfferings=ListToArray(lstOfferingsID)>
         <cfset strResult.arrQualifications=ListToArray(lstQualificationsID)>
         <cfset ArrayAppend(result,strResult)>
</cfloop> 

<cfoutput>#serializeJSON(result)#</cfoutput> 
