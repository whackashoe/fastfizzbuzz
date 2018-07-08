CXXFLAGS:=-std=c++11 -O3 -march=native

all: bin/cpp-ffb \
	 bin/cpp-naive \
	 bin/cpp-counting \
	 bin/cpp-bitwise \
	 bin/asm-memcheat \
	 bin/asm-naive \
	 bin/asm-naive-parity \
	 bin/asm-addition-parity \
	 bin/asm-table \
	 bin/haskell-naive \
	 bin/rust-naive

bin/%: cpp/%.o
	$(CXX) $(CXXFLAGS) $< -o $@

bin/%: asm/%.o
	$(LD) $< -o $@

asm/%.o: asm/%.s
	$(AS) $< -o $@

bin/%: haskell/%.hs
	ghc $< -o $@

bin/%: rust/%.rs
	rustc $< -o $@

asm/memcheat.s: asm/memcheat_gen.py fizzbuzz.txt
	python asm/memcheat_gen.py > asm/memcheat.s

fizzbuzz.txt: bin/ffb
	./bin/ffb > fizzbuzz.txt

clean:
	$(RM) *.o haskell/*.o haskell/*.hi fizzbuzz.txt bin/*
