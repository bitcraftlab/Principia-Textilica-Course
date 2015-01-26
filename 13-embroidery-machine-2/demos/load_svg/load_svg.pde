
// Loading SVG is really simple in Processing ...

PShape shp = loadShape("shapes.svg");

// You can also get elements of the SVG by ID
PShape rect = shp.getChild("rectangle");
PShape tri = shp.getChild("triangle");

// Now you can modify the Shapes
tri.beginShape();
tri.fill(#ff0000);
tri.endShape(CLOSE);

rect.beginShape();
rect.fill(#ffff00);
rect.endShape(CLOSE);

// Now you can display them in Processing using shape()
size(240,120);
background(255);
translate(10, 10);
shape(tri);
translate(120, 0);
shape(rect);
 
// You can also iterate over the vertices and do something with them
PShape myshape = rect;
for (int i = 0; i < myshape.getVertexCount(); i++) {
  PVector v = myshape.getVertex(i);
  fill(0);
  ellipse(v.x, v.y, 10, 10);
}


