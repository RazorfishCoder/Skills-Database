/*!
 * HTML5 Form Fallback
 * http://www.sitebase.be
 *
 * Copyright (c) 2010 Sitebase
 *
 * Date: 16th September, 2010
 * Version : 1.00
 *
 * === FEATURES ===
 * - Add placeholder for older browsers
 * - Add autofocus for older browsers
 * - Add form validation (email, url, number)
 *
 * === HOW TO USE ===
 * 1. You can style the placeholder in your CSS by styling the class .placeholder
 * 2. Add invalid class to your CSS
	.invalid{
		// style here
	}
	Don't add it to the same selector as :invalid because it will not work
	in IE this way:
	input:invalid, .invalid{
		// style here
	}
 * 3. Include this script just before the closing body tag.
 */

// Create input element to do tests
var input = document.createElement('input');

// Add placeholder support for non HTML5 browsers
var support_placeholder = 'placeholder' in input;
if(!support_placeholder){
	$(':input[placeholder]').each(function() {
		var $$ = $(this);
		if($$.val() === '') {
	   
			$$.addClass('placeholder');
			$$.val($$.attr('placeholder'));
		}
		$$.focus(function() {
			$$.addClass('focus');
			if($$.val() === $$.attr('placeholder')) {
				$$.val('');
				$$.removeClass('placeholder');
			}
		}).blur(function() {
			$$.removeClass('focus');
			if($$.val() === '') {
				$$.addClass('placeholder');
				$$.val($$.attr('placeholder'));
			}
		});
	});
}

// Add autofocus support for non HTML5 browsers
var support_autofocus = 'autofocus' in input;
if(!support_autofocus){
	$('input[autofocus]').eq(0).focus();
}else{
	// Fix for opera
	$('input[autofocus]').eq(0).val('');	
	$('input[autofocus]').eq(0).removeClass('placeholder');
}

// Handler form validation
$('input,textarea').keyup(function() {
	validate(this);
});

// Validate an element
function validate(element){
	var $$ = $(element);
	var validator = element.getAttribute('type'); // Using pure javascript because jQuery always returns text in none HTML5 browsers
	var valid = true;
	var apply_class_to = $$;
	
	var required = element.getAttribute('required') == null ? false : true;
	switch(validator){
		case 'email': valid = is_email($$.val()); break;
		case 'url': valid = is_url($$.val()); break;
		case 'number': valid = is_number($$.val()); break;
	}
	
	// Extra required validation
	if(valid && required && $$.val().replace($$.attr('placeholder'), '') == ''){
		valid = false;
	}
	
	// Set input to valid of invalid
	if(valid || (!required && $$.val() == '')){
		apply_class_to.removeClass('invalid');
		apply_class_to.addClass('valid');
		return true;
	}else{
		apply_class_to.removeClass('valid');
		apply_class_to.addClass('invalid');
		return false;
	}
}

// Add required class to inputs
$(':input[required]').addClass('required');

// Block submit if there are invalid classes found
$('form').submit(function() {
	$('input,textarea').each(function() {
		validate(this);
	});
	if(($(this).find(".invalid").length) == 0){
		// Delete all placeholder text
		$('input,textarea').each(function() {
			if($(this).val() == $(this).attr('placeholder')) $(this).val('');
		});
		return true;
	}else{
		return false;
	}
});


function is_email(value){
	return (/^([a-z0-9])(([-a-z0-9._])*([a-z0-9]))*\@([a-z0-9])(([a-z0-9-])*([a-z0-9]))+(\.([a-z0-9])([-a-z0-9_-])?([a-z0-9])+)+$/).test(value);
}

function is_url(value){
	return (/^(http|https|ftp):\/\/([A-Z0-9][A-Z0-9_-]*(?:\.[A-Z0-9][A-Z0-9_-]*)+):?(\d+)?\/?/i).test(value);
}

function is_number(value){
	return (typeof(value) === 'number' || typeof(value) === 'string') && value !== '' && !isNaN(value);
}

// Make thumbnails smooth fade in on rollover
$(".gallery a").css('opacity', 0.6).mouseenter(function() {
	$(this).css('opacity', 0.6).stop(true,true).animate({opacity: 1}, 400);
}).mouseleave(function() {
	$(this).css('opacity', 1).stop(true,true).animate({opacity: 0.6}, 400);
});