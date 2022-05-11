# How to Exploit Experience? Revisiting Evolutionary Sequential Transfer Optimization: Part A

This repository provides the MATLAB implementations of producing the benchmark suite developed in the above article, which contains 12 individual sequential transfer optimization problems (STOPs). To instantiate an STOP, we need to configure the following six aspects: target task, transfer scenario, the parameter that determines optimum coverage, similarity distribution, problem dimension, and the number of source tasks. Their available configurations are as follows:

* target task (F): `Sphere`, `Ellipsoid`, `Schwefel`, `Quartic`, `Ackley`, `Rastrigin`, `Griewank`, and `Levy`
* transfer scenario (T): `intra-family transfer` and `inter-family transfer`
* the parameter of controlling optimum coverage (xi): `0`, `0.7`, and `1`
* similarity distribution (S): `c`, `u`, `i` and `d`
* problem dimension (d): 5 to 50
* the number of source tasks (k): a positive integer

In the article, we name a black-box STOP as F-T-xi-S-d-k, where F denotes the target family, T represents the transfer scenario, xi is the optimum coverage-related parameter, S represents the similarity distribution, d denotes the problem dimension, k is the number of source tasks.
