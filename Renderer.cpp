#include "Renderer.h"

/*
    Relating to SDL > Allow the SDL renderer to understand where to draw to

    This format was inspired by this video: https://www.youtube.com/watch?v=nvWDgBGcAIM&t 
    For future productions, I am more inclined to change the format for modularity.
*/
Renderer::Renderer(SDL_Window* _window, SDL_Renderer* _renderer)
    : renderer(_renderer){ // prefer member initializer list
    SDL_GetWindowSize(_window, &WindowSizeX, &WindowSizeY);
    printf("Initial window size: %d x %d\n", WindowSizeX, WindowSizeY);
}

// Sets up prerequisites for the scene, such as texture and positioning. 
void Renderer::init() {
    printf("Initializing...");
    dvdLogoTexture = loadTexture("./dvd_video.png");
    if (!dvdLogoTexture) {
        std::cerr << "Failed to load texture!\n";
    }

    // Centering the texture. The object is already based on center.
    dstRect = SDL_FRect{WindowSizeX / 2.0f, WindowSizeY / 2.0f, 100.0f, 100.0f};
}

// Creating textures
SDL_Texture* Renderer::loadTexture(const std::string& filePath) {
    SDL_Texture* texture = IMG_LoadTexture(renderer, filePath.c_str());
    if (!texture) {
        printf("Error loading texture: %s\n", SDL_GetError());
    }
    return texture;
}

// Free memory later on or clear what to draw..?
void Renderer::cleanup() {
    if (dvdLogoTexture) {
        SDL_DestroyTexture(dvdLogoTexture);
        dvdLogoTexture = nullptr;
    }
}

void Renderer::render() {
    // Compute Delta Time
    static auto previousTime = std::chrono::high_resolution_clock::now();
    auto currentTime = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsedTime = currentTime - previousTime;
    DeltaTime = elapsedTime.count();
    previousTime = currentTime;

    // Set up rendering background (white)
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, SDL_ALPHA_OPAQUE);
    SDL_RenderClear(renderer);

    SDL_SetTextureColorMod(dvdLogoTexture, 100, 0, 155); // Red tint

    static Pnt2d Vel = {25.0f, 25.0f};

    // Render the DVD logo if available
    if (dvdLogoTexture) {
        SDL_SetTextureColorMod(dvdLogoTexture, 255, 255, 255); // No color change
        SDL_RenderTexture(renderer, dvdLogoTexture, NULL, &dstRect);
    }

    printf("Rectx = %f, Recty = %f\n", dstRect.x, dstRect.y);
    checkWindowColl(dstRect, Vel, WindowSizeX, WindowSizeY);
    translateRect(dstRect, Vel, DeltaTime);

    // Present the rendered frame
    SDL_RenderPresent(renderer);
}
