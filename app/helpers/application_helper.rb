module ApplicationHelper
#  def remove_child_link(name, f)
#    f.hidden_field(:_delete) + link_to(name, "javascript:void(0)", :class => "remove_child")
#  end

#  def add_child_link(name, association)
#    link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
#  end

#  def new_child_fields_template(form_builder, association, options = {})
#    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
#    options[:partial] ||= association.to_s.singularize
#    options[:form_builder_local] ||= :f

#    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
#      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
#        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
#      end
#    end
#  end

  # creates a link to an employee detail page
  # @employeeObject = contains the employee's first_name, last_name, and job_title
  def employee_link(employeeObject)
      link_to(employeeObject.first_name + ' ' + employeeObject.last_name + ' // ' + employeeObject.job_title, '/employees/' + employeeObject.first_name.downcase + '-' + employeeObject.last_name.downcase)
  end 

end

