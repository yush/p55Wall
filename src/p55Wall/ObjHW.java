package p55Wall;

import processing.core.*;
import controlP5.*;

public class ObjHW {
	  //TODO: z buffer
	  ControlP5 aController;
	  P55Wall pA;
	  PGraphics ptrScreen;
	  private PGraphics _backBuffer;  //backbuffer a remonter dans objet controlleur (a creer?)
	  private int selectionWeight= 2;
	  private int contourWeight= 10;
	  
	  public int objColor;
	  public boolean selected;
	  
	  public ObjTemplate head;
	  public ObjTemplate queue;
	  public ObjLink aLink;
	  
	 
	  ObjHW( P55Wall tWall,ControlP5 tController, PGraphics aScreen, PGraphics aBackBuffer) {
	    pA = tWall;
		ptrScreen = aScreen;
	    _backBuffer = aBackBuffer;
	    aController = tController;
	    head = new ObjCir(200,200,50, this, aController);
	    queue = new ObjArrow(200,200,40,this, aController);
	    //queue = new ObjCir(200,250,20, this, aController);
	    aLink = new ObjLink(200,200,200,250,10, this);
	    objColor = pA.color(255,220,0);
	  }
	  
	  
	  private void _drawObj( int contourWeight, int typeBuffer) {
	    if (head.selected) {
	      head.center.x = pA.mouseX;
	      head.center.y = pA.mouseY;
	      aLink.processed = false;
	    }
	    if (queue.selected) {
	      queue.center.x = pA.mouseX;
	      queue.center.y = pA.mouseY;
	      aLink.processed = false;
	    }

	    aLink.psrc1.x = head.center.x;
	    aLink.psrc1.y = head.center.y;   
	    aLink.psrc2.x = queue.center.x;
	    aLink.psrc2.y = queue.center.y;
	    
	    aLink.drawIt(pA, contourWeight, typeBuffer);    
	    head.drawIt(pA, contourWeight, typeBuffer);
	    queue.drawIt(pA, contourWeight, typeBuffer);
	  } 
	  
	  
	  private boolean _isSelectedBackBuffer(int x, int y) {
	    int res;
	    drawObjInBuffer();
	    res = _backBuffer.get(x, y);
	    //on parcourt la liste des composants
	    System.out.println("_isSelectedBackBuffer");
	    if ( pA.color(head.id) == res ) {
	      head.selected = true;
	      System.out.println("head selected");
	    }
	    if ( pA.color(queue.id) == res) {
	      queue.selected = true;
	      System.out.println("queue selected");
	    }
	    selected = queue.selected | head.selected;
	    return selected;
	  }

	  private void _drawSelection(PGraphics aBuffer) {
	    if(selected) {
	      aBuffer.beginDraw();
	      aBuffer.fill(255,0,0);
	      _drawObj( contourWeight+selectionWeight, 0); 
	      aBuffer.endDraw();
	    }   
	  }
	  
	  

	  
	  public boolean isSelected(int clickX, int clickY) {
	    return _isSelectedBackBuffer(pA.mouseX, pA.mouseY);
	  }
	  
	  public void drawIt(PGraphics aBuffer, int aColor, int typeBuffer) {    
	    aBuffer.beginDraw();  
	    aBuffer.pushStyle();
	    aBuffer.noStroke();
	    aBuffer.fill(0);
	    _drawObj( contourWeight, typeBuffer);
	    //aBuffer.fill(aColor);
	    aBuffer.fill(255);
	    aBuffer.popStyle();
	    aBuffer.endDraw();
	  }
	  
	  public void drawObj() {
	    _drawSelection(pA.g);
	    drawIt(pA.g, objColor, 0);
	  }
	  
	  public void drawObjInBuffer() {
	    drawIt(pA.backBuffer, pA.color(255) ,1);
	  }
	  
	  public void setUnselected() {
	    head.selected = false;
	    queue.selected = false;
	  }
	  
	  public void loadParametersUI() {
	     aController.controller("headRadius").setValue(head.getObjSize());
	     aController.controller("queueRadius").setValue(queue.getObjSize());
	     aController.controller("red").setValue(pA.red(objColor));
	     aController.controller("green").setValue(pA.green(objColor));
	     aController.controller("blue").setValue(pA.blue(objColor));
	  }
	  
	  public void xml(StringBuilder tStrXml) {
	     tStrXml.append("<objHW id='test'>");
	     head.toXml(tStrXml);
	     queue.toXml(tStrXml);
	     tStrXml.append("</objHW>");
	  }
}
