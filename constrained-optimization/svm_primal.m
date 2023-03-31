function [ w, b, time, fval, exitflag, output ] = svm_primal( trainX, trainY, options )

    C = 1;
    [N, D] = size(trainX);
    H = zeros(D+1+N);
    H(1:D, 1:D) = eye(D);
    f = [ zeros(D+1,1); C*ones(N,1) ];
    A = [ -(trainY*ones(1,D)).*trainX, -trainY, -eye(N) ];
    b = -1*ones(N,1);
    LB = [ -Inf*ones(D+1,1); zeros(N,1) ];
    UB = [ Inf*ones(D+1+N, 1) ];

    tic
    if nargin == 3
        [X,fval,exitflag,output] = quadprog(H, f, A, b, [], [], LB, UB, [], options);
    end
    if nargin ==2
        [X,fval,exitflag,output] = quadprog(H, f, A, b, [], [], LB, UB, []);
    end
    
    time = toc;
    w = X(1:D);
    b = X(D+1);
end