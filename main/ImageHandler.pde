class ImageHandler {
  ArrayList<PImage> imageList;
  ArrayList<int[]> reconstructionList; 

  int m_imageCount;
  int m_resizeFactor;
  int m_arraySize;
  public int imageWidth, imageHeight;

  ImageHandler (String[] imagePaths, int resizeFactor) {
    m_resizeFactor = resizeFactor;
    loadImages(imagePaths);
    generateReconstructionArrays();
    sortImages();
  }

  void loadImages(String[] imagePaths){
    imageList = new ArrayList<PImage>();
    m_imageCount = imagePaths.length;
    PImage tmpImage;
    String path;
    for (int i =0; i< m_imageCount; i++) {
      tmpImage = loadImage(imagePaths[i]);
      tmpImage.loadPixels();
      if (i == 0)
      {
        imageWidth =(int) (tmpImage.width/m_resizeFactor);
        imageHeight =(int) (tmpImage.height/m_resizeFactor);
        m_arraySize = imageWidth*imageHeight;
        println("Loading images");
        println("Dimensions: "+imageWidth + 'x'+ imageHeight);
        println("Array size:" + m_arraySize);
        if (m_arraySize > 1000000){
          println("Bigass picture, go grab some popcorn or something ");
        }
      }
      tmpImage.resize(imageWidth, imageHeight);
      imageList.add(tmpImage);
    }
  }

  void generateReconstructionArrays(){
    reconstructionList = new ArrayList<int[]>();
    int[] reconArray = new int[m_arraySize];
    for (int i = 0; i < m_arraySize; ++i) {
        reconArray[i] = i;    
    }
    for (int i = 0; i < m_imageCount; i++) {
      reconstructionList.add(reconArray.clone());
    }
  }

  void sortImages(){
    for (int i = 0; i < m_imageCount; ++i) {
       reversibleQuickSort(imageList.get(i).pixels, reconstructionList.get(i), 0, m_arraySize-1 );
    }
  }
}