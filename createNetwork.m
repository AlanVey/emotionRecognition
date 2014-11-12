function [net] = createNetwork(layerSize, numLayers, trainFunc, x, y)
  hiddenSizes(1:numLayers) = layerSize;
  net = feedforwardnet(hiddenSizes, trainFunc);
  
  net = configure(net, x, y);
  [net, ~] = train(net, x, y);
end