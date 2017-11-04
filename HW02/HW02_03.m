clear
clc

% yields
y = [7.571  7.931  7.977  7.996  8.126  8.247  8.298  8.304  8.311  8.327  8.369  8.462 ...
    8.487  8.492  8.479  8.510  8.507  8.404];
% maturity
x = [1,3, 6, 9, 12, 15, 18, 21, 24, 30, 36, 48, 60, 72, 84, 96, 108, 120];

% (a)
figure;
scatter(x, y);

xlabel('maturity');
ylabel('yields');

% (b)
y_bar = sum(y)/18;
R_square = zeros(1, 6);
for m = 1:6
    p = polyfit(x, y, m);
    y_head = polyval(p, x);
    
    % SSR SST
    SSR = 0;
    SST = 0;  
    for i = 1:18
        SSR = SSR + ( y_head(i) - y_bar )^2;
        SST = SST + ( y(i) - y_bar )^2;
    end
    R_square(m) = SSR/SST;
end
figure;
plot(R_square,'ro--');
xlabel('Polynomial order k');
ylabel('R^2');
set(gca, 'XTick', 1:6);

% (c)
p = polyfit(x, y, 4);
y_head = polyval(p, x);
residual = y - y_head;
figure;
hold on;
scatter(x, residual);
plot([0 120], [0 0], 'r-');
title('4th-order polynomial model');
xlabel('maturity');
ylabel('residual');
hold off;

% (d)
y3 = zeros(9, 2);
y3(1:9, 1) = y(1, 1:9)';
y3(1:9, 2) = y(1, 10:18)';
vartestn( y3 );

% (e)
figure;
histogram(residual, 5);
xlabel('Residual');
figure;
qqplot(residual);

