function obj = Schwefel(var,opt)
%Schwefel 2.2 function
%   - var: design variable vector
%   - opt: shift vector
    var = var-opt;  
    obj = sum(abs(var))+prod(abs(var));
end