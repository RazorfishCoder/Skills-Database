// 'skills' namespace
skills=window.skills || {};

skills.edit = (function() {

    // private
    function init() {
        //initialize common code
        addSkill();
        removeSkill();
        ratings();
    }
    
    function addSkill(){
        $('#add-skill').live('click',function(e) {
            e.preventDefault();
            var content = skill_nested;
            var new_id  = new Date().getTime();
            $('#skill-tags').before(content.replace(/run_time_name/gi, new_id));
          });
          var skill_nested = '<div class="skill_tag_fields_template clearfix"> <span class="skill-tag-col"><label for="employee_skill_tags_run_time_name_name">Name:</label> <input type="text" value="" name="employee[skill_tags][run_time_name][name]" id="employee_skill_tags_run_time_name_name" class="tagautocomplete ui-autocomplete-input ui-autocomplete-loading"></span><span class="skill-tag-col"><span class="tag-rating-label">Rate:</span> <input type="hidden" value="" name="employee[skill_tags][run_time_name][rate]" id="employee_skill_tags_run_time_name_rate"> <ul class="ratings"><li class="one"><a href="#">1</a></li> <li class="two"><a href="#">2</a></li> <li class="three"><a href="#">3</a></li> <li class="four"><a href="#">4</a></li> <li class="five"><a href="#">5</a></li> </ul> <a class="remove-skill" href="#">remove</a></span></div>';
    }
    
    function removeSkill(){
        $('.remove-skill').live('click', function(e) {
            e.preventDefault();            
            // remove markup
            $(this).parents('div:first').remove();
         });
    }
    
    function ratings(){
        
        $('ul.ratings > li').live('mouseover mouseout', function(event) {
          if (event.type == 'mouseover') {
            $(this).prevAll().addClass('active');
            $(this).nextAll().addClass('disable');
          } else {
            $(this).prevAll().removeClass('active');
            $(this).nextAll().removeClass('disable');
          }
        });
        
        $('ul.ratings a').live('click',function(e){
            e.preventDefault();
            var $this = $(this),
                $ratings = $this.parents('ul'),
                $input = $ratings.prev('input[type="hidden"]');
                val = $this.text(),
                newClass = $this.parent().attr('class');
                
            $input.attr('value',val);
            $ratings[0].className = 'ratings ' + newClass;
        });
    }

    return {
        // public
        init: init
    };
})();

jQuery(document).ready(skills.edit.init);

