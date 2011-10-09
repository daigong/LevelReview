module Admin::SubjectsHelper
  def subjects_options selected
    options_from_collection_for_select Admin::Subject.all, "id", "name", selected
  end
end
