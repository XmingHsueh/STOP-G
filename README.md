# How to Exploit Experience? Revisiting Evolutionary Sequential Transfer Optimization: Part A

This repository provides the MATLAB implementations of producing the benchmark suite developed in the above article, which contains 12 individual sequential transfer optimization problems (STOPs). To instantiate an STOP, we need to configure the following six aspects: target task, transfer scenario, the parameter that determines optimum coverage, similarity distribution, problem dimension, and the number of source tasks. Their available configurations are as follows:

* target task: `Sphere`, `Ellipsoid`, `Schwefel`, `Quartic`, `Ackley`, `Rastrigin`, `Griewank`, and `Levy`
* transfer scenario: `intra-family transfer` and `inter-family transfer`
* generation scheme: `constrained generation` and `unconstrained generation`
* the parameter of controlling optimum coverage: `0`, `0.1`, `0.3`, `0.7`, and `1`
* problem dimension: `5`, `10`, and `20`
* the number of source tasks: `1000`

The naming rule for STOPs 
