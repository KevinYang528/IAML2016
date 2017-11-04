clear; clc;
load('07HW2_digit.mat');

% colormap gray;
% imagesc(~reshape(train0(1,:), 28, 28)');

% Training
TRAINING = normc( double( cat(1, train0, train1) ) );
GROUP = zeros(1000, 1);
GROUP(501:1000, 1) = 1;

% Test
TEST = normc( double( cat(1, test0, test1) ) );
testGROUP = zeros(200, 1);
testGROUP(101:200, 1) = 1;

for i = 0:8
    g = 2^(-14+i);
    for j = 0:8
        c = 2^(-5+j);
        % -t 0 : linear
        % -t 1 : polynomial
        % -t 2 : RBF
%                 model = svmtrain(GROUP, TRAINING, [' -t 1 -c ',num2str(c), ' -g ', num2str(g)]);
%                 [pGROUP, Accuracy, p_val] = svmpredict(testGROUP, TEST, model);
%                 A(i+1, j+1) = Accuracy(1);
        
        % 10 fold-validation
        model = svmtrain(GROUP, TRAINING, [' -t 1 -c ',num2str(c), ' -g ', num2str(g), ' -v 10 ']);
        CV(i+1, j+1) = model;
    end
end
% g = 2^(-14);c = 2^(-5); 
% model = svmtrain(GROUP, TRAINING, [' -t 2 -c ',num2str(c), ' -g ', num2str(g), ' -v 10 ']);
% [pGROUP Accuracy p_val] = svmpredict(GROUP, TRAINING, model);
