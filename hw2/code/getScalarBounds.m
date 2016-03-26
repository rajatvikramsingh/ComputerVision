function [firstBound, secondBound] = getScalarBounds(DoGPyramid, level)
    if (level-1 < 1)
        firstBound = level;
    else
        firstBound = level-1;
    end
    if (level+1 > size(DoGPyramid, 3))
        secondBound = level;
    else
        secondBound = level+1;
    end
end