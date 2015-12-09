class PixelManager {
  ImageHandler m_imageHandler;
  ArrayList<PixelAgent> m_agentArray;
  int m_modFactor;
  int m_numIterations;
  boolean m_switchImageTrigger = false;
  boolean m_fade_trigger = false;

  public PixelManager (ImageHandler imgHandler, int modFactor,int numIterations) {
    m_imageHandler = imgHandler;
    m_modFactor = modFactor;
    m_numIterations = numIterations;
    generatePixelAgents();
  }

  public void generatePixelAgents(){
    m_agentArray = new ArrayList<PixelAgent>();
    color tmp_c;
    int o_pos, d_pos;
    PVector origin, dest;
    float x,y;
    PImage sourceImg = imgHandler.imageList.get(0);
    sourceImg.loadPixels();

    for (int n = 0; n < imgHandler.m_arraySize; ++n) 
    {
      ArrayList<PVector> destinations = new ArrayList<PVector>();
      color[] colors = new color[IMAGE_NUM];
      if (n%m_modFactor ==0)
      {
        o_pos = imgHandler.reconstructionList.get(0)[n];
        x = o_pos%imgHandler.imageWidth;
        y = (int)(o_pos/imgHandler.imageWidth);
        origin= new PVector(x,y);
        colors[0] = imgHandler.imageList.get(0).pixels[n] + 0xFF000000;

        for (int i = 1; i < imgHandler.m_imageCount; i++) {
          d_pos = imgHandler.reconstructionList.get(i)[n];
          x = d_pos%imgHandler.imageWidth;
          y = (int)(d_pos/imgHandler.imageWidth);
          dest= new PVector(x,y);
          PImage img = imgHandler.imageList.get(i);
          img.loadPixels();
          colors[i] = img.pixels[n] + 0xFF000000;
          destinations.add(dest);
        }

        m_agentArray.add(new PixelAgent(origin,destinations,colors, m_numIterations));
      }
    } 

    //println("Number of pixel agents : " + m_agentArray.length());
  }

  int fadeCounter =0;
  int iterCount =0;
  boolean  next_triggered =false;
  public void update() {
    boolean onDest = true;

    if (REFRESH_BACKGROUND && iterCount <= m_numIterations)
    {
      background(BACKGROUND_COLOR);
    }
    if (!(iterCount > m_numIterations + FADE_FRAMES) || m_switchImageTrigger)
      for (PixelAgent pa : m_agentArray) {
        if (next_triggered){
          pa.nextColour();
        }
        if (m_switchImageTrigger){
          pa.nextImage();
        }

        if (iterCount >= m_numIterations )
        {
          if( iterCount < m_numIterations +FADE_FRAMES)
          {
            pa.fadeColour(iterCount - m_numIterations, FADE_FRAMES);
            continue;
          }
        }
    
      pa.update();

    }



    if (next_triggered)
    {
      next_triggered = false;
    }

    if (m_switchImageTrigger)
    {
      m_switchImageTrigger = false;
    }

    if (iterCount == (m_numIterations +FADE_FRAMES -1)){
        print("next_colour loaded");
        next_triggered =true;
    } 


    if (iterCount > m_numIterations + FADE_FRAMES +PAUSE_FRAMES)
      {
        println("next_image triggered ");
        m_switchImageTrigger = true;
        iterCount=0;
        return;
    }
    iterCount +=1;

  }
  
}
