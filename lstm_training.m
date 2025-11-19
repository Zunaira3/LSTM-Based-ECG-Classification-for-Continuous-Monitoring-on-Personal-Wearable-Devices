

if ~exist('trainX','var')
    error('Please prepare and load trainX (cell array) and trainY (categorical).');
end

inputSize = size(trainX{1},1); % change if features are arranged differently
numHiddenUnits = 128;
numClasses = numel(categories(trainY));

layers = [ ...
    sequenceInputLayer(inputSize,'Name','input')
    lstmLayer(numHiddenUnits,'OutputMode','last','Name','lstm1')
    fullyConnectedLayer(64,'Name','fc1')
    reluLayer('Name','relu')
    fullyConnectedLayer(numClasses,'Name','fc_out')
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classOutput')];

options = trainingOptions('adam', ...
    'MaxEpochs',20, ...
    'MiniBatchSize',32, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(trainX, trainY, layers, options);

% Save trained model
save('trained_lstm_model.mat','net');
