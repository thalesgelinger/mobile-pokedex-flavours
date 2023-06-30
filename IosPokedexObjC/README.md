# Ios Objective C Pokedex

THE FUCKING HARDEST ONE

Notes about development:

- as i'm a vim user, i was working  to setup everthing works with hot reload and lsp, so my live would be easier
- to create i had to use xcode, there's no way, i couldn't find any cli to make it works
- for make it run, i had to learn about the xcode cli, so i created 3 scripts to help me
- on for build, one that will run the build and install ni the app and another to listem to changes in any .m file and rebuild everthing
- for lsp was trick, i already have my neovim setted up with lspzero, i was searching for any lsp with objc and i found the clangd
- it was recognizing pretty much everthing, but for some reason, the uikit lib was not being recognized, and it was just because, i didn't have
- the compile_commands.json, so for fixing that i had to install xcpretty with this line `sudo gem install xcpretty`
- and then run this command `xcodebuild clean build -project IosPokedexObjC.xcodeproj -scheme IosPokedexObjC -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 14 Pro Max' COMPILER_INDEX_STORE_ENABLE=NO | xcpretty -r json-compilation-database --output compile_commands.json
`
- then i created my .json file and the lsp worked as expected, now i'm read to really learn obj-c


- everty time i add a new file (.m and .h), i need to also add this file to compile sources
- it can be done with xcode, but i did the hard way, for making it by scratch i have to 
- create an uuid for the file and add the file, clean and build again
- but i added a script `add_file.rb` that receive the new file path
- for use it its just `ruby add_file.rb ./Project/NewFile.m`
- then just run `xcode clean`
- and then the buid script, and everhting should work
