% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% The function of generating the optimal solutions of the source tasks
% according to the target optimum and the set of similarity values.
%
% ------------
% Inputs:
% ------------
% opt_target--->the optimal solution of the target task
% sims--->the set of similarity values
%
% ------------
% Outputs:
% ------------
% opt_sources--->the optimal solutions of the source tasks
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. “A Scalable Test Problem Generator for Sequential
% Transfer Optimization", arXiv preprint arXiv:2304.08503, 2023.

function opt_sources = optimum_scaling(opt_target,sims)

k = length(sims); % the number of source tasks
dim = length(opt_target);
opt_sources = zeros(k,dim);

for i = 1:k
    r = rand(1,dim);
    opt_gen = opt_target+(1-sims(i))/norm(r-opt_target,inf)*(r-opt_target);
    opt_gen(opt_gen>1) = 1;
    opt_gen(opt_gen<0) = 0;
    opt_sources(i,:) = opt_gen;
end