/* 
 * Exponentional Distribution Simulation
 * Author: galaa
 * Created on February 25, 2011, 3:18 AM
 */

#include <cstdlib>
#include <iostream>
#include <math.h>
#include <ctime>

using namespace std;

int main()
{
    cout << "L = "; float L; cin >> L; // Parameter
    cout << "n = "; int n; cin >> n; // Sample Size
    srand(time(NULL)); // Initialize random number generator.
    for(int i=1; i<=n; i++){
        cout << -1*log((float)rand()/RAND_MAX)/L << endl;
    }
    return 0;
}

