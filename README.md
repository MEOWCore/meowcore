# MeowCore

Grand Theft Auto: San Andreas multiplayer framework derived from [Multi Theft Auto](https://www.multitheftauto.com/)
### Build Instructions
#### Windows
1. Execute `create-projects.bat`
2. Open `Build\MeowCore.sln`
3. Compile

#### Linux
1. Execute `utils/premake5_x86 gmake` (32-bit OS) or `utils/premake5_x64 gmake` (64-bit OS)
2. `cd Build`
3. Run `make config=release_x86` to build the 32-bit server and `make config=release_x64` to build the 64-bit server (or use `debug` instead of `release` to run an unoptimized debug build)

## License

Unless otherwise specified, all source code hosted on this repository is licensed under the GPLv3 license. See the LICENSE file for more details.

Grand Theft Auto and all related trademarks are © Rockstar North 1997 - 2016.
