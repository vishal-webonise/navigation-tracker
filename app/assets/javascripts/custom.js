jQuery(document).ready(function() {
	
	// Tabs
	$('.nav-tabs a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})

	// Token input
	$("#select_project").tokenInput("dashboard/user_projects");
	$("#select_users").tokenInput("users", { propertyToSearch: "first_name"});

});