% % 创建一个新的图形窗口
% figure;
% 
% % 定义平面
% planeVertices = [0, 0, 0; 22, 0, 0;  22, 20, 0; 0, 20, 0];
% planeFaces = [1, 2, 3, 4];
% patch('Vertices', planeVertices, 'Faces', planeFaces, 'FaceColor', 'none', 'FaceAlpha', 0.5);
% 
% hold on;
% 
% % 定义三角形的三个顶点，使其小于平面
% triangleVertices = [2.5, 0.5, -2.5; 1, 4, -1; 4, 2, -1.5];
% triangleVertices1 = [5.25, 0.5, -1.5; 3.75, 4, 0; 6.75, 2, -0.5];
% triangleVertices2 =  [8, 0.5, -1.1; 6.5, 4, 0.4; 9.5, 2, -0.1];
% triangleVertices3 = [10.75, 0.5, -1; 9.25, 4, 0.5; 12.25, 2, 0];
% % triangleVertices4 = [13.5, 0.5, -0.5; 12, 4, 1; 15, 2, 0.5];
% % triangleVertices5 = [16.25, 0.5, 0; 14.75, 4, 1.5; 17.75, 2, 1];
% triangleVertices6 = [13.5, 0.5, 1; 12, 4, 2.5; 15, 2, 2];
% triangleVertices7 = [16.25, 0.5, 0; 16.25, 0.5, 4; 17.75, 0.5, 0];
% % triangleVertices8 = [24.5, 0.5, 0; 23, 0.5, -2; 26, 0.5, 0];
% triangleVertices9 = [19, 0.5, 0; 19, 8, 0; 20.5, 2, 0];
% % 在平面下方绘制小三角形，颜色为淡黄色
% patch('Vertices', triangleVertices, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices1, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices2, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices3, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices4, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices5, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices6, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices7, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices8, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices9, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% 
% % 设置图形属性
% % axis equal;
% axis image;
% 定义三维线段的起点和终点
startPoint = [0, 0, 0];
endPoint = [4, 4, 4];

% 定义平行于z轴的切平面的位置
zPositions = [1, 2, 3];

% 绘制三维线段
figure;
plot3([startPoint(1), endPoint(1)], [startPoint(2), endPoint(2)], [startPoint(3), endPoint(3)], 'r-', 'LineWidth', 4);
hold on;
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Line Segment and Intersecting Planes');

% 计算并绘制线段与切平面的交点
for i = 1:length(zPositions)
    z = zPositions(i);
    
    % 计算交点
    t = (z - startPoint(3)) / (endPoint(3) - startPoint(3));
    intersectPoint = startPoint + t * (endPoint - startPoint);
    
    % 绘制交点
    plot3(intersectPoint(1), intersectPoint(2), z, 'r.', 'MarkerSize', 8, 'LineWidth', 2);
    
    % 绘制切平面
    [X, Y] = meshgrid(linspace(startPoint(1), endPoint(1), 10), linspace(startPoint(2), endPoint(2), 10));
    Z = z * ones(size(X));
    surf(X, Y, Z, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none');
end

legend('Line Segment', 'Intersect Points', 'Intersecting Planes', 'Location', 'best');
hold off;

axis off;
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('3D Plane and Small Triangle Below');

% 显示图例
% legend('Plane', 'Triangle');

% 关闭图形绘制
% hold off;
%%
% 定义两条直线的坐标
x1 = [0, 2];
y1 = [1.5, 3.5];

x2 = [1, 3];
y2 = [6, 2];

% 创建一个新的图形窗口
figure;

% 绘制第一条直线
plot(x1, y1, 'k', 'LineWidth', 2);
hold on;  % 保持图形，以便添加更多的图形元素

% 绘制第二条直线
plot(x2, y2, 'k', 'LineWidth', 2);
scatter(x1(1),y1(1),35,'k','filled');
scatter(x1(2),y1(2),35,'k','filled');
scatter(x2(1),y2(1),35,'k','filled');
scatter(x2(2),y2(2),35,'k','filled');
% 计算两条直线的包围盒
% min_x = min([x1, x2]);
% max_x = max([x1, x2]);
% min_y = min([y1, y2]);
% max_y = max([y1, y2]);
% 
width = x1(2) - x1(1);
height = y1(2) - y1(1);
width1 = x2(2) - x2(1);
height1 = y2(1) - y2(2);
% 绘制包围盒
rectangle('Position', [x1(1), y1(1), width, height], 'EdgeColor', [0.8235,0.1255,0.1529], 'LineWidth', 3,'LineStyle', '--');
rectangle('Position', [x2(1), y2(2), width1, height1], 'EdgeColor', [0.2196,0.3490,0.5373], 'LineWidth', 3,'LineStyle', '--');
% 设置轴的范围
axis image;
axis off;
% axis equal;
% axis([0, 10, 0, 10]);

% % 添加标题和标签
% title('Lines and their bounding box');
% xlabel('X-axis');
% ylabel('Y-axis');
% 
% % 显示图例
% legend('Line 1', 'Line 2', 'Bounding Box');

