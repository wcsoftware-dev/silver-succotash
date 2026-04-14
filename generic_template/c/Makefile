# Makefile for {{PROJECT_NAME}} project

CC = gcc
CFLAGS = -Wall -Wextra -std=c11

BUILD_DIR = build
BIN_DIR = bin

all: $(BIN_DIR)/{{PROJECT_NAME}}

$(BIN_DIR)/{{PROJECT_NAME}}: $(BUILD_DIR)/main.o
	mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(BIN_DIR)/{{PROJECT_NAME}} $(BUILD_DIR)/main.o

$(BUILD_DIR)/main.o: main.c {{PROJECT_NAME}}.h
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c main.c -o $(BUILD_DIR)/main.o

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)