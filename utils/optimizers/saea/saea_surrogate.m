function func_surrogate = saea_surrogate(database,surrogate_name)
X = database(:,1:end-1);
y = database(:,end);
no_samples = size(X,1);
dim = size(X,2);

switch(surrogate_name)
    case 'GPR'
        gprModel = fitrgp(X,y,'Basis','linear','FitMethod','exact','PredictMethod','exact','Standardize',1);
        func_surrogate = @(x)predict(gprModel,x);
    case 'GLM'
        glmModel = fitglm(X,y,'purequadratic');
        func_surrogate = @(x)predict(glmModel,x);
    case 'RBF'
        R = zeros(no_samples,no_samples);
        for i=1:no_samples
            for j=1:no_samples
                R(i,j)=sqrt(sum((X(i,:)-X(j,:)).^2));
            end
        end
        spr_estimate = max(max(R))/(dim*no_samples)^(1/dim);
        net = newrbe(X',y',spr_estimate);
        func_surrogate = @(x)sim(net,x');
        model_type = 'regression';
end
