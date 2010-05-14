class ObjArrow extends ObjTemplate {
  int arrowWidth, arrowHeight;
  boolean dragged=false;

  private PVector _tp1, _tp2, _tp3;
	private RPolygon arrowOutside, arrowInside;

  ObjArrow(int tX, int tY, int aHeight, int aWidth, ObjHW theParent, ControlP5 tController) {
    println("constructeur ObjArrow");
    super.aController = tController;
    parent = theParent; 
    center.x = tX;
    center.y = tY;
    arrowHeight = aHeight;
		arrowWidth = aWidth;
  }
  
  public ObjArrow(ObjTemplate anObj) {
    parent = anObj.parent;
    super.aController =  anObj.aController;
    center.x = (int)anObj.center.x;
    center.y = (int)anObj.center.y;
    arrowHeight = anObj.getObjSize();
		arrowWidth = anObj.getObjSize();
  }
 
	RPolygon _rectHole(PVector v1, PVector v2, int tContour, int tHeight)
	{
		PVector vOrth;
		RPoint pOrth, pStart, pEnd, pArrow, pContourSize, pContourHalfSize, pOffset;
		RPoint p1,p2,p3,p4;
		RContour aRectHole;

		pContourHalfSize = new RPoint(tContour/2, tContour/2);
		pContourSize = new RPoint(tContour, tContour);

		vOrth = _getOrthogonalVector(v1, v2);
		pOrth = new RPoint(vOrth.x, vOrth.y);
		pOrth.normalize();
		pOrth.scale(pContourSize);

		pStart = new RPoint(v1.x, v1.y);
		pEnd = new RPoint(v2.x, v2.y);
		pStart.sub(pEnd);
		pArrow = new RPoint(pStart);
		pArrow.normalize();
		pOffset = new RPoint(pArrow);	
		pArrow.scale(pContourSize);

		p1 = new RPoint(pEnd);
		pOffset.scale(new RPoint(tHeight/2,tHeight/2));
		p1.add(pOffset);
		pOffset = new RPoint(pOrth);
		pOffset.normalize();
		pOffset.scale(pContourHalfSize);
		pOffset.print();
		p1.sub(pOffset);
		p2 = new RPoint(p1);
		p2.add(pOrth);
		p3 = new RPoint(p2);
		p3.add(pArrow);
		p4 = new RPoint(p3);
		p4.sub(pOrth);

		aRectHole = new RContour();
		aRectHole.addPoint(p1);
		aRectHole.addPoint(p2);
		aRectHole.addPoint(p3);
		aRectHole.addPoint(p4);
		aRectHole.addClose();

		return aRectHole.toPolygon();
	}

	RPolygon _arrow( PVector vStart, PVector vEnd, int tWidth, int tHeight)
	{
		RPoint p1, p2, p3, pOrth, pArrow, pStart, pEnd;
		RPolygon ply;
		RContour ctr;
		PVector vOrth, vf1, vf2;

		pStart = new RPoint(vStart.x, vStart.y);
		pEnd = new RPoint(vEnd.x, vEnd.y);
		pStart.sub(pEnd);
		pArrow = new RPoint(pStart);
		pArrow.normalize();
		pArrow.scale(new RPoint(tHeight/2, tHeight/2));

		vOrth = _getOrthogonalVector(vStart, vEnd);
		pOrth = new RPoint(vOrth.x, vOrth.y);
		pOrth.normalize();

		p1 = new RPoint(vEnd.x, vEnd.y);
		p2 = new RPoint(p1);
		p3 = new RPoint(p1);
		pOrth.scale(new RPoint(tWidth/2,tWidth/2));
		p2.add(pOrth);
		p2.add(pArrow);
		p3.sub(pOrth);
		p3.add(pArrow);

		p1.sub(pArrow);

		ctr = new RContour();
		ctr.addPoint(p1);
		ctr.addPoint(p2);
		ctr.addPoint(p3);
		ctr.addClose();

		ply = ctr.toPolygon();
		return ply;
	}

 	private void _processArrowPolygon() {
		int contour=10;
		RPolygon aRectHole;
		PVector vTmp1, vTmp2;
		ObjTemplate myMate = getMyMate();
		if (myMate != null) 
		{		
			vTmp1 = new PVector(200,200);
			vTmp2 = new PVector(250,300);
			arrowOutside = _arrow(myMate.center, center, arrowWidth, arrowHeight);
			arrowInside = _arrow( myMate.center, center, arrowWidth-contour, arrowHeight-contour);
			aRectHole = _rectHole(myMate.center, center, contour*2, contour*2);
			arrowInside = arrowInside.union(aRectHole);
		}
	}

  private void _drawWithGeom()
  {
		_processArrowPolygon();
		if (parent.ptrScreen != null) 
		{
			parent.ptrScreen.fill(0);
	  	arrowOutside.draw(parent.ptrScreen);
			parent.ptrScreen.fill(parent.objColor);
			arrowInside.draw(parent.ptrScreen);
		}
  }
  
  public void render() {
		_drawWithGeom();
  }
  
  public void toXml(StringBuilder aSB) {
    aSB.append("<ObjArrow id='"+id+"'>");
    aSB.append("<arrowSize>"+arrowHeight+"</arrowSize>");
    aSB.append("</ObjArrow>");
  }
  
  public void setObjSize(int aSize) {
    arrowHeight = aSize; 
  }
  
  public int getObjSize() {
    return arrowHeight; 
  }

}

