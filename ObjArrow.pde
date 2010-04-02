class ObjArrow extends ObjTemplate {
  //modification de l'angle de la fleche
  PVector p1;  //center of the arrow
  PVector p2;
  int arrowSize;
  boolean selected=false;
  boolean dragged=false;
  boolean processed = false;

  private PVector _tp1, _tp2, _tp3;

  ObjArrow(int tX1, int tY1, int tX2, int tY2, int aSize, ControlP5 tController) {
    super.aController = tController;
    p1 = new PVector(tX1, tY1);
    p2 = new PVector(tX2, tY2);  
    arrowSize = aSize;
  }

  private void processCoord(PVector aP1, PVector aP2, int tSize) {
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
    //aVector = vSegment;
    aVector.normalize();
    aVector.mult(tSize/2);
    _tp3 = PVector.add(aP2, aVector );
    println("tp1:"+_tp1);
    println("tp2:"+_tp2);
    println("tp3:"+_tp3);
  }

  public void drawIt(PGraphics aBuffer, int contourWeight, int typeBuffer){
    if (typeBuffer ==  1) {
      aBuffer.fill(color(id));
    }
    processCoord(p1, p2, arrowSize+contourWeight);
    aBuffer.beginDraw();
    aBuffer.noStroke();
    aBuffer.triangle(_tp1.x, _tp1.y,_tp2.x, _tp2.y,_tp3.x, _tp3.y);
    aBuffer.endDraw();
  }

}

