class ObjLink extends ObjTemplate {
  PVector pf1,pf2,pf3,pf4;    //coordonnées finale du rectangle
  PVector psrc1, psrc2;    //coordonnées du segment a suivre
  int weight;
  boolean processed;
  boolean dragged;
  
  private RShape shpMain;
  
  ObjLink(int tX1,int tY1,int tX2,int tY2,ObjHW tParent, int tWeight) {
    psrc1 = new PVector(tX1, tY1);
    psrc2 = new PVector(tX2, tY2);
    parent = tParent;
    weight = tWeight; 
    processed=false;
  }
  
  /*
  * determine les coordonnées du rectangle a partir de 2 points
  */
  private void processCoord(int contour) {
    PVector vOrtho;
    PVector vSegment = new PVector(psrc2.x-psrc1.x,psrc2.y-psrc1.y,0);
    vOrtho = _getOrthogonalVector(psrc1, psrc2);
    // orthogonal fait 1/2 epaisseur
    vOrtho.mult((weight+contour)/2);

    //recup coordonnées finales
    pf1 = PVector.add(psrc1, vOrtho);
    pf4 = PVector.sub(pf1, vOrtho);
    pf4.sub(vOrtho); 
    pf2 = PVector.add(pf1, vSegment);
    pf3 = PVector.add(pf4, vSegment);
    processed = true;
  }
    
  private void _draw(color tColor, int contour, PGraphics aBuffer) {
    processCoord(contour);  //TODO: ne recalculer que si necessaire, mais il faut calculer le contour, puis l'interieur
    aBuffer.beginDraw();
    aBuffer.fill(tColor);
    aBuffer.quad(pf1.x, pf1.y, pf2.x, pf2.y, pf3.x, pf3.y, pf4.x, pf4.y);
    aBuffer.endDraw();
  }
  
  private void _drawWithGeom() {
    int tHeight;
    //processCoord(contour);  //TODO: ne recalculer que si necessaire, mais il faut calculer le contour, puis l'interieur
    //dessiner polygone
    //shpMain = RShape.createRectangle();
  }
  
  /*
  * Public
  */
  
  public void render() {
    _draw(0, parent.contourWeight, parent.ptrScreen);
    _draw(parent.objColor, 0, parent.ptrScreen); 
  }

  
  public void setObjSize(int aSize) {
     
  }
  
  public int getObjSize() { 
    return 0;
  }

  public void toXml(StringBuilder aSB) {
    
  }
  
}
