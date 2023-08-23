
%% Getting the train and validation for features and target 
[featuresTrain, featuresValidation, YTrain, YValidation] = trainvalid_creation_func();

%% Generating genuine and imposter value for various pairs%% 
g1 = {};
im1 = {};
g2 = {};
im2 = {};

for i = 1:3:118
    
    g1 = [g1,mysimcos_func(featuresValidation(i,:),featuresValidation(i+1,:))];
    g2 = [g2,mysimcos_func(featuresValidation(i,:),featuresValidation(i+2,:))];
    j = i;
    for j = i:3:115   
        im1 = [im1,mysimcos_func(featuresValidation(i,:),featuresValidation(j+4,:))];
        im2 = [im2,mysimcos_func(featuresValidation(i,:),featuresValidation(j+5,:))];
        
    end
end

genuine = [cell2mat(g1) cell2mat(g2)]';
imposter = [cell2mat(im1) cell2mat(im2)]';

%% plot the distribution of genuine and imposter scores %%
figure (1);
hold on;
histogram(genuine);
histogram(imposter);

%% plot the ROC of genuine and imposter scores %%

gen_label = ones(80,1);
imp_label = zeros(1560,1);
scores = [genuine ; imposter];
label = [gen_label ; imp_label];
[X,Y,~,AUC]= perfcurve(label,scores,1);

figure (2);
plot(X,Y,'r','LineWidth',2)
xlabel('False positive rate'); ylabel('True positive rate');
title(['ROC for genuine-imposter matching - with AUC ' num2str(AUC)])
