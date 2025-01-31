#include "mechanics.h"


/*
    Rather than definining everything in render, we're going to pass direct references to my variables
    and edit them in this class. This means we need pointers * and &

*/

//Check if some object is colliding with the window Should be rext.x + rect.w/2 as an example check 
void checkWindowColl(SDL_FRect &rect, Pnt2d &Vel, int WinX, int WinY) {


    //Direct passing of Vel means we simply change it in here!
    if(rect.x + rect.w >= WinX || rect.x < 0) {
        Vel.x = -Vel.x; // pray to god this reacts quick enough
    } 
    if(rect.y + rect.h >= WinY || rect.y < 0) {
        Vel.y = -Vel.y;
    }

}   // This will be a seperate check from Translate, since it will prevent multiple calls of this.



// Translate a rectangle
void translateRect(SDL_FRect &rect, Pnt2d Vel, float DT) {
    rect.x += Vel.x * DT;
    rect.y += Vel.y * DT;

}






