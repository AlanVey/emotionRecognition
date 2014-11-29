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
  tree = tree{1,1};
  info = [0,0];
  while (size(tree.kids, 1) > 0)
    tree = tree.kids{1, val(tree.op) + 1};
    info(1) = info(1) + 1;
  end
  info(2) = tree.class;
end
