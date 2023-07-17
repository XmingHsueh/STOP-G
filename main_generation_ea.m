% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% This file is the script of generating the 12 benchmark sequential transfer 
% optimization problems (STOPs) developed in the following paper.
% *the backbone optimizer: evolutionary algorithm*
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. ¡°A Scalable Test Problem Generator for Sequential
% Transfer Optimization", arXiv preprint arXiv:2304.08503, 2023.

clc,clear
warning off;

%% Specify the STOPs to be generated
task_families = {'Sphere','Ellipsoid','Schwefel','Quartic','Ackley','Rastrigin','Griewank','Levy'}; % eight task families
transfer_scenarios = {'a','e'}; % intra-family and inter-family transfers
similarity_distributions = {'h1','h2','m1','m2','m3','m4','l1','l2'}; % eight similarity distributions
k = 20; % the number of source tasks
specifications = [1 1 1 50 k; % STOP 1
    2 2 2 25 k; % STOP 2
    3 1 2 30 k; % STOP 3
    4 2 1 50 k; % STOP 4
    5 1 3 25 k; % STOP 5
    6 2 4 50 k; % STOP 6
    7 1 5 25 k; % STOP 7
    8 2 6 30 k; % STOP 8
    1 1 7 25 k; % STOP 9
    6 2 8 30 k; % STOP 10
    5 1 8 50 k; % STOP 11
    2 2 7 50 k]; % STOP 12
backbone_opt = 'ea'; % ea, saea
FEsMax = 2000; % the maximum function evaluations
no_problems = size(specifications,1);

%% Generation of the STOPs
folder_problems = '.\benchmarks-ea'; % the folder used for storing the generated STOPs
if ~isfolder(folder_problems)
    mkdir(folder_problems);
end
count = 0; % the number of available STOPs
for n = 1:no_problems
    STOP('func_target',task_families{specifications(n,1)},...
        'trans_sce',transfer_scenarios{specifications(n,2)},...
        'sim_distribution',similarity_distributions{specifications(n,3)},...
        'dim',specifications(n,4),...
        'k',specifications(n,5),...
        'optimizer',backbone_opt,...
        'FEsMax',FEsMax,...
        'mode','generation',...
        'folder_stops',folder_problems);
    count = count+1;
    fprintf('#%d of the 12 problems is ready!\n',count);
end

addpath(folder_problems);