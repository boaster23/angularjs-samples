<cfparam name="menustyle" default="newnav7">
<cfset pagetitle="Employer Explorer">
<cfinclude template="/includes/header.cfm">	

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css?version=4.1" />


<cfquery name="sectors" datasource="fitSQL">
 	select catname, categoryid from tblsectors
    where qual=0 and introduction=0 and overview=0 
    and catname <> 'growing + harvesting' and catname <> 'processing + commercialising' and catname <> 'supporting + protecting'
    and catType='profilecategories' order by catname
</cfquery>

<cfquery name="qualities" datasource="fitSQL">
 	select * from EmpQualities order by catname
</cfquery>

<cfquery name="offerings" datasource="fitSQL">
 	select * from EmpOffering order by catname
</cfquery>

<cfquery name="quals" datasource="fitSQL">
 	select * from EmpQualification order by catname
</cfquery>

<cfquery name="size" datasource="fitSQL">
 	select * from EmpSize where size <> 'unknown' order by sizeid
</cfquery>

<cfquery name="location" datasource="fitSQL">
 	select * from EmpLocation where location <> 'unknown' order by locationid
</cfquery>

<cfquery name="type" datasource="fitSQL">
 	select * from EmpSector where sector <> 'unknown' order by sectorid
</cfquery>

<cfsavecontent variable="scsector">
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

<cfsavecontent variable="scquality">
 <div  id="quality-wrapper">
<cfoutput query="qualities">
     <div class="itembutton" >
        <a href="javascript:void(0)" id="q#categoryid#" class="qualities buttonhover" 
        ng-click="selectedItems($event)">#catname#</a>
     </div>
</cfoutput>
 <div class="clearfix">
 </div>
</div>
</cfsavecontent>

<cfsavecontent variable="scoffering">
 <div id="offerings-wrapper">
		<cfoutput query="offerings">	                                  
         <div class="itembutton">
              <a href="javascript:void(0)" id="o#categoryid#" class="offerings buttonhover" 
              ng-click="selectedItems($event)">#catname#
              </a>
         </div>                    
        </cfoutput>   
        <div class="clearfix">
        </div>         
  </div>
</cfsavecontent>

<cfsavecontent variable="scquals">
<div id="quals-wrapper">
	<cfoutput query="quals">          
      <div class="itembutton">
       <a href="javascript:void(0)" id="x#categoryid#" class="quals buttonhover" 
       ng-click="selectedItems($event)">#catname#
       </a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>

<cfsavecontent variable="scsize">
<div id="size-wrapper">
	<cfoutput query="size">          
      <div class="itembutton">
       <a href="javascript:void(0)" id="s#sizeid#" class="size buttonhover" 
       ng-click="selectedItems($event)">#size#
       </a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>

<cfsavecontent variable="sclocation">
<div id="location-wrapper">
	<cfoutput query="location">          
      <div class="itembutton">
       <a href="javascript:void(0)" id="l#locationid#" class="location buttonhover" 
       ng-click="selectedItems($event)">#location#
       </a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>

<cfsavecontent variable="sctype">
<div id="type-wrapper">
	<cfoutput query="type">          
      <div class="itembutton">
       <a href="javascript:void(0)" id="t#sectorid#" class="type buttonhover" 
       ng-click="selectedItems($event)">#sector#
       </a>
      </div>
	</cfoutput>
    <div class="clearfix">
    </div>
</div>
</cfsavecontent>


<div class="container bg-color padding" id="gallery" ng-app="gallery" ng-controller="galleryController" ><!--content wrapper-->

	<h1>Employer profile explorer: where could you work?</h1>
    	<p>Use this page to explore companies and organisations that employ people with skills in technology, engineering and science.
        </p>
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
                <h2>Where the work is about:</h2>
                #scquality#                 
                <h2>Employers that offer:</h2>   
                #scoffering#
                <h2>Employers that look for qualifications in:</h2>
                #scquals#                 
                <h2>Employers in these industries:</h2>
               	#scsector#                 
                <h2>Select by company size:</h2>
                #scsize#
                <h2>Select by company location:</h2>
                #sclocation# 
                <h2>Select by sector:</h2>
                #sctype#  
				</cfoutput>           
            </div> 
              
		<div class="col-sm-7" ><!--- Right hand column, holds page nav and grid of images --->  
        	<div class="visible-xs" >
                	<div id="right-side">
                    	<div class="row">
                    		<div class="col-sm-12">
                            	<h2>Filter employers by:</h2>
                            </div>
                        </div>
                        <ul>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon1">
                            	<div><img src="icons/Focus.png"></div>
                                <div class="iconText">focus</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon2">
                            	<div><img src="icons/Offer.png"></div>
                                <div class="iconText">offering</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon3">
                            	<div><img src="icons/Study.png"></div>
                                <div class="iconText">study area</div>
                                </a>
                            </li>
                        	<li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon4">
                            	<div><img src="icons/Beehive.png"></div>
                                <div class="iconText">industry</div>
                                </a>                               
<!---                            </li>
                             <li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon5">
                            	<div><img src="icons/Beehive.png"></div>
                                <div class="iconText">Size</div>
                                </a>                               
                            </li>
                            <li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon6">
                            	<div><img src="icons/Beehive.png"></div>
                                <div class="iconText">Location</div>
                                </a>                               
                            </li>
                            <li class="col-sm-3 col-xs-3 icon">
                            	<a href="#menu-icon7">
                            	<div><img src="icons/Beehive.png"></div>
                                <div class="iconText">Sector</div>
                                </a>                               
                            </li>--->
                        </ul>

               	  	<div id="menu-icon1" >
						<cfoutput>#scquality#</cfoutput>    					
    					<p align="right">
                        	<a href="#" class="ui-closable-tab"><span class='ui-icon ui-icon-circle-close'></span> close</a>
                        </p>
                  	</div>
               	  	<div id="menu-icon2" >
						<cfoutput>#scoffering#</cfoutput>       
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
				  		<cfoutput>#scsector#</cfoutput>
                        <br>
						<cfoutput>#scsize#</cfoutput>
                        <br>
						<cfoutput>#sclocation#</cfoutput>
                        <br>
						<cfoutput>#sctype#</cfoutput>
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
                        boundary-links="true" rotate="false">
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
                            boundary-links="true" rotate="false">
               </pagination>
               
                
                </div>
          
           
           </div><!--end row-->
           </div><!-- end ng-hide-->
           <div ng-show="show" class="slideshow" ng-swipe-left="nextItem()" ng-swipe-right="prevItem()">
                
                <div id="imgDiv">
               
                <input id="prev" type="button" ng-click="prevItem()" value="<" class="hidden-xs"/>
                 <img ng-src="{{currItem.LGITEMURL}}" err-src="{{defaultItem}}" alt="{{currItem.TITLE}}" class="img-responsive" />
                 <input id="close" title="Close" type="button" ng-click="closeItem()" value="Back" />
                 <input id="next" type="button" ng-click="nextItem()" value=">" class="hidden-xs"/>
                </div>
			   <!--<p>{{currItem.PROFILEID}}</p> -->
            	<h1><span ng-bind-html="currItem.ORGANISATION"></span></h1> 
                <div ng-bind-html="profileDesc"></div>
          
            </div><!-- end ng-show for slideshow-->

        </div><!--end wrapper-->
        </div><!--end gallery-->
	
        <script src="js/src/angular.js?version=2.3"></script>
        <script src="js/src/ngStorage.min.js?version=2.2"></script>
        <script src="js/src/ui-bootstrap-tpls-0.10.0.min.js?version=2.2"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-sanitize.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.2/angular-touch.js"></script>
        <script src="js/app3.js?version=3.9"></script>

<cfinclude template="/includes/footer.cfm">

</body>
</html>
