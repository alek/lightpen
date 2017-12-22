commands = []
cursor = 0

$.fn.pressEnter = function(fn) {  
    return this.each(function() {  
        $(this).bind('enterPress', fn);
        $(this).keyup(function(e){
            if(e.keyCode == 13)
            {
              $(this).trigger("enterPress");
            }
        })
    });  
 }; 

add = function(el) {
	return new Element(this.obj.appendChild(document.createElementNS("http://www.w3.org/2000/svg", el)));
}

applyCounter = function(map, val) {
	result = {}
	for (var key in map) {
		if (map[key].toString().includes("$CNT")) {
			result[key] = eval(map[key].replace("$CNT", val).replace("RND()", Math.random()));
		} else if (map[key].toString().includes("RND()")) {
			result[key] = eval(map[key].replace("RND()", Math.random()));
		} else {
			result[key] = map[key];
		}
	}
	return result;
}

addSVG = function(tag, attrs) {
	var el= document.createElementNS('http://www.w3.org/2000/svg', tag);
	for (var k in attrs) {
    	el.setAttribute(k, attrs[k]);
	}
	return el;
}


$( document ).ready(function() {

	// enter command
    $('.command').pressEnter(function(){
    	cmd = $(this).val();
    	commands.push(cmd);
    	cursor = commands.length - 1;
    	try {
			console.log(peg.parse(cmd));
		} catch (error) {
			console.log(error);
		}
    	$(this).val('');
    });    

    // key up
    $('.command').keydown(function(e) {
    	if(e.keyCode == 38) {
			$(this).focus().val("").val(commands[cursor]);
    		if (cursor > 0) {
	    		cursor = cursor - 1;
	    	}
    	} else if (e.keyCode == 40) {
    		if (cursor < commands.length -1) {
    			cursor = cursor + 1;    			
    		}
    		$(this).focus().val("").val(commands[cursor]);
    	}
	});
});

