
/// OUTPUT EMBROIDERY ///
// save embroidery in various file formats (dxf, pdf, png ...)

import processing.dxf.*;
import processing.pdf.*;

PGraphics og;
String writer;
String filename;
boolean output = false;

void beginOutput() {
  /*
  if (!output) return;
  output = false; writer = null;
  filename = selectOutput("Output Pa++ern");
  if(filename == null) return;
  output = true;
  String ext = filename.substring(filename.lastIndexOf('.') + 1, filename.length()).toLowerCase();
  if (ext.equals("pdf")) writer = PDF; 
  if (ext.equals("dxf")) writer = DXF;
  if (writer == null) return;
  beginRecord(writer, filename); 
  */

}

void endOutput() {
  /*
  if (!output) return;
  output = false;
  if (writer == null) { save(filename); return; }
  endRecord();
  */
}
