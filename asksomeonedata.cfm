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
SELECT dbo.Contacts.Firstname, dbo.Contacts.Surname as surname, dbo.AskSomeoneQuestions.questionid, dbo.AskSomeoneQuestions.question, dbo.AskSomeoneQuestions.title, 
dbo.AskSomeoneQuestions.askername, dbo.AskSomeoneQuestions.yearlevelid, dbo.AskSomeoneQuestions.askerschoolregion, 
dbo.AskSomeoneQuestions.dateadded, dbo.AskSomeoneAnswers.answer, dbo.AskSomeoneAnswers.answerid, dbo.Contacts.jobtitle, 
Contacts_1.Surname AS orgname
FROM dbo.AskSomeoneAnswers INNER JOIN
dbo.AskSomeoneQuestions ON dbo.AskSomeoneAnswers.questionid = dbo.AskSomeoneQuestions.questionid INNER JOIN
dbo.Contacts ON dbo.AskSomeoneAnswers.indid = dbo.Contacts.IndID INNER JOIN
dbo.Contacts AS Contacts_1 ON dbo.Contacts.employer = Contacts_1.IndID
WHERE asksomeoneQuestions.questionid=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="8" value="#form.profileid#">
ORDER BY dbo.AskSomeoneAnswers.answerid desc
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