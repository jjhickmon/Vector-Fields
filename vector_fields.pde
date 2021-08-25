int size = 500;
float x_max = 2;
float y_max = 2;
float x_num = 9; // the number of vetors on the x axis
float y_num = 9; // the number of vetors on the y axis
float l = 50;

void setup(){
  size(800, 600);
  frameRate(24);
  background(0);
  
  translate(400, 300);
  stroke(255);
  noFill();
  rect(-(size/2), -(size/2), size, size);
  line(0, -(size/2), 0, (size/2));
  line(-(size/2), 0, (size/2), 0);
  textSize(15);
  textAlign(CENTER, CENTER);
  text(Float.toString(-x_max), -(size/2) - 25, 0);
  text(Float.toString(x_max), (size/2) + 25, 0);
  text(Float.toString(-y_max), 0, -(size/2) - 15);
  text(Float.toString(y_max), 0, (size/2) + 15);
}

void draw(){
  plot();
  //rect(0, 0, (width/2)-(size/2), height);
  //rect((width/2)+(size/2)+1, 0, (width/2)+(size/2), height);
  //rect(0, 0, width, (height/2)-(size/2));
  //rect(0, (height/2)+(size/2)+1, width, (height/2)+(size/2));
}

void plot(){
  translate(400, 300);
  for(float x = -x_max; x <= x_max; x += ((x_max*2)/(x_num+1))){
    for(float y = -y_max; y <= y_max; y += ((y_max*2)/(y_num+1))){
      // the x and y components of the vector field F
      float i = -y;  // enter x function here
      float j = x;   // enter y function here
      if(!(i >= -x_max && i <= x_max && j >= -y_max && j <= y_max)){ continue; }
      float x0 = map(x, -x_max, x_max, -(size/2), (size/2));
      float y0 = map(y, -y_max, y_max, (size/2), -(size/2));
      float x1 = map(i, -x_max, x_max, -(size/2), (size/2));
      float y1 = map(j, -y_max, y_max, (size/2), -(size/2));
      
      if(x1 >= 0 && y1 >= 0){ // 1st quadrant
        float theta = atan(y1/x1);
        x1 = l*cos(theta);
        y1 = l*sin(theta);
      } else if (x1 <= 0 && y1 <= 0){ // 3rd quadrant
        circle(x1, y1, 5);
        float theta = atan(y1/x1)+PI;
        x1 = l*cos(theta);
        y1 = l*sin(0);
      } else if (x1 < 0 && y1 > 0){ // 2nd quadrant
        float theta = atan(y1/x1)+PI;
        x1 = l*cos(theta);
        y1 = l*sin(theta);
      } else if (x1 > 0 && y1 < 0){ // 4th quadrant
        float theta = atan(y1/x1)+TWO_PI;
        x1 = l*cos(theta);
        y1 = l*sin(theta);
      }
      
      float x2 = x0+x1;  // the new point after applying the vector
      float y2 = y0+y1;
      
      if(x2 >= -(size/2) && x2 <= (size/2) && y2 >= -(size/2) && y2 <= (size/2)+1){
        line(x0, y0, x2, y2);
        if(!(x0 == x2 && y0 == y2)){
          pushMatrix();
          translate(x2, y2);
          rotate(atan2(y2-y0, x2-x0));
          fill(255);
          triangle(0, 0, -10, 5, -10, -5);
          popMatrix(); 
        }
      }
    }
  }
}
