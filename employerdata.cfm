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
			SELECT top 1 Emp_Profiles.Name, Emp_Profiles.LargeServerPath, 
            Emp_Profiles.NPIServerPath, Emp_Profiles.EmpProfileID, JnEmployerSector.categoryID,
            Emp_Profiles.Profile
			FROM Emp_Profiles INNER JOIN JnEmployerSector ON Emp_Profiles.EmpProfileID = JnEmployerSector.EmpProfileID
            WHERE Emp_Profiles.EmpProfileID=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="8" value="#form.profileid#">
            AND Emp_Profiles.islive=1
    		ORDER BY categoryID
</cfquery>


<cfset strProfileData.desc="#get_theprofile.profile#">

<cfoutput>#serializejson(strProfileData)#</cfoutput>