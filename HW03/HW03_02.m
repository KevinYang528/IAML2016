clear; close all;

% data
x = [0.2, 0.3, 0.6, 0.9, 1.1, 1.3, 1.4, 1.6 ]';
y = [0.050446, 0.098426, 0.33277, 0.7266, 1.0972, 1.5697, 1.8487, 2.5015]';
plot(x,y, '-ob'); set( gcf, 'Color', 'w');
xlabel('x', 'FontSize', 16); ylabel('y', 'FontSize', 16);
set(gca,'FontSize', 16);

degree = 3;
% regress y with different order of x
for i=1:degree
    X(:,i)=power(x,i);
    [b,bint,r]=regress(y,[ones(length(x), 1) X(:,1:i)]);
    RSS(i)=r'*r;
end
figure; plot((1:degree), RSS, '-+r'); set( gcf, 'Color', 'w');
set(gca,'FontSize', 16); xlabel('Order', 'FontSize', 16);
ylabel('RSS', 'FontSize', 16); title('RSS');

% Calculate and plot AIC and BIC
for i=1:degree
    X(:,i)=power(x,i);
    [b,bint,r]=regress(y,[ones(length(x), 1) X(:,1:i)]);
    RSS(i)=r'*r;
    AIC(i)=length(y)*log(RSS(i)/length(y))+2*i;
    BIC(i)=length(y)*log(RSS(i)/length(y))+log(length(y))*i;
end

figure; bar( [ AIC(1:degree); BIC(1:degree)]', 1);
title('AIC and BIC', 'FontSize', 16);
xlabel('Order', 'FontSize', 16); set(gca,'FontSize', 16);
ylabel('AIC/BIC', 'FontSize', 16);
set( gcf, 'Color', 'w'); legend({'AIC', 'BIC'});