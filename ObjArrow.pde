class ObjArrow extends ObjTemplate /*implements Comparable*/ {
  int arrowSize;
  boolean dragged=false;

  private PVector _tp1, _tp2, _tp3;

  ObjArrow(int tX1, int tY1, int aSize, ObjHW theParent, ControlP5 tController) {
    println("constructeur ObjArrow");
    super.aController = tController;
    parent = theParent; 
    arrowSize = aSize;
  }
  
  public ObjArrow(ObjTemplate anObj) {
    parent = anObj.parent;
    super.aController =  anObj.aController;
    center.x = (int)anObj.center.x;
    center.y = (int)anObj.center.y;
    arrowSize = anObj.getObjSize();
  }
  
  private void _draw(color tColor, int contour, PGraphics aBuffer){
    aBuffer.fill(tColor);
    ObjTemplate myMate = getMyMate();    
    if (myMate != null) {
      _processCoord(myMate.center, center, arrowSize+contour);
      aBuffer.beginDraw();
      aBuffer.noStroke();
      aBuffer.triangle(_tp1.x, _tp1.y,_tp2.x, _tp2.y,_tp3.x, _tp3.y);
      aBuffer.endDraw();
    }
  }

  private void _processCoord(PVector aP1, PVector aP2, int tSize) {
    PVector orthoVector, vSegment, aVector, arrowBase;
    vSegment = new PVector(aP2.x-aP1.x,aP2.y-aP1.y,0);
    orthoVector = _getOrthogonalVector(aP1, aP2);
    orthoVector.mult(tSize/2);
    aVector = vSegment;
    aVector.normalize();
    aVector.mult(tSize/2);
    arrowBase = PVector.sub(aP2, aVector);
    _tp1 = PVector.add(arrowBase, orthoVector);
    _tp2 = PVector.sub(arrowBase, orthoVector);
    aVector.normalize();
    aVector.mult(tSize/2);
    _tp3 = PVector.add(aP2, aVector );
    /*
    println("tp1:"+_tp1);
    println("tp2:"+_tp2);
    println("tp3:"+_tp3);
    */
  }
  
  public void render() {
    _draw(0, parent.contourWeight, parent.ptrScreen);
    _draw(parent.objColor, 0, parent.ptrScreen);
  }
  
  public void toXml(StringBuilder aSB) {
    aSB.append("<ObjArrow id='"+id+"'>");
    aSB.append("<arrowSize>"+arrowSize+"</arrowSize>");
    aSB.append("</ObjArrow>");
  }
  
  public void setObjSize(int aSize) {
    arrowSize = aSize; 
  }
  
  public int getObjSize() {
    return arrowSize; 
  }

}

