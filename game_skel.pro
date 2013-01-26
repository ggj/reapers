TEMPLATE = app
CONFIG += console
CONFIG -= qt
CONFIG += glfw

INCLUDEPATH += ../seed/include ../seed/contrib

SOURCES += source/main.cpp \
	source/gameflow.cpp \
    source/states/credits_state.cpp \
    source/states/main_menu_state.cpp \
    source/states/options_state.cpp \
    source/states/game_pause_state.cpp \
    source/states/game_state.cpp \
    source/scenes/game_scene.cpp \
    source/data/game_data.cpp \
    source/game/WorldManager.cpp \
    source/game/PlayerEntity.cpp \
    source/game/EntityFactory.cpp \
    source/game/entity.cpp \
    source/states/game_run_state.cpp \
    source/game/physicsmanager.cpp

HEADERS += \
	source/gameflow.h \
    source/states/main_menu_state.h \
    source/states/credits_state.h \
    source/states/options_state.h \
    source/states/game_pause_state.h \
    source/states/game_state.h \
    source/scenes/game_scene.h \
    source/data/game_data.h \
    source/defines.h \
    source/game/WorldManager.h \
    source/game/PlayerEntity.h \
    source/game/EntityFactory.h \
    source/game/entity.h \
    source/states/game_run_state.h \
    source/game/physicsmanager.h

OTHER_FILES_CONFIG = \
#Configs
	resources/configs/app.config \
	resources/configs/game.config

OTHER_FILES_FONT = \
#Fonts
	resources/fonts/Delicious-Roman.otf \
	resources/fonts/Delicious-Italic.otf \
	resources/fonts/Delicious-Bold.otf \
	resources/fonts/Delicious-BoldItalic.otf

OTHER_FILES_SCENE = \
#Scenes
	resources/scenes/empty.scene \
	resources/scenes/game.scene \

OTHER_FILES_TEXTURE = \
#Textures
	resources/textures/rocket_invader.png \
	resources/textures/frame03.png \
	resources/textures/tile_map.png \
	resources/textures/player_idle_frame2.png \
	resources/textures/player_idle_frame1.png

#Gui
OTHER_FILES_GUI_STYLE = \
    #Styles
	resources/gui/styles/common.rcss \
	resources/gui/styles/window.rcss \

OTHER_FILES_GUI_VIEW = \
    #Views
	resources/gui/views/mainmenu.rml \
	resources/gui/views/window.rml \
	resources/gui/views/gameplay.rml \
	resources/gui/views/credits.rml \
	resources/gui/views/options.rml \
	resources/gui/views/game.rml \
	resources/gui/views/gamepause.rml

OTHER_FILES_SOUND = \
#Sounds
	resources/sounds/sfx.ogg \
	resources/sounds/theme.ogg
#Maps
OTHER_FILES_MAPS = \
resources/level1.json

OTHER_FILES += $${OTHER_FILES_CONFIG} \
	$${OTHER_FILES_FONT} \
	$${OTHER_FILES_SCENE} \
	$${OTHER_FILES_TEXTURE} \
	$${OTHER_FILES_GUI_STYLE} \
	$${OTHER_FILES_GUI_VIEW} \
        $${OTHER_FILES_SOUND} \
        $${OTHER_FILES_MAPS}

CONFIG(debug, debug|release) {
	DESTDIR = bin
	DEFINES += DEBUG
	LIBS += -L../seed/lib/debug
} else {
	DESTDIR = bin
	DEFINES += RELEASE
	LIBS += -L../seed/lib/release
}

unix:!macx {
	DEFINES += LINUX
	LIBS += -lseed -lseedcontrib -lGL -lopenal
	QMAKE_CXXFLAGS += -std=c++0x

	sdl {
		LIBS += -lSDL -lSDL_image
	}
}

macx {
	DEFINES += LINUX
	INCLUDEPATH += ../seed/contrib/osx/
	LIBS += -lseed -lseedcontrib -framework OpenAL -framework OpenGL -framework Cocoa -framework IOKit
	CONFIG -= sdl
	CONFIG += glfw

	#Configs
	APP_CONFIG_FILES.files = $$OTHER_FILES_CONFIG
	APP_CONFIG_FILES.path = Contents/Resources/configs
	#Fonts
	APP_FONT_FILES.files = $$OTHER_FILES_FONT
	APP_FONT_FILES.path = Contents/Resources/fonts
	#Scenes
	APP_SCENE_FILES.files = $$OTHER_FILES_SCENE
	APP_SCENE_FILES.path = Contents/Resources/scenes
	#Textures
	APP_TEXTURE_FILES.files = $$OTHER_FILES_TEXTURE
	APP_TEXTURE_FILES.path = Contents/Resources/textures
	#Gui
	    #Styles
	    APP_GUI_STYLE_FILES.files = $$OTHER_FILES_GUI_STYLE
	    APP_GUI_STYLE_FILES.path = Contents/Resources/gui/styles
	    #Views
	    APP_GUI_VIEW_FILES.files = $$OTHER_FILES_GUI_VIEW
	    APP_GUI_VIEW_FILES.path = Contents/Resources/gui/views
	#Sounds
	APP_SOUND_FILES.files = $$OTHER_FILES_SOUND
	APP_SOUND_FILES.path = Contents/Resources/sounds

	QMAKE_BUNDLE_DATA += APP_CONFIG_FILES APP_FONT_FILES APP_SCENE_FILES \
			APP_TEXTURE_FILES APP_GUI_STYLE_FILES APP_GUI_VIEW_FILES \
                        APP_SOUND_FILES APP_MAPS_FILES
	#Maps
	APP_MAPS_FILES.files = $$OTHER_FILES_MAPS
	APP_MAPS_FILES.path = Contents/Resources/
}

win32 {
	LIBS += -L../seed/contrib/windows/ -lseed -lseedcontrib -mwindows -lmingw32 -lopengl32 -lopenal32
	INCLUDEPATH += ../seed/contrib/windows/
	CONFIG -= glfw
	CONFIG += sdl
	sdl {
		DEFINES += WIN32 main=SDL_main
		LIBS += -lSDLmain -lSDL -lSDL_image -lgdi32
	}
}

glfw {
	DEFINES += BUILD_GLFW
} else:sdl {
	DEFINES += BUILD_SDL
}






















