int maxx, maxy;
int[][] cells;
int w = 40;

void setup() {
  size(400, 400);
  cells = new int[width/w][height/w];
}

void draw() {

  int xmax = width / w;
  int ymax = height / w;

  for (int x = 0; x < xmax; x++) {
    for (int y = 0; y < ymax; y++) {
      if (cells[x][y] == 0) {
        fill(0);
      } else {
        fill(255);
      }
      rect(x * w, y * w, w-2, w-2);
    }
  }
  
}

void mousePressed() {
  
  int cellX = mouseX / w;
  int cellY = mouseY / w;

  if ( cells[cellX][cellY] == 1) {
    cells[cellX][cellY] = 0;
  } else {
    cells[cellX][cellY] = 1;
  }
}
