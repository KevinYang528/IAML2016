clear; clc; close all;

load('04HW2_noisy.mat');
[U, S, V] =  svd( X );

% (a) intrinsic dimensionality of the data is 10
U2 = U;
U2(:,11:560) = 0;
X2 = (U2*S*V');

num = [10 121 225 318 426];
figure;
for i = 1:5
    subplot(2, 5, i);
    colormap gray;
    imagesc(reshape(X(:, num(i)), 20, 28)');
    title({ [num2str( num(i) ), '^t^h']; ['Original'] });
    
    subplot(2, 5, i+5);
    imagesc(reshape(X2(:, num(i)), 20, 28)');
    title('Reconstructed');
end

% (b)
% intrinsic dimensionality of the data is 2
U3 = U;
U3(:,3:560) = 0;
X3 = (U3*S*V');
figure;
for i = 1:5
    subplot(2, 5, i);
    colormap gray;
    imagesc(reshape(X(:, num(i)), 20, 28)');
    title({ [num2str( num(i) ), '^t^h']; ['Original'] });
    
    subplot(2, 5, i+5);
    imagesc(reshape(X3(:, num(i)), 20, 28)');
    title('Reconstructed');
end
% intrinsic dimensionality of the data is 30
U4 = U;
U4(:, 31:560) = 0;
X4 = (U4*S*V');
figure;
for i = 1:5
    subplot(2, 5, i);
    colormap gray;
    imagesc(reshape(X(:, num(i)), 20, 28)');
    title({ [num2str( num(i) ), '^t^h']; ['Original'] });
    
    subplot(2, 5, i+5);
    imagesc(reshape(X4(:, num(i)), 20, 28)');
    title('Reconstructed');
end
figure;

C = diag(S).^2./sum(diag(S).^2);
plot(C);grid on;
xlabel('Component number');
ylabel('Percentage variance');
set(gca, 'XTick', 0:10:600);