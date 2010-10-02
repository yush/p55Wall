

package p55Wall;

import processing.core.*;
import controlP5.*;

public class ObjCir extends ObjTemplate{
	  int radius;
	  boolean dragged=false;
	    
	  /*
	  * Constructeur
	  */
	  
	  public ObjCir(int tX, int tY, int tRad, ObjHW theParent, ControlP5 tController) {
	    super(theParent);
		System.out.println("constructeur ObjCir");
	    parent = theParent;
	    super.aController = tController;
	    center.x = tX;
	    center.y = tY;
	    radius = tRad;
	  }
	  
	  public ObjCir(ObjTemplate anObj) {
	    super(anObj.parent);
	    super.aController =  anObj.aController;
	    center.x = (int)anObj.center.x;
	    center.y = (int)anObj.center.y;
	    //radius = anObj.getObjSize();
	  }
	  
	  public void setSelected(boolean tSelected) {
	    if ((selected == true)  && (selected != tSelected)) {
	      System.out.println("set selected radius:"+radius);
	      aController.controller("headRadius").setValue(radius); 
	    }
	    selected = tSelected; 
	  }
	  
	  private void _drawSelection(PGraphics aBuffer) {
	    aBuffer.pushStyle();
	    aBuffer.noFill();
	    aBuffer.stroke(255,0,0);
	    aBuffer.ellipse(center.x,center.y,radius,radius);
	    aBuffer.popStyle();
	  } 
	  
	  //dessine l'Žlement

	  public void drawIt(P55Wall tWall, int contour, int typeBuffer){
	    if (typeBuffer ==  1) {
	      tWall.g.fill(tWall.color(id));
	    }
	    tWall.g.beginDraw();
	    tWall.g.noStroke();
	    tWall.g.ellipse(center.x,center.y,radius+contour,radius+contour);
	    tWall.g.endDraw();
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
