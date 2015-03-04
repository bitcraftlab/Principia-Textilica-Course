public PVector normalize(PVector v){
  //v * 1/|v|
  if(lengthVector(v) > 0.0001){
    float lengthVec = 1/lengthVector(v);
    v.x *= lengthVec;
    v.y *= lengthVec;
    return v;
  }
  else return null;
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
  return new PVector(v1.x+=v2.x, v1.y+=v2.y);
}

public PVector interpolate(PVector from, PVector to, float t){
  return new PVector(from.x + t*(to.x-from.x), from.y + t*(to.y-from.y));
}

public PVector getReflectionVector(PVector v, PVector mirrorNormal){
  mirrorNormal = normalize(mirrorNormal);
  float sp = getScalarProduct(v, mirrorNormal);
  float x = v.x - 2*sp*mirrorNormal.x;
  float y = v.y - 2*sp*mirrorNormal.y;
  PVector result = new PVector(x,y);
  return result;
}

public PVector turn(PVector v, float alpha){
    PVector result = new PVector(v.x*cos(alpha) - v.y*sin(alpha), v.x*sin(alpha) + v.y*cos(alpha));
    result = normalize(result);
    /*float x = v.x*cos(alpha) - v.y*sin(alpha);
    float y = v.x*sin(alpha) + v.y*cos(alpha);
    v.x = x;
    v.y = y;
    v = normalize(v);
    return v;*/
    return result;
}
