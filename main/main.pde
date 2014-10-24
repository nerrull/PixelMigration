ArrayList<String> imageList;
ArrayList<PixelAgent> agentArray;
String[] imagePaths;
ImageHandler imgHandler;
PixelManager pxlManager;


int PIXEL_EXIT =0;
int PIXEL_ENTER = 1;
int PIXEL_NORMAL = 3;


Direction d;
final int         COLOUR_MODE = GREEN;
final int         IMAGE_NUM =2;
final int         MOD_FACTOR = 1;
final int         NUM_ITERATIONS = 60;
final int         PAUSE_FRAMES = 10;

final Direction   PIXEL_DIRECTION = d.FREE; 
final int         TRAVEL_MODE = PIXEL_NORMAL;

final int       RESIZE_FACTOR = 1;
boolean         RENDER_ON = true;
final String    OUT_PATH = "results/pastel_logo/";

void setPaths(){
  imagePaths = new String[IMAGE_NUM];
  imagePaths[0] = "source/RobertRobert/p.jpg";
  imagePaths[1] = "source/RobertRobert/r.jpg";
  //imagePaths[2] = "source/sean2/2.jpg";
  //imagePaths[3] = "source/sean/4.jpg";
  //imagePaths[4] = "source/sean/1.jpg";
}

void setup() {
    colorMode(RGB, 255, 255, 255);
    setPaths();
    imgHandler = new ImageHandler(imagePaths, RESIZE_FACTOR);
    size(imgHandler.imageWidth, imgHandler.imageHeight);
    pxlManager = new PixelManager(imgHandler, MOD_FACTOR, NUM_ITERATIONS);
       
    if (RENDER_ON){
      //saveFrame(OUT_PATH + "f#########.gif");
    }
    frameRate(30);
      background(0);
}
r
void draw() {

  if (RENDER_ON){
    saveFrame(OUT_PATH + "f#########.png");
  }
    background(0);
  pxlManager.update();
  println("FrameCount: "+frameCount);
  
}

void keyPressed(){
  if ( key == 's')
  {
    
    RENDER_ON = !RENDER_ON;
    println("render_ON toggle: " + RENDER_ON);
  }
    saveFrame("results/blog/f######.gif");
}
