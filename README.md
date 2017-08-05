fastfizzbuzz
===

What is the fastest we can optimize FizzBuzz to 1 million to?

The approach I took is able to operate in approximately 1/5th the time of a normally implemented FizzBuzz.

## Building

`make`

---

note: requires C++11 enabled compiler


## perf stat

 Performance counter stats for './ffb':

         17.991315 task-clock (msec)         #    0.961 CPUs utilized          
                 4 context-switches          #    0.222 K/sec                  
                 0 cpu-migrations            #    0.000 K/sec                  
               141 page-faults               #    0.008 M/sec                  
         5,544,876 cycles                    #    0.308 GHz                    
           921,276 stalled-cycles-frontend   #   16.61% frontend cycles idle   
         3,699,572 stalled-cycles-backend    #   66.72% backend  cycles idle    [66.59%]
        67,914,074 instructions              #   12.25  insns per cycle        
                                             #    0.05  stalled cycles per insn [74.96%]
        19,075,304 branches                  # 1060.251 M/sec                   [77.97%]
           239,209 branch-misses             #    1.25% of all branches         [77.97%]
        21,320,426 L1-dcache-loads           # 1185.040 M/sec                   [56.04%]
            98,541 L1-dcache-load-misses     #    0.46% of all L1-dcache hits   [34.07%]
           250,090 LLC-loads                 #   13.901 M/sec                   [12.03%]
     <not counted> LLC-load-misses         
     <not counted> L1-icache-loads         
     <not counted> L1-icache-load-misses   
     <not counted> dTLB-loads              
     <not counted> dTLB-load-misses        
     <not counted> iTLB-loads              
     <not counted> iTLB-load-misses        
     <not counted> L1-dcache-prefetches    
     <not counted> L1-dcache-prefetch-misses

       0.018727128 seconds time elapsed


 Performance counter stats for './naive':

         83.204834 task-clock (msec)         #    0.990 CPUs utilized          
                18 context-switches          #    0.216 K/sec                  
                 3 cpu-migrations            #    0.036 K/sec                  
               360 page-faults               #    0.004 M/sec                  
       256,535,764 cycles                    #    3.083 GHz                     [15.80%]
        10,449,295 stalled-cycles-frontend   #    4.07% frontend cycles idle    [19.99%]
        66,859,789 stalled-cycles-backend    #   26.06% backend  cycles idle    [18.59%]
       363,870,500 instructions              #    1.42  insns per cycle        
                                             #    0.18  stalled cycles per insn [23.30%]
        80,907,450 branches                  #  972.389 M/sec                   [28.09%]
           610,887 branch-misses             #    0.76% of all branches         [32.87%]
       196,035,912 L1-dcache-loads           # 2356.064 M/sec                   [28.07%]
            12,719 L1-dcache-load-misses     #    0.01% of all L1-dcache hits   [62.50%]
           295,527 LLC-loads                 #    3.552 M/sec                   [55.72%]
             1,400 LLC-load-misses           #    0.47% of all LL-cache hits    [50.15%]
        55,510,005 L1-icache-loads           #  667.149 M/sec                   [18.23%]
           441,185 L1-icache-load-misses     #    0.79% of all L1-icache hits   [16.72%]
       141,742,768 dTLB-loads                # 1703.540 M/sec                   [23.15%]
                93 dTLB-load-misses          #    0.00% of all dTLB cache hits  [21.51%]
        95,824,307 iTLB-loads                # 1151.668 M/sec                   [20.07%]
                 0 iTLB-load-misses          #    0.00% of all iTLB cache hits  [12.55%]
            12,456 L1-dcache-prefetches      #    0.150 M/sec                   [11.81%]
                 0 L1-dcache-prefetch-misses #    0.000 K/sec                   [11.16%]

       0.084004282 seconds time elapsed


 Performance counter stats for './counting':

         77.789678 task-clock (msec)         #    0.993 CPUs utilized          
                 7 context-switches          #    0.090 K/sec                  
                 1 cpu-migrations            #    0.013 K/sec                  
               360 page-faults               #    0.005 M/sec                  
       314,528,148 cycles                    #    4.043 GHz                     [15.81%]
        11,362,285 stalled-cycles-frontend   #    3.61% frontend cycles idle    [17.85%]
        47,541,090 stalled-cycles-backend    #   15.12% backend  cycles idle    [12.70%]
       229,346,862 instructions              #    0.73  insns per cycle        
                                             #    0.21  stalled cycles per insn [17.83%]
        59,070,354 branches                  #  759.360 M/sec                   [22.93%]
           412,002 branch-misses             #    0.70% of all branches         [28.07%]
        56,878,825 L1-dcache-loads           #  731.187 M/sec                   [71.41%]
             9,032 L1-dcache-load-misses     #    0.02% of all L1-dcache hits   [62.47%]
           277,729 LLC-loads                 #    3.570 M/sec                   [55.53%]
               104 LLC-load-misses           #    0.04% of all LL-cache hits    [50.06%]
        66,637,945 L1-icache-loads           #  856.643 M/sec                   [18.20%]
           317,293 L1-icache-load-misses     #    0.48% of all L1-icache hits   [16.68%]
       146,539,229 dTLB-loads                # 1883.788 M/sec                   [23.09%]
                51 dTLB-load-misses          #    0.00% of all dTLB cache hits  [21.45%]
        92,009,474 iTLB-loads                # 1182.798 M/sec                   [20.02%]
                 0 iTLB-load-misses          #    0.00% of all iTLB cache hits  [12.51%]
            10,473 L1-dcache-prefetches      #    0.135 M/sec                   [11.77%]
                 0 L1-dcache-prefetch-misses #    0.000 K/sec                   [11.12%]

       0.078353869 seconds time elapsed


 Performance counter stats for './bitwise':

         81.758393 task-clock (msec)         #    0.992 CPUs utilized          
                12 context-switches          #    0.147 K/sec                  
                 5 cpu-migrations            #    0.061 K/sec                  
               365 page-faults               #    0.004 M/sec                  
       256,671,027 cycles                    #    3.139 GHz                     [15.80%]
        10,173,482 stalled-cycles-frontend   #    3.96% frontend cycles idle    [20.01%]
        64,409,311 stalled-cycles-backend    #   25.09% backend  cycles idle    [17.03%]
       301,887,645 instructions              #    1.18  insns per cycle        
                                             #    0.21  stalled cycles per insn [21.91%]
        68,580,964 branches                  #  838.825 M/sec                   [26.77%]
           487,357 branch-misses             #    0.71% of all branches         [31.65%]
       170,359,196 L1-dcache-loads           # 2083.691 M/sec                   [26.76%]
             8,511 L1-dcache-load-misses     #    0.00% of all L1-dcache hits   [62.49%]
           655,600 LLC-loads                 #    8.019 M/sec                   [55.54%]
               312 LLC-load-misses           #    0.05% of all LL-cache hits    [50.04%]
        66,707,508 L1-icache-loads           #  815.910 M/sec                   [18.13%]
           374,889 L1-icache-load-misses     #    0.56% of all L1-icache hits   [16.60%]
       145,220,756 dTLB-loads                # 1776.218 M/sec                   [23.03%]
                14 dTLB-load-misses          #    0.00% of all dTLB cache hits  [21.44%]
        93,780,198 iTLB-loads                # 1147.041 M/sec                   [20.04%]
                 0 iTLB-load-misses          #    0.00% of all iTLB cache hits  [12.52%]
             9,454 L1-dcache-prefetches      #    0.116 M/sec                   [11.78%]
                 0 L1-dcache-prefetch-misses #    0.000 K/sec                   [11.13%]

       0.082382617 seconds time elapsed

## Contributing

Just file a pull request and include a comparison of bench times and perf stat if available.


