#include "mechanics.cpp"

#include <chrono>
#include <SDL3/SDL.h>
#include <SDL3/SDL_image.h>

/*
    This class manages edges and points to create an image

*/

class Renderer{
    public:
        Renderer(SDL_Window *_window, SDL_Renderer *_renderer);
        SDL_Texture* loadTexture(const std::string& filePath);
        void cleanup();
        void render();
        void init();
        SDL_Texture* dvdLogoTexture;

    
    private:
        float rotation = 0.0f;
        float DeltaTime = 0.0f;
        
        SDL_FRect dstRect;

        int WindowSizeX;
        int WindowSizeY;
        SDL_Renderer* renderer;


        std::vector<Pnt2d> points;
        std::vector<Edge> edges;

};
