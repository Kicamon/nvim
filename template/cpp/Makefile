CXX = g++
TARGET = Main
SRC = $(wildcard *.cpp)
OBJ = $(patsubst %.cpp, %.o,$(SRC))
 
CXXLAGS = -c -Wall
 
$(TARGET): $(OBJ)
	$(CXX) -o $@ $^
 
%.o: %.cpp
	$(CXX) $(CXXLAGS) $< -o $@

test: $(TARGET)
	./$(TARGET)
 
clean:
	rm -f *.o $(TARGET)

.PHONY: clean test
