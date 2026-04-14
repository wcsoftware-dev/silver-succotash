# Makefile for {{PROJECT_NAME}} project

CSC = csc

SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

all: $(BIN_DIR)/{{PROJECT_NAME}}.exe

$(BIN_DIR)/{{PROJECT_NAME}}.exe: $(SRC_DIR)/Program.cs
	mkdir -p $(BIN_DIR)
	$(CSC) -out:$(BIN_DIR)/{{PROJECT_NAME}}.exe $(SRC_DIR)/Program.cs

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)