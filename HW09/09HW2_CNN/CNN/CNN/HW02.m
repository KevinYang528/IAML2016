clear; clc;

% load('mnist_uint8.mat');
load('07HW2_digit.mat');

train_x = cat(1, train0, train1, train2, train3, train4, train5,...
    train6, train7, train8, train9);
test_x = cat(1, test0, test1, test2, test3, test4, test5,...
    test6, test7, test8, test9);
train_y = zeros(5000, 10);
test_y = zeros(1000, 10);
for i = 1:10
    train_y(500*(i-1)+1:500*i, i) = 1;
    test_y(100*(i-1)+1:100*i, i) = 1; 
end


train_x = double(reshape(train_x',28,28,5000))/255;
test_x = double(reshape(test_x',28,28,1000))/255;
train_y = double(train_y');
test_y = double(test_y');

% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
% will run 1 epoch in about 200 second and get around 11% error. 
% With 100 epochs you'll get around 1.2% error
rand('state',0)
cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};
cnn = cnnsetup(cnn, train_x, train_y);

opts.alpha = 1;
opts.batchsize = 5;
opts.numepochs = 5;

cnn = cnntrain(cnn, train_x, train_y, opts);

[er, bad] = cnntest(cnn, test_x, test_y);

%plot mean squared error
figure; plot(cnn.rL);

assert(er<0.12, 'Too big error');