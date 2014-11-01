function [predictions] = testTrees(trees, x2)
  predictions = ones(length(x2), 1);
  for (i = 1 : length(x2))
    for (j = 2 : length(trees))
      if (inTree(x2(i), trees(j)))
        predictions(i) = j;
      end
    end
  end
end

function [isInTree] = inTree(val, tree)
  tree
  while (~ISEMPTY(tree.kids))
    if (val(tree.op) == 0)
      tree = tree.kids(1);
    else
      tree = tree.kids(2);
    end
  end
  isInTree = tree.class;
end