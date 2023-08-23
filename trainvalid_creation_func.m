function [XTrain, XValidation, YTrain, YValidation] = trainvalid_creation_func()

    imds = imageDatastore('data', ...
        'IncludeSubfolders',true, ...
        'LabelSource','foldernames');

    [imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
    
    load vgg19_final.mat;
    net = vgg19_final;

    inputSize = net.Layers(1).InputSize;

    pixelRange = [-30 30];
    imageAugmenter = imageDataAugmenter( ...
        'RandXReflection',true, ...
        'RandXTranslation',pixelRange, ...
        'RandYTranslation',pixelRange);

    augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
        'ColorPreprocessing','gray2rgb','DataAugmentation',imageAugmenter); %Notice 'ColorPreprocessing','gray2rgb'

    augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation,'ColorPreprocessing','gray2rgb'); %Notice 'ColorPreprocessing','gray2rgb'


    layer = 'fc7';
    XTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
    XValidation = activations(net,augimdsValidation,layer,'OutputAs','rows');

    %%% Create geuine and impostor comparisons here, using cosine similarity
    %%% between featuresValidation pairs per lecture instructions

    YTrain = imdsTrain.Labels;
    YValidation = imdsValidation.Labels;