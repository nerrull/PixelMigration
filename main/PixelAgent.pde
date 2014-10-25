class PixelAgent{
  ArrayList<PVector> m_destinations;
  color[] m_colors;
  PVector m_pos, m_origin, m_destination;
  color m_c;
  int m_colorCounter;
  boolean m_colorSwitched = false;
  float m_iterations = 50.0f;
  int m_iterCount =0;
  float incX, incY;

  Direction m_currentDirection;
  boolean m_onDestination = false;

  PixelAgent(PVector origin, ArrayList<PVector> destinations, color[] colors,int iterations){
    m_iterations = (float) iterations;
    m_origin = new PVector(origin.x, origin.y);
    m_destinations = destinations;
    m_destination = destinations.get(0);
    m_pos= new PVector(m_origin.x,m_origin.y);
    m_colors = colors;
    m_c = colors[0];
    m_colorCounter = 0;
    m_currentDirection = PIXEL_DIRECTION;
    if (TRAVEL_MODE == PIXEL_ENTER)
      m_c = color(0);
    draw();
  }

  void update(){
    checkLocation();
    move();
    draw();
  }

  void move(){
    getIncrement();
    moveX();
    moveY();
    m_iterCount++;
    }

  void getIncrement(){
    switch (m_currentDirection){
      case FREE :
        incX = abs(m_origin.x - m_destination.x)/m_iterations;
        incY = abs(m_origin.y - m_destination.y)/m_iterations;
      break;
      case RIGHT :
        incX = abs(width - m_origin.x + m_destination.x)/m_iterations;
        incY = abs(m_origin.y - m_destination.y)/m_iterations;
      break;
      case LEFT :
        incX = abs(m_origin.x + width - m_destination.x)/m_iterations;
        incY = abs(m_origin.y - m_destination.y)/m_iterations;
      break;
      case UP :
        incX = abs(m_origin.x - m_destination.x)/m_iterations;
        incY = abs(m_origin.y + height - m_destination.y)/m_iterations;
      break;
      case DOWN :
        incX = abs(m_origin.x - m_destination.x)/m_iterations;
        incY = (height + (m_destination.y - m_origin.y ))/m_iterations;
      break;
    }
  
    if(m_iterCount >= m_iterations)
    {
      if (!m_colorSwitched)
      {
        nextColour();
      }
      m_currentDirection = Direction.FREE;
      incX = abs(m_pos.x - m_destination.x);
      incY = abs(m_pos.y - m_destination.y);
    }
  }

  void moveX(){
    switch (m_currentDirection) {
      case FREE :
        moveXfree();
      break;
      case RIGHT :
        moveXright();
      break;
      case LEFT :
        moveXleft();
      break;
      case UP :
        moveXfree();
      break;  
      case DOWN :
        moveXfree();
      break;         
    }
  }

  void moveY(){
    switch (m_currentDirection) {
      case FREE :
        moveYfree();
      break;
      case RIGHT :
        moveYfree();
      break;
      case LEFT :
        moveYfree();
      break;
      case UP :
        moveYup();
      break;  
      case DOWN :
        moveYdown();
      break;      
    }
  }

  void moveXfree(){
      if (m_pos.x > m_destination.x){
        m_pos.x -= incX;
      }
      else if (m_pos.x < m_destination.x){
        m_pos.x += incX;
      }
  }

  void moveYfree(){
      if (m_pos.y > m_destination.y){
        m_pos.y -= incY;
      }
      else if (m_pos.y < m_destination.y){
        m_pos.y += incY;
      }
  }

  void moveXright(){
    float tmpX = m_pos.x;
    m_pos.x += incX;
    if(m_pos.x >= width){
      m_pos.x = incX -(width-tmpX);
      nextColour();
    }
  }

  void moveXleft(){
    float tmpX = m_pos.x;
    m_pos.x -= incX;
    if(m_pos.x < 0){
      m_pos.x = width - (incX -tmpX);
      nextColour();
    }
  }

  void moveYup(){
    float tmpY = m_pos.y;
    m_pos.y -= incY;
    if(m_pos.y < 0){
      m_pos.y = height - (incY - tmpY);
      nextColour();
    }
  }

  void moveYdown(){
    float tmpY = m_pos.y;
    m_pos.y += incY;
    if(m_pos.y >= height){
      m_pos.y = incY - (height-tmpY);
      nextColour();
    }
  }

  void draw(){
    stroke(m_c);
    if( DRAW_MODE == POINT_MODE)
      point(m_pos.x, m_pos.y);
    else if (DRAW_MODE == LINE_MODE)
      line(m_pos.x, m_pos.y, m_origin.x ,m_origin.y);
  }

  void checkLocation(){
    if (m_iterCount > m_iterations + PAUSE_FRAMES)
    {
      m_onDestination = true;
    }
  }

  void nextImage(){
    m_colorSwitched = false;
    m_currentDirection = PIXEL_DIRECTION;
    m_onDestination = false;
    m_iterCount = 0;

    m_origin = m_destinations.get(0);
    m_destinations.remove(0);
    m_destination = m_destinations.get(0);
  }

  void nextColour(){
    m_colorSwitched = true;
    m_colorCounter++;

    if (m_colorCounter >= m_colors.length)
      m_colorCounter = 0;
    m_c = m_colors[m_colorCounter];

    
    if (TRAVEL_MODE == PIXEL_EXIT)
      m_c = color(0);
  }
};
