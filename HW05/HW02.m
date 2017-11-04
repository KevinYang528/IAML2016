clear; clc; close all;

train = load('05HW2_wine_training.txt');
test = load('05HW2_wine_test.txt');
path(path, 'glmnet_matlab\glmnet_matlab');
x_train = train(:, 1:11);
y_train = train(:, 12);
x_test = test(:, 1:11);
y_test = test(:, 12);

lambda = [0.0001, 0.0005, 0.0025, 0.0125, 0.0625, 0.3125, 1.5625, 7.815, 39.0625, 195.3125];
fit = glmnet(x_train, y_train);
x = 1:10;
for i = 1:10
    beta(i, :) = glmnetCoef( fit, lambda(i) );
    pred(:, i) = glmnetPredict( fit, x_test, lambda(i), 'link');
    pred2(:, i) = glmnetPredict( fit, x_train, lambda(i), 'link');
    test_error(i) = (1/100)*sum( (y_test-pred(:, i) ).^2 );
    train_error(i) = (1/100)*sum( (y_train-pred2(:, i) ).^2 );
end

% Plot of train error and test error for each lambda
figure; hold on;
plot(x, train_error, 'LineWidth', 2);
plot(x, test_error, 'LineWidth', 2);

set(gca,'FontSize', 16);
xlabel('\lambda', 'FontSize', 16);
ylabel('Error', 'FontSize', 16);
legend('training error', 'test error');
set(gca, 'XLim', [1, 10]);
set(gca, 'XTick', 1:1:10);
set(gca, 'XTickLabel', [0.0001, 0.0005, 0.0025, 0.0125, 0.0625, 0.3125, 1.5625, 7.815, 39.0625, 195.3125]);
hold off;