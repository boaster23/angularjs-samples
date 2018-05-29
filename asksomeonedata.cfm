 <cfscript>
    try {
        requestBody = toString( getHttpRequestData().content );
        if ( len( requestBody ) ) {
            structAppend( form, deserializeJson( requestBody ) );
        }
    } catch ( any error ) {
    }
</cfscript> 
<!---
<cfdump var="#form#">
<cfabort> --->


<cfset strProfileData=StructNew()>

<cfquery name="get_theprofile" datasource="fitSQL">
SQL REMOVED
</cfquery>


<cfsavecontent variable="theprofile">
	<cfoutput query="get_theprofile" group="questionid">
        <cfoutput>
            <h2>Answer from #firstname#, #jobtitle#</h2>
    		<p>#answer#</p>
            <hr />
        </cfoutput>
    </cfoutput>
</cfsavecontent>

<cfset strProfileData.desc="#theprofile#">

<cfoutput>#serializejson(strProfileData)#</cfoutput>