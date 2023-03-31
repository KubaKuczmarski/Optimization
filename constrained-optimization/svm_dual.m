function [ alpha, time, fval, exitflag, output  ] = svm_dual( trainX, trainY, options )

    C = 1;
    N = length(trainY);
    K = trainX*trainX';
    H = 2*diag(trainY)*K*diag(trainY);
    f = -ones(N,1);
    Aeq = trainY';
    beq = [0];
    LB = zeros(N,1);
    UB = C*ones(N,1);

    tic;
    if nargin == 3
        [alpha,fval,exitflag,output] = quadprog(H, f, [], [], Aeq, beq, LB, UB, [], options);
    end
    if nargin ==2
        [alpha,fval,exitflag,output] = quadprog(H, f, [], [], Aeq, beq, LB, UB, []);
    end

    time = toc;

end