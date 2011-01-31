// 'skills' namespace
skills=window.skills || {};

skills.common = (function() {

    // private
    function init() {
        //initialize common code
        initSkillsGraph();
    }

    function initSkillsGraph(){
        if (!Raphael) return;
        // ----- Start Create Canvas For Drawing Our Graph
        var r = Raphael("skills-graph", 450, 450),
            R = 200,
            outerCoord = 450 - R * 2,
            step = 16,
            init = true,
            param = {stroke: "#fff", "stroke-width": 15},
            marksAttr = {fill: "#444", stroke: "none"};
		// ----- End Create Canvas For Drawing Our Graph


        // ----- Start Create Custom Attribute For A Dynamic Arc
        r.customAttributes.arc = function (value, total, R, hexColor) {
            var alpha = 360 / total * value,
                a = (90 - alpha) * Math.PI / 180,
                x = 225 + R * Math.cos(a),
                y = 225 - R * Math.sin(a),
                color = hexColor || "hsb(".concat(Math.round(R) / 200, ",", value / total, ", .75)"),
                path;
            if (total == value) {
                path = [["M", 225, 225 - R], ["A", R, R, 0, 1, 1, 224.99, 225 - R]];
            } else {
                path = [["M", 225, 225 - R], ["A", R, R, 0, +(alpha > 180), 1, x, y]];
            }
            return {path: path, stroke: color};
        };
		// ----- End Create Custom Attribute For A Dynamic Arc
		
		// ----- Start Create Custom Attribute For Data Storage
        r.customAttributes.dataStore = function (value) {
            value = value;
            return {value: value};
        };
		// ----- End Create Custom Attribute For Data Storage

		/**
		 * animateArc()
		 * Function to animate along the path setup by our top 10 skills.
		 * @param value
		 * @param total
		 * @param R
		 * @param hand -
		 * @param id - html element id that we're using to hold the animation
		 */
		function drawArc(value, total, R, hand, id, hexColor) {
            var color = hexColor || "hsb(".concat(Math.round(R) / 200, ",", value / total, ", .75)");
            if (init) {
                hand.animate({arc: [value, total, R, color]}, 900, ">");
            } else {
                if (!value || value == total) {
                    value = total;
                    hand.animate({arc: [value, total, R, color]}, 750, "bounce", function () {
                        hand.attr({arc: [0, total, R, color]});
                    });
                } else {
                    hand.animate({arc: [value, total, R, color]}, 750, "elastic");
                }
            }
        }
		// ----- drawArc()

		// ----- Start Create Shells Of Arc's For Each Top 10 Skill (used in animation)
		// ----- Start onLoad() function
        (function () {
            var skillsArray = [.50,.75,.25,.20,.80,.95,.5,.20,.65,.12],
                colorArray = ['#6B5023','#D6C985','#B3B2B8','#677079','#9B1F39','#AE3B0E','#FB9C1C','#DFD011','#5E6900','#EEF2F5'],
                variables = [], data = [];
                var skills = $.ajax({
                  type: 'POST',
                  url: '/taggings/skill_tags_cloud',
                  data: 'JSON',
                  success: function(result){
                    var _skills = [];
                    for(var i=0;i < result.rows.length; i++) {
                         _skills[i] = result.rows[i].value;
                    }
                    skillsFinal = (_skills.length > 0) ? _skills : skillsArray;
                    for(var i=0,len=skillsFinal.length; i<len; i++) {
            	        var l = 360 * skillsFinal[i],
            	            percentage = 100*skillsFinal[i],
            	            cnt = i + 1;
            	        variables[i] =  r.path().attr(param).attr({arc: [0, 360, R]}).attr({dataStore: percentage}).click(function(){
            	                //alert(this.attr('dataStore'));
            	            });
            	        // data for use on events
            	        data.push(percentage);
            	        // text labels. we start from the outermost circle and work in (subtracting for text size)
            	        var yAxis = outerCoord - 8;
            	        var txt = r.text(220,yAxis,"skill (" + percentage + '%)').attr({'text-anchor':'end','fill':'#444','font-weight':'800','font-family':'Arial'}).toFront();
            	        // make adjustments
            	        R -= step;
            	        outerCoord += step;
            	        // animate the arc
            	        drawArc(l, 360, R, variables[i], cnt);
                    }
			        init = false;
                  }
                });


        })();
		// ----- End onLoad() function
    }

    return {
        // public
        init: init
    };
})();

jQuery(document).ready(skills.common.init);

