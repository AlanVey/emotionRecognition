function [net] = createNetworkRP( x, y )

  hiddenSizes(1:3) = 70;
  net = feedforwardnet(hiddenSizes, 'trainrp');
  
  net.divideFcn = 'divideind';
  net.divideParam.trainInd = 1 : floor(length(x) - (length(x) * 0.2));
  net.divideParam.valInd = ceil(length(x) - (length(x) * 0.2)) : length(x);
  net.divideParam.testInd = length(x);
  
  net.trainParam.delt_inc = 1.1;
  net.trainParam.delt_dec = 0.5;
  
  net = configure(net, x, y);
  [net, ~] = train(net, x, y);

end

