# How to Exploit Optimization Experience? Revisiting Evolutionary Sequential Transfer Optimization: Part A - Benchmark Problems

## Benchmarking Sequential Transfer Optimization Problems (STOPs)

This repository provides the MATLAB implementations of producing the benchmark suite developed in the above paper, which contains 12 individual STOPs. To instantiate an STOP, we need to configure the following six aspects: target task, transfer scenario, optimum coverage, similarity distribution, problem dimension, and the number of source tasks. Their available configurations are as follows:

* target task (F): `Sphere`, `Ellipsoid`, `Schwefel`, `Quartic`, `Ackley`, `Rastrigin`, `Griewank`, and `Levy`.
* transfer scenario (T): `Ta` and `Te`.
* the parameter that controls optimum coverage (xi): a real number from 0 to 1.
* similarity distribution (p): `pc`, `pu`, `pi` and `pd`.
* problem dimension (d): a positive integer.
* the number of source tasks (k): a positive integer.

For more detailed explainations about the above six aspects, interested readers can refer to part A of the series. In this work, we name an STOP as F-T-xi-p-d-k, where F denotes the target family, T represents the transfer scenario, xi is the optimum coverage-related parameter, p represents the similarity distribution, d denotes the problem dimension, k is the number of source tasks. According to this naming rule, we specify the following 12 STOPs to form the benchmark suite,


|Problem ID|Problem Specification|
|:-|:-|
|STOP 1|Sphere-Ta-0-pc-50-k|
|STOP 2|Ellipsoid-Te-0-pu-25-k|
|STOP 3|Schwefel-Ta-0-pi-30-k|
|STOP 4|Quartic-Te-0-pd-50-k|
|STOP 5|Ackley-Ta-1-pi-25-k|
|STOP 6|Rastrigin-Te-1-pu-50-k|
|STOP 7|Griewank-Ta-0.7-pi-25-k|
|STOP 8|Levy-Te-0.7-pd-30-k|
|STOP 9|Sphere-Ta-1-pc-25-k|
|STOP 10|Rastrigin-Te-0.7-pc-30-k|
|STOP 11|Ackley-Ta-0.7-pc-50-k|
|STOP 12|Ellipsoid-Te-1-pc-50-k|

The above 12 STOPs can be easily instantiated using the class [STOP](https://github.com/XmingHsueh/Revisiting-S-ESTOs-PartA/blob/main/utils/STOP.m). The script of generating the 12 STOPs is [main_benchmarking_stop](https://github.com/XmingHsueh/Revisiting-S-ESTOs-PartA/blob/main/main_benchmarking_stop.m).


## Citation

If you find this repo useful for your research, please consider to cite:
```latex
@article{Xue2022,
title = {How to Exploit Optimization Experience? Revisiting Evolutionary Sequential Transfer Optimization: Part A - Benchmark Problems},
author = {Xue, Xiaoming and Yang, Cuie and Feng, Liang and Zhang, Kai and Song, Linqi and Tan, Kay Chen}
journal = {...},
volume = {...},
pages = {...},
year = {2022},
doi = {https://...},
url = {http://...},
}
```

## Acknowledgments

...
