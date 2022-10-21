% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% The class of black-box sequential transfer optimization problems (STOPs).
% Modifiable properties include: 1. the target task;  2. transfer scenario; 
% 3. optimum coverage; 4. similarity distribution; 5. problem dimension;
% 6. the number of source tasks.
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. ¡°How to Exploit Optimization Experience? Revisiting Evolutionary 
% Sequential Transfer Optimization: Part A - Benchmark Problems", Submitted for Peer Review.

classdef STOP

    % STOP properties:
    % func_target--->the target task with configurable optimum
    % trans_sce--->the transfer scenario: intra-family transfer (a) or inter-family transfer (e)
    % sim_distribution--->the similarity distribution: determined by the distribution of tau (c, u, i, d)
    % xi--->the parameter that controls optimum coverage of a box-constrained image, ranging from 0 to 1
    % dim--->the problem dimension of source and target tasks, a positive integer
    % k--->the number of source tasks, a positive integer
    % mode--->the mode of problem call, problem generation (gen) or s-esto optimization (opt)
    % target_problem--->the instantiated target task
    % source_problems---<read-only>the instantiated source tasks
    % knowledge_base--->the knowledge base containing the evaluated solutions of the k source tasks
    % folder_stops--->the folder used for storing the generated STOPs
    % problem_families---<read-only>the list of candidate task families
    % optimizer---<read-only>the population-based optimizer used for solving the source and target tasks
    % popsize---<read-only>the population size, N>0
    % FEsMax---<read-only>the maximum function evaluations (FEs) available
    % state_knowledgebase---<read-only>the availability of the specified STOP: 1->available; 0->unavailable

    properties
        func_target = 'Sphere';
        trans_sce = 'a';
        sim_distribution = 'c';
        xi = 1;
        dim = 20;
        k = 1000;
        mode = 'opt';
        target_problem;
        knowledge_base = struct;
        folder_stops = 'problems';
    end

    properties(SetAccess = protected)
        problem_families = {'Sphere','Ellipsoid','Schwefel','Quartic','Ackley','Rastrigin',...
            'Griewank','Levy'};
        optimizer = 'ea';
        popsize = 50;
        FEsMax = 2500;
        state_knowledgebase;
        source_problems;
    end

    methods

        function obj = STOP(varargin) % initialization
            isStr = find(cellfun(@ischar,varargin(1:end-1))&~cellfun(@isempty,varargin(2:end)));
            for i = isStr(ismember(varargin(isStr),{'func_target','trans_sce','xi','sim_distribution',...
                    'dim','mode','folder_stops'}))
                obj.(varargin{i}) = varargin{i+1};
            end
            % examine the availability of the specified STOP
            dir_sesto = [obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-xi',num2str(obj.xi),'-p',...
                obj.sim_distribution,'-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat'];
            obj.state_knowledgebase = sign(exist(dir_sesto,'file'));
            if obj.state_knowledgebase == 1 && strcmp(obj.mode,'opt') % will not load the data in the generation mode
                load([obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-xi',num2str(obj.xi),'-p',...
                obj.sim_distribution,'-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat']);
                obj.target_problem = target;
                obj.source_problems = sources;
                for i = 1:obj.k
                    obj.knowledge_base(i).solutions = knowledge(i).solutions;
                    obj.knowledge_base(i).fitnesses = knowledge(i).fitnesses;
                end
            elseif obj.state_knowledgebase == 0
                obj = obj.Configuration(); % generate the STOP since it does not exist
            end
        end

        function obj = Configuration(obj) % problem constructor
            [opt_target,opt_source] = opt_config(obj.xi,obj.k,obj.dim,obj.sim_distribution);
            for i = 1:obj.k % configure the source tasks
                idx_target = find(strcmp(obj.problem_families,obj.func_target));
                if strcmp(obj.trans_sce,'a') % intra-family transfer
                    idx_source = idx_target;
                    obj.source_problems(i).func = obj.problem_families{idx_source};
                else % inter-family transfer
                    idx_source = randi(length(obj.problem_families));
                    while idx_source==idx_target
                        idx_source = randi(length(obj.problem_families));
                    end
                    obj.source_problems(i).func = obj.problem_families{idx_source};
                end
                obj.source_problems(i).opt = opt_source(i,:);
            end
            h=waitbar(0,'Starting');
            for i = 1:obj.k % configure the knowledge base
                problem = problem_family(find(strcmp(obj.problem_families,...
                    obj.source_problems(i).func)),obj.source_problems(i).opt);
                [solutions,fitnesses] = evolutionary_search(problem,obj.popsize,...
                    obj.FEsMax,obj.optimizer);
                obj.knowledge_base(i).solutions = solutions;
                obj.knowledge_base(i).fitnesses = fitnesses;
                waitbar(i/obj.k,h,sprintf('STOP generation in progress: %.2f%%',i/obj.k*100));
            end
            close(h);
            % save the STOP
            target = problem_family(find(strcmp(obj.problem_families,obj.func_target)),opt_target);
            obj.target_problem = target;
            for i = 1:obj.k
                sources(i) = problem_family(find(strcmp(obj.problem_families,...
                    obj.source_problems(i).func)),obj.source_problems(i).opt);
                knowledge(i).solutions = obj.knowledge_base(i).solutions;
                knowledge(i).fitnesses = obj.knowledge_base(i).fitnesses;
            end
            obj.source_problems = sources;
            save([obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-xi',num2str(obj.xi),'-p',...
                obj.sim_distribution,'-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat'],...
                'target','sources','knowledge');
        end

    end

end