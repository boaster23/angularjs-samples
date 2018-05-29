
<cfparam name="m" default="5">
<cfset pagetitle="Submit a question to Futureintech's panel of experts">
<cfinclude template="/includes/header.cfm">	

<link rel="stylesheet" href="css/styles.css?version=4.3" />

<script type="text/javascript">
	<!--
	
		function submitit()
			{
				document.survey.action="submit-question2.cfm";
			}
	
	
	//-->
</script>

<script type="text/javascript" src="//www.ipenz.org.nz/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
		window.onload = function()
		{
		CKEDITOR.replace( 'question',
  	  {
        toolbar : 'Publicwis',
		width: '100%',
		height:200,
        uiColor : '#9AB8F3'

   	 });
		};
</script>

<cfquery name="get_year" datasource="fitSQL">
	SQL REMOVED
</cfquery>

<div class="container bg-color padding"><!--content wrapper-->

			<h1>New Zealand students: Submit your question</h1><br />
				<p>This forum is aimed at helping <strong>New Zealand school students</strong> to make decisions about tertiary study and careers. Our panel of engineers, food technologists, surveyors, IT professionals and scientists can only answer questions about New Zealand-based school subjects, qualifications, jobs and industries.
                </p>
				<p>Questions from outside New Zealand and/or questions relating to immigration will <strong>not</strong> be answered. Try New Zealand Immigration's <a href="https://www.newzealandnow.govt.nz/studying-in-nz" target="_blank">Study in New Zealand</a> page instead.
                </p>

	<cfform name="survey" method="post" action="about:blank" onSubmit="submitit()">
        <p><strong>*Your question:</strong><br>
        <textarea name="question" cols="80" rows="10"></textarea> 
        </p>
        <p><strong>*Your name:</strong> (will not be published online)<br>
        <cfinput name="askername" type="text" size="60" required="yes" message="Please enter your name">
        </p>
        <p><strong>Your year level:</strong> (e.g. Year 12)<br>
        <select name="yearlevelid">
        	<cfoutput query="get_year">
				<option value="#yearlevelid#">#catname#</option>
			</cfoutput>
        </select>
       
        </p>
        <p><strong>Your school and/or region:</strong><br>
        <input name="askerschoolregion" type="text" size="60">
        </p>
        <p><strong>*Your email address: </strong>(will not be published online - but we do need it to send you the answers!)<br>
        <cfinput name="askeremail" type="text" required="yes" size="60%" message="Please enter your email addresss">
        </p>
        
        <input type="hidden" name="formSecurity" 
        value="<cfoutput>#Hash( DateFormat( now(), 'dd/mm/yyyy' ) & '1bfgty' )#</cfoutput>"/>
        
         <p>
         <input name="submit" type="submit" value="Submit your question&nbsp;&gt;&gt;" class="btn btn-primary">
         </p>
         
         <p>*Fields marked with an asterisk are required in order for your question to be submitted.
         </p>
 <noscript>
       <br />
 
<font color="#FF0000">*WARNING Javascript is not enabled in your browser. This form will not be submitted until you enable Javascript. Email <a href="mailto:beau.broadhead@engineeringnz.org">beau.broadhead@engineeringnz.org</a> if you have difficulties. </font>
		                              </noscript>
</p>
                       
</cfform>

</div>
	<cfinclude template="/includes/footer.cfm">

</body>
</html>
