<cfparam name="menustyle" default="newnav7">
<cfset pagetitle="Profile Explorer">
<cfinclude template="/includes/header.cfm">	

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css?version=4.1" />



<cfquery name="careerKeywords" datasource="fitSQL">
 	select keywordid,KeywordDesc from CareerKeywords order by KeywordDesc  
</cfquery>

<cfquery name="sectors" datasource="fitSQL">
SQL REMOVED
</cfquery>

<cfquery name="gender" datasource="fitSQL">
SQL REMOVED
</cfquery>

<cfsavecontent variable="keywords">
 <div  id="keyword-wrapper">
<cfoutput query="CareerKeywords">
     <div class="itembutton" >
        <a href="javascript:void(0)" id="k#keywordid#" class="keywords buttonhover" 
        ng-click="selectedItems($event)">#keywordDesc#
        </a>
     </div>
</cfoutput>
 <div class="clearfix">
 </div>
</div>
</cfsavecontent>

<cfsavecontent variable="ethnicity">
 <div id="ethnicity-wrapper">
					                                  
                    <div class="itembutton">
                    	<a href="javascript:void(0)" id="m4" class="ethnicity buttonhover" 
                        ng-click="selectedItems($event)">M&#257;ori
                        </a>
                    </div>                    
                    <div class="itembutton">
                    	<a href="javascript:void(0)" id="mpacifika" class="ethnicity buttonhover" 
                        ng-click="selectedItems($event)">Pasifika
                        </a>
                    </div>
                    <div class="itembutton">
                    	<a href="javascript:void(0)" id="m3" class="ethnicity buttonhover" 
                        ng-click="selectedItems($event)">European
                        </a>
                    </div>                      
                    <div class="itembutton">
                    	<a href="javascript:void(0)" id="m2" class="ethnicity buttonhover" 
                        ng-click="selectedItems($event)">Asian
                        </a>
                    </div>
                    <div class="itembutton">
                    	<a href="javascript:void(0)" id="m8" class="ethnicity buttonhover" 
                        ng-click="selectedItems($event)">Other
                        </a>
                    </div>
                    <div class="clearfix">
                    </div>
                    
  </div>
</cfsavecontent>

<cfsavecontent variable="gender">
<div id="gender-wrapper">
	<cfoutput query="gender">              
      <div class="itembutton">
       <a href="javascript:void(0)" id="g#genderid#" class="gender buttonhover" 
       ng-click="selectedItems($event)">#description#
       </a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>

<cfsavecontent variable="sector">
<div  id="sector-wrapper">
	<cfoutput query="sectors">
		<div class="itembutton">
        <a href="javascript:void(0)" id="s#categoryid#" class="sector buttonhover" 
        ng-click="selectedItems($event)">#catname#</a>
        </div>
    </cfoutput>
	<div class="clearfix">
    </div>
</div>
</cfsavecontent>

<div class="container bg-color padding" id="gallery" ng-app="gallery" ng-controller="galleryController" ><!--content wrapper-->

<h1>Select keywords and categories to explore people's stories</h1>
   <!---  <spinner ng-show="enable"></spinner> --->
<div ng-show="enable" class="spinner"><img src='js/ajax_loader.gif'></div> 
<div class="wrapper" style="display:none;" ng-hide="enable">
	<div ng-hide="show">
	<div class="row"> <!--- row holding counter and reset/clear button --->
        <div class="col-xs-7">
     
        	<display-counter ng-if="itemCount > 0" class="display-counter">
    		</display-counter>
    		<p ng-if="itemCount == 0">
    			<strong>No matching stories &ndash; try removing a selection</strong>
   			</p>
        </div>
		<div class="col-xs-5 resetContainer">
			<input ng-click="resetButtons()" value="Clear all selections" type="button" class="rightAlign">
    	</div>	
     </div>
     <div class="row">
          <div class="actionsDiv col-sm-5 hidden-xs"><!--- Left hand column, holds categories for selection --->  
				<cfoutput>
                <h2>Show me stories about:</h2>
                #keywords# 
                 <h2>Just show me people who are:</h2>
                #gender#                
                <h2>Just show me people who are:</h2>   
                #ethnicity#
                <h2>Show me people who work in:</h2>
                #sector#
				</cfoutput>           
            </div> 
              
		<div class="col-sm-7" ><!--- Right hand column, holds page nav and grid of images --->  
        	<div class="visible-xs" >
                	<div id="right-side">
                    	<div class="row">
                    		<div class="col-sm-12">
                            	<h2>Filter stories by:</h2>
                            </div>
                        </div>
                        <ul>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon1">
                            	<div><img src="icons/Heart.png"></div>
                                <div class="iconText">keyword</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon3">
                            	<div><img src="icons/Gender.png"></div>
                                <div class="iconText">gender</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon2">
                            	<div><img src="icons/Ethnicity.png"></div>
                                <div class="iconText">ethnicity</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon4">
                            	<div><img src="icons/Beehive.png"></div>
                                <div class="iconText">industry</div>
                                </a>                               
                            </li>
                        </ul>

               	  	<div id="menu-icon1" >
				  		<cfoutput>#keywords#</cfoutput>
    					<p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
                  	</div>
               	  	<div id="menu-icon3" >
						<cfoutput>#gender#</cfoutput>    					
                        <p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
  					</div>                  	
                    <div id="menu-icon2">
						<cfoutput>#ethnicity#</cfoutput>                  
    					<p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
  					</div>
               	  	<div id="menu-icon4" >
						<cfoutput>#sector#</cfoutput>
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
			
        	
			<!--Show first page navigation always--> 
            
			<pagination ng-if="itemCount > entryLimit" total-items="totalItems" items-per-page="entryLimit" page="currentPage" 
            			on-select-page="setPage(page)" max-size="maxSize" class="pagination-sm hidden-xs"
                        boundary-links="true" rotate="false" >
            </pagination>
            <!--The actual gallery of profiles matching selections, inc message if no matches--> 
            
            <div id="grid-wrapper" >
               		<div ng-repeat="imagesRow in itemsData | startFrom:(currentPage-1)*entryLimit/rowSize | limitTo:entryLimit/rowSize" class="grid-row row">
						<div ng-repeat="image in imagesRow" class="image-cell col-xs-4">
                           <div class="image-cell-inner">
                            	<img ng-src="{{image.SMITEMURL}}" 
                                	err-src="{{defaultItem}}" 
                                	alt="{{image.TITLE}}" 
                                    title="{{image.TITLE}}" 
                                    class="img-responsive" 
                                    ng-click="openItem(image)" />
                         	</div>
						</div>
					</div>
               </div>
               <!--Show second page navigation only if there is more than one page--> 
               <pagination ng-if="itemCount > entryLimit" total-items="totalItems" items-per-page="entryLimit" page="currentPage" 
               				on-select-page="setPage(page)" max-size="maxSize" class="pagination-sm" 
                            boundary-links="true" rotate="false" >
               </pagination>
               
                
                </div>
          
           
           </div><!--end row-->
           </div><!-- end ng-hide-->
           <div ng-show="show" class="slideshow" ng-swipe-left="nextItem()" ng-swipe-right="prevItem()" >
                
                <div id="imgDiv">
                <input id="prev" type="button" ng-click="prevItem()" value="<" class="hidden-xs"/>
                 <img ng-src="{{currItem.LGITEMURL}}" err-src="{{defaultItem}}" alt="{{currItem.TITLE}}" class="img-responsive" />
                 <input id="close" title="Close" type="button" ng-click="closeItem()" value="Back" />
                 <input id="next" type="button" ng-click="nextItem()" value=">" class="hidden-xs"/>
                </div>
                
                
                
                
			  
            	<h1><span ng-bind-html="currItem.COMPLETENAME"></span>, {{currItem.JOBTITLE}}</h1>
                <h2>{{currItem.ORGANISATION}}</h2>
                <div ng-bind-html="profileDesc"></div>
          
            </div><!-- end ng-show for slideshow-->

        </div><!--end wrapper-->
        </div><!--end gallery-->
	
        <script src="js/src/angular.js?version=2.1"></script>
        <script src="js/src/ngStorage.min.js?version=2.0"></script>
        <script src="js/src/ui-bootstrap-tpls-0.10.0.min.js?version=2.0"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-sanitize.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-touch.js"></script>
<!---         <script type="text/javascript" src="http://fgnass.github.io/spin.js/spin.min.js"></script>
  		<script type="text/javascript" src="js/spinner/angular-spinner.js"></script> --->
        <script src="js/app3.js?version=4.2"></script>

<cfinclude template="/includes/footer.cfm">

</body>
</html>
