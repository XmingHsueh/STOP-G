function [population_new,fitness_new] = ea_selector(population_old,fitness_old,population,fitness)
popsize = size(population,1);
fitness_total = [fitness_old;fitness];
population_total = [population_old;population];
[~,indxs] = sort(fitness_total);
population_new = population_total(indxs(1:popsize),:);
fitness_new = fitness_total(indxs(1:popsize));