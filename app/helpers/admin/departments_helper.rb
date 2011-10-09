module Admin::DepartmentsHelper

  def departments_options selected
    options_from_collection_for_select Admin::Department.all, "id", "name", selected
  end

end
