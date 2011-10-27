abstract class ObjTemplate implements Comparable {
  public ObjHW parent;
  public PVector center;
  public int id;  //hash key (used by backbuffer)
  public ControlP5 aController;
  boolean isSelected=false;
  boolean processed=false;
  
  /*
  TODO
    isSelected
  */
  
  ObjTemplate() {
    id = (int)random(255);
    center = new PVector();
    center.z = 0;
  }
  
  public color getObjColor() {
    return parent.objColor; 
  }
  
  public void setObjColor(color aColor) {
    parent.objColor = aColor; 
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
  
  
  public String toString() {
     StringBuilder aStr = new StringBuilder();
    aStr.append( this.getClass().getName()+"\r\n");
    aStr.append( "x:"+center.x+"\r\n");
    aStr.append( "y:"+center.y+"\r\n");
    aStr.append(" isSelected:"+ isSelected+"\r\n");
   return aStr.toString(); 
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
  
  public void loadParametersUI() {
     parent.theGUICtrl.ctrlControlP5.controller("size").setValue(this.getObjSize());
     parent.theGUICtrl.ctrlControlP5.controller("red").setValue(red(parent.objColor));
     parent.theGUICtrl.ctrlControlP5.controller("green").setValue(green(parent.objColor));
     parent.theGUICtrl.ctrlControlP5.controller("blue").setValue(blue(parent.objColor));
  }
  
  public boolean isAtPos(int x, int y) {
    color res;
    res = parent.theGUICtrl.backBuf.get(x,y);
    if (color(id) == res) {
      println("obj selected");
      return true;
    }
    return false;
  }
}
