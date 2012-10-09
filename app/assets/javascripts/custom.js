jQuery(document).ready(function() {
	
	/* Tabs */

	$('.nav-tabs a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})

	// Javascript to enable link to tab
	var url = document.location.toString();
	if (url.match('#')) {
	  $('.nav-tabs a[href=#'+url.split('#')[1]+']').tab('show') ;
	} 

	// Change hash for page-reload
	$('.nav-tabs a').on('shown', function (e) {
	  window.location.hash = e.target.hash;
	})

	/* END Tabs */

	/* START Token Input */

	project_id = $("#project_id").attr('value');
	console.log(project_id);
	$("#project_users").tokenInput("/projects/"+project_id+"/users.json",
				{ 
					propertyToSearch: "first_name",
					tokenFormatter: function(item) { return "<li class='project_users' id='" + item.id + "'>" + item.first_name + " " + item.last_name + "</li>" },
				}
			);

 	// prevent form submit until both fields has values

	$('#assign_users_to_project').submit(function(){
		if($('#project_users').val().length < 1){
			$('#alert_box').addClass("alert-error").html('Users before submit').fadeIn(200).delay(5500).fadeOut(500).removeClass('alert-error');
			return false;
		}
	});

 	/* END Token Input */

 	// Show My Projects tab if current_user.projects.any? or show Add new project tab
 	if($('#all_projects div').attr('rel') != "no_projects") {
 		$('li a[href=#all_projects]').trigger('click');
 	}

}); // END documnet-ready