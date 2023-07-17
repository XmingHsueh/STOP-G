function [solutions,objs] = ea(problem,FEsMax,id_source)

% ea parameters
popsize = 50; % the population size

% initialization
fun = problem.fnc; % the objective function
lb = problem.lb; % the lower bound
ub = problem.ub; % the upper bound
population = lhsdesign_modified(popsize,lb,ub); % initialize a population using the LHS sampling
obj_pop = zeros(popsize,1); % the objective values of the solutions in the population
for i=1:popsize
    obj_pop(i) = fun(population(i,:)); % function evaluation
end
FEsCount = popsize;
gen = 1;
solutions = cell(FEsMax/popsize,1);
objs = cell(FEsMax/popsize,1);
solutions{gen} = (population-repmat(lb,popsize,1))./(repmat(ub,popsize,1)-...
    repmat(lb,popsize,1)); % convert the solutions into the common search space
objs{gen} = obj_pop;
obj_min = min(obj_pop);

while FEsCount < FEsMax
    
    % generate an offspring population
    population_parent = population;
    obj_pop_parent = obj_pop;
    population_offspring = ea_generator(population_parent,lb,ub);
    
    % evaluate the offspring population
    obj_pop_offspring = zeros(popsize,1);
    for i=1:popsize
        obj_pop_offspring(i) = fun(population_offspring(i,:));
    end
    FEsCount = FEsCount+popsize;
    gen = gen+1;
    
    % execute the environmental selection
    [population,obj_pop] = ea_selector(population_parent,obj_pop_parent,population_offspring,obj_pop_offspring);
    
    % update the record
    solutions{gen} = (population-repmat(lb,popsize,1))./(repmat(ub,popsize,1)-repmat(lb,popsize,1));
    objs{gen} = obj_pop;
    
    obj_min = min([obj_pop;obj_min]);
    fprintf('EA is solving the %dth source task, FEsUsed: %d, obj_best: %.2f\n',id_source,FEsCount,obj_min);

end