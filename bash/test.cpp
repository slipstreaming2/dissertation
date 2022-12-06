#include <iostream>
#include <string>
#include <time.h>
#include <chrono>

using namespace std;
using namespace std::chrono;

// int main() {
//     string line;
//     clock_t start = clock();
//     while(!getline(cin, line).eof()) {
//         if(line[0] == '-') {
//             clock_t end = clock();
//             cout << start << " " << end << endl;
//             cout <<  (double) (end-start) / CLOCKS_PER_SEC * 1000.0 << endl;
//         }
//     }
//     return 0;
// }

int main() {
    string line;
    auto t1 = high_resolution_clock::now();
    while(!getline(cin, line).eof()) {
        if(line[0] == '-') {
            auto t2 = high_resolution_clock::now();
            cout << duration_cast<milliseconds>(t2-t1).count() << endl;
        }
    }
    return 0;
}

