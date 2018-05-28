<!--- FORM SECURITY --->
<cfif NOT isdefined( "FORM.formSecurity" ) OR ( FORM.formSecurity IS NOT Hash( DateFormat( now(), 'dd/mm/yyyy' ) & "1bfgty" ) )>
	<p>There has been a problem and your order was not submitted. Please email <a href="mailto:beau.broadhead@engineeringnz.org?subject=Ask Someone question not submitted ">beau.broadhead@engineeringnz.org</a></p>
    <cfabort>
</cfif>


<cfparam name="m" default="5">
<cfset pagetitle="Your question has been submitted to the Futureintech Ask Someone forum">
<cfinclude template="/includes/header.cfm">	
	

<cfparam name="searchID" default="0">
<cfparam name="form.question" default="">
<cfparam name="form.askername" default="">
<cfparam name="form.yearlevelid" default="">
<cfparam name="form.askerschoolregion" default="">
<cfparam name="form.askeremail" default="">

<div class="container bg-color padding"><!--content wrapper-->

	
	  <table width="100%" border="0" cellspacing="0" cellpadding="6">
        <tr>
          <td height="32" valign="top">

<h1> Your 'Ask Someone' question has been submitted </h1>

    <cftransaction>
        <cfquery datasource="fitSQL">
            insert into AskSomeOneQuestions
            (question, askername, yearlevelid, askerschoolregion, askeremail) 
            values 
            (<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.question#">,
             <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.askername#">,
             <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.yearlevelid#">,
             <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.askerschoolregion#">,
             <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.askeremail#">
              )
        </cfquery>
        
        <cfquery name="get_max" datasource="fitSQL">
            select max(questionid) as latest from AskSomeoneQuestions
        </cfquery>
    </cftransaction>
 
 	<cfquery name="get_year" datasource="fitSQL">
		select catname from AskQYearLevel 
    	where yearlevelid=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.yearlevelid#">
	</cfquery>

    <cfmail to="writer.researcher@futureintech.org.nz"
        from="enquiries@futureintech.org.nz"
        subject="'Ask Someone' question submission"
        type="HTML">	
     <p><strong>Question:</strong> #form.question#</p>
     <hr />
     <p><strong>Submitter's name:</strong> #form.askerName#</p>
     <p><strong>Submitter's year level:</strong> #form.yearlevelid#</p>
     <p><strong>Submitter's school or region:</strong> #form.askerSchoolregion#</p>
     <p><strong>Submitter's email address:</strong> #form.askeremail#</p>
     <hr />
     
    </cfmail>

 
 
    <cfmail to="#trim(form.askeremail)#"
        from="writer.researcher@futureintech.org.nz"
        subject="Thank you for your 'Ask Someone' question"
        type="HTML">
        <h1>Your question has been submitted </h1>	
            <p>Thank you for submitting a question to Futureintech's 'Ask Someone' question and answer forum. </p>
        <h2>What happens next? </h2>
            <p>Futureintech writer <a href="mailto:writer.researcher@futureintech.org.nz">Megan Rodden</a> will send your question to people who can provide answers based on their own experience of working in a relevant technology, engineering or science-based industry. If your question is about study options, Megan will forward it to people who have followed a similar qualification pathway. The answers they provide will be posted on the 'Ask Someone' page, and you'll be notified by email.
            </p>
    </cfmail>


		<p>Thank you for submitting a question to our 'Ask Someone' question and answer forum. </p>
	<h2>What happens next? </h2>
		<p>Futureintech writer <a href="mailto:writer.researcher@futureintech.org.nz">Megan Rodden</a> will send your question to people who can provide answers based on their own experience of working in a relevant technology, engineering or science-based industry. If your question is about  study options, Megan will forward it to people who have followed a similar qualification pathway. The answers they provide will be posted on the 'Ask Someone' page, and you'll be notified by email.<br />
  <br />
</p>
 
	<div style="margin-top:10px; margin-bottom:10px; padding:10px; border:1px solid black;">
		<cfoutput >
            <p><font size="3"><strong>Your question</strong></font></p>
            <p><strong>Question:</strong> #form.question#</p>
            <hr />
        
            <p><strong>Your name:</strong> #form.askerName#</p>
            <p><strong>Your year level:</strong> #get_year.catname#</p>
            <p><strong>Your school or region:</strong> #form.askerSchoolregion#</p>
            <p><strong>Your email address:</strong> #form.askeremail#</p>
            <hr />
        </cfoutput>
	</div>
	
    <br />

<p><a href="questions.cfm">&lt;&lt; Back to main Q+A page</a></p>
	

<!---end--->

</td>
        </tr>
      </table>
</div>
	<cfinclude template="/includes/footer.cfm">

</body>
</html>
