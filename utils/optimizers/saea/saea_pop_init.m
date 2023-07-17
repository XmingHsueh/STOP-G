function [population_parent,objs_parent] = saea_pop_init(database,parent_strategy,popsize)
population = database(:,1:end-1);
objs = database(:,end);

switch (parent_strategy)
    case 'new'
        population_parent = population(end-popsize+1:end,:);
        objs_parent = objs(end-popsize+1:end);
    case 'elite'
        [~,idx] = sort(objs);
        population_parent = population(idx(1:popsize),:);
        objs_parent = objs(idx(1:popsize));
end
