function problem= problem_family(problem_id,optimum)

switch(problem_id)
    case 1 %Sphere function
        dim = length(optimum);
        problem.name = 'Sphere';
        problem.dims = dim;
        problem.lb = -100*ones(1,dim);
        problem.ub = 100*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        problem.fnc = @(x)Sphere(x,x_best);
        problem.x_best = x_best;
    case 2 %Ellipsoid function
        dim = length(optimum);
        problem.name = 'Ellipsoid';
        problem.dims = dim;
        problem.lb = -50*ones(1,dim);
        problem.ub = 50*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        problem.fnc = @(x)Ellipsoid(x,x_best);
        problem.x_best = x_best;
    case 3 %Schwefel function 2.2
        dim = length(optimum);
        problem.name = 'Schwefel';
        problem.dims = dim;
        problem.lb = -30*ones(1,dim);
        problem.ub = 30*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        problem.fnc = @(x)Schwefel(x,x_best);
        problem.x_best = x_best;
    case 4 %Quartic function
        dim = length(optimum);
        problem.name = 'Quartic';
        problem.dims = dim;
        problem.lb = -5*ones(1,dim);
        problem.ub = 5*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        problem.fnc = @(x)Quartic(x,x_best);
        problem.x_best = x_best;
    case 5 %Ackley function
        dim = length(optimum);
        problem.name = 'Ackley';
        problem.dims = dim;
        problem.lb = -32*ones(1,dim);
        problem.ub = 32*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        rotation = eye(dim,dim);
        problem.fnc = @(x)Ackley(x,rotation,x_best);
        problem.x_best = x_best;
    case 6 %Rastrigin function
        dim = length(optimum);
        problem.name = 'Rastrigin';
        problem.dims = dim;
        problem.lb = -10*ones(1,dim);
        problem.ub = 10*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        rotation = eye(dim,dim);
        problem.fnc = @(x)Rastrigin(x,rotation,x_best);
        problem.x_best = x_best;
    case 7 %Griewank function
        dim = length(optimum);
        problem.name = 'Griewank';
        problem.dims = dim;
        problem.lb = -200*ones(1,dim);
        problem.ub = 200*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        rotation = eye(dim,dim);
        problem.fnc = @(x)Griewank(x,rotation,x_best);
        problem.x_best = x_best;
    case 8 %Levy function
        dim = length(optimum);
        problem.name = 'Levy';
        problem.dims = dim;
        problem.lb = -20*ones(1,dim);
        problem.ub = 20*ones(1,dim);
        x_best = problem.lb+(problem.ub-problem.lb).*optimum;
        problem.fnc = @(x)Levy(x,x_best);
        problem.x_best = x_best;
end
