clear
clc

x = load('02HW1_Xtrain');
y = load('02HW1_Ytrain ');

figure;
scatter(x, y);
hold on;
% �Q��polyfit�D�X polynomial function ���Y��
p = polyfit(x, y, 1);
% �e�Xpolynomial���^�k��u
x1 = linspace(0,1);
y1 = polyval(p,x1);
plot(x1, y1, 'r-');
% y2 ���U���I�� y head
y2 = polyval(p, x);
scatter(x, y2, 'x');
hold off;

figure;
% residual
residual = y-y2;
scatter(x, residual);
hold on;
% least square
least_square = (y-y2).^2;
scatter(x, least_square, 's');
legend('residual','least square');
hold off;

training_error = (1/20)*sum(least_square);


