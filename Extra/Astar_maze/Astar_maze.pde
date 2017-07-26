//maze generator including


import java.util.*;
import java.util.Stack;


int cols = 20;
int rows = 20;
int cellWidth, cellHeight;

Spot[][] grid = new Spot[rows][cols];


ArrayList<Spot> openSet = new ArrayList<Spot>();
ArrayList<Spot> closedSet = new ArrayList<Spot>();



Spot start, end, current;
boolean noSolution = false;


//maze
Spot mazeCurrent;
Stack stack = new Stack();

boolean finishMazeMake = false;

void setup() {
  size(800, 800);
  println("A*");
  //frameRate(20);
  cellWidth = width/cols;
  cellHeight = height/rows;
  
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = new Spot(i, j);
    }
  }
  
 // println(grid[0][0].neighbors);
  
  start = grid[0][0];
  end = grid[rows-1][cols-1];
  
  start.wall = false;
  end.wall = false;
  
  openSet.add(start);
  
  mazeCurrent = grid[0][0];
  
  noLoop();
  
} 

void mousePressed() {
  loop();
}

void draw() {
  
  if (finishMazeMake == true) {
    if (!openSet.isEmpty()) {
      //we can keep going
      int winner = 0;
      
      //the node in openset having the lowest fscore value
      for (int i = 0; i < openSet.size(); i++) {
        if (openSet.get(i).f < openSet.get(winner).f)
          winner = i;
      }
      
      current = openSet.get(winner);
      if (openSet.get(winner).equals(end)) {
        
        //find path
        noLoop();
        println("finish");
      }
      
      
      //openSet.remove(current);
      removeFromArray(openSet, current);
      closedSet.add(current);
      
      
      
      //for each neighbor of current
        ArrayList<Spot> neighbors = current.neighbors;
        
       for (int i = 0; i < neighbors.size(); i++) {
         Spot neighbor = neighbors.get(i);
         
         //the neighbor which is not in closedset
         if (!closedSet.contains(neighbor) && !neighbor.wall) {
           float tempG = current.g + 1;
           boolean newPath = false;
           if (openSet.contains(neighbor)) {
             if (tempG < neighbor.g) {
               neighbor.g = tempG;//this path is the best until
               newPath = true;
             }
           } else {//discover a new node
             neighbor.g = tempG;
             openSet.add(neighbor);
             newPath = true;
           }
           if (newPath) {
             neighbor.h = heuristic(neighbor, end);
             neighbor.f = neighbor.g + neighbor.h;
             neighbor.previous = current;
           }
         }
         
         
       }//end of for
      
      
    } else {
      //no solution;
      println("No path");
      noSolution = true;
      noLoop();
      return;
    }
  
    background(51);
  
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j].show(color(255));
      }
    }
    
    for (int i = 0; i < closedSet.size(); i++) {
      //closedSet.get(i).show(color(255,0,0));
    }
    
    for (int i = 0; i < openSet.size(); i++) {
      //openSet.get(i).show(color(0,255,0));
    }
      
     //path
     ArrayList<Spot> path = new ArrayList<Spot>();;
       Spot temp = current;
       path.add(temp);
          
       while (temp.previous != null) {
         path.add(temp.previous);
         temp = temp.previous;
       }  
     
      
    for (int i = 0; i < path.size(); i++) {
      //path.get(i).show(color(0, 0, 255));
    }
    
    noFill();
    stroke(255, 0, 200);
    strokeWeight(4);
    beginShape();
      for (int i = 0; i < path.size(); i++) {
        vertex(path.get(i).x*cellWidth+cellWidth/2,path.get(i).y*cellHeight+cellHeight/2); 
      }
    endShape();
    
    
  }// end of   if (finishMazeMake == true)
  
  else {
    background(51);
    
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          grid[i][j].show(color(255));
        }
      }
     mazeCurrent.visited = true;
     mazeCurrent.highlight();
     //step1
     
     Spot next = mazeCurrent.checkNeighbors();
    if (next != null) {
      next.visited = true;
      
      //step2 last implement
      //push the current cell to the stack
      stack .push(mazeCurrent);
      
      //step 3
      removeWalls(mazeCurrent, next);
      
      
      //step 4
      mazeCurrent = next;
    } else if (!stack.empty()) {
      //back tracking
      mazeCurrent =  (Spot)stack.pop();
    } else if (stack.empty()) {
      println("finish make maze");
      finishMazeMake = true;
      
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          grid[i][j].addNeighbors(grid);
        }
      }
      
      
      //noLoop();
      //return;
    }
  }// end of else
  
}

void removeWalls(Spot a, Spot b) {

    int x = a.x - b.x;
    int y = a.y - b.y;
    if (x == 1) {
      a.walls[3] = false;
      b.walls[1] = false;
    } else if (x == -1) {
      a.walls[1] = false;
      b.walls[3] = false;
    }

    if (y == 1) {
      a.walls[0] = false;
      b.walls[2] = false;
    } else if (y == -1) {
      a.walls[2] = false;
      b.walls[0] = false;
    }
}


float heuristic(Spot a, Spot b) {
  //float d = dist(a.x, a.y, b.x, b.y);
  float d = abs(a.x - b.x) + abs(a.y - b.y);
  return d;
}


void removeFromArray(ArrayList<Spot> arr, Spot elt) {
  for (int i = arr.size() - 1; i >=0; i--) {
    if (arr.get(i).equals(elt)) {
      arr.remove(i);
    }
  }
  
}