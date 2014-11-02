function [predictions] = testTrees2(trees, x2)
  fprintf('The number of examples is: %d', size(x2, 1));
  %chooses the tree with the longest branch
  predictions = ones(length(x2), 1);
  for (i = 1 : length(x2))
    maxBranch = 0;
    for (j = 2 : length(trees))
      branch = inTree(x2(i,:), trees(j));
      if(branch > maxBranch)
        maxBranch = branch;
        predictions(i) = j;
      end
    end
  end
end

function [level] = inTree(val, tree)
  tree = tree{1,1};
  level = 1;
  while (size(tree.kids, 1) > 0)
    tree = tree.kids{1, val(tree.op) + 1};
    level = level + 1;
  end
  if(tree.class == 0)
      level = -1;
  end
end