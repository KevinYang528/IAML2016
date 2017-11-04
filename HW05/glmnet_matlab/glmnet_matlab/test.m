clear; clc;
load('05HW1_diabetes.mat');

% cd glmnet_matlab;
fit = glmnet(x_train, y_train);