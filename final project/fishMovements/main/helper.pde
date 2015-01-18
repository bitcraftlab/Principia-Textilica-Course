public PVector normalize(PVector v){
  //v * 1/|v|
  float lengthVec = 1/lengthVector(v);
  v.x *= lengthVec;
  v.y *= lengthVec;
  return v;
}

public float lengthVector(PVector v){
  return sqrt(v.x* v.x + v.y*v.y);
}

public float distance(PVector p1, PVector p2){
  PVector temp = new PVector(p2.x-p1.x, p2.y-p1.y);
  return lengthVector(temp);
}

public float getAngle(PVector v1, PVector v2){ 
  return acos(  getScalarProduct(v1,v2) / (lengthVector(v1)*lengthVector(v2)) );
}

public float getScalarProduct(PVector v1, PVector v2){
  return (v1.x*v2.x + v1.y*v2.y);
}

public PVector add(PVector v1, PVector v2){
  /*v1.x += v2.x;
  v1.y += v2.y;
  return v1;*/
  return new PVector(v1.x+=v2.x, v1.y+=v2.y);
}
