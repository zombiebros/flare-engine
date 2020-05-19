#!/bin/bash

rm -rf emscripten/*
mkdir -p emscripten

cp -r ../flare-game/mods/fantasycore mods/fantasycore
cp -r ../flare-game/mods/kalorian_quest mods/kalorian_quest

cmake .

EMCC_DEBUG=1 emcc \
	-v \
    -Isrc/ \
    src/*.cpp \
    -O3 \
    -s ASSERTIONS=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s USE_SDL=2 \
    -s USE_SDL_IMAGE=2 \
    -s SDL2_IMAGE_FORMATS='["png"]' \
    -s USE_SDL_TTF=2 \
    -s USE_SDL_MIXER=2 \
    -s "EXTRA_EXPORTED_RUNTIME_METHODS=['print','printErr']" \
    -lidbfs.js \
    --preload-file mods \
    -o emscripten/index.html

rm -rf mods/fantasycore
rm -rf mods/kalorian_quest

cp distribution/good_emscripten_template.html emscripten/index.html
