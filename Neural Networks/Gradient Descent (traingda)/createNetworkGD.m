function [net] = createNetworkGD(layerSize, numLayers, valPc, lr, lr_inc, lr_dec, x, y)
  hiddenSizes(1:numLayers) = layerSize;
  net = feedforwardnet(hiddenSizes, 'traingda');
  
  net.divideFcn = 'divideind';
  net.divideParam.trainInd = 1 : floor(length(x) - (length(x) * valPc));
  net.divideParam.valInd = ceil(length(x) - (length(x) * valPc)) : length(x);
  net.divideParam.testInd = length(x);
  
  net.trainParam.lr = lr;
  net.trainParam.lr_inc	= lr_inc; % Ratio to increase learning rate
  net.trainParam.lr_dec = lr_dec; % Ratio to decrease learning rate
  
  net = configure(net, x, y);
  [net, ~] = train(net, x, y);
end