% Test different features

% Loading train and test data
load('yes_train.mat');
load('no_train.mat');
load('marvin_train.mat');
load('yes_test.mat');
load('no_test.mat');
load('marvin_test.mat');



% Put training data in one matrix
TrainData = [yes_train yes_test no_train no_test marvin_train marvin_test];
% Number of training examples
m_train = size(TrainData,2); %number of training examples
% Labels vector
y_train = ones(m_train,1);
y_train = [y_train(1:1901); 2*y_train(1902:3801); 3*y_train(3802:end)];
num_of_features = 10
num_frames=20

num_labels = 3;
lambda = 1;

% Feature Extraction
TrainFeatures = zeros(num_of_features*m_train,num_frames);
for i = 1:m_train
    
    row_from = (i-1)*num_of_features+1;
    row_to = i*num_of_features;
    TrainFeat = TestingFeatures(TrainData(:,i),16000,1/num_frames,1/num_frames);
    TrainFeatures(row_from:row_to,:) = TrainFeat;
    
end
% Reshape
TrainFeaturesMat = TrainFeatures';
Train_unroll = TrainFeaturesMat(:);
TrainFeatRe = reshape(Train_unroll,[num_frames*num_of_features m_train]);
TrainFeaturesMat = TrainFeatRe';

n_train = size(TrainFeaturesMat, 2);
theta_train = zeros(n_train, 1);
% Compute hypothesis
h = 1./(1+exp(-(TrainFeaturesMat * theta_train))); 
% Compute cost function and gradient
[J, grad] = lrCostFunction(theta_train, TrainFeaturesMat, y_train, lambda);
% Classifier OnevsAll
[all_theta_train] = oneVsAll(TrainFeaturesMat, y_train, num_labels, lambda);

% Prediction for training examples
pred_train = predictOneVsAll(all_theta_train, TrainFeaturesMat);
prediction_train = mean(double(pred_train == y_train) * 100);
fprintf('\nTraining data set prediction accuracy: %f \n' ,prediction_train);



% Plot features of 3 examples
% Plotting random examples 
rp = randperm(m_train);
for i = 1:3
    ex_num = rp(i);
    plot(TrainFeaturesMat(ex_num,1:num_frames),'DisplayName','ZCR'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames+1):(num_frames*2)),'DisplayName','Energy'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*2+1):(num_frames*3)),'DisplayName','Energy entropy'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*3+1):(num_frames*4)),'DisplayName','Spectral centroid'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*4+1):(num_frames*5)),'DisplayName','Spectral spread'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*5+1):(num_frames*6)),'DisplayName','Spectral entropy'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*6+1):(num_frames*7)),'DisplayName','Spectral flux'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*7+1):(num_frames*8)),'DisplayName','Spectral rolloff'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*8+1):(num_frames*9)),'DisplayName','Harmonic ratio'); hold on;
    plot(TrainFeaturesMat(ex_num,(num_frames*9+1):(num_frames*10)),'DisplayName','Fundamental frequency'); hold on;
    
    hold off
    legend
    if ex_num <= 1901 % examples of "yes" 
        title('Yes');
    elseif ex_num > 1902 && ex_num <= 3801 % examples of "no"
        title('No');
    else
        title('Marvin'); % examples of "marvin"
    end
    figure;
end    



% Validation set
% Loading validation data
load('yes_validate.mat');
load('no_validate.mat');
load('marvin_validate.mat');

ValidateData = [yes_validate no_validate marvin_validate];
% Number of CV dataset examples
m_val = size(ValidateData, 2);
% Labels 
y_val = ones(m_val,1);
y_val = [y_val(1:476); 2*y_val(477:951); 3*y_val(952:end)];

% Extract CV Data Features
ValidateFeatures = zeros(m_val*num_of_features,num_frames);
for i = 1:m_val
    
    rowc_from = (i-1)*num_of_features+1;
    rowc_to = i*num_of_features;
    ValidateFeat = TestingFeatures(ValidateData(:,i),16000,1/num_frames,1/num_frames);
    ValidateFeatures(rowc_from:rowc_to,:) = ValidateFeat;
    
end

ValidateFeatures = ValidateFeatures';
Validate_unroll = ValidateFeatures(:);
ValidateFeatures = reshape(Validate_unroll,[num_frames*num_of_features m_val]);
ValidateFeatures = ValidateFeatures';

% Find inf or nan values and replace with 100000
[row,col] = find(isnan(ValidateFeatures)| isinf(ValidateFeatures));
rc_size = size(row);
for i = 1:rc_size
    ValidateFeatures(row(i),col(i)) = 100000;
end

% Prediction for CV dataset
pred_validate = predictOneVsAll(all_theta_train, ValidateFeatures);
prediction_validate = mean(double(pred_validate == y_val) * 100);

fprintf('\nCross validation data set prediction accuracy: %f \n' ,prediction_validate);


% Prediction accuracy for each word
acc_yes = find(pred_train(1:1901)==1);
acc_yes = length(acc_yes)/1901*100;
fprintf('\nTrain data set "yes" prediction accuracy: %f \n' ,acc_yes);

acc_no = find(pred_train(1902:3801)==2);
acc_no = length(acc_no)/1900*100;
fprintf('\nTrain data set "no" prediction accuracy: %f \n' ,acc_no);

acc_marv = find(pred_train(3802:end)==3);
acc_marv = length(acc_marv)/1397*100;
fprintf('\nTrain data set "marvin" prediction accuracy: %f \n' ,acc_marv);


% Plot weights - theta
plot(all_theta_train(1,:),'m');hold on;
plot(all_theta_train(2,:),'r');hold on;
plot(all_theta_train(3,:),'b');hold on;
legend('Theta1','Theta2','Theta3');

% Words testing - optional

%detect_command(all_theta);
