/* 
 * Uniform Distribution Simulation
 * Author: galaa
 * Created on February 25, 2011, 3:12 AM
 */

#include <cstdlib>
#include <iostream>
#include <ctime>

using namespace std;

int main ()
{
    cout << "a = "; float a; cin >> a; // Lower bound
    cout << "b = "; float b; cin >> b; // Upper bound
    cout << "n = "; int n; cin >> n; // Sample Size
    srand(time(NULL)); // Initialize random number generator.
    for (int i=1; i<=n; i++){
        cout << a+(b-a)*((float) rand()/RAND_MAX) << endl;
    }
    return 0;
}

