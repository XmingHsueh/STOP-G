function obj = Ellipsoid(var,opt)
%Ackley function
%   - var: design variable vector
%   - opt: shift vector
dim = length(var);

sum = 0;
for i = 1: dim
    sum = sum + (dim-i+1)*(var(i)-opt(i))^2;
end

obj = sum;

end

