$(document).ready(function(){
  $('#add_skill').live('click',function() {
    var content = $('#skill_tag_fields_template').html();
    var new_id  = new Date().getTime();
    $('#skill_tags').before(content.replace('run_time_name', new_id));

      return false;
  });

//  var skill_nested = '<div id="skill_tag_fields_template">
//  AGREGADO
//  <p>
//    name: <input type="text" value="" name="employee[skill_tags][run_time_name][name]" id="employee_skill_tags_run_time_name_name">
//    rate: <input type="text" value="" name="employee[skill_tags][run_time_name][rate]" id="employee_skill_tags_run_time_name_rate">
//  </p>

//</div>'

//  $('form a.add_child').click(function() {
//    var assoc   = $(this).attr('data-association');
//    var content = $('#' + assoc + '_fields_template').html();
//    var regexp  = new RegExp('new_' + assoc, 'g');
//    var new_id  = new Date().getTime();

//    $(this).parent().before(content.replace(regexp, new_id));
//    return false;
//  });

//  $('form a.remove_child').live('click', function() {
//    var hidden_field = $(this).prev('input[type=hidden]')[0];
//    if(hidden_field) {
//      hidden_field.value = '1';
//    }
//    $(this).parents('.fields').hide();
//    return false;
//  });
});

