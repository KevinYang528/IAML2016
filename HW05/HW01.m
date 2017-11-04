clear; clc; close all;

load('05HW1_diabetes.mat');
path(path, 'glmnet_matlab\glmnet_matlab');

fit = glmnet(x_train, y_train);
x = 1:6;
my_lambda = [0.01, 0.1, 1, 10, 100, 1000];

for i = 1:6
    beta(i, :) = glmnetCoef( fit, my_lambda(i) );
    pred(:, i) = glmnetPredict( fit, x_test, my_lambda(i), 'link');
    test_error(i) = (1/200)*sum( (y_test-pred(:, i) ).^2 );
    beta2(i, :) = ridge( y_train, x_train, my_lambda(i) );
end



% Plot of weight beta for each lambda
figure; hold on; box on;
for m = 2:65    
    plot(x, beta(:, m));    
end
hold off; 

xlabel('\lambda', 'FontSize', 16);
ylabel('\beta', 'Rotation', 0, 'FontSize', 16);
set(gca, 'XLim', [1, 6]);
set(gca, 'XTick', 1:1:6);
set(gca, 'XTickLabel', [0.01, 0.1, 1, 10, 100, 1000]);

% Plot of test error for each lambda
figure;
plot(x, test_error, 'LineWidth', 2);

set(gca,'FontSize', 16);
xlabel('\lambda', 'FontSize', 16);
ylabel('test error', 'FontSize', 16);
legend('test error');
set(gca, 'XLim', [1, 6]);
set(gca, 'XTick', 1:1:6);
set(gca, 'XTickLabel', [0.01, 0.1, 1, 10, 100, 1000]);

% Plot of weight beta for each lambda
figure; hold on; box on;
for m = 1:64    
    plot(x, beta2(:, m));    
end
hold off;

xlabel('\lambda', 'FontSize', 16);
ylabel('\beta', 'Rotation', 0, 'FontSize', 16);
set(gca, 'XLim', [1, 6]);
set(gca, 'XTick', 1:1:6);
set(gca, 'XTickLabel', [0.01, 0.1, 1, 10, 100, 1000]);
