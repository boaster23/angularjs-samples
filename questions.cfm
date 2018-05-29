<cfparam name="menustyle" default="newnav7">
<cfset pagetitle="Q+A Explorer">
<cfinclude template="/includes/header.cfm">	

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css?version=4.3" />


<cfquery name="subjects" datasource="fitSQL">
SQL REMOVED
</cfquery>

<cfquery name="quals" datasource="fitSQL">
SQL REMOVED
</cfquery>

<cfquery name="jobroles" datasource="fitSQL">
SQL REMOVED
</cfquery>

<cfquery name="general" datasource="fitSQL">
SQL REMOVED
</cfquery>


<cfsavecontent variable="scsubject">
<div  id="offerings-wrapper">
	<cfoutput query="subjects">
		<div class="itembutton">
        <a href="javascript:void(0)" id="s#categoryid#" class="subjects buttonhover" 
        ng-click="selectedItems($event)">#catname#</a>
        </div>
    </cfoutput>
	<div class="clearfix">
    </div>
</div>
</cfsavecontent>

<cfsavecontent variable="scquals">
 <div  id="quals-wrapper">
<cfoutput query="quals">
     <div class="itembutton" >
        <a href="javascript:void(0)" id="q#categoryid#" class="quals buttonhover" 
        ng-click="selectedItems($event)">#catname#</a>
     </div>
</cfoutput>
 <div class="clearfix">
 </div>
</div>
</cfsavecontent>

<cfsavecontent variable="scjobroles">
 <div id="sector-wrapper">
		<cfoutput query="jobroles">	                                  
         <div class="itembutton">
              <a href="javascript:void(0)" id="o#categoryid#" class="jobroles buttonhover" 
              ng-click="selectedItems($event)">#catname#</a>
         </div>                    
        </cfoutput>   
        <div class="clearfix">
        </div>         
  </div>
</cfsavecontent>

<cfsavecontent variable="scgeneral">
<div id="general-wrapper">
	<cfoutput query="general">          
      <div class="itembutton">
       <a href="javascript:void(0)" id="x#categoryid#" class="general buttonhover" 
       ng-click="selectedItems($event)">#catname#</a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>



<div class="container bg-color padding" id="gallery" ng-app="gallery" ng-controller="galleryController" ><!--content wrapper-->
	<div ng-hide="show">
		<h1>Questions + answers</h1>
    	
        <div class="col-sm-9 col-md-9 col-lg-9" style="padding:0px;">
            <p>Do you have a question about what to study or what it would be like to work in a technology, engineering or science-related career? If you're a New Zealand school student, you can submit your question and we'll ask our panel of experts &ndash; engineers, food technologists, surveyors, software developers, scientists and more &ndash; for answers.
            </p>
		</div>
        
        <div class="col-sm-3 col-md-3 col-lg-3">
        	<a href="https://www.futureintech.org.nz/explorer/submit-question.cfm" class="btn btn-primary text-right">Ask your question&nbsp;&gt;&gt;</a> 
        </div>       

		<div style="clear:both">
        	<h1>Use keywords and categories to explore already answered questions</h1>  
        </div>

     </div>

<div ng-show="enable" class="spinner"><img src='/explorer/js/ajax_loader.gif'>
</div>       

<div class="wrapper" style="display:none;" ng-hide="enable">
	<div ng-hide="show">
 
     <div class="row">
          <div class="actionsDiv col-sm-5 hidden-xs"><!--- Left hand column, holds categories for selection --->  
				<cfoutput>
                <h2>Sort by:</h2> 
                #scgeneral#                                         
                <h2>School subjects:</h2>
                #scsubject#                 
                <h2>Tertiary qualifications:</h2>   
                #scquals#
                <h2>Job roles:</h2>
                #scjobroles#                 
                
				</cfoutput>           
            </div> 
              
		<div class="col-sm-7" ><!--- Right hand column, holds page nav and grid of images, also all the mobile (xs) stuff --->  
        	<div class="visible-xs" >
                	<div id="right-side">
                    	<div class="row">
                    		<div class="col-sm-12">
                            	<h2>Filter questions by:</h2>
                            </div>
                        </div>
                        <ul>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon1">
                            	<div><img src="icons/Focus.png"></div>
                                <div class="iconText">General</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon2">
                            	<div><img src="icons/Calculator.png"></div>
                                <div class="iconText">Subjects</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon3">
                            	<div><img src="icons/Study.png"></div>
                                <div class="iconText">Tertiary</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon4">
                            	<div><img src="icons/Briefcase.png"></div>
                                <div class="iconText">Jobs</div>
                                </a>                               
                        </ul>

               	  	<div id="menu-icon1" >
						<cfoutput>#scgeneral#</cfoutput>    					
    					<p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
                  	</div>
               	  	<div id="menu-icon2" >
						<cfoutput>#scsubject#</cfoutput>       
                        <p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
  					</div>                  	
                    <div id="menu-icon3">
						<cfoutput>#scquals#</cfoutput>           
    					<p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
  					</div>
               	  	<div id="menu-icon4">
				  		<cfoutput>#scjobroles#</cfoutput>
                        <p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
  					</div> 
                </div>

            </div>
              <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
              <script language="javascript" type="text/javascript">
							$(document).ready(function() {
									$("#right-side").tabs({
  										collapsible: true,
										active: false,
										show: { effect: "blind", duration: 400 }
									});
								
									$(".ui-closable-tab").on( "click", function() {
        								$(this).closest("div.ui-tabs-panel").hide("slow");
									});

							});
                </script>

            <div class="row">
                <div class="col-sm-8">
                    <display-counter ng-if="itemCount > 0" class="display-counter">
                    </display-counter>
                    <p ng-if="itemCount == 0">
                        <strong>No matching stories &ndash; try removing a selection</strong>
                    </p>
                </div>
                <div class="resetContainer col-sm-4">
                    <input ng-click="resetButtons()" value="Clear all filters" type="button">
                </div> 
            </div>

          
			<!--Show first page navigation always--> 
             <pagination ng-if="itemCount > entryLimit" total-items="totalItems" items-per-page="entryLimit" page="currentPage" 
            		on-select-page="setPage(page)" max-size="maxSize" class="pagination-sm"
                    boundary-links="true" rotate="false">
            </pagination>
           

            <!--The actual gallery of profiles matching selections, inc message if no matches--> 
            <div id="question-wrapper">
               		<div ng-repeat="itemsRow in itemsData | startFrom:(currentPage-1)*entryLimit/rowSize | limitTo:entryLimit/rowSize" >
						<div ng-repeat="item in itemsRow" >
                           <a href ng-click="openItem(item)">
                           		<div  class="question-block">
                           			<strong>
                                    <div class="question-number">{{item.CURRENTROW}}</div> <span ng-bind-html="item.TITLE"></span></strong>
                                    <div class="question-more">
                                    	>>
                                    </div>
                         		</div>
                            </a>
						</div>
					</div>               
               </div>

                <!--Show second page navigation only if there is more than one page--> 
               	<pagination ng-if="itemCount > entryLimit" total-items="totalItems" items-per-page="entryLimit" page="currentPage" 
               			on-select-page="setPage(page)" max-size="maxSize" class="pagination-sm" 
                        boundary-links="true" rotate="false">
               	</pagination>
                
                </div>
           
           </div><!--end row-->
           </div><!-- end ng-hide-->
           <div ng-show="show" class="slideshow" ng-swipe-left="nextItem()" ng-swipe-right="prevItem()" >
   
                <div class="question-detail-block"> 
                	<h1>Question {{currItem.CURRENTROW}}: <span ng-bind-html="currItem.TITLE"></span></h1>
        			<p ng-bind-html="currItem.QUESTION" style="font-size:1.05em;"></p>
                	<p><em>
                    	- 	
                        <span ng-bind-html="currItem.YEARLEVELCATNAME"></span>
                        <span ng-if="currItem.YEARLEVELCATNAME != 'Career Changer'">student </span>
                		<span ng-if="currItem.ASKERSCHOOLREGION != 'Unknown'">from <span ng-bind-html="currItem.ASKERSCHOOLREGION"></span>
                    	</span>
                        (<span ng-bind-html="currItem.DATEADDED"></span>)
                   	</em>
                	</p>
                <p class="question-detail-close">
                <button type="button" class="btn btn-primary" ng-click="closeItem()" >X</button>
                </p>
                	<p  class="hidden-xs question-detail-next">
                	<button type="button" class="btn btn-primary" ng-click="nextItem()">&lt;&nbsp;</button>
                	</p>
                	<p style="" class="hidden-xs question-detail-previous">
                	<button type="button" class="btn btn-primary" ng-click="prevItem()" >&nbsp;&gt;</button>
                	</p>
                </div>
        		
                <p ng-bind-html="profileDesc" class="question-detail-answer"></p>

                                
          
            </div><!-- end ng-show for slideshow-->

        </div><!--end wrapper-->
        </div><!--end gallery-->
	
        <script src="js/src/angular.js?version=2.3"></script>
        <script src="js/src/ngStorage.min.js?version=2.2"></script>
        <script src="js/src/ui-bootstrap-tpls-0.10.0.min.js?version=2.2"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-sanitize.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-touch.js"></script>
        <script src="js/app3.js?version=4.1"></script>

<cfinclude template="/includes/footer.cfm">

</body>
</html>
