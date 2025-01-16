function [contourCoords, totalContours, pointsPerContour] = Func_extractContourCoords(mLine, vContourPoint, vXTemp, vYTemp, iCountContour)
    % 计算所有轮廓点的总数
    totalPoints = sum(vContourPoint);
    
    % 初始化一个数组，行数为所有轮廓点的总数，列数为2（存储X和Y坐标）
    contourCoords = zeros(totalPoints, 2);
    
    % 初始化数组存储每个轮廓的点数
    pointsPerContour = zeros(iCountContour, 1);
    
    idxStart = 1;  % 每个轮廓的起始点索引
    rowIdx = 1;  % 用于存储每个轮廓点的行索引
    
    for i = 1:iCountContour
        idxEnd = sum(vContourPoint(1:i));  % 当前轮廓的结束点索引
        indices = mLine(idxStart:idxEnd, 1);  % 获取当前轮廓的点的索引
        coords = [vXTemp(indices), vYTemp(indices)];  % 获取对应点的坐标
        
        % 将坐标存储到 contourCoords 中
        contourCoords(rowIdx:rowIdx + vContourPoint(i) - 1, :) = coords;
        
        % 存储每个轮廓的点数
        pointsPerContour(i) = vContourPoint(i);
        
        rowIdx = rowIdx + vContourPoint(i);  % 更新行索引
        idxStart = idxEnd + 1;  % 更新下一个轮廓的起始点索引
    end
    
    % 返回轮廓总数
    totalContours = iCountContour;
end
