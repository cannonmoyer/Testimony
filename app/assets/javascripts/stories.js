$(document).ready(function(){
	$("#form_correct").submit(function(){
    	$("#action").prop('disabled', true);
    	}
    );//end click
    
    $("#search").keyup(
    	//search
		
		debounce(function(){
			console.log("searching");
			search();
		}, 200)
    );//end keyup
    
});//end doc

	function search(){
		var keyword = $('#search').val();  
		if(keyword == ""){
			keyword = "empty";
		}
		$.ajax({
		    type : 'get',
		    url : "/stories/search", 
		    dataType : 'script',
		    data: {"keyword": keyword},
		    async : true,
		    success : function(data) {
		    	 
		    }//end function
		});//end ajax
	}//end function

	function debounce(func, wait, immediate) {
		var timeout;
		return function() {
			var context = this, args = arguments;
			var later = function() {
				timeout = null;
				if (!immediate) func.apply(context, args);
			};
			var callNow = immediate && !timeout;
			clearTimeout(timeout);
			timeout = setTimeout(later, wait);
			if (callNow) func.apply(context, args);
		};
	};
