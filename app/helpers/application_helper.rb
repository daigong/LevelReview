module ApplicationHelper

  #为semantic_form_for表单添加额外字段
  #同时js会自动加入规则，详情请见semantic_form_extra_rule.js
  def semantic_extra_input name, options = {}
    has_class = []
    if options.include? :class
      has_class = options.delete(:class).split(" ")
    end
    content_tag :li, :class=>"#{has_class.join(" ")}" do
      html_str = label_tag name do
        label_str=options[:label]
        if has_class.include? 'required'
          label_str<<content_tag(:abbr, '*', :title=>'required')
        end
        label_str.html_safe
      end
      html_str<<text_field_tag(name, options[:value], "data-validate"=>true, "data-extra-validate"=>true)
      html_str
    end
  end

  #为semantic_form_for添加额外的select字段
  #同时js会自动加入规则，详情请见semantic_form_extra_rule.js
  def semantic_extra_select name, option_tags, options = {}
    has_class = []
    if options.include? :class
      has_class = options.delete(:class).split(" ")
    end
    options[:include_blank] = true unless options.include? :include_blank&&options[:include_blank]==false
    content_tag :li, :class=>"#{has_class.join(" ")}" do
      html_str = label_tag name do
        label_str=options.delete :label
        if has_class.include? 'required'
          label_str<<content_tag(:abbr, '*', :title=>'required')
        end
        label_str.html_safe
      end
      options["data-validate"] = true
      options["data-extra-validate"] = true
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
