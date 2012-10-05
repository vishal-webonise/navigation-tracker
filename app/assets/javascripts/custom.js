jQuery(document).ready(function() {
	
	// Tabs
	$('.nav-tabs a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})

	/* START Token Input */
	function project_users(project_id) {
		project_users_ids = $.get("dashboard/project_users", {project_id: project_id}, function(data) {
			project_users_ids = JSON.stringify(data);
			//console.log(project_users_ids);
			$("#project_users").tokenInput( "users",
				{ 
					propertyToSearch: "first_name",
					prePopulate: $.parseJSON(project_users_ids),
					preventDuplicates: true,
					tokenFormatter: function(item) { return "<li class='project_users' id='" + item.id + "'>" + item.first_name + " " + item.last_name + "</li>" },
				}
			);

		}, 'json');
	}

	function clear_project_users() {
	 	$("#project_users").tokenInput("remove");
	 	// $('#token-input-project_users:first').parent().parent().remove()
	}

	$("#user_project").tokenInput("dashboard/user_projects",
	 	{
	 		tokenLimit: 1,
	 		tokenFormatter: function(item) { return "<li class='project_users' id='" + item.id + "'>" + item.name + "</li>" },
	 		onAdd: function(item){ project_users(item.id)},
	 		onDelete: clear_project_users,
	 	}
 	);

 	/* END Token Input */

}); // END documnet-ready