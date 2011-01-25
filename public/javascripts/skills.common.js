
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
        //initSkillsGraph();
        initTest();
    }

    function initSkillsGraph(){
        if (!Raphael) return;
        var r = Raphael("skills-graph", 450, 450),
            posY = 225, startingRadius = 200, offset = 10,
            attrs = {'stroke-width':offset, 'stroke':'#990'};
        
        // rx, ry, large_arc_flag, sweep_flag, x, y, angle
        // var b = r.path('M10,225 a200,200 0,1,1 200,200').attr(attrs);
        //         attrs.stroke = '#970';
        //         var a = r.path('M20,225 a190,190 0,1,1 190,190').attr(attrs);
        //         
        
        r.path().attr(attrs);
        
        var skills = [];        
        
        function drawCircle (radius,posX){
            
        }
        // in case I need these functions
        /*
        function circlePath(x,y,r){
            var s = "M" + x + "," + (y-r) + "A"+r+","+r+",0,1,1,"+(x-0.1)+","+(y-r)+" z";   
              return s;
        }
        
        Raphael.fn.circlePath = function(x , y, r) {      
          var s = "M" + x + "," + (y-r) + "A"+r+","+r+",0,1,1,"+(x-0.1)+","+(y-r)+" z";   
          return s; 
        }
        */
    }
    
    function initTest(){
        var paper = Raphael("skills-graph",450,450); 
        var R = 200, 
            value = 50,                     // value you want to arc to 
            total = 100,                    // total possible 
            alpha = 360 / total * value, 
            a = (90 - alpha) * Math.PI / 180, 
            x = 300 + R * Math.cos(a), 
            y = 300 - R * Math.sin(a), 
            param = {stroke: "#FF0000", "stroke-width": 10}; 
            
            //console.log(alpha);
            
        //paper.path('M10,225').attr(param).arcTo(R, R, (alpha > 180 ? 0 : 1), 1,0, x, y);
    }
    
    return {
        // public
        init: init
    };
})();

jQuery(document).ready(skills.common.init);
