function [solutions,objs]= saea(problem,FEsMax,id_source)

% saea parameters
popsize = 50; % the population size
surrogate = 'GPR'; % the surrogate model
query_max = 1; % =1: preselection, >1: iteration 
selector = 'RouletteWheel'; % the selestion mechanism
acquisition = 'plain'; % the acquisition function
popinit_strategy = 'elite'; % the strategy for initializing the population at each round of surrogate-assisted search
num_initial_solutions = 50; % the number of initial solutions

% initialization
fun = problem.fnc; % the objective function
lb = problem.lb; % the lower bound
ub = problem.ub; % the upper bound
dim = length(lb);
solutions_initial = lhsdesign_modified(num_initial_solutions,lb,ub);
objs_initial = zeros(num_initial_solutions,1);
for i = 1:num_initial_solutions
    objs_initial(i) = fun(solutions_initial(i,:));
end
FEsUsed = num_initial_solutions;
database = [solutions_initial, objs_initial];

while FEsUsed < FEsMax
    
    % construct the surrogate model until it is built successfully
    flag = 0;
    while flag == 0 
        try
            func_surrogate = saea_surrogate(database,surrogate);
            flag = 1;
        catch
            continue;
        end
    end
    
    % identify a candidate solution to be evaluated by applying the evolutionary solver to the surrogate model
    no_queries = 0;
    [population_sas,objs_sas] = saea_pop_init(database,popinit_strategy,popsize); % initialize the population
    while no_queries < query_max
        population_sas_offspring = saea_generation(population_sas,lb,ub); % generate the offspring population
        objs_offspring = saea_acquisition(func_surrogate,population_sas_offspring,acquisition); % acquisite the objective values of the offspring
        [population_sas,objs_sas] = saea_selection(population_sas,objs_sas,population_sas_offspring,objs_offspring,selector); % form the next parental population
        no_queries = no_queries+1;
    end
    [~,idx] = min(objs_sas);
    solution_candidate = population_sas(idx,:);
    
    % evaluate the candidate solution and update the database
    epsilon = 5e-3;
    no_trials  = 50;
    scales = linspace(0.1,1,no_trials);
    c = 1;
    while min(max(abs(repmat(solution_candidate,size(database,1),1)-database(:,1:end-1)),[],2)) < epsilon
        perturbation = scales((mod(c,no_trials)==0)*no_trials+(mod(c,no_trials)~=0)*mod(c,no_trials))*(ub-lb).*(rand(1,dim)-0.5*ones(1,dim));
        solution_candidate = solution_candidate + perturbation;
        solution_candidate(solution_candidate>ub(1)) = ub(1);
        solution_candidate(solution_candidate<lb(1)) = lb(1);
        c = c+1;
    end
    
    obj_candidate = fun(solution_candidate);
    database = [database;solution_candidate obj_candidate];
    FEsUsed = FEsUsed+1;
    fprintf('SAEA is solving the %dth source task, FEsUsed: %d, obj_best: %.2f\n',id_source,FEsUsed,min(database(:,end)));

end

solutions = (database(:,1:end-1)-repmat(lb,FEsMax,1))./(repmat(ub,FEsMax,1)-repmat(lb,FEsMax,1));
objs = database(1:end,end);