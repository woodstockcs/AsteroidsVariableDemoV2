abstract class Floater
{
  protected int[] xCorners;
  protected int[] yCorners;
  protected int corners;  //the number of corners, a triangular floater has 3
  protected int myColor;
  protected double myCenterX, myCenterY; //holds center coordinates
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel
  protected double myPointDirection; //holds current direction the ship is pointing in degrees

  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();

  public void accelerate (double dAmount)
  {  
    //Accelerates the floater in the direction it is pointing
    //(myPointDirection)

    //convert the current direction the floater is pointing to radians
    double dRadians =myPointDirection*(Math.PI/180);

    //change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  void turn (int nDegreesOfRotation)
  {  
    //rotates the floater by a given number of degrees
    myPointDirection+=nDegreesOfRotation;
    if (myPointDirection < 0) myPointDirection+=360;
    if (myPointDirection > 360) myPointDirection-=360;
  }
  public void move ()
  {  
    //Moves the floater towards the coordinates
    //myDirectionX and myDirectionY

    //move the floater in the current direction of travel
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;

    //wrap around screen
    if (myCenterX >width) {
      myCenterX = 0;
    } else if (myCenterX<0) {
      myCenterX = width;
    }
    if (myCenterY >height) {
      myCenterY = 0;
    } else if (myCenterY < 0) {
      myCenterY = height;
    }
  }
  public void show (boolean isHyperspace, int countDown, boolean jets)
  {  
    //Draws the floater at the current position
    if (isHyperspace == false)
    {
      fill(myColor);
      stroke(myColor);
    } else
    {
      fill(255, 255, 255, 60 - countDown);
      stroke(255, 255, 255, 60 - countDown);
    }
    //convert degrees to radians for sin and cos     
    float dRadians = (float)(myPointDirection*(Math.PI/180));

    translate((float)myCenterX, (float)myCenterY);
    rotate(dRadians);
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    if(jets)
    {
      line(-12,-4,-20,-6);
      line(-12,0,-20,0);
      line(-12,4,-20,6);
    }

    endShape(CLOSE);

    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }
}