class ObjCir extends ObjTemplate {
  int radius;
  boolean dragged=false;
    
  /*
  * Constructeur
  */
  public ObjCir(int tX, int tY, int tRad, ObjHW theParent, ControlP5 tController) {
    println("constructeur ObjCir");
    parent = theParent;
    super.aController = tController;
    center.x = tX;
    center.y = tY;
    radius = tRad;
  }
  
  public ObjCir(ObjTemplate anObj) {
    parent = anObj.parent;
    super.aController =  anObj.aController;
    center.x = (int)anObj.center.x;
    center.y = (int)anObj.center.y;
    radius = anObj.getObjSize();
  }
  
  public void setSelected(boolean tSelected) {
    if ((isSelected == true)  && ( isSelected != tSelected)) {
      println("set selected radius:"+radius);
      aController.controller("headRadius").setValue(radius); 
    }
    isSelected = tSelected; 
  }
  
  /*
  * Private
  */
  private void _drawSelection(PGraphics aBuffer) {
    aBuffer.pushStyle();
    aBuffer.noFill();
    aBuffer.stroke(255,0,0);
    aBuffer.ellipse(center.x,center.y,radius,radius);
    aBuffer.popStyle();
  } 
  
  /*
  * PUBLIC
  */
  
  /*
  * dessine l'Ã©lement
  */
  public void drawIt(PGraphics aBuffer, int contour, int typeBuffer){
    if (typeBuffer ==  1) {
      aBuffer.fill(color(id));
    }
    aBuffer.beginDraw();
    aBuffer.noStroke();
    aBuffer.ellipse(center.x,center.y,radius+contour,radius+contour);
    aBuffer.endDraw();
  }
  
  public void toXml(StringBuilder aSB) {
    aSB.append("<ObjCir id='"+id+"'>");
    aSB.append("<radius>"+radius+"</radius>");
    aSB.append("<position x='"+center.x+"' y='"+center.y+"'/>");
    aSB.append("</ObjCir>");
  }
  
  public void setObjSize(int aSize) {
    radius = aSize; 
  }
  
  public int getObjSize() {
     return (int)radius;
  }
}
  

