final static int ALPHA = 24; 
final static int RED = 16;
final static int GREEN = 8;
final static int BLUE = 0;

float getColourValue(color c){
  if (COLOUR_MODE ==GREEN ){
    return ((c >>GREEN) &0xFF) +0.001* ((c >>RED) &0xFF)+ 0.000001 *((c >>BLUE) &0xFF);
  }
  if (COLOUR_MODE ==RED ){
    return ((c >>RED) &0xFF) +0.001* ((c >>GREEN) &0xFF)+ 0.000001*((c >>BLUE) &0xFF);
  } 
  if (COLOUR_MODE ==BLUE ){
   return ((c >>BLUE) &0xFF) +0.001* ((c >>RED) &0xFF)+ 0.000001*((c >>GREEN) &0xFF);
  }
  else{
    return 0.1;
  }  
}

void reversibleQuickSort(color arr[], int reverseArray[], int left, int right) {
  int index = reversiblePartition(arr,reverseArray, left, right);
  if (left < index - 1)
    reversibleQuickSort(arr,reverseArray, left, index - 1);
  if (index < right)
    reversibleQuickSort(arr, reverseArray, index, right);
}

int reversiblePartition(color arr[],int reverseArray[], int left, int right)
{
  int i = left, j = right;
  color tmp;
  int tmp2;
  double pivot = getColourValue(arr[(left + right) / 2]);

  while (i <= j) {
    while (getColourValue(arr[i]) < pivot)
      i++;
    while (getColourValue(arr[j]) > pivot)
      j--;
    if (i <= j) {
      tmp = arr[i];
      arr[i] = arr[j];
      arr[j] = tmp;

      tmp2 = reverseArray[i];
      reverseArray[i] = reverseArray[j];
      reverseArray[j] = tmp2;
      i++;
      j--;
    }
  };
  return i;
}


//Not used
/*int partition(color arr[], int left, int right)
{
  int i = left, j = right;
  color tmp;
  double pivot = getColourValue(arr[(left + right) / 2]);

  while (i <= j) {
    while (getColourValue(arr[i]) < pivot)
      i++;
    while (getColourValue(arr[j]) > pivot)
      j--;
    if (i <= j) {
      tmp = arr[i];
      arr[i] = arr[j];
      arr[j] = tmp;
      i++;
      j--;
    }
  };

  return i;
}

void quickSort(color arr[], int left, int right) {
  int index = partition(arr, left, right);
  if (left < index - 1)
    quickSort(arr, left, index - 1);
  if (index < right)
    quickSort(arr, index, right);
}

*/
