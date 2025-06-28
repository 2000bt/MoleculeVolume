% 定义最小点和最大点的坐标
minX = 0; minY = 0; minZ = 0;
maxX = 1; maxY = 1; maxZ = 1;

% 根据最小点和最大点计算8个顶点的坐标
vertices = [
    minX, minY, minZ;  % P1
    maxX, minY, minZ;  % P2
    maxX, maxY, minZ;  % P3
    minX, maxY, minZ;  % P4
    minX, minY, maxZ;  % P5
    maxX, minY, maxZ;  % P6
    maxX, maxY, maxZ;  % P7
    minX, maxY, maxZ   % P8
];

% 定义长方体的边连接关系 (每行表示一条边的两个端点索引)
edges = [
    1, 2; 2, 3; 3, 4; 4, 1;  % 底面
    5, 6; 6, 7; 7, 8; 8, 5;  % 顶面
    1, 5; 2, 6; 3, 7; 4, 8   % 竖直边
];

% 绘制长方体的边
figure;
hold on;
for i = 1:size(edges, 1)
    % 获取边的两个端点坐标
    pt1 = vertices(edges(i, 1), :);
    pt2 = vertices(edges(i, 2), :);
    
    % 绘制边
    plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)], 'b-', 'LineWidth', 2);
end

% 设置轴属性
grid on;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('长方体的12条边');
view(3); % 3D视图
hold off;
