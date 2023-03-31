function [ acc ] = svm_pred_primal( testX, testY, w, b )

    N = length(testY);
    pred = sign(testX*w + b);
    acc = sum(pred==testY)/N * 100;

end

