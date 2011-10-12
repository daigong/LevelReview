module ApplicationHelper

  #为semantic_form_for表单添加额外字段
  def semantic_extra_input name, options = {}
    content_tag :li do
      html_str = label_tag name, options[:label]
      html_str<<text_field_tag(name, options[:value], "data-validate"=>true)
      html_str
    end
  end

  #为semantic_form_for添加额外的select字段
  def semantic_extra_select name, option_tags, options = {}
    options[:include_blank] = true unless options.include? :include_blank&&options[:include_blank]==false
    content_tag :li do
      html_str = label_tag name, options[:label]
      options["data-validate"] = true
      html_str<<select_tag(name, option_tags, options)
      html_str
    end
  end

  #部门select列表
  def department_options selected=nil
    departments = Admin::Department.all
    options_from_collection_for_select(departments, "id", "name", selected)
  end
end
