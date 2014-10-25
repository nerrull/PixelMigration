ArrayList<String> imageList;
ArrayList<PixelAgent> agentArray;
String[] imagePaths;
ImageHandler imgHandler;
PixelManager pxlManager;

//Pixel Masking only for specific uses with directions
final int PIXEL_EXIT   =   0;                         //pixels disappear when they exit the frame
final int PIXEL_ENTER  =   1;                         //pixels appear after exiting the frame
final int PIXEL_NORMAL =   3;                         //default setting.
final int TRAVEL_MODE  = PIXEL_NORMAL; 


/***************** DRAWING MODES ********************/
final int POINT_MODE = 0;                             //Draws a point at current postion
final int LINE_MODE = 1;                              //Draws line from current position to destination
final int DRAW_MODE = POINT_MODE;

/*******************SORT COLOR*********************/
final static int  ALPHA = 24; 
final static int  RED   = 16;
final static int  GREEN = 8;
final static int  BLUE  = 0;
final int         COLOUR_MODE = GREEN;                 //Colour to sort pictures by

/***************** OTHER SETTINGS ***********************************************************/
final int         IMAGE_NUM        =2;                 //Number of images to be loaded
final int         MOD_FACTOR       = 1;                //Reduce number of pixelAgents
final int         NUM_ITERATIONS   = 60;               //Frames between images
final int         PAUSE_FRAMES     = 10;               //Frames added when images are formed
final Direction   PIXEL_DIRECTION  = Direction.FREE;   //UP, DOWN, LEFT, RIGHT, FREE
final int         RESIZE_FACTOR    = 1;                //Leave it at 1, doesn't work atm
final color       BACKGROUND_COLOR = color(0);         //Duh


boolean           RENDER_ON = true;                    //If you want frame saving to start on first frame
                                                       //Toggle with 's'
boolean           REFRESH_BACKGROUND = true;           //Refresh background every frame
                                                       //Toggle with 'b'



// IMPORTANT to set
final String      OUT_PATH = "results/EXPORT_FOLDER_NAME/";

void setPaths(){
  imagePaths = new String[IMAGE_NUM];
  imagePaths[0] = "source/Example/1.jpg";
  imagePaths[1] = "source/RobertRobert/2.jpg";
  //imagePaths[2] = "source/2.jpg";
  //imagePaths[3] = "source/4.jpg";
  //imagePaths[4] = "source/1.jpg";
}

void setup() {
    colorMode(RGB, 255, 255, 255);
    setPaths();
    background(BACKGROUND_COLOR);
    imgHandler = new ImageHandler(imagePaths, RESIZE_FACTOR);
    size(imgHandler.imageWidth, imgHandler.imageHeight);
    pxlManager = new PixelManager(imgHandler, MOD_FACTOR, NUM_ITERATIONS);
    frameRate(30);
}

void draw() {

  if (RENDER_ON){
    saveFrame(OUT_PATH + "f#########.png");
  }
  if (REFRESH_BACKGROUND)
  {
    background(BACKGROUND_COLOR);
  }
  pxlManager.update();
  println("FrameCount: "+frameCount);
  
}

void keyPressed(){
  if ( key == 's')
  {
    RENDER_ON = !RENDER_ON;
    println("render_ON toggle: " + RENDER_ON);
  }
  if ( key == 'b'){
    REFRESH_BACKGROUND = !REFRESH_BACKGROUND;
  }
}
