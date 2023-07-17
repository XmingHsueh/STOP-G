function population_child = ea_generator(population_parent,lb,ub)
[popsize,dim] = size(population_parent);
population = (population_parent-repmat(lb,popsize,1))./(repmat(ub,popsize,1)-repmat(lb,popsize,1));
mu = 15;
mum = 15;
probswap = 0.5;
indorder = randperm(popsize);
population_child = zeros(popsize,dim);

for i=1:popsize/2
    p1 = indorder(i); % population_parent 1
    p2 = indorder(i+(popsize/2)); % population_parent 2
    u = rand(1,dim);
    cf = zeros(1,dim);
    cf(u<=0.5)=(2*u(u<=0.5)).^(1/(mu+1));
    cf(u>0.5)=(2*(1-u(u>0.5))).^(-1/(mu+1));
    
    % crossover
    pp1 = population(p1,:);
    pp2 = population(p2,:);
    child1 = 0.5*((1+cf).*pp1 + (1-cf).*pp2);
    child1(child1<0) = 0;
    child1(child1>1) = 1;
    pp1 = population(p2,:);
    pp2 = population(p1,:);
    child2 = 0.5*((1+cf).*pp1 + (1-cf).*pp2);
    child2(child2<0) = 0;
    child2(child2>1) = 1;
    
    % mutation
    temp1 = child1;
    for j=1:dim
        if rand(1)<1/dim
            u=rand(1);
            if u <= 0.5
                del=(2*u)^(1/(1+mum)) - 1;
                temp1(j)=child1(j) + del*(child1(j));
            else
                del= 1 - (2*(1-u))^(1/(1+mum));
                temp1(j)=child1(j) + del*(1-child1(j));
            end
        end
    end

    child1 = temp1;
    child1(child1<0) = 0;
    child1(child1>1) = 1;
    temp2 = child2;
    for j=1:dim
        if rand(1)<1/dim
            u=rand(1);
            if u <= 0.5
                del=(2*u)^(1/(1+mum)) - 1;
                temp2(j)=child2(j) + del*(child2(j));
            else
                del= 1 - (2*(1-u))^(1/(1+mum));
                temp2(j)=child2(j) + del*(1-child2(j));
            end
        end
    end
    child2 = temp2;
    child2(child2<0) = 0;
    child2(child2>1) = 1;
    
    % variable swap (uniform X)
    swap_indicator = (rand(1,dim) >= probswap);
    temp = child2(swap_indicator);
    child2(swap_indicator) = child1(swap_indicator);
    child1(swap_indicator) = temp;
    
    population_child(i,:) = lb+child1.*(ub-lb);
    population_child(i+popsize/2,:) = lb+child2.*(ub-lb);
end