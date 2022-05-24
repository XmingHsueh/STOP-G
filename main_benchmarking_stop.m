% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% This file is the script of generating the 12 benchmark problems developed
% in the following paper.
%
% ------------
% Reference:
% ------------
% X. Xue, Y. Hu, C. Yang, et al. ¡°How to Exploit Experience? Revisiting Evolutionary
% Sequential Transfer Optimization: Part A", Submitted for Peer Review.

clc,clear
task_families = {'Sphere','Ellipsoid','Schwefel','Quartic','Ackley','Rastrigin','Griewank','Levy'}; % eight task families
transfer_scenarios = {'a','e'}; % intra-family and inter-family transfers
xis = [0 0.7 1]; % the parameter xi that determines optimum coverage
similarity_distributions = {'c','u','i','d'}; % four representative similarity distributions
k = 1000; % the number of previously-solved source tasks
no_problems = 12; % the number of individual benchmark problems
folder_problems = '.\benchmarks';
if ~isfolder(folder_problems)
    mkdir(folder_problems);
end

specifications = [1 1 1 1 50 k; % STOP 1
    2 2 1 2	25 k; % STOP 2
    3 1 1 3	30 k; % STOP 3
    4 2 1 4	50 k; % STOP 4
    5 1 2 1	50 k; % STOP 5
    6 2 2 2	30 k; % STOP 6
    7 1 2 3	25 k; % STOP 7
    8 2 2 4	30 k; % STOP 8
    1 1 3 1	25 k; % STOP 9
    6 2 3 2	50 k; % STOP 10
    5 1 3 3	25 k; % STOP 11
    2 2 3 4	30 k]; % STOP 12
count = 0; % the number of available STOPs

for n = 1:no_problems
    STOP('func_target',task_families{specifications(n,1)},'trans_sce',...
        transfer_scenarios{specifications(n,2)},'xi',xis(specifications(n,3)),'sim_distribution',...
        similarity_distributions{specifications(n,4)},'dim',specifications(n,5),'k',...
        specifications(n,6),'mode','gen','folder_stops',folder_problems);
    count = count+1;
    fprintf('#%d of the 12 problems is ready!\n',count);
end

addpath(folder_problems);