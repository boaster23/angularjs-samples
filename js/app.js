var app = angular.module("gallery", ['ui.bootstrap', 'ngStorage', 'ngSanitize','ngTouch']);


app.directive('errSrc', function() {
    return {
        link: function(scope, element, attrs) {
            element.bind('error', function() {
                if (attrs.src != attrs.errSrc) {
                    attrs.$set('src', attrs.errSrc);
                }
            });
        }
    }
});

app.directive("displayCounter", function() {
    return {
        template : 
		"<p>Displaying <strong>{{currentPage*entryLimit-(entryLimit-1)}}</strong> to <strong>{{lastItemCount}}</strong> of <span id='itemCount'>{{itemCount}}</span> items</p>"	
    	}
});

app.controller("galleryController", function($scope, $http, $interval, $localStorage, $location, $timeout) {
    console.log("galleryController start");
	
	
    var itemsJson = "";
	var profileUrl='';
    $scope.rowSize = 3; // number of items in a row
    $scope.entryLimit = 21; // max number of items to display in a page
    $scope.currentPage = 1;
    $scope.maxSize = 3; // max number of pagination items
	$scope.lastItemCount=0;
	$scope.itemCount = 0;
    $scope.defaultItem = "//www.futureintech.org.nz/profiles/Harrison%20Grierson%20-%20image%20online.jpg";
	$scope.profileDesc='';
	$scope.enable=true;
    var listItem = []; // all images from server
    var searchedItem = [];
    var start = true;
    var timer;
    var storage = $localStorage;
	var objPass={};		
	var arrPass=[];  //array of selected buttons
	var pacifika=[5,6,7];
	var mode='';
	var contentWrapper='wrapper';
	
	
	if($location.absUrl().indexOf('employers.cfm') > 0) {
		mode='employer';
		itemsJson = "getemployerlist.cfm";
		profileUrl = "employerdata.cfm";
	}
	else if($location.absUrl().indexOf('questions.cfm') > 0) {
		mode='asksomeone';
		itemsJson = "asksomeonelist.cfm";
		profileUrl = "asksomeonedata.cfm";
		$scope.rowSize = 1;
		$scope.entryLimit = 12;
	}
	else {
		mode='people';
		itemsJson = "getimagelist.cfm";
		profileUrl = "profiledata.cfm";
	}
	
	//retrieve all items and place in listItem variable
	$http({
			url:itemsJson,
			method: "GET"
				}).success(function(data, status, headers, config) {
								$timeout(function () {
    								$scope.enable=false;
									angular.element('.'+contentWrapper).css('display', 'block');
								},1500);
								initPagination(data);
								listItem=data;
								searchedItem=data;
								$scope.itemCount=listItem.length;
								$scope.setPage(1);
								
               	   	  }).error(function(data, status, headers, config) {
               	    	     $scope.status = data;
							 return data;
        });
		

	//filtering the ask someone pages
	function filterAskSomeOne() {
	  for(var x in arrPass) 
		{
			if(!isNaN(arrPass[x].id)) {
				arrPass[x].id=parseInt(arrPass[x].id);
			}
			if(arrPass[x].class == 'subjects') {
             		searchedItem=searchedItem.filter(function (el) {
              		return (el.ARRSUBJECTS.indexOf(arrPass[x].id) >= 0);
            	 });
         	} else if(arrPass[x].class == 'quals') {
             		searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRQUALS.indexOf(arrPass[x].id) >= 0);
             	});
			} else if (arrPass[x].class == 'jobroles') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRJOBROLES.indexOf(arrPass[x].id) >= 0);
             	});
         	} else if (arrPass[x].class == 'general') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRGENERAL.indexOf(arrPass[x].id) >= 0);
             	});
			}
		}
	}
	
		
	
	//filtering the employer profile pages
	function filterEmployers() {
	  for(var x in arrPass) 
		{
			if(!isNaN(arrPass[x].id)) {
				arrPass[x].id=parseInt(arrPass[x].id);
			}
			if(arrPass[x].class == 'sector') {
             		searchedItem=searchedItem.filter(function (el) {
              		return (el.ARRSECTOR.indexOf(arrPass[x].id) >= 0);
            	 });
         	} else if(arrPass[x].class == 'qualities') {
             		searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRQUALITIES.indexOf(arrPass[x].id) >= 0);
             	});
			} else if (arrPass[x].class == 'offerings') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.ARROFFERINGS.indexOf(arrPass[x].id) >= 0);
             	});
         	} else if (arrPass[x].class == 'quals') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRQUALIFICATIONS.indexOf(arrPass[x].id) >= 0);
             	});
         	} else if (arrPass[x].class == 'size') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.SIZEID == arrPass[x].id);
             	});
         	} else if (arrPass[x].class == 'location') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.LOCATIONID == arrPass[x].id);
             	});
         	} else if (arrPass[x].class == 'type') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.SECTORID == arrPass[x].id);
             	});
         	}
		}
	}
	
	//filtering the people profile pages
	function filterPeople() {
		for(var x in arrPass) 
		{
			if(!isNaN(arrPass[x].id)) {
				arrPass[x].id=parseInt(arrPass[x].id);
			}
			if(arrPass[x].class == 'keywords') {
             		searchedItem=searchedItem.filter(function (el) {
              		return (el.ARRKEYWORD.indexOf(arrPass[x].id) >= 0);
            	 });
         	} else if(arrPass[x].class == 'sector') {
             		searchedItem=searchedItem.filter(function (el) {
               		return (el.ARRSECTOR.indexOf(arrPass[x].id) >= 0);
             	});
			} else if (arrPass[x].class == 'gender') {
				searchedItem=searchedItem.filter(function (el) {
               		return (el.GENDERID == arrPass[x].id);
             	});
         	} else if(arrPass[x].class == 'ethnicity') {
             		searchedItem=searchedItem.filter(function (el) {
					if(arrPass[x].id == 'pacifika'){
						return ((el.ARRETHNICITY.indexOf(pacifika[0]) >= 0)
						|| (el.ARRETHNICITY.indexOf(pacifika[1]) >= 0)
						|| (el.ARRETHNICITY.indexOf(pacifika[2]) >= 0)
						);
					} else {
               			return (el.ARRETHNICITY.indexOf(arrPass[x].id) >= 0);
					}
             	});
		    }
		}
	}
	
	//runs when user clicks left hand button options for profiles or questions
   	$scope.selectedItems=function(evt) {
		var element=angular.element(evt.target);
		var slClass=element.attr("class").split(' ')[0];
		var idOnly = element.attr("id").toString().substr(1);
		
		if(element.closest("div.itembutton").hasClass("selected")){
				element.closest("div.itembutton").removeClass("selected");
				element.removeClass("buttonhover");
					arrPass=arrPass.filter(function (el) {
              			return (!(el.id == idOnly && el.class == slClass));
            	 	});	
		} else {
				objPass={class:slClass,id:idOnly};
				if(slClass != 'keywords'){
					arrPass=arrPass.filter(function (el) {
              			return (el.class != slClass);
            	 	});	
					$("."+slClass).parent("div.itembutton").removeClass("selected");
				}
				arrPass.push(objPass);
				element.closest("div.itembutton").addClass("selected");
		}
		
		searchedItem=listItem;
		
		if(mode == 'employer')
			filterEmployers();
		else if(mode == 'asksomeone')
			filterAskSomeOne();
		else
			filterPeople();
		
		$scope.itemCount=searchedItem.length;
		
		initPagination(searchedItem);
		$scope.setPage(1);
		//console.log(searchedItem);
	}		
   

	//set the current page
    $scope.setPage = function (pageNumber) {
        $scope.currentPage = pageNumber;
		setLastItemCount();
    };
	
	//assigns appropriate value for lastItemCount var used in display counter
	function setLastItemCount() {
		if(($scope.currentPage*$scope.entryLimit) > $scope.itemCount)
			$scope.lastItemCount=$scope.itemCount;
		else
			$scope.lastItemCount=$scope.currentPage*$scope.entryLimit;	
	}
	
	//reset gallery to initial state
	$scope.resetButtons=function() {
		$(".selected").removeClass("selected");
		searchedItem=listItem;
		objPass={};
		arrPass=[];
		$scope.itemCount=searchedItem.length;
		initPagination(searchedItem);
		$scope.setPage(1);
	}

	//name search if needed later
    $scope.search = function(searchStr) {
        var searchText = searchStr.toLowerCase();
        searchedItem = listItem.filter(
            function isFiltered(element) {
                return (element.title.toLowerCase().indexOf(searchText) !== -1 || element.date.toLowerCase().indexOf(searchText) !== -1);
            }
        );
        initPagination(searchedItem);
    };
	
	//slideshow functions
	function getProfileDesc(profileid) {
		
		$http({
			url: profileUrl,
			method: "POST",
			data: {profileid:profileid}
				}).success(function(data, status, headers, config) {
								$scope.profileDesc = data.DESC;
               	   	  }).error(function(data, status, headers, config) {
               	    	     $scope.status = data;
							 return data;
            });
	}
	
	
	$scope.openItem = function(itm) {
        $scope.show = true;
        $scope.currItem = itm||searchedItem[0];
		getProfileDesc($scope.currItem.PROFILEID);
    };

    $scope.closeItem = function() {
        $scope.show = false;
        if(start === false && angular.isDefined(timer)) {
            $interval.cancel(timer);
            timer = undefined;
        }
    };
	
	$scope.nextItem = function() {
        var index = searchedItem.indexOf($scope.currItem);
        $scope.currItem = searchedItem[++index % searchedItem.length];
		getProfileDesc($scope.currItem.PROFILEID);
    };

    $scope.prevItem = function() {
        var index = searchedItem.indexOf($scope.currItem);
        index = (index > 0)? --index : searchedItem.length - 1;
        $scope.currItem = searchedItem[index];
		getProfileDesc($scope.currItem.PROFILEID);
    };

   

	//intialise gallery and pagination
    function initPagination (data) {
        $scope.totalItems = data.length;
        var rowsCount = Math.ceil(data.length / $scope.rowSize);
        var index;
        $scope.itemsData = [];
        for (var i = 0; i < rowsCount; i++) {
            $scope.itemsData[i] = new Array();
            for (var j = 0; j < $scope.rowSize; j++) {
                index = $scope.rowSize * i + j;
                if (data[index])
                $scope.itemsData[i][j] = data[index];
            }
        }
    };


		
    console.log("galleryController end!");
});

app.filter('startFrom', function() {
    return function(input, start) {
        if(input) {
            start = +start; //parse to int
            return input.slice(start);
        }
        return [];
    }
});