/* 
 * Geometric Distribution Simulation
 * Author: galaa
 * Created on February 25, 2011, 3:21 AM
 */

#include <cstdlib>
#include <iostream>
#include <ctime>

using namespace std;

int main()
{
    cout << "p = "; float p; cin >> p; // Parameter
    cout << "n = "; int n; cin >> n; // Sample Size
    srand(time(NULL)); // Initialize random number generator.
    for (int i = 1; i <= n; i++){
        float r = (float) rand()/RAND_MAX;
        float prob = p;
        float cum_prob = prob;
        int k = 1;
        while (cum_prob < r){
            prob *= 1 - p;
            cum_prob += prob;
            k++;
        }
        cout << k << endl;
    }
    return 0;
}

