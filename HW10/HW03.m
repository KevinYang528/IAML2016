clear; clc;

% (a) For k = 1, 3, 5, 11, 16, and 21, build kNN classifiers from the training data.
train = load('10HW3_train.txt');
valid = load('10HW3_validate.txt');
test = load('10HW3_test.txt');
k = [1, 3, 5, 11, 16, 21];

train_set = train(:, 1:784);
train_label = train(:, 785);
valid_set = valid(:, 1:784);
valid_label = valid(:, 785);
test_set = test(:, 1:784);
test_label = test(:, 785);


for i = 1:6
    
    model = fitcknn(train_set, train_label, 'NumNeighbors', k(i));
    train_pred(:, i) = predict(model, train_set);
    valid_pred(:, i) = predict(model, valid_set);
    test_pred(:, i) = predict(model, test_set);
    
end


train_err = zeros(1, 6);
valid_err = zeros(1, 6);
test_err = zeros(1, 6);
C = zeros(10, 10);
N = zeros(1, 10);

for i = 1:6
    
    train_temp = 0;
    valid_temp = 0;
    test_temp = 0;
    
    % training error
    for j = 1:1000
        
        if train_pred(j, i) ~= train_label(j)
            train_temp = train_temp + 1;
        end
        
        if j <= 300
            % validate error            
            if valid_pred(j, i) ~= valid_label(j)
                valid_temp = valid_temp + 1;
                
            end
            % test error            
            if test_pred(j, i) ~= test_label(j)
                test_temp = test_temp + 1;
            end
            
            % 3-NN
            if i == 2
            % Cij is the number of test examples that have label j
            % but are classified as label i by the classifier
            C( test_pred(j, i)+1, test_label(j)+1 ) = ...
                C( test_pred(j, i)+1, test_label(j)+1 ) + 1;
            
            % Nj is the number of test examples that have label j. 
            N( test_label(j)+1 ) = N( test_label(j)+1 ) + 1;          
            end
            
        end
        
        train_err(1, i) = train_temp/1000*100;
        valid_err(1, i) = valid_temp/300*100;
        test_err(1, i) = test_temp/300*100;
        
    end
end

% (b)Compute the confusion matrix of the classifier based on the data in 
%¡§10HW3_test.txt¡§.
CM = zeros(10, 10);
for i = 1:10
    CM(:, i) = C(:, i)/N(i);
end

% (c) Identify one falsely classified vector.
colormap gray;
imagesc(~reshape(test(41, 1:784), 28, 28)');


% §ä¥X¿ù»~ªº¼Æ¦r
for j = 1:300
    if test_pred(j, 2) ~= test_label(j) && test_label(j) == 3
        fprintf('%d\n', j);
    end
end
