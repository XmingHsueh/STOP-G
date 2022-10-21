% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% The function of configuring the optima of source and target tasks.
%
% ------------
% Inputs:
% ------------
% xi--->the parameter that controls the optimum coverage of a box-constrained image
% num_tasks--->the number of source tasks
% d--->the problem dimension
% sim_distribution--->the similarity distribution
%
% ------------
% Outputs:
% ------------
% target_opt--->the optimum of the target task
% source_opt--->the optima of the source tasks
% lb_image--->the lower bound of the image in the decison space
% ub_image--->the upper bound of the image in the decison space
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. ¡°How to Exploit Optimization Experience? Revisiting Evolutionary 
% Sequential Transfer Optimization: Part A - Benchmark Problems", Submitted for Peer Review.

function [target_opt,source_opt,lb_image,ub_image] = opt_config(xi,num_tasks,d,sim_distribution)
source_opt = zeros(num_tasks,d);
lb_image = zeros(1,d);
ub_image = zeros(1,d);

for i = 1:d % a randomly generated box-constrained image
    lb_image(i) = rand*(1-xi);
    ub_image(i) = lb_image(i)+xi;
end

u = unifrnd(0,1,1,num_tasks);
switch(sim_distribution)
    case 'c'
        tau = ones(1,num_tasks);
    case 'u'
        tau = u;
    case 'i'
        tau = sqrt(u); % inverse transform method
    case 'd'
        tau = 1-sqrt(1-u); % inverse transform method
end

target_opt = lb_image+(ub_image-lb_image).*rand(1,d);
for i = 1:num_tasks
    source_ori = lb_image+(ub_image-lb_image).*rand(1,d);
    source_opt(i,:) = target_opt*(1-tau(i))+source_ori*tau(i);
end