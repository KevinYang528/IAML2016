clear; clc; close all;
data = load('data.txt');
y1 = data(:, 1:3);
y2 = data(:, 4:6);
y = {y1, y2};

N1 = 10;
N2 = 10;
N = N1 + N2;
m1 = (1/N1)*sum(y1);
m2 = (1/N2)*sum(y2);
m = [m1; m2];
m0 = (N1/N)*m1 + (N2/N)*m2;
% Sb
Sb = 0;
for i = 1:2
    Sb = Sb + (N1/N)*(m(i, :) - m0)'*(m(i, :) - m0);
end

% Sw
Sw = 0;
for i = 1:2
    for j = 1:N1
        Sw = Sw + (N1/N)*( y{i}(j, :) - m(i, :) )'*( ( y{i}(j, :) - m(i, :)) );
    end
end

% (b) Find the optimal v for the data in the table above

[w, ~] = eig( Sb^(1/2)*Sw^(-1)*Sb^(1/2) );
v = inv(Sw)*(m1' - m2');
% v = Sb^(-1/2)*w;
% ps: first colume of Sb^(-1/2)*w = inv(Sw)*(m1' - m2')
fprintf('optimal vector  :\n');
disp(v);

figure; 
scatter3(y1(:, 1), y1(:, 2), y1(:, 3), 'fill');
hold on;
scatter3(y2(:, 1), y2(:, 2), y2(:, 3), 'fill');
v0 = [0 0 0];
v_opt = v(:, 1)'/norm( v(:, 1)' );
v_line = [v0-v_opt;v_opt];
plot3(v_line(:, 1), v_line(:, 2), v_line(:, 3),'LineWidth', 2);
axis equal; hold off;

% (c) Plot a line representing your optimal direction v

% 將各個點投影到optimal direction v
y1_p = y1;
y2_p = y2;
P = (v_opt'*v_opt)/(v_opt*v_opt');
for i = 1:N1
y1_p(i, :) = P*y1(i, :)';
y2_p(i, :) = P*y2(i, :)';
end

figure;
scatter3(y1_p(:, 1), y1_p(:, 2), y1_p(:, 3), 'fill');
hold on;
scatter3(y2_p(:, 1), y2_p(:, 2), y2_p(:, 3), 'fill');
v_line = [v0-v_opt;v_opt];
plot3(v_line(:, 1), v_line(:, 2), v_line(:, 3), 'LineWidth', 1);
axis equal; hold off;

% (d) fit each distribution with a Gaussian

% 除以最佳投影向量的單位向量  norm( v_opt )，得到在最佳投影向量上的座標
for i = 1:N1
    y1_ax(i, :) = y1_p(i, :)./norm( v_opt );
    y2_ax(i, :) = y2_p(i, :)./norm( v_opt );
end
y1_pd = fitdist(y1_ax(:, 1),'Normal');
y2_pd = fitdist(y2_ax(:, 1),'Normal');

x_values = -1.5:0.01:1.5;
y1_pdf = pdf(y1_pd,x_values);
y2_pdf = pdf(y2_pd,x_values);

% find decision boundary
diff = 10;
for i = -1:0.0001:0
    diff_temp = abs( pdf(y1_pd, i) - pdf(y2_pd,  i) );
    if diff_temp < diff
        diff = diff_temp;
        db = i;
    end
end

figure;
plot(x_values,y1_pdf,'LineWidth',2);
hold on;
plot(x_values,y2_pdf,'LineWidth',2);
plot([db, db, db, db, db], -0:0.5:2, '--','LineWidth', 2);
hold off;

% (e) Training error
y1_true = 0;
y1_fulse = 0;
y2_true = 0;
y2_fulse = 0;
for i = 1:N1
    if y1_ax(i, 1) < db
        y1_true = y1_true + 1;
    else
        y1_fulse = y1_fulse + 1;
    end
    if y2_ax(i, 1) > db
        y2_true = y2_true + 1;
    else
        y2_fulse = y2_fulse + 1;
    end
end
training_error = 100*(y1_fulse + y2_fulse)/N;
fprintf('training_error = %.1f %%\n', training_error);
