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
SQL REMOVED
</cfquery>


<cfsavecontent variable="theprofile">
	<cfinclude template="/includes/inc_peopleprofiledescription.cfm">
</cfsavecontent>

<cfset strProfileData.desc="#theprofile#">

<cfoutput>#serializejson(strProfileData)#</cfoutput>