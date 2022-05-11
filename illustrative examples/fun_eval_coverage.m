% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% this function is used to evaluated the fitness of solution [x1,x2] for 
% an interval coverage task with the feature [l1,l2].

function obj_value = fun_eval_coverage(l1,l2,x1,x2)
l1_min = l1-x1;
l1_max = l1+x1;
l2_min = l2-x2;
l2_max = l2+x2;
obj_value = [inf inf];
if min([l1_min,l2_min])<=0 && max([l1_max,l2_max])>=1
    if (l1<=l2)&&(l1_max>=l2_min)  || (l1>l2)&&(l2_max>=l1_min)
        obj_value = [x1 x2];
    end
end