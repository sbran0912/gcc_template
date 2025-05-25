########################################################################
####################### Makefile Template ##############################
########################################################################

# DEBUG or RELEASE
BUILD_MODE ?= DEBUG

# Project structur
EXT = .c
SRCDIR = src
OBJDIR = obj
SRC = $(wildcard $(SRCDIR)/*$(EXT))
OBJ = $(SRC:$(SRCDIR)/%$(EXT)=$(OBJDIR)/%.o)


ifeq ($(OS),Windows_NT)
	PLATFORM_OS=WINDOWS
else
	PLATFORM_OS=LINUX
endif

ifeq ($(PLATFORM_OS),WINDOWS)
	APPNAME = main.exe
else
	APPNAME = main.app
endif

# Define Compiler flags:
echo "BUILD_MODE = $(BUILD_MODE)"
CFLAGS = -Wall -std=c11
ifeq ($(BUILD_MODE),DEBUG)
    CFLAGS += -g -O0
else
    CFLAGS += -s -O1
endif
# Define Linker flags:
ifeq ($(PLATFORM_OS),WINDOWS)
	LFLAGS = -lraylib -lopengl32 -lgdi32 -lwinmm
else
	LFLAGS = -lraylib -lGL -lm -lpthread -ldl -lrt
endif

########################################################################
####################### Targets beginning here #########################
########################################################################

all: $(APPNAME)

# Builds the app
$(APPNAME): $(OBJ)
	gcc -o $@ $^ $(LFLAGS)

# Building rule for .o files and its .c/.cpp in combination with all .h
$(OBJDIR)/%.o: $(SRCDIR)/%$(EXT)
	gcc $(CFLAGS) -o $@ -c $<

clean:
	rm $(OBJDIR)/*.o
	rm $(APPNAME)

