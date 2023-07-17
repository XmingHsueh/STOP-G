% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% The function of generating k independent similarity values from the
% specified similarity distribution using the inverse transform sampling.
%
% ------------
% Inputs:
% ------------
% sim_distribution--->the specified similarity distribution
% k--->the number of source tasks
%
% ------------
% Outputs:
% ------------
% sims--->the k similarity values
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. “A Scalable Test Problem Generator for Sequential
% Transfer Optimization", arXiv preprint arXiv:2304.08503, 2023.

function sims = sims_its(sim_distribution,k)

% unis = unifrnd(0,1,1,k);
unis = linspace(0,1,k); % k uniformly distributed real numbers within [0,1]
sims = zeros(1,k);

switch(sim_distribution)
    case 'h1'
        sims = ones(1,k);
    case 'h2'
        for i = 1:k
            sims(i) = (sqrt(unis(i))+1)/2;
        end
    case 'm1'
        for i = 1:k
            sims(i) = unis(i);
        end
    case 'm2'
        for i = 1:k
            sims(i) = sqrt(unis(i));
        end
    case 'm3'
        for i = 1:k
            sims(i) = 1-sqrt(1-unis(i));
        end
    case 'm4'
        for i = 1:k
            if unis(i)<=0.5
                sims(i) = sqrt(unis(i)/2);
            else
                sims(i) = (-sqrt(1-unis(i))+sqrt(2))/sqrt(2);
            end
        end
    case 'l1'
        sims = zeros(1,k);
    case 'l2'
        for i = 1:k
            sims(i) = (-sqrt(1-unis(i))+1)/2;
        end
end