function predictions = nFoldCrossValidationDT(examples, answers, n, trees)
% CROSSVALIDATION takes in data and perfoms nfold validation, generates
% predictions and returns them with expected values
  predictions = cell(n, 2);

  for i = 1:n  
    [~, ~, ~, ~, tI1, tI2] = partition(size(answers, 1), i, n);
    
    predictions(i, 1) = {testTrees2(trees, examples(tI1:tI2, :))};
    predictions(i, 2) = {answers(tI1:tI2, :)};
  end

end

function [egI1, egI2, egI3, egI4, tI1, tI2] = partition(numEgs, i, n)
  ds  = numEgs/n;
  i1 = round((i - 1) * ds);
  i2 = round(i * ds);
  
  egI1 = 1;
  egI2 = i1 - 1;
  egI3 = i2 + 1;
  egI4 = numEgs;
  tI1 = i1;
  tI2 = i2;
  
  if i == 1
    egI1 = egI3;
    egI2 = egI3;
    tI1  = 1;
  elseif i == n
    egI3 = egI2;
    egI4 = egI2;
    tI2  = numEgs;
  end
  
end

function [predictions] = testTrees2(trees, x2)
  %chooses the tree with the longest branch
  predictions = ones(length(x2), 1);
  for (i = 1 : length(x2))
    maxBranch = 0;
    found = false;
    for (j = 1 : length(trees))
      info = inTree(x2(i,:), trees(j));
      if (info(2))
        if (~found)
          maxBranch = info(1);
          predictions(i) = j;
          found = true;
        elseif (info(1) > maxBranch)
          maxBranch = info(1);
          predictions(i) = j;
        end
      elseif (~found && info(1) > maxBranch)
        maxBranch = info(1);
        predictions(i) = j;
      end
    end
  end
end

function [info] = inTree(val, tree)
  info = [0,0];
  while (size(tree.kids, 1) > 0)
    tree = tree.kids{1, val(tree.op) + 1};
    info(1) = info(1) + 1;
  end
  info(2) = tree.class;
end

