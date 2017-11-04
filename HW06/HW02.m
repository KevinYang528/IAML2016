clear; clc; close all;
X = xlsread('06HW1_iris.xlsx');

% (a) 
% (1) List the principal components explaining 95% of 
%     the total variance in the dataset

X = normc(X);
% 先將資料減去平均
X_mean = mean(X);

X_a = X;
for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        X_a(i, j) = X(i, j) - X_mean(j);
    end
end

% 進行SVD分解
[U, S, V] =  svd( X_a );

C = 100*diag(S).^2./sum(diag(S).^2);

figure;
plot(C, 'o-'); grid on;
xlabel('Component number');
ylabel('Percentage variance');
set(gca, 'XTick', 0:1:4);

% (2) Plot the data points using the first two PCs as axes, 
%     distinguishing between the classes using different color or marker

X_cov = cov(X_a);
[pc, var, pve] = pcacov(X_cov);
pc1 = X*pc(:, 1);
pc2 = X*pc(:, 2);
figure;
hold on; box on;
scatter(pc1(1:50), pc2(1:50), 'r');
scatter(pc1(51:100), pc2(51:100), 'g');
scatter(pc1(101:150), pc2(101:150), 'b');
hold off;
xlabel('PC1');
ylabel('PC2');
legend('setosa', 'versicolor', 'virginica');

% (b)
% (1) Perform LDA on the original explanatory variables
% nomalize
X = normc(X);
% training set
a_train = X(1:30, :);
b_train = X(51:80, :);
c_train = X(101:130, :);

y = {a_train, b_train, c_train};

L = 3;
N1 = 30;
N2 = 30;
N3 = 30;
N = N1 + N2 + N3;
m1 = (1/N1)*sum(a_train);
m2 = (1/N2)*sum(b_train);
m3 = (1/N3)*sum(c_train);
m = [m1; m2; m3];
m0 = (N1/N)*m1 + (N2/N)*m2 + (N3/N)*m3;
% Sb
Sb = 0;
for i = 1:L
    Sb = Sb + (N1/N)*(m(i, :) - m0)'*(m(i, :) - m0);
end

% Sw
Sw = 0;
for i = 1:L
    for j = 1:N1
        Sw = Sw + (N1/N)*( y{i}(j, :) - m(i, :) )'*( ( y{i}(j, :) - m(i, :)) );
    end
end

% Find the optimal v for the data in the table above

[w, ~] = eig( Sb^(1/2)*Sw^(-1)*Sb^(1/2) );
v = real(Sb^(-1/2)*w);

a_LD1 = a_train*v(:, 1);
b_LD1 = b_train*v(:, 1);
c_LD1 = c_train*v(:, 1);
a_LD2 = a_train*v(:, 2);
b_LD2 = b_train*v(:, 2);
c_LD2 = c_train*v(:, 2);
figure; hold on; box on;
scatter(a_LD1, a_LD2, 'r');
scatter(b_LD1, b_LD2, 'g');
scatter(c_LD1, c_LD2, 'b');
hold off;
xlabel('LD1');
ylabel('LD2');
title('training set');
legend('setosa', 'versicolor', 'virginica');

% test set
a_test = X(31:50, :);
b_test = X(81:100, :);
c_test = X(131:150, :);

a_LD1 = a_test*v(:, 1);
b_LD1 = b_test*v(:, 1);
c_LD1 = c_test*v(:, 1);
a_LD2 = a_test*v(:, 2);
b_LD2 = b_test*v(:, 2);
c_LD2 = c_test*v(:, 2);
figure; hold on; box on; 
scatter(a_LD1, a_LD2, 'r');
scatter(b_LD1, b_LD2, 'g');
scatter(c_LD1, c_LD2, 'b');
hold off;
xlabel('LD1');
ylabel('LD2');
title('test set');
legend('setosa', 'versicolor', 'virginica');


% (2) Perform LDA on the PCs obtained above
U2 = U;
U2(:,3:150) = 0;
X = (U2*S*V');

X = normc(X);
% training set
a_train = X(1:30, :);
b_train = X(51:80, :);
c_train = X(101:130, :);

y = {a_train, b_train, c_train};

L = 3;
N1 = 30;
N2 = 30;
N3 = 30;
N = N1 + N2 + N3;
m1 = (1/N1)*sum(a_train);
m2 = (1/N2)*sum(b_train);
m3 = (1/N3)*sum(c_train);
m = [m1; m2; m3];
m0 = (N1/N)*m1 + (N2/N)*m2 + (N3/N)*m3;
% Sb
Sb = 0;
for i = 1:L
    Sb = Sb + (N1/N)*(m(i, :) - m0)'*(m(i, :) - m0);
end

% Sw
Sw = 0;
for i = 1:L
    for j = 1:N1
        Sw = Sw + (N1/N)*( y{i}(j, :) - m(i, :) )'*( ( y{i}(j, :) - m(i, :)) );
    end
end

% Find the optimal v for the data in the table above
[w, ~] = eig( Sb^(1/2)*Sw^(-1)*Sb^(1/2) );
v = real(Sb^(-1/2)*w);

a_LD1 = a_train*v(:, 1);
b_LD1 = b_train*v(:, 1);
c_LD1 = c_train*v(:, 1);
a_LD2 = a_train*v(:, 2);
b_LD2 = b_train*v(:, 2);
c_LD2 = c_train*v(:, 2);
figure; hold on; box on;
scatter(a_LD1, a_LD2, 'r');
scatter(b_LD1, b_LD2, 'g');
scatter(c_LD1, c_LD2, 'b');
hold off;
xlabel('LD1');
ylabel('LD2');
title('training set');
legend('setosa', 'versicolor', 'virginica');


% test set
a_test = X(31:50, :);
b_test = X(81:100, :);
c_test = X(131:150, :);

a_LD1 = a_test*v(:, 1);
b_LD1 = b_test*v(:, 1);
c_LD1 = c_test*v(:, 1);
a_LD2 = a_test*v(:, 2);
b_LD2 = b_test*v(:, 2);
c_LD2 = c_test*v(:, 2);
figure; hold on; box on; 
scatter(a_LD1, a_LD2, 'r');
scatter(b_LD1, b_LD2, 'g');
scatter(c_LD1, c_LD2, 'b');
hold off;
xlabel('LD1');
ylabel('LD2');
title('test set');
legend('setosa', 'versicolor', 'virginica');

