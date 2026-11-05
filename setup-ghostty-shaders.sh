#!/usr/bin/env bash
git clone --depth 1 https://github.com/hackr-sh/ghostty-shaders
git clone https://github.com/sahaj-b/ghostty-cursor-shaders
git clone https://github.com/KroneCorylus/ghostty-shader-playground.git
cp ghostty-shaders/*.glsl ghostty/.config/ghostty/shaders
cp ghostty-cursor-shaders/ghostty/*.glsl ghostty/.config/ghostty/shaders/cursor
cp ghostty-shader-playground/public/shaders/*.glsl ghostty/.config/ghostty/shaders/cursor
rm ghostty-shaders -rf
rm ghostty-cursor-shaders -rf
rm ghostty-shader-playground -rf
