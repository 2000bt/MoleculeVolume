function [validContourCoords, validContourCoords1] = Func_RayCasting_Intersect(contourCoords, totalContours, pointsPerContour, contourCoords1, totalContours1, pointsPerContour1)
    % 初始化结果
    validContourCoords = [];
    validContourCoords1 = [];
    
    % 遍历第一组轮廓的所有轮廓
    startIdx1 = 1;
    for i = 1:totalContours
        % 当前轮廓点坐标
        currentContour1 = contourCoords(startIdx1:startIdx1 + pointsPerContour(i) - 1, :);
        startIdx1 = startIdx1 + pointsPerContour(i);
        
        % 遍历第二组轮廓
        startIdx2 = 1;
        for j = 1:totalContours1
            % 第二组中的一个轮廓
            currentContour2 = contourCoords1(startIdx2:startIdx2 + pointsPerContour1(j) - 1, :);
            startIdx2 = startIdx2 + pointsPerContour1(j);
            
            % 找出第一组当前轮廓在第二组当前轮廓内的点
            for k = 1:size(currentContour1, 1)
                if isPointInPolygon(currentContour1(k, :), currentContour2)
                    validContourCoords = [validContourCoords; currentContour1(k, :)];
                end
            end
            
            % 找出第二组当前轮廓在第一组当前轮廓内的点
            for k = 1:size(currentContour2, 1)
                if isPointInPolygon(currentContour2(k, :), currentContour1)
                    validContourCoords1 = [validContourCoords1; currentContour2(k, :)];
                end
            end
        end
    end
end

function inside = isPointInPolygon(point, polygon)
    % 使用 Ray-Casting 算法判断点是否在多边形内部
    x = point(1);
    y = point(2);
    n = size(polygon, 1);
    inside = false;
    
    j = n;
    for i = 1:n
        xi = polygon(i, 1);
        yi = polygon(i, 2);
        xj = polygon(j, 1);
        yj = polygon(j, 2);
        
        if ((yi > y) ~= (yj > y)) && ...
           (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
            inside = ~inside;
        end
        j = i;
    end
end
