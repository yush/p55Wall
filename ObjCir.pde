class ObjCir extends ObjTemplate {
  int x;
  int y;
  float radius;
  boolean selected=false;
  boolean dragged=false;
  //ControlP5 aController;
    
  /*
  * Constructeur
  */
  ObjCir(int tX, int tY, float tRad, ControlP5 tController) {
    super.aController = tController;
    x = tX;
    y = tY;
    radius = tRad;
  }
  
  public void setSelected(boolean tSelected) {
    if ((selected == true)  && (selected != tSelected)) {
      println("set selected radius:"+radius);
      aController.controller("headRadius").setValue(radius); 
    }
    selected = tSelected; 
  }
  
  /*
  * Private
  */
  private void _drawSelection(PGraphics aBuffer) {
    aBuffer.pushStyle();
    aBuffer.noFill();
    aBuffer.stroke(255,0,0);
    aBuffer.ellipse(x,y,radius,radius);
    aBuffer.popStyle();
  } 
  
  /*
  * PUBLIC
  */
  
  /*
  * dessine l'élement
  */
  public void drawIt(PGraphics aBuffer, int contour, int typeBuffer){
    if (typeBuffer ==  1) {
      aBuffer.fill(color(id));
    }
    aBuffer.beginDraw();
    aBuffer.noStroke();
    aBuffer.ellipse(x,y,radius+contour,radius+contour);
    aBuffer.endDraw();
  }
  
  public void xml(StringBuilder aSB) {
    aSB.append("<ObjCir id='"+id+"'>");
    aSB.append("<radius>"+radius+"</radius>");
    aSB.append("<position x='"+x+"' y='"+y+"'/>");
    aSB.append("</ObjCir>");
  }
  
}
  
