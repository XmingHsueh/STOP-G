function objs_offspring = saea_acquisition(func_surrogate,pop_offspring,acquisition)
popsize = size(pop_offspring,1);
objs_offspring = zeros(popsize,1);

switch(acquisition)
    case 'plain'
        for i = 1:popsize
            objs_offspring(i) = func_surrogate(pop_offspring(i,:));
        end
end