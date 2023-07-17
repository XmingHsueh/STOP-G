# A Scalable Test Problem Generator for Sequential Transfer Optimization

## A Benchmark Suite of Sequential Transfer Optimization Problems (STOPs)

This repository provides the MATLAB implementation of generating a benchmark suite of sequential transfer optimization problems (STOPs). To instantiate an STOP, we need to set up the following five parameters: the target family, the transfer scenario, the similarity distribution, the task dimension, and the number of source tasks. Their available realizations are as follows:

* Task families (F): `Sphere`, `Ellipsoid`, `Schwefel`, `Quartic`, `Ackley`, `Rastrigin`, `Griewank`, and `Levy`.
* Transfer scenarios (T): `Ta` and `Te`.
* Similarity distributions (h): `h1`, `h2`, `m1`, `m2`, `m3`, `m4`, `l1`, `l2`.
* Task dimensions (d): positive integers.
* Numbers of source tasks (k): positive integers.

In this work, we name an STOP as F-T-h-d-k, where F denotes the target family, T represents the transfer scenario, h represents the similarity distribution, d denotes the task dimension, k is the number of source tasks. According to this naming rule, we specify the following 12 STOPs to form the benchmark suite,


|Problem ID|Problem Specification|
|:-|:-|
|STOP 1|Sphere-Ta-h1-50-k|
|STOP 2|Ellipsoid-Te-h2-25-k|
|STOP 3|Schwefel-Ta-h2-30-k|
|STOP 4|Quartic-Te-h1-50-k|
|STOP 5|Ackley-Ta-m1-25-k|
|STOP 6|Rastrigin-Te-m2-50-k|
|STOP 7|Griewank-Ta-m3-25-k|
|STOP 8|Levy-Te-m4-30-k|
|STOP 9|Sphere-Ta-l1-25-k|
|STOP 10|Rastrigin-Te-l2-30-k|
|STOP 11|Ackley-Ta-l2-50-k|
|STOP 12|Ellipsoid-Te-l1-50-k|

In this repository, we employ two backbone optimizers, i.e., evolutionary algorithm (EA) and surrogate-assisted evolutionary algorithm (SAEA), to denmonstrate the generation process of the 12 STOPs, whose scripts can be found at [STOP-EA](https://github.com/XmingHsueh/STOP/blob/main/main_generation_ea.m) and [STOP-SAEA](https://github.com/XmingHsueh/STOP/blob/main/main_generation_saea.m), respectively.

## Citation

If you find this repo useful for your research, please consider to cite:
```latex
@article{xue2023scalable,
  title={A Scalable Test Problem Generator for Sequential Transfer Optimization},
  author={Xue, Xiaoming and Yang, Cuie and Feng, Liang and Zhang, Kai and Song, Linqi and Tan, Kay Chen},
  journal={arXiv preprint arXiv:2304.08503},
  year={2023}
}
```

## Acknowledgments

...
