all:
	g++ -I src/include -L src/lib -o main main.cpp -lmingw32 -lSDL3 -lSDL3_image
