function [population,objs] = saea_selection(population_parent,objs_parent,population_offspring,objs_offspring,selector)
popsize = size(population_parent,1);

switch(selector)
    case 'Truncation'
        objs_total = [objs_parent;objs_offspring];
        population_total = [population_parent;population_offspring];
        [~,idx] = sort(objs_total);
        population = population_total(idx(1:popsize),:);
        objs = objs_total(idx(1:popsize));
    case 'RouletteWheel'
        objs_total = [objs_parent;objs_offspring];
        population_total = [population_parent;population_offspring];
        fit_total = objs_total - min(min(objs_total),0) + 1e-6;
        fit_total = cumsum(1./fit_total);
        fit_total = fit_total./max(fit_total);
        idx = arrayfun(@(S)find(rand<=fit_total,1),1:popsize);
        population = population_total(idx,:);
        objs = objs_total(idx);
end
