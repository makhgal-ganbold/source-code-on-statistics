/* 
 * File:   main.cpp
 * Author: galaa
 *
 * Created on February 25, 2011, 2:31 PM
 */

#include <cstdlib>
#include <iostream>
#include <ctime>
#include <math.h>

using namespace std;

/*
 * 
 */
int main(int argc, char** argv) {

    cout << "Мартингалын жишээ \n\n";
    cout << "Үүсгэх санамсаргүй утгын тоогоо заана уу\n";
    cout << "n = "; int n; cin >> n;
    srand(time(NULL)); // Initialize random number generator.
    cout << "X=X_1+...X_i :\n";
    const float PI = atan(1.0)*4;
    float x = 0;
    for (int i=1;i<=n/2;i++){
        float u1 = (float) rand()/RAND_MAX;
        float u2 = (float) rand()/RAND_MAX;
        x +=(float) sqrt(-2*log(u1))*cos(2*PI*u2);
        cout << x << endl;
        x +=(float) sqrt(-2*log(u1))*sin(2*PI*u2);
        cout << x << endl;
    }
    if(n%2){
        float u1 = (float) rand()/RAND_MAX;
        float u2 = (float) rand()/RAND_MAX;
        x +=(float) sqrt(-2*log(u1))*cos(2*PI*u2);
        cout << x << endl;
    }

    return 0;
}

