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
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      if (Math.random() < DENSITY) {
        grid[row][col] = 1; 
      } else {
        grid[row][col] = 0; 
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
    paused = !paused; // toggle pause mode
  } else if (keyCode == RIGHT) {
    stepForward(); // move forward one step
  }
}

void stepForward() {
  showGrid();
  int[][] nextGrid = calcNextGrid(); // calculate the next grid state
  grid = nextGrid; //update grid
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      int neighbors = countNeighbors(row,col);
      
      // Applying the rules of the game to determine the next state of the cell
      if (grid[row][col] == 1 && (neighbors < 2 || neighbors > 3)) {
        nextGrid[row][col] = 0;
      } else if (grid[row][col] == 0 && neighbors == 3) {
        nextGrid[row][col] = 1;
      } else {
        nextGrid[row][col] = grid[row][col];
      }
    }
  }
  // your code here

  return nextGrid;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  
  
  int[] dx = {-1, 0, 1, -1, 1, -1, 0, 1}; //checking all the coordinates
  int[] dy = {-1, -1, -1, 0, 0, 1, 1, 1}; //checking all the coordinates

  for (int k = 0; k < dx.length; k++) {
    int neighborY = y + dy[k];
    int neighborX = x + dx[k];

    // Check if the neighbor is within the grid boundaries and alive
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
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      if (grid[row][col] == 1) {
        fill(255, 0, 0); //red if alive
      } else {
        fill(0); //black if dead
      }
      square(col * SPACING, row * SPACING, SPACING); //draw the cell
    }
  }
}
