$(document).ready(function(){
  $('#add_skill').live('click',function() {
    var content = $('#skill_tag_fields_template').html();
    var new_id  = new Date().getTime();
    $('#skill_tags').before(content.replace('run_time_name', new_id));
        alert('so siome');
      return false;
  });

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

