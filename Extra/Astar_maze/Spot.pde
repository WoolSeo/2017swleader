
class Spot {
  float f, g, h;
  int x, y;
  ArrayList<Spot> neighbors = new ArrayList<Spot>();
  Spot previous;
  
  boolean wall = false;
  boolean[] walls = {true, true, true, true};//top, right, bottom, left
  boolean visited = false;

  Spot(int i, int j) {//row, cols
    f = g = h = 0;//f = g + h;
    y = i;
    x = j;
    previous = null;
    
    if (random(1) < 0)
      this.wall = true;
  }
  
  
  void show(color cellColor) {
    //fill(cellColor);
    
    if (this.wall) {
      fill(0);
      noStroke();
      ellipse(x*cellWidth+cellWidth/2, y*cellHeight+cellHeight/2, cellWidth/2, cellHeight/2); 
   
    }
    stroke(255);
    if (walls[0])
      line(x*cellWidth    , y*cellHeight    , x*cellWidth + cellWidth, y*cellHeight);//top
    
    if (walls[1])
      line(x*cellWidth + cellWidth, y*cellHeight    , x*cellWidth + cellWidth, y*cellHeight + cellHeight);//right
    if (walls[2])
      line(x*cellWidth + cellWidth, y*cellHeight + cellHeight, x*cellWidth    , y*cellHeight+ cellHeight);//bottom
    if (walls[3])
      line(x*cellWidth    , y*cellHeight + cellHeight, x*cellWidth    , y*cellHeight);//left
    
    if (visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
    }
    
    
    
   
    //rect(x*cellWidth, y*cellHeight, cellWidth-1, cellHeight-1); 
    
    //textSize(10);
    //fill(255);
    //text(str(f), x*cellWidth+cellWidth/2, y*cellHeight+cellHeight/2);
  }
  
  
 int index(int row, int col) {
   if (row < 0 || row > rows-1 || col < 0 || col > cols-1) {
     return -1;
   }
   return 0;
 }
  
  Spot checkNeighbors() {//for maze
   
   //i, j(row, col)
   //i-1 j, i j+1, i+1 j, i j-1
   Spot[] neighbors = new Spot[0];
   int topIndex, rightIndex, bottomIndex, leftIndex;
   topIndex      = index(y-1, x);
   rightIndex    = index(y, x+1);
   bottomIndex   = index(y+1, x);
   leftIndex     = index(y, x-1);
   
   
   Spot top, right, bottom, left;
   if (topIndex != -1) {
     top = grid[y-1][x];
     if (!top.visited)
            neighbors = (Spot[])append(neighbors, top);
   } 
   if (rightIndex != -1) {
     right = grid[y][x+1];
     if (!right.visited)
            neighbors = (Spot[])append(neighbors, right);
   }
   if (bottomIndex != -1) {
     bottom = grid[y+1][x];
     if (!bottom.visited)
            neighbors = (Spot[])append(neighbors, bottom);
   }
   if (leftIndex != -1) {
     left = grid[y][x-1];
     if (!left.visited)
            neighbors = (Spot[])append(neighbors, left);
   }
   
   if(neighbors.length > 0 ) {
     int r = floor(random(0, neighbors.length));
     return neighbors[r];
   } else
     return null;
 }
 
 void highlight() {
   noStroke();
   fill(0,0,255,100);
   rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
 }
  
  
  void addNeighbors(Spot[][] grid) {//for a *
    int i, j;//row, col
    i = this.y;
    j = this.x;
    if (i > 0 && grid[i-1][j].walls[2] == false)
      neighbors.add(grid[i-1][j]);//top
    
    if (j < cols - 1 && grid[i][j+1].walls[3] == false)
      neighbors.add(grid[i][j+1]);//right
    
    if (i < rows - 1 && grid[i+1][j].walls[0] == false)
      neighbors.add(grid[i+1][j]);//bottom
    
    if (j > 0 && grid[i][j-1].walls[1] == false)
      neighbors.add(grid[i][j-1]);//left
    
    //maze doesn't need digonal
    //if (i > 0 && j > 0)
    //  neighbors.add(grid[i-1][j-1]);//lefet diognal
    
    //if (i < rows -1 && j < cols -1)
    //  neighbors.add(grid[i+1][j+1]);//right diognal
    
  }
  
}