$(document).ready(function() {
        var availableTags = {};

        $.getJSON( "/taggings/autocomplete", {tags_type: "skill_tags"}, function(data){availableTags['skill_tags']=  data;} );
        $.getJSON( "/taggings/autocomplete", {tags_type: "product_tags"}, function(data){availableTags['product_tags']=  data;} );
        $.getJSON( "/taggings/autocomplete", {tags_type: "industry_tags"}, function(data){availableTags['industry_tags']=  data;} );

		function split( val ) {
			return val.split( /,\s*/ );
		}
		function extractLast( term ) {
			return split( term ).pop();
		}

		$( ".tagautocomplete" )
			// don't navigate away from the field on tab when selecting an item
			.bind( "keydown", function( event ) {
				if ( event.keyCode === $.ui.keyCode.TAB &&
						$( this ).data( "autocomplete" ).menu.active ) {
					event.preventDefault();
				}
			})
			.autocomplete({
				minLength: 0,
				source: function( request, response ) {
                    console.log(this.element.context.classList);
					// delegate back to autocomplete, but extract the last term
					response( $.ui.autocomplete.filter(
//						availableTags[this.element.context.id], extractLast( request.term ) ) );
						availableTags[this.element.context.classList[0]], extractLast( request.term ) ) );
				},
				focus: function() {
					// prevent value inserted on focus
					return false;
				},
				select: function( event, ui ) {
					var terms = split( this.value );
					// remove the current input
					terms.pop();
					// add the selected item
					terms.push( ui.item.value );
					// add placeholder to get the comma-and-space at the end
					terms.push( "" );
					this.value = terms.join( ", " );
					return false;
				}
			});
	});

