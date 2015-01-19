function [predictions] = testANN(net, x2)
  result = sim(net, x2);
  predictions = NNout2labels(result);
end

