clear; clc; close all;
x = [0.2, 0.3, 0.6, 0.9, 1.1, 1.3, 1.4, 1.6 ];
y = [0.050446, 0.098426, 0.33277, 0.7266, 1.0972, 1.5697, 1.8487, 2.5015];
scatter(x, y);

for k = 1:3
hold on;
% 利用polyfit求出 polynomial function 的係數
p = polyfit(x, y, k);
% 畫出polynomial的迴歸實線
x1 = linspace(0,1.6);
y1 = polyval(p,x1);
plot(x1, y1, 'r-');
% y2 為各個點的 y head
y2 = polyval(p, x);

% Calculate and plot AIC and BIC

% RSS
residual = y-y2;
RSS = sum( residual.^2 );

N = length(y);

    % AIC
    AIC(k) = N*log(RSS/N) + 2*(k+1);
    % BIC
    BIC(k) = N*log(RSS/N) + log(N)*(k+1);
end

figure;
bar( [AIC(1:k); BIC(1:k)]', 1);
hold off;
