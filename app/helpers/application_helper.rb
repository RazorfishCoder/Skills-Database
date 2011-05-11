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
  # @employee_object = contains the employee's first_name, last_name, and job_title
  def employee_link(employee_object)
      link_to(employee_object.first_name + ' ' + employee_object.last_name + ' // ' + employee_object.job_title, employee_path(employee_object))
  end 

  # creates a link to an employee detail page
  # @employee_object = contains the employee's first_name, last_name
  def employee_link_short(employee_object)
      link_to(employee_object.first_name + ' ' + employee_object.last_name, employee_path(employee_object))
  end 
  
  # displays read only version of ratings list
  def ratings_readonly(rating)
    if (rating.is_a?(Integer) )
    	rating = Integer(rating)
    else
	rating = 1
    end
    if(rating <= 5)
      items = ['one','two','three','four','five']
        content = ""
        items.each_with_index do |item, i|
            text = i + 1
            content << content_tag('li', content_tag('a', text, :href => '#' ), :class => item) + " "
        end
        content_tag(:ul, content.html_safe, :class => "ratings read-only " + items[rating - 1])
    else 
      content_tag(:span,"error: rating out of range");
    end
  end
    
    # displays editable version of ratings list
    def ratings_edit(rating)
      rating = Integer(rating)
      if(rating <= 5)
        items = ['one','two','three','four','five']
          content = ""
          items.each_with_index do |item, i|
              text = i + 1
              content << content_tag('li', content_tag('a', text, :href => '#' ), :class => item) + " "
          end
          content_tag(:ul, content.html_safe, :class => "ratings " + items[rating - 1])
      else 
        content_tag(:span,"error: rating out of range");
      end
    end
end
