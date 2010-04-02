class ObjTemplate {
  public int id;  //hash key (used by backbuffer)
  public ControlP5 aController;
  
  /*
  TODO
    isSelected
  */
  
  ObjTemplate() {
    id = (int)random(255);
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
  
}
