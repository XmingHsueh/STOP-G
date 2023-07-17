function obj = Quartic(var,opt)
%Quartic function with noise
%   - var: design variable vector
%   - opt: shift vector
    w = 1:length(opt);
    var = var-opt;
    obj = sum(w.*var.^4)+rand;
end