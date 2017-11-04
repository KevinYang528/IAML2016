clear; clc; close all;

X = 0:.01:2;
Y = sin(2*pi*X)+.1*rand(size(X));
net = newff([0 2],[3 1],{'tansig' 'purelin'});
net.trainParam.epochs = 2000; %maximum training epochs
net.trainParam.goal = 0.001; %goal for the error function
net = train( net, X, Y);
simY = sim(net, X);

% Root Mean Squared Error
RMSE = sqrt(mean((Y - simY).^2)); 