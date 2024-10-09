CC = cc
TARGET = Main
SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, %.o,$(SRC))
 
$(TARGET): $(OBJ)
	$(CC) -o $@ $^
 
%.o: %.c
	$(CC) -c $< -o $@

test: $(TARGET)
	./$(TARGET)
 
clean:
	rm -f *.o $(TARGET)

.PHONY: clean test
