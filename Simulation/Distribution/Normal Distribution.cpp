/* 
 * Standard Normal Distribution Simulation
 * Author: galaa
 * Created on 2016/03/19 07:49:41
 */

#include <cstdlib>
#include <iostream>
#include <math.h>
#include <ctime>

using namespace std;

int main()
{
  cout << "n = "; int n; cin >> n; // Sample Size
  srand(time(NULL));
  for(int i=1; i<=n; i++){
    float u = (float)rand()/RAND_MAX;
    float r = (float)rand()/RAND_MAX;
    float v = -1*log(r);
    if(u<exp(-1*(v-1)*(v-1)/2)){
      if((float)rand()/RAND_MAX>0.5){
        cout << v << endl;
      }else{
        cout << -1*v << endl;
      }
    }else{
      i--;
    }
  }
  return 0;
}
