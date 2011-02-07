$(document).ready(function(){
  $('#add_skill').live('click',function() {
    var content = skill_nested;
    var new_id  = new Date().getTime();
    $('#skill_tags').before(content.replace(/run_time_name/gi, new_id));

      return false;
  });

  var skill_nested = '<div id="skill_tag_fields_template"> <p>    name: <input type="text" value="" name="employee[skill_tags][run_time_name][name]" id="employee_skill_tags_run_time_name_name" class="tagautocomplete ui-autocomplete-input ui-autocomplete-loading">    rate: <input type="text" value="" name="employee[skill_tags][run_time_name][rate]" id="employee_skill_tags_run_time_name_rate"><a id="remove_skill" href=""> remove</a>  </p></div>';

  $('#remove_skill').live('click', function() {

    $(this).parents('p').remove();
    return false;
  });
});

