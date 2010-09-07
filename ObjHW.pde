class ObjHW {
  //TODO: z buffer
  ControlP5 aController;
  PGraphics ptrScreen;
  private PGraphics _backBuffer;  //backbuffer a remonter dans objet controlleur (a creer?)
  private int selectionWeight= 2;
  private int contourWeight= 10;
  
  public color objColor;
  public boolean selected;
  
  public ObjTemplate head;
  public ObjTemplate queue;
  public ObjLink aLink;
  
 
  ObjHW( ControlP5 tController, PGraphics aScreen, PGraphics aBackBuffer) {
    ptrScreen = aScreen;
    _backBuffer = aBackBuffer;
    aController = tController;
    head = new ObjCir(200,200,50, this, aController);
    queue = new ObjArrow(200,200,40,this, aController);
    //queue = new ObjCir(200,250,20, this, aController);
    aLink = new ObjLink(200,200,200,250,10);
    objColor = color(255,220,0);
  }
  
  /*
  * Private
  */
  private void _drawObj(PGraphics aBuffer, int contourWeight, int typeBuffer) {
    if (head.selected) {
      head.center.x = mouseX;
      head.center.y = mouseY;
      aLink.processed = false;
    }
    if (queue.selected) {
      queue.center.x = mouseX;
      queue.center.y = mouseY;
      aLink.processed = false;
    }

    aLink.psrc1.x = head.center.x;
    aLink.psrc1.y = head.center.y;   
    aLink.psrc2.x = queue.center.x;
    aLink.psrc2.y = queue.center.y;
    
    aLink.drawIt(aBuffer, contourWeight, typeBuffer);    
    head.drawIt(aBuffer, contourWeight, typeBuffer);
    queue.drawIt(aBuffer, contourWeight, typeBuffer);
  } 
  
  private boolean _isSelectedBackBuffer(int x, int y) {
    color res;
    drawObjInBuffer();
    res = _backBuffer.get(x, y);
    //on parcourt la liste des composants
    println("_isSelectedBackBuffer");
    if ( color(head.id) == res ) {
      head.selected = true;
      println("head selected");
    }
    if ( color(queue.id) == res) {
      queue.selected = true;
      println("queue selected");
    }
    selected = queue.selected | head.selected;
    return selected;
  }

  private void _drawSelection(PGraphics aBuffer) {
    if(selected) {
      aBuffer.beginDraw();
      aBuffer.fill(255,0,0);
      _drawObj(aBuffer, contourWeight+selectionWeight, 0); 
      aBuffer.endDraw();
    }   
  }
  
  /*
  * Public
  */
  

  
  public boolean isSelected(int clickX, int clickY) {
    return _isSelectedBackBuffer(mouseX, mouseY);
  }
  
  public void drawIt(PGraphics aBuffer, color aColor, int typeBuffer) {    
    aBuffer.beginDraw();  
    aBuffer.pushStyle();
    aBuffer.noStroke();
    aBuffer.fill(0);
    _drawObj(aBuffer, contourWeight, typeBuffer);
    aBuffer.fill(aColor);
    _drawObj(aBuffer, 0, typeBuffer);
    aBuffer.popStyle();
    aBuffer.endDraw();
  }
  
  public void drawObj() {
    _drawSelection(ptrScreen);
    drawIt(ptrScreen, objColor, 0);
  }
  
  public void drawObjInBuffer() {
    drawIt(backBuffer, color(255) ,1);
  }
  
  public void setUnselected() {
    head.selected = false;
    queue.selected = false;
  }
  
  public void loadParametersUI() {
     aController.controller("headRadius").setValue(head.getObjSize());
     aController.controller("queueRadius").setValue(queue.getObjSize());
     aController.controller("red").setValue(red(objColor));
     aController.controller("green").setValue(green(objColor));
     aController.controller("blue").setValue(blue(objColor));
  }
  
  public void xml(StringBuilder tStrXml) {
     tStrXml.append("<objHW id='test'>");
     head.toXml(tStrXml);
     queue.toXml(tStrXml);
     tStrXml.append("</objHW>");
  }
  
}
