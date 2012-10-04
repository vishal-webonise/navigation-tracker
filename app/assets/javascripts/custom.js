jQuery(document).ready(function() {
	
	// Tabs
	$('.nav-tabs a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})

	// Token Input

	function project_users(project_id) {
		console.log(project_id);
		project_users_ids = $.post("dashboard/project_users", {project_id: project_id}, function(response) {return response}, 'JSON')
		$("#project_users").tokenInput( "users",
			{ 
				propertyToSearch: "first_name",
				// prePopulate:$.parseJSON($("#project_users").attr("rel")),
				prePopulate: project_users_ids,
				preventDuplicates: true,
				tokenFormatter: function(item) { return "<li class='project_users' id='" + item.id + "'>" + item.first_name + " " + item.last_name + "</li>" },
			}
		);
	}

	function clear_project_users() {
	 	$("#project_users").tokenInput("clear");
	}

	$("#user_project").tokenInput("dashboard/user_projects",
	 	{
	 		tokenLimit: 1,
	 		tokenFormatter: function(item) { return "<li class='project_users' id='" + item.id + "'>" + item.name + "</li>" },
	 		onAdd: function(item){ project_users(item.id)},
	 		onDelete: clear_project_users,
	 	}
 	);

});