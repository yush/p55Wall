class ObjCir extends ObjTemplate {
  int radius;
  boolean dragged=false;
  RShape shp1,shp2,shp3,shp4,shp5,shp6;
    
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
    _initShape();
  }
  
  public ObjCir(ObjTemplate anObj) {
    parent = anObj.parent;
    super.aController =  anObj.aController;
    center.x = (int)anObj.center.x;
    center.y = (int)anObj.center.y;
    radius = anObj.getObjSize();
    _initShape();
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
  
  private void _draw(color tColor, int contour, PGraphics aBuffer) {
    println("ObjCir.drawIt.buffer:"+aBuffer);
    println("center.x:"+center.x);
    println("contour:"+contour);
    aBuffer.beginDraw();
    aBuffer.fill(tColor);
    aBuffer.ellipse(center.x,center.y,radius+contour,radius+contour);
    aBuffer.endDraw();
  }
  
  private void _initShape() {
      //base
    shp1 = RShape.createCircle(center.x, center.y, radius+ parent.contourWeight);
    shp2 = RShape.createCircle(center.x, center.y, radius);
    
    //
    shp3 = RShape.createRectangle(center.x,center.y,20,200);    
    
    //calcule
    shp4 = RG.diff(shp1, shp2);
    shp5 = RG.intersection(shp3, shp4);
    shp6 = RG.union(shp2, shp5); 
  }
  
  private void _drawWithGeom(PGraphics tImageBuffer) {
    noStroke();    
    fill(parent.objColor);
    tImageBuffer.beginDraw();
    tImageBuffer.fill(CONTOUR_COLOR);
    shp1.draw(tImageBuffer);
    tImageBuffer.fill(parent.objColor);
    shp6.draw(tImageBuffer);
    tImageBuffer.endDraw();
  }
  
  private void _drawBufferWithGeom() {
    noStroke();    
    fill(color(id));
    backBuffer.beginDraw();
    backBuffer.fill(CONTOUR_COLOR);
    shp1.draw(backBuffer);
    backBuffer.endDraw();
  }
 
  
  /*
  * PUBLIC
  */
  
  /*
  * dessine l'élement
  */
  public void render() {
    /*
    _draw(0,parent.contourWeight, parent.ptrScreen);
    _draw(parent.objColor,0, parent.ptrScreen);
    */
    _drawWithGeom(imageBuffer);
    _drawBufferWithGeom();
  }
  


  public void setSelected(boolean tSelected) {
    if ((selected == true)  && (selected != tSelected)) {
      println("set selected radius:"+radius);
      aController.controller("headRadius").setValue(radius); 
    }
    selected = tSelected; 
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
  
