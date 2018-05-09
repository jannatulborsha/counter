#include<iostream>
#include "add.h"
#include "sub.h"

using namespace std;

int main(){
    int a, b, c;
    a = 20;
    b = 10;
    c = add(a,b);
    cout << c << endl;
    c = sub(a,b);
    cout << c << endl;
    return 0;
}