package p55Wall;

abstract class ObjTemplate /*implements Comparable*/ {
/*
	public ObjHW parent;
	  public PVector center;
	  public int id;  //hash key (used by backbuffer)
	  public ControlP5 aController;
	  boolean selected=false;
	  boolean processed=false;
	  
	  
	  ObjTemplate() {
	    println("constructeur ObjTemplate");
	    id = (int)random(255);
	    center = new PVector();
	    center.z = 0;
	  }
	  
	  //retourne le vecteur orthogonal a un vecteur definit par les 2 points en parametre
	  protected PVector _getOrthogonalVector(PVector src, PVector dest) {
	    float longueur;
	    PVector vOrtho = new PVector();
	    PVector vAxeZ = new PVector(0,0,-1);
	    PVector vSegment = new PVector(dest.x-src.x,dest.y-src.y,0);
	    longueur = vSegment.mag();
	    vSegment.normalize();
	    vAxeZ.normalize();
	    vOrtho = vSegment.cross(vAxeZ);
	    
	    // retour aux longueurs d'origine
	    vSegment.mult(longueur);
	    return vOrtho;
	  }
	  
	  
	  public int compareTo(Object anObjTemplate) {
	    int res=0;
	    ObjTemplate tObj= (ObjTemplate)anObjTemplate;
	    float zValue = tObj.center.z;
	     if ( this.center.z > zValue) {
	       res = 1;
	     }
	     if ( this.center.z < zValue) {
	       res = -1;
	     }
	     return res;
	  }
	  
	  public abstract void setObjSize(int aSize);
	  public abstract int getObjSize();
	  public abstract void drawIt(PGraphics aBuffer, int contour, int typeBuffer);
	  public abstract void toXml(StringBuilder aSB);
	  
	  
	  public ObjTemplate getMyMate() {
	    if ( parent.head == this) {
	      return parent.queue;
	    }
	    if ( parent.queue == this) {
	      return parent.head;
	    }
	   return null;
	  }
	  
	  public int compareTo(ObjArrow anObjTemplate) {
	    int res=0;
	     if ( this.center.z > anObjTemplate.center.z ) {
	       res = 1;
	     }
	     if ( this.center.z < anObjTemplate.center.z ) {
	       res = -1;
	     }
	     return res;
	  }
	*/  
	}
