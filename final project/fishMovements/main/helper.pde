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
