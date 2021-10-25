#define N 10
#define MAX 113

int array[N] = {90, 80, 70, 60, 5, 4, 3, 2, 1, MAX};

int getMax(int a[], int n){  
  int max = a[0];  
  for (int i = 1; i < n; i++)  
    if (a[i] > max)  
      max = a[i];  
  return max;  
}  

void bucket(int a[], int n){  
  int max = getMax(a, n); 
  int bucket[MAX];  
  for (int i = 0; i <= max; i++){  
    bucket[i] = 0;  
  }  
  for (int i = 0; i < n; i++){  
      bucket[a[i]]++;  
  }  
  for (int i = 0, j = 0; i <= max; i++){  
    while (bucket[i] > 0){  
        a[j++] = i;  
        bucket[i]--;  
    }  
  }  
}

int main( ){
    bucket(array,N);
    return 0;
}