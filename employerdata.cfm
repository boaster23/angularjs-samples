 <cfscript>
    try {
        requestBody = toString( getHttpRequestData().content );
        if ( len( requestBody ) ) {
            structAppend( form, deserializeJson( requestBody ) );
        }
    } catch ( any error ) {
    }
</cfscript> 
 <!------>

<cfset strProfileData=StructNew()>

<cfquery name="get_theprofile" datasource="fitSQL">
SQL REMOVED
</cfquery>


<cfset strProfileData.desc="#get_theprofile.profile#">

<cfoutput>#serializejson(strProfileData)#</cfoutput>