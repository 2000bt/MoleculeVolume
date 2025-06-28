function [validContourCoords,validContourCoords1]=Func_AABB_EverySlice(contourCoords, totalContours, pointsPerContour,contourCoords1, totalContours1, pointsPerContour1)
% 初始化有效点集
validContourCoords = [];
validContourCoords1 = [];

% 遍历第一组轮廓
for i = 1:totalContours
    % 获取当前轮廓的点集
    contour = contourCoords(sum(pointsPerContour(1:i-1)) + 1 : sum(pointsPerContour(1:i)), :);
    
    % 初始化当前轮廓的有效点
    validContour = [];
    
    % 遍历第二组的每个轮廓，与当前第一组轮廓求交集
    for j = 1:totalContours1
        contour1 = contourCoords1(sum(pointsPerContour1(1:j-1)) + 1 : sum(pointsPerContour1(1:j)), :);
        
        % 计算当前第一组轮廓与第二组轮廓的包围盒交集
        minX = min(contour(:,1));
        maxX = max(contour(:,1));
        minY = min(contour(:,2));
        maxY = max(contour(:,2));
        
        minX1 = min(contour1(:,1));
        maxX1 = max(contour1(:,1));
        minY1 = min(contour1(:,2));
        maxY1 = max(contour1(:,2));
        
        % 计算交集区域
        intersectMinX = max(minX, minX1);
        intersectMaxX = min(maxX, maxX1);
        intersectMinY = max(minY, minY1);
        intersectMaxY = min(maxY, maxY1);
        
        % 剔除不在交集区域内的点
        validPoints = contour(contour(:,1) >= intersectMinX & contour(:,1) <= intersectMaxX & ...
                               contour(:,2) >= intersectMinY & contour(:,2) <= intersectMaxY, :);
        validContour = [validContour; validPoints]; % 合并有效点
    end
    
    % 将第一组有效点集合并
    validContourCoords = [validContourCoords; validContour];
end

% 遍历第二组轮廓
for i = 1:totalContours1
    % 获取当前轮廓的点集
    contour1 = contourCoords1(sum(pointsPerContour1(1:i-1)) + 1 : sum(pointsPerContour1(1:i)), :);
    
    % 初始化当前轮廓的有效点
    validContour1 = [];
    
    % 遍历第一组的每个轮廓，与当前第二组轮廓求交集
    for j = 1:totalContours
        contour = contourCoords(sum(pointsPerContour(1:j-1)) + 1 : sum(pointsPerContour(1:j)), :);
        
        % 计算当前第二组轮廓与第一组轮廓的包围盒交集
        minX1 = min(contour1(:,1));
        maxX1 = max(contour1(:,1));
        minY1 = min(contour1(:,2));
        maxY1 = max(contour1(:,2));
        
        minX = min(contour(:,1));
        maxX = max(contour(:,1));
        minY = min(contour(:,2));
        maxY = max(contour(:,2));
        
        % 计算交集区域
        intersectMinX1 = max(minX1, minX);
        intersectMaxX1 = min(maxX1, maxX);
        intersectMinY1 = max(minY1, minY);
        intersectMaxY1 = min(maxY1, maxY);
        
        % 剔除不在交集区域内的点
        validPoints1 = contour1(contour1(:,1) >= intersectMinX1 & contour1(:,1) <= intersectMaxX1 & ...
                                 contour1(:,2) >= intersectMinY1 & contour1(:,2) <= intersectMaxY1, :);
        validContour1 = [validContour1; validPoints1]; % 合并有效点
    end
    
    % 将第二组有效点集合并
    validContourCoords1 = [validContourCoords1; validContour1];
end