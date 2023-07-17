% Author: Xiaoming Xue
% Email: xminghsueh@gmail.com
%
% ------------
% Description:
% ------------
% The class of black-box sequential transfer optimization problems (STOPs).
% Configurable parameters include: 1. the target family;  2. the transfer scenario; 
% 3. the similarity distribution; 4. the task dimension;  5. the number of
% source tasks£»6. the backbone optimizer
%
% ------------
% Reference:
% ------------
% X. Xue, C. Yang, L. Feng, et al. ¡°A Scalable Test Problem Generator for Sequential
% Transfer Optimization", arXiv preprint arXiv:2304.08503, 2023.

classdef STOP

    % STOP parameters:
    % func_target--->the target family
    % trans_sce--->the transfer scenario: intra-family transfer (a) or inter-family transfer (e)
    % sim_distribution--->the similarity distribution: h1, h2, m1, m2, m3, m4, l1, l2
    % dim--->the task dimension of the source and target tasks: a positive integer
    % k--->the number of source tasks: a positive integer
    % optimizer--->the backbone optimizer: a valid search engine
    % FEsMax---the maximum function evaluations (FEs) for solving the source tasks
    % mode--->the mode of problem call, problem generation (generation) or sequential transfer optimization (optimization)
    % target_problem--->the instantiated target task
    % source_problems---<read-only>the instantiated source tasks
    % knowledge_base--->the knowledge base containing the solution data of the k source tasks
    % folder_stops--->the folder used for storing the generated STOPs
    % problem_families---<read-only>the list of candidate task families
    % state_knowledgebase---<read-only>the availability of the specified STOP: 1->available; 0->unavailable

    properties
        func_target = 'Sphere';
        trans_sce = 'a';
        sim_distribution = 'h1';
        dim = 20;
        k = 1000;
        optimizer = 'EA'
        FEsMax = 1000;
        mode = 'opt';
        target_problem;
        knowledge_base = struct;
        folder_stops = 'problems';
    end

    properties(SetAccess = protected)
        problem_families = {'Sphere','Ellipsoid','Schwefel','Quartic','Ackley','Rastrigin',...
            'Griewank','Levy'};
        source_problems;
        state_knowledgebase;
    end

    methods

        function obj = STOP(varargin) % initialization
            isStr = find(cellfun(@ischar,varargin(1:end-1))&~cellfun(@isempty,varargin(2:end)));
            for i = isStr(ismember(varargin(isStr),{'func_target','trans_sce','sim_distribution',...
                    'dim','k','optimizer','FEsMax','mode','folder_stops'}))
                obj.(varargin{i}) = varargin{i+1};
            end

            % examine the availability of the specified STOP
            dir_sesto = [obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-h',...
                obj.sim_distribution,'-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat'];
            obj.state_knowledgebase = sign(exist(dir_sesto,'file'));

            if obj.state_knowledgebase == 1 && strcmp(obj.mode,'opt') % load the STOP
                load([obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-h',...
                obj.sim_distribution,'-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat']);
                obj.target_problem = target;
                obj.source_problems = sources;
                for i = 1:obj.k
                    obj.knowledge_base(i).solutions = knowledge(i).solutions;
                    obj.knowledge_base(i).objs = knowledge(i).objs;
                end
            elseif obj.state_knowledgebase == 0 % generate the STOP since it does not exist
                obj = obj.Generation(); 
            end
        end

        function obj = Generation(obj) % problem constructor
            sims = sims_its(obj.sim_distribution,obj.k); % generate k similarity values
            opt_target = rand(1,obj.dim); % configure the target optimum
            [~,idx_min] = min(opt_target);
            opt_target(idx_min) = 0;
            target = problem_family(find(strcmp(obj.problem_families,obj.func_target)),opt_target); % instantiate the target task
            obj.target_problem = target;
            opt_sources = optimum_scaling(opt_target,sims);
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
                obj.source_problems(i).opt = opt_sources(i,:);
            end
            h=waitbar(0,'Starting');
            for i = 1:obj.k % configure the knowledge base
                problem = problem_family(find(strcmp(obj.problem_families,...
                    obj.source_problems(i).func)),obj.source_problems(i).opt);
                cmd_opt = ['[solutions,objs] = ',obj.optimizer,'(problem,obj.FEsMax,i);'];
                eval(cmd_opt);
                obj.knowledge_base(i).solutions = solutions;
                obj.knowledge_base(i).objs = objs;
                waitbar(i/obj.k,h,sprintf('Generation in progress: %.2f%%',i/obj.k*100));
            end
            close(h);
            % save the STOP
            for i = 1:obj.k
                sources(i) = problem_family(find(strcmp(obj.problem_families,...
                    obj.source_problems(i).func)),obj.source_problems(i).opt);
                knowledge(i).solutions = obj.knowledge_base(i).solutions;
                knowledge(i).objs = obj.knowledge_base(i).objs;
            end
            obj.source_problems = sources;
            save([obj.folder_stops,'\',obj.func_target,'-T',obj.trans_sce,'-h',obj.sim_distribution,...
                '-d',num2str(obj.dim),'-k',num2str(obj.k),'.mat'],'target','sources','knowledge');
        end

    end

end