clear; clc;

load('11HW1_KmeanData.mat');

X = X';
Y = Y';
XY = cat(1, X, Y);

figure;
plot(XY(:, 1), XY(:, 2), '.', 'MarkerSize', 12);
   
figure; 
hold on;
plot(X(:, 1), X(:, 2), 'r.', 'MarkerSize', 12);
plot(Y(:, 1), Y(:, 2), 'b.', 'MarkerSize', 12);
legend('X', 'Y', 'Location', 'NW');
hold off;

opts = statset('Display', 'final');
[idx, C] = kmeans(XY, 6, 'Distance','cityblock',...
    'Replicates', 10, 'Options', opts);

figure;
hold on
plot(XY(idx==1,1),XY(idx==1,2),'r.','MarkerSize',12)
plot(XY(idx==2,1),XY(idx==2,2),'g.','MarkerSize',12)
plot(XY(idx==3,1),XY(idx==3,2),'b.','MarkerSize',12)
plot(XY(idx==4,1),XY(idx==4,2),'c.','MarkerSize',12)
plot(XY(idx==5,1),XY(idx==5,2),'m.','MarkerSize',12)
plot(XY(idx==6,1),XY(idx==6,2),'y.','MarkerSize',12)
    
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
%        'Location','NW')
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
%        'Location','NW')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

