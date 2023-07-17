function [pop,objs] = ea_selector(pop_parent,objs_parent,pop_offspring,objs_offspring)
popsize = size(pop_offspring,1);
objs_total = [objs_parent;objs_offspring];
pop_total = [pop_parent;pop_offspring];
[~,indxs] = sort(objs_total);
pop = pop_total(indxs(1:popsize),:);
objs = objs_total(indxs(1:popsize));