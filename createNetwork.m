function [net] = createNetwork(layerSize, numLayers, valPc, trainFunc, x, y)
  hiddenSizes(1:numLayers) = layerSize;
  net = feedforwardnet(hiddenSizes, trainFunc);
  
  net.divideFcn = 'divideind';
  net.divideParam.trainInd = 1 : floor(length(x) - (length(x) * valPc));
  net.divideParam.valInd = ceil(length(x) - (length(x) * valPc)) : length(x);
  net.divideParam.testInd = length(x);
  
  net = configure(net, x, y);
  [net, ~] = train(net, x, y);
end