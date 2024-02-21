final int SPACING = 5; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
boolean paused = false;

void setup() {
  size(1600, 1600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];

  // populate initial grid
  // your code here
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (Math.random() < DENSITY) {
        grid[i][j] = 1; 
      } else {
        grid[i][j] = 0; 
      }
    }
  }
  

}

void draw() {
  if(!paused) {
    showGrid();
    int[][] nextGrid = calcNextGrid();
    grid = nextGrid;
  }
}

void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  } else if (keyCode == RIGHT) {
    stepForward();
  }
}

void stepForward() {
  showGrid();
  int[][] nextGrid = calcNextGrid();
  grid = nextGrid;
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      int neighbors = countNeighbors(i,j);
      
      if (grid[i][j] == 1 && (neighbors < 2 || neighbors > 3)) {
        nextGrid[i][j] = 0;
      } else if (grid[i][j] == 0 && neighbors == 3) {
        nextGrid[i][j] = 1;
      } else {
        nextGrid[i][j] = grid[i][j];
      }
    }
  }
  // your code here

  return nextGrid;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  
  
  int[] dx = {-1, 0, 1, -1, 1, -1, 0, 1};
  int[] dy = {-1, -1, -1, 0, 0, 1, 1, 1};

  for (int k = 0; k < dx.length; k++) {
    int neighborY = y + dy[k];
    int neighborX = x + dx[k];

    if (neighborY >= 0 && neighborY < grid.length && neighborX >= 0 && neighborX < grid[0].length) {
      if (grid[neighborY][neighborX] == 1) {
        n++;
      }
    }
  }
  return n;
}

void showGrid() {
  // your code here
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] == 1) {
        fill(255, 0, 0); 
      } else {
        fill(0); 
      }
      square(j * SPACING, i * SPACING, SPACING);
    }
  }
}
