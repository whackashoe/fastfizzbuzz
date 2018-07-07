CXXFLAGS:=-std=c++11 -O3

all: ffb naive counting bitwise memcheat


memcheat.S: memcheat_gen.py fizzbuzz.txt
	python memcheat_gen.py > memcheat.S

fizzbuzz.txt: ffb
	./ffb > fizzbuzz.txt

memcheat.o: memcheat.S
	as memcheat.S -o memcheat.o

memcheat: memcheat.o
	ld memcheat.o -o memcheat

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
	rm *.o ffb naive counting bitwise memcheat
