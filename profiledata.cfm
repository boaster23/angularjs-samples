 <cfscript>
    try {
        requestBody = toString( getHttpRequestData().content );
        if ( len( requestBody ) ) {
            structAppend( form, deserializeJson( requestBody ) );
        }
    } catch ( any error ) {
    }
</cfscript> 

<!--- <cfdump var="#form#">
<cfabort> --->

<cfset strProfileData=StructNew()>

<cfquery name="get_theprofile" datasource="fitSQL">
		SELECT Contacts.Firstname, Contacts.Surname, Contacts.jobtitle,
        profiles.*, ProfileVersion.*
		FROM (profiles INNER JOIN Contacts ON profiles.IndID = Contacts.IndID) 
        LEFT JOIN ProfileVersion ON profiles.ProfileID = ProfileVersion.profileID
        WHERE Profiles.ProfileID=
        <cfqueryparam cfsqltype="cf_sql_integer" maxlength="8" value="#form.profileid#">
        AND ProfileVersion.editedVersion=1
</cfquery>


<cfsavecontent variable="theprofile">
	<cfinclude template="/includes/inc_peopleprofiledescription.cfm">
</cfsavecontent>

<cfset strProfileData.desc="#theprofile#">

<cfoutput>#serializejson(strProfileData)#</cfoutput>