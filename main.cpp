#include <stdio.h>
#include <SDL3/SDL.h>
#include <SDL3/SDL_image.h>

#include "Renderer.cpp"

#define SCREEN_WIDTH 1280
#define SCREEN_HEIGHT 720

int main(int argc, char** argv) {

    // SDL Initialization
    printf("Welcome to the program\n");
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }


    printf("Trying window creation\n");
    SDL_Window* window = SDL_CreateWindow("SDL Test", SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_OPENGL);
    if (!window) {
        printf("SDL_CreateWindow failed: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    printf("Trying renderer creation\n");
    SDL_Renderer* sdlrenderer = SDL_CreateRenderer(window, nullptr);
    if (!sdlrenderer) {
        printf("SDL_CreateRenderer failed: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    //This works with SDL to render what I have
    Renderer renderer(window, sdlrenderer);
    renderer.init();

    // Main loop
    bool running = true;
    while (running) {
        SDL_Event event;
        
        //Necessary to close and to allow for it to do other things without threads.
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_EVENT_QUIT) running = false;
        }
        renderer.render();
    }

    // Cleanup
    SDL_DestroyRenderer(sdlrenderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
