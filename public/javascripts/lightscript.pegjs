Request
  = request:(LoopRequest / SimpleRequest) {
    if (request != null) {
      document.getElementById('canvas').appendChild(addSVG(request[0], request[1]));
    }
  }

LoopRequest
  = loop:LoopCommand _ request:SimpleRequest {
    if (loop["from"] < loop["to"]) {
      for (var i=loop["from"]; i<loop["to"]; i+=loop["increment"]) {
        document.getElementById('canvas').appendChild(addSVG(request[0], applyCounter(request[1], i)));
      }
    } else {
       for (var i=loop["from"]; i>loop["to"]; i-=loop["increment"]) {
          document.getElementById('canvas').appendChild(addSVG(request[0], applyCounter(request[1], i)));
        } 
    }
  }

SimpleRequest = request:(Command / Shape) {
    return request;
  }

Command = command:(PopCommand / HelpCommand) {
  return command;
}

PopCommand 
  = "pop" {
    var canvas = document.getElementById('canvas');
    canvas.removeChild(canvas.lastChild);
  }

HelpCommand 
  = "help"

LoopCommand
  = "loop(" from:Integer ".." to:Integer "," inc:Integer ")" {
    return {
      from: from,
      to: to,
      increment: inc
    }
  }

Shape = shape:(Circle / Line / Square / Rect) {
  return shape;
}

// SVG Circle

Circle = circle:(CircleFullDesc / CircleDefaults) {
  return circle;
}

CircleDefaults
  = "circle" _ cx:IntVal _ cy:IntVal _ r:IntVal {
    return['circle', {
      cx: cx, 
      cy: cy, 
      r: r, 
      stroke: "black", 
      fill:  "black", 
      'stroke-width': 1}
      ];
  }

CircleFullDesc 
  = "circle" _ cx:IntVal _ cy:IntVal _ r:IntVal _ stroke:Color _ fill:Color _ width:IntVal {
    return['circle', {
      cx: cx, 
      cy: cy, 
      r: r, 
      stroke: stroke, 
      fill:  fill, 
      'stroke-width': width}
   ];
  }

// SVG Line

Line = line:(LineFullDesc / LineDefaults) {
  return line;
}

LineDefaults
  = "line" _ x1:IntVal _ y1:IntVal _ x2:IntVal _ y2:IntVal {
    return['line', {
        x1: x1, 
        y1: y1, 
        x2: x2, 
        y2: y2,  
      'style': "stroke:rgb(0,0,0);stroke-width:1"}
      ];
  }

LineFullDesc
  = "line" _ x1:IntVal _ y1:IntVal _ x2:IntVal _ y2:IntVal _ width:IntVal {
    return['line', {
        x1: x1, 
        y1: y1, 
        x2: x2, 
        y2: y2,  
      'style': "stroke:rgb(0,0,0);stroke-width:" + width}
      ];
  }

// SVG Rect

Rect = rect:(RectFullDesc / RectDefaults) {
  return rect;
}

RectDefaults
  = "rect" _ x:IntVal _ y:IntVal _ width:IntVal _ height:IntVal {
    return['rect', {
        x: x, 
        y: y, 
        width: width, 
        height: height,  
      'style': "stroke:rgb(0,0,0);stroke-width:1"}
      ];
  }

RectFullDesc
  = "rect" _ x:IntVal _ y:IntVal _ width:IntVal _ height:IntVal _ style:Style {
    return['rect', {
        x: x, 
        y: y, 
        width: width, 
        height: height,  
      'style': style}
      ];
  }

Square
  = "square"

IntVal = 
  val:(Variable / Integer) {
    return val;
  }

//Variable =
//  "$CNT" {
//    return "$CNT";
//  }

Variable =
  [a-zA-Z0-9%/+$*()-]+ { return text(); }

Integer "integer"
  = [0-9]+ { return parseInt(text(), 10); }

Text
  = [a-zA-Z]+ { return text(); }

Color "color"
  = [a-zA-Z]+ { return text(); }

Style "style"
  = [a-zA-Z(),;:0-9]+ { return text(); }

_ "whitespace"
  = [ \t\n\r]*