%此处存储过程代码
% 给定矩形的四个顶点坐标

% % 给定一个点的坐标
% len=length(mLine);
% point_1=[vXTemp(mLine(1,1)),vYTemp(mLine(1,1))];
% point_2=[vXTemp(mLine(len,1)),vYTemp(mLine(len,1))];
% 
% % 判断点是否在矩形内
% % inRectangle = inpolygon(point(1), point(2), rect(:, 1), rect(:, 2));
% 
% % if inRectangle
% %     disp('点在矩形内部，最近的边是矩形的边界');
% % else
%     % 计算点到每条边的距离
%     distances = zeros(4, 1);
%     for i = 1:4
%         p1 = rect(i, :);
%         p2 = rect(mod(i, 4) + 1, :);
%         distances(i) = point_to_line_distance(point_1, p1, p2);
%     end
%     
%     % 找到最小距离及对应的边
%     [minDistance, minIndex] = min(distances);
%     disp(['点到矩形边的最近距离是 ', num2str(minDistance), '，最近的边是第 ', num2str(minIndex), ' 条边']);
%     
%     distances1 = zeros(4, 1);
%     for i = 1:4
%         p1 = rect(i, :);
%         p2 = rect(mod(i, 4) + 1, :);
%         distances1(i) = point_to_line_distance(point_2, p1, p2);
%     end
%     
%     % 找到最小距离及对应的边
%     [minDistance1, minIndex1] = min(distances1);
%     disp(['点到矩形边的最近距离是 ', num2str(minDistance1), '，最近的边是第 ', num2str(minIndex1), ' 条边']);
%     
%     [mLine]=Func_rewrite(mLine,minIndex.minIndex1);
% end

function distance = point_to_line_distance(point, p1, p2)
    A = point - p1;
    B = p2 - p1;
    t = dot(A, B) / dot(B, B);
    
    if t <= 0
        distance = norm(point - p1);
    elseif t >= 1
        distance = norm(point - p2);
    else
        projection = p1 + t * B;
        distance = norm(point - projection);
    end
end