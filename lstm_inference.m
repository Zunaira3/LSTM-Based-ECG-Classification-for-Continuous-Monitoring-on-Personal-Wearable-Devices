% lstm_inference.m
% Load trained model and run inference on new heartbeat segments
% Usage: preds = lstm_inference(net, testX)

function preds = lstm_inference(net, testX)
    % testX: cell array of sequences (same preprocessing as train)
    preds = cell(numel(testX),1);
    for i=1:numel(testX)
        Y = classify(net, testX{i});
        preds{i} = Y;
    end
end
