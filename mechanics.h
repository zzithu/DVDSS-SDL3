#include <vector>
#include <iostream>

/*
    This class does imports and has the basic object declarations to be used elsewhere
*/

//Point in a 2d space, can be used as a vector. 
struct Pnt2d {
    double x, y;

    Pnt2d(double xVal = 0, double yVal = 0) : x(xVal), y(yVal) {}

    Pnt2d operator+(const Pnt2d& other) const {
        return Pnt2d(x + other.x, y + other.y);
    }
}; //Note for usage, SDL has a lot of built in support for rectangles and such, therefore its less likely that I manage my
//own clases when the resources exist. 

//Connection between 2 points, SDL does most of this so eh
struct Edge {
    int start, end;
};

/*
void checkWindowColl(SDL_FRect &rect, Pnt2d &Vel, int WinX, int WinY);
void translateRect(SDL_FRect &rect, Pnt2d Vel, float DT);
*/