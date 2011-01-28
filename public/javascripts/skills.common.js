
// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function(){
  log.history = log.history || [];   // store logs to an array for reference
  log.history.push(arguments);
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};



// place any jQuery/helper plugins in here, instead of separate, slower script files.
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
            step = 16,
            init = true,
            param = {stroke: "#fff", "stroke-width": 15},
            hash = document.location.hash,
            marksAttr = {fill: hash || "#444", stroke: "none"};
		// ----- End Create Canvas For Drawing Our Graph


        // ----- Start Create Custom Attribute For A Dynamic Arc
        r.customAttributes.arc = function (value, total, R) {
            var alpha = 360 / total * value,
                a = (90 - alpha) * Math.PI / 180,
                x = 225 + R * Math.cos(a),
                y = 225 - R * Math.sin(a),
                color = "hsb(".concat(Math.round(R) / 200, ",", value / total, ", .75)"),
                path;
            if (total == value) {
                path = [["M", 225, 225 - R], ["A", R, R, 0, 1, 1, 224.99, 225 - R]];
            } else {
                path = [["M", 225, 225 - R], ["A", R, R, 0, +(alpha > 180), 1, x, y]];
            }
            return {path: path, stroke: color};
        };
		// ----- End Create Custom Attribute For A Dynamic Arc

		/**
		 * animateArc()
		 * Function to animate along the path setup by our top 10 skills.
		 * @param value
		 * @param total
		 * @param R
		 * @param hand -
		 * @param id - html element id that we're using to hold the animation
		 */
		function drawArc(value, total, R, hand, id) {
            if (total == 31) { // month
                var d = new Date;
                d.setDate(1);
                d.setMonth(d.getMonth() + 1);
                d.setDate(-1);
                total = d.getDate();
            }
            var color = "hsb(".concat(Math.round(R) / 200, ",", value / total, ", .75)");
            if (init) {
                hand.animate({arc: [value, total, R]}, 900, ">");
            } else {
                if (!value || value == total) {
                    value = total;
                    hand.animate({arc: [value, total, R]}, 750, "bounce", function () {
                        hand.attr({arc: [0, total, R]});
                    });
                } else {
                    hand.animate({arc: [value, total, R]}, 750, "elastic");
                }
            }
        }
		// ----- drawArc()

		// ----- Start Create Shells Of Arc's For Each Top 10 Skill (used in animation)
		// ----- Start onLoad() function
		// Sorry i screwed your code just for test the server real response
        (function () {
            var skills = [.50,.75,.25,.20,.80,.95,.5,.20,.65,.12],
                variables = [];
                var skills = $.ajax({
                  type: 'POST',
                  url: '/taggings/skill_tags_cloud',
                  data: 'JSON',
                  success: function(result){
                    var _skills = [];
                    for(var i=0;i < result.rows.length; i++) {
                         _skills[i] = result.rows[i].value;
                    }
                    skills = _skills;
                    for(var i=0,len=skills.length; i<len; i++) {
            	        var l = 270 * skills[i],
            	        cnt = i + 1;
            	        variables[i] =  r.path().attr(param).attr({arc: [0, 360, R]});
            	        R -= 16;
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

