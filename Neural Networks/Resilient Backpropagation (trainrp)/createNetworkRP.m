function [net] = createNetworkRP( layerSize, numLayers, valPc, delt_inc, delt_dec, x, y )

  hiddenSizes(1:numLayers) = layerSize;
  net = feedforwardnet(hiddenSizes, 'trainrp');
  
  net.divideFcn = 'divideind';
  net.divideParam.trainInd = 1 : floor(length(x) - (length(x) * valPc));
  net.divideParam.valInd = ceil(length(x) - (length(x) * valPc)) : length(x);
  net.divideParam.testInd = length(x);
  
  net.trainParam.delt_inc = delt_inc;
  net.trainParam.delt_dec = delt_dec;
  
  net = configure(net, x, y);
  [net, ~] = train(net, x, y);

end

