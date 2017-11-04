% data preparation
load('07HW2_digit.mat'); 
train = [train0;train1;train2;train3;train4;train5;train6;train7;train8;train9];
train = double(train);
test = [test0;test1;test2;test3;test4;test5;test6;test7;test8;test9];
test = double(test);

% group labeling
label_train(5000,1) = 0; % train data labeling
label_test(1000,1) = 0;  % test data labeling
for i = 1:10
    label_train((i-1)*500+1:i*500) = i-1;
    label_test((i-1)*100+1:i*100) = i-1;
end

% gray level-binariy conversion
for i = 1:5000
    for j = 1:784
        if train(i,j) ~= 0  % train data
            train(i,j) = 1;
        end
    end
end
for i = 1:1000
    for j = 1:784
        if test(i,j) ~= 0  % test data
            test(i,j) = 1;
        end
    end
end

% SVM, RBF kernel
ACC = [];
for g = 1:5; 
    for c = 1:5;
        gamma = 2^(-16+g*2);
        cost = 2^(-7+c*2);
        libsvm_options = ['-s', ' ', '1' , ' ', '-t', ' ', '2', '-g', ' ', num2str(gamma), ' ', '-c', ' ', num2str(cost)];
        SVMStruct = svmtrain(label_train(1:1000,:), train(1:1000,:), libsvm_options);  % model construction     
        [predict_label, accuracy, dec_values] = svmpredict(label_test(1:200,:), test(1:200,:), SVMStruct);
        ACC = [ACC accuracy];
    end
end

%%
% SVM, linear kernel
ACC = [];
for g = 1:5; 
    for c = 1:5;
        gamma = 2^(-16+g*2);
        cost = 2^(-7+c*2);
        libsvm_options = ['-s', ' ', '0' , ' ', '-t', ' ', '0', '-g', ' ', num2str(gamma), ' ', '-c', ' ', num2str(cost)];
        SVMStruct = svmtrain(label_train(1:1000,:), train(1:1000,:), libsvm_options);  % model construction     
        [predict_label, accuracy, dec_values] = svmpredict(label_test(1:200,:), test(1:200,:), SVMStruct);
        ACC = [ACC accuracy];
    end
end

%%
% SVM, polynomial kernel
ACC = [];
for
    for g = 1:5;
        for c = 1:5;
            gamma = 2^(-16+g*2);
            cost = 2^(-7+c*2);
            libsvm_options = ['-s', ' ', '0' , ' ', '-t', ' ', '0', '-g', ' ', num2str(gamma), ' ', '-c', ' ', num2str(cost)];
            SVMStruct = svmtrain(label_train(1:1000,:), train(1:1000,:), libsvm_options);  % model construction
            [predict_label, accuracy, dec_values] = svmpredict(label_test(1:200,:), test(1:200,:), SVMStruct);
            ACC = [ACC accuracy];
        end
    end
end

figure; set(gcf, 'Color', [1 1 1]);
plot(ACC(:,1))