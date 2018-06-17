# Miso space game
Simple space game in Haskell ([Miso frontend framework](https://haskell-miso.org/))

![GitHub Logo](/img/screen1.png)

## Setup
Please follow instructions for [Miso stack project](https://github.com/dmjio/miso#stack).

- Build project `stack build`.
- Run tests with `stack test`.
- Generate documentation with `stack haddock`.
- Last build of application is in `dist` directory

## Control

- Move up, down, left and right with arrows
- Shoot with space

## Description

- [x] Player has a space ship in the bottom of a screen and he can move it to the left and to the right.
- [x] There appears generated enemies in the top of a screen.
- [x] Number of generated enemies depends on level / time.
- [x] Score is equal to game time.
- [x] The aim is to stay alive as long as possible.
