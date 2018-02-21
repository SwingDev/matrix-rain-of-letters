color maskR = color(255, 0, 0);
color maskG = color(0, 255, 0);
color maskB = color(0, 0, 255);
color black = color(0, 0, 0);

void setup() {
  size(1024, 1024); // tiling texture size
  blendMode(ADD); 
  rectMode(CENTER); // drawing shapes with center as pivot
  background(0);
  noLoop(); // We need only one frame
}
void draw() {
  int gap = 16; // same gap as in previous one
  // width needs to be little bit smaller
  int segmentWidth = 14; 

  for (int x = 0; x < width; x += gap) { // horizontal loop
    int segRandH = ((int)random(height-30)+30);
    int SegYpos =0+16*(int)random(height/16);
    if (x==0) { // repeat first segment to last
      makeRainSegment(0, SegYpos, segmentWidth, segRandH);
      makeRainSegment(width, SegYpos, segmentWidth, segRandH);
    } else {
      makeRainSegment(x, SegYpos, segmentWidth, segRandH);
    }
    if (segRandH>height/2) // for fast tails
    {
      if (x==0) {
        MakeSpeedBand(x, gap);
        MakeSpeedBand(width, gap);
      } else
        MakeSpeedBand(x, gap);
    }
  }
  saveFrame();
}

void makeRainSegment(int xPos, int yPos, int w, int h) {

  setGradient(xPos, yPos+w/2, w, h, maskR, black);
  makeSquare(xPos, yPos, w);

  setGradient(xPos, yPos+w/2-height, w, h, maskR, black);
  makeSquare(xPos, yPos-height, w);

  setGradient(xPos, yPos+w/2+height, w, h, maskR, black);
  makeSquare(xPos, yPos+height, w);
}
// generate smooth vertical gradient
void setGradient(int x, int y, float w, float h, color c1, color c2 ) {

  noFill();

  // top to bottom gradient
  for (int i = y; i >= y-h; i--) {
    float inter = map(i, y, y-h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    strokeWeight(1);
    stroke(c);
    line(x-w*0.5, i, x+w*0.5, i);
  }
}
void makeSquare(int xPos, int yPos, int w) {
  fill(maskG);
  strokeWeight(0);
  rect(xPos, yPos, w, w);
}
void MakeSpeedBand(int xPos, int gap) {
  fill(maskB);
  rect(xPos, height/2, gap, height);
}