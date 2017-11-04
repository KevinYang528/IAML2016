clear;
clc;
close all;

% (a) Plot the 5 curves superimposed over a plot of the data points
n = 1;
for t = 0:1/29:1
    
    sigma = sqrt(0.07);
    mu = 0;
    
    N(n) = ( 1 / ( sqrt(2*pi)*sigma ) ) * exp( (-1/2)*( (t-mu)/sigma)^2 );
    g(n) = ( sin(2*pi*t) )^2 + N(n);
    n = n + 1;
end

t = 0:1/29:1;
scatter(t, g);
set( gcf, 'Color', 'w');
set(gca,'FontSize', 16); xlabel('t', 'FontSize', 16);
ylabel('g(t)', 'FontSize', 16); title('Data point');

k = [2, 5, 10, 14, 18];
for i = 1:5
    hold on;
    % 利用polyfit求出 polynomial function 的係數
    p = polyfit(t, g, k(i));
    % 畫出polynomial的迴歸實線
    x1 = linspace(0, 1);
    y1 = polyval(p, x1);
    plot(x1, y1, 'r-');
end
hold off;

% (b) Log of training error

k2 = 1:18;
for i = 1:18
% 利用polyfit求出 polynomial function 的係數
p = polyfit(t, g, k2(i));
y2 = polyval(p, t);
err(i) = (1/30)*sum( (g-y2).^2 );
end
figure; 
plot(k2, log(err), '-+r'); set( gcf, 'Color', 'w');
set(gca,'FontSize', 16); xlabel('Order', 'FontSize', 16);
ylabel('Log of training error', 'FontSize', 16); title('Training error');
hold on;

% (c) Log of testing error
n = 1;
for t = 0:1/999:1
    
    sigma = sqrt(0.07);
    mu = 0;
    
    N2(n) = ( 1 / ( sqrt(2*pi)*sigma ) ) * exp( (-1/2)*( (t-mu)/sigma)^2 );
    g2(n) = ( sin(2*pi*t) )^2 + N2(n);
    n = n + 1;
end

t = 0:1/29:1;
t2 = 0:1/999:1;

for i = 1:18
% 利用polyfit求出 polynomial function 的係數
p = polyfit(t, g, k2(i));
y3 = polyval(p, t2);
err2(i) = (1/1000)*sum( (g2-y3).^2 );
end

% (d) Compare the training error with the test error
figure;
plot(k2, log(err2), '-+b'); set( gcf, 'Color', 'w');
set(gca,'FontSize', 16); xlabel('Order', 'FontSize', 16);
ylabel('Log of testing error', 'FontSize', 16); title('Testing error');

figure; hold on;
plot(k2, log(err), '-+r'); plot(k2, log(err2), '-+b');
set( gcf, 'Color', 'w');
set(gca,'FontSize', 16); xlabel('Order', 'FontSize', 16);
ylabel('Log of error', 'FontSize', 16); title('Training error / Testing error');
legend('Training error', 'Testing error');
hold off;