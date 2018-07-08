CXXFLAGS:=-std=c++11 -O3

all: bin/ffb \
	 bin/naive \
	 bin/counting \
	 bin/bitwise \
	 bin/memcheat \
	 bin/asm-naive \
	 bin/asm-naive-parity \
	 bin/asm-addition-parity

bin/%: cpp/%.o
	$(CXX) $(CXXFLAGS) $< -o $@

bin/%: asm/%.o
	$(LD) $< -o $@

asm/%.o: asm/%.s
	$(AS) $< -o $@

asm/memcheat.s: asm/memcheat_gen.py fizzbuzz.txt
	python asm/memcheat_gen.py > asm/memcheat.s

fizzbuzz.txt: bin/ffb
	./bin/ffb > fizzbuzz.txt

clean:
	$(RM) *.o fizzbuzz.txt bin/*
