module ProjectsHelper
	def results_as_json(parent, children)
  	children.collect do |child|
      {
        :name => parent,
        :children => child.visit_path
      }
    end.to_json
  end
end
