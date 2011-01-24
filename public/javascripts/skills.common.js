
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
        var r = Raphael("skills-graph", 450, 450),
            attrs = {'stroke-width':10, 'stroke':'#990'};
        
        //var p = r.path("M100,10 L100,10 40,180 190,60 10,60 160,180 z").attr(attrs);
            
        
    }
    
    return {
        // public
        init: init
    };
})();

jQuery(document).ready(skills.common.init);
