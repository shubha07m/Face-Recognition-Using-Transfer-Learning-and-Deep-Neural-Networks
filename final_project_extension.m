
[featuresTrain, featuresValidation, YTrain, YValidation] = trainvalid_creation_func();


sc1 = {};
sc2 = {};
success = 0;
for i = 1:3:118
    for j = 1:3:118
        sc1 = [sc1,mysimcos_func(featuresValidation(i,:),featuresValidation(j+1,:))];
        sc2 = [sc2,mysimcos_func(featuresValidation(i,:),featuresValidation(j+2,:))];
        sc = cell2mat([sc1' sc2']);
    end
    
    maxscore = max(max(sc(:,1)), max(sc(:,2)));
    k = ((i-1)/3 + 1);
    if (maxscore == sc(k,1) || maxscore == sc(k,2))
        success = success +1;
    
    end
        
    j = 1;
    
    sc1 = {};
    sc2 = {};
    
end

disp(success)