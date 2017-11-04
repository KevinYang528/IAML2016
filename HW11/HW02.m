clear; clc; close all;

G = double(imread('11HW2_PatchPanelsGrey.jpeg'));
I = double(imread('11HW2_PatchPanels.jpg'));


figure; imshow(uint8(G));
title(['Original (Grey)']);
figure; imshow(uint8(I));
title(['Original (Color)']);

k = [2, 5, 10, 15, 20];
for i = 1:5
% 灰階    
G_reshape = reshape(G, [size(G, 1)*size(G, 2), 3]);
% k-means
opts = statset('Display', 'final');
[idx, C] = kmeans(G_reshape, k(i), 'Distance', 'cityblock',...
    'Replicates', 5, 'Options', opts);

G_kmeans = reshape(idx, [size(G, 1) size(G, 2)]);
% figure; imshow(uint8((G_kmeans-1).*255./4));

% 算出同類的色彩平均
avg = zeros(length(k(i)), 3);
fprintf('run\n');
for j = 1:k(i)
    sum = zeros(1, 3);
    n = 0;
    for m = 1:length(idx)
        if idx(m)==j
            sum = sum + G_reshape(m, :);
            n = n + 1;
        end
        avg(j, 1:3) = sum/n;
    end
    fprintf('...\n');
end
% 換成平均的顏色
fprintf('run\n');
G_reshape_avg = G_reshape;
for j = 1:k(i)
    for m = 1:length(idx)
        if idx(m) == j
            G_reshape_avg(m, :) = avg(j, :);
        end
    end
end

G_kmeans_avg = reshape(G_reshape_avg, [size(G, 1) size(G, 2), 3]);

figure; imshow(uint8(G_kmeans_avg));
title(['k = ', num2str(k(i)), ' (Grey)']);
imwrite(uint8(G_kmeans_avg), ['k=', num2str(k(i)),'(Grey).jpg']);



% 彩色
I_reshape = reshape(I, [size(I, 1)*size(I, 2), 3]);
% k-means
opts = statset('Display', 'final');
[idx2, C2_1] = kmeans(I_reshape, k(i), 'Distance', 'cityblock',...
    'Replicates', 5, 'Options', opts);
I_kmeans = reshape(idx2, [size(I, 1) size(I, 2)]);
% figure; imshow(uint8((I_kmeans-1).*255./4));

% 算出同類的色彩平均
avg2 = zeros(length(k(i)), 3);
fprintf('run\n');
for j = 1:k(i)
    sum = zeros(1, 3);
    n = 0;
    for m = 1:length(idx2)
        if idx2(m)==j
            sum = sum + I_reshape(m, :);
            n = n + 1;
        end
        avg2(j, 1:3) = sum/n;
    end
    fprintf('...\n');
end
% 換成平均的顏色
fprintf('run\n');
I_reshape_avg = I_reshape;
for j = 1:k(i)
    for m = 1:length(idx2)
        if idx2(m) == j
            I_reshape_avg(m, :) = avg2(j, :);
        end
    end
end

I_kmeans_avg = reshape(I_reshape_avg, [size(I, 1) size(I, 2), 3]);

figure; imshow(uint8(I_kmeans_avg));
title(['k = ', num2str(k(i)), ' (Color)']);
imwrite(uint8(I_kmeans_avg), ['k=', num2str(k(i)),'(Color).jpg']);

end

