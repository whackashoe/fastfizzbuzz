CXXFLAGS:=-std=c++11 -O3

all: ffb naive counting bitwise mem


mem.S: mem_gen.py fizzbuzz.txt
	python mem_gen.py > mem.S

fizzbuzz.txt: ffb
	./ffb > fizzbuzz.txt

mem.o: mem.S
	as mem.S -o mem.o

mem: mem.o
	ld mem.o -o mem

ffb: ffb.o
	$(CXX) $(CXXFLAGS) ffb.o -o ffb

ffb.o: ffb.cpp
	$(CXX) $(CXXFLAGS) -c ffb.cpp

naive: naive.o
	$(CXX) $(CXXFLAGS) naive.o -o naive

naive.o: naive.cpp
	$(CXX) $(CXXFLAGS) -c naive.cpp

counting: counting.o
	$(CXX) $(CXXFLAGS) counting.o -o counting

counting.o: counting.cpp
	$(CXX) $(CXXFLAGS) -c counting.cpp

bitwise: bitwise.o
	$(CXX) $(CXXFLAGS) bitwise.o -o bitwise

bitwise.o: bitwise.cpp
	$(CXX) $(CXXFLAGS) -c bitwise.cpp

clean:
	rm *.o ffb naive counting bitwise mem
