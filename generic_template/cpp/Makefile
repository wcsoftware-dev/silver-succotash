# Makefile for {{PROJECT_NAME}} project

CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17

SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

all: $(BIN_DIR)/{{PROJECT_NAME}}

$(BIN_DIR)/{{PROJECT_NAME}}: $(BUILD_DIR)/main.o
	mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $(BIN_DIR)/{{PROJECT_NAME}} $(BUILD_DIR)/main.o

$(BUILD_DIR)/main.o: $(SRC_DIR)/main.cpp {{PROJECT_NAME}}.h
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $(SRC_DIR)/main.cpp -o $(BUILD_DIR)/main.o

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)