

<cfquery name="get_all" datasource="fitSQL" >
SELECT dbo.EmpJnOffering.categoryID AS OffCategoryID, dbo.EmpJnQualifications.categoryID AS QualsCategoryID, dbo.EmpJnQualities.categoryID AS QualityCategoryID, dbo.JnEmployerSector.categoryID AS SectorCategoryID, dbo.Emp_Profiles.EmpProfileID, dbo.Emp_Profiles.isPDP, dbo.Emp_Profiles.LocationID, dbo.Emp_Profiles.SizeID, dbo.Emp_Profiles.SectorID, dbo.Emp_Profiles.Name, dbo.Emp_Profiles.NPIServerPath, dbo.Emp_Profiles.LargeServerPath
FROM dbo.JnEmployerSector RIGHT OUTER JOIN
dbo.Emp_Profiles ON dbo.JnEmployerSector.EmpProfileID = dbo.Emp_Profiles.EmpProfileID LEFT OUTER JOIN
dbo.EmpJnOffering ON dbo.Emp_Profiles.EmpProfileID = dbo.EmpJnOffering.EmpProfileID LEFT OUTER JOIN
dbo.EmpJnQualifications ON dbo.Emp_Profiles.EmpProfileID = dbo.EmpJnQualifications.EmpProfileID LEFT OUTER JOIN
dbo.EmpJnQualities ON dbo.Emp_Profiles.EmpProfileID = dbo.EmpJnQualities.EmpProfileID
WHERE isLive=1
ORDER BY dbo.Emp_Profiles.EmpProfileID DESC
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
