function [ acc ] = svm_pred_dual( testX, testY, alpha, trainX, trainY )

    N = length(testY);
    predict = sign(sum(((alpha.*trainY)*ones(1,N)).*(trainX*testX'), 1));
    acc = sum(testY==predict')/N*100;

end