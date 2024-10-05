CC = cc
TARGET = Main
SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, %.o,$(SRC))
 
$(TARGET): $(OBJ)
	$(CC) -o $@ $^
 
%.o: %.c
	$(CC) -c $< -o $@
 
.PHONY: clean
clean:
	rm -f *.o $(TARGET)
