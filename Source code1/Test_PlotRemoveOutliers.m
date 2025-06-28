strFile='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.dst';
 [ ~, ~,  ~, CubePoints,  ~,  ~,  ~ ] = Func_GetCubePoints( strFile );

 %%剔除离群点前     
% % 检查 CubePoints 的大小
% if isempty(CubePoints) || size(CubePoints, 2) < 5
%     error('CubePoints 的列数少于 5 或为空，请检查输入数据');
% end
% 
% % 提取 CubePoints 中的不同类型的点
% blackPoints = CubePoints(CubePoints(:, 5) == 0, :); % 标记为 0 的点
% greenPoints = CubePoints(CubePoints(:, 5) == 1, :); % 标记为 1 的点
% 
% % 创建一个新的图形窗口
% figure;
% 
% % 如果有黑色点，绘制它们
% if ~isempty(blackPoints)
%     scatter3(blackPoints(:, 1), blackPoints(:, 2), blackPoints(:, 3), 10, 'k', 'filled');
%     hold on;
% end
% 
% % 如果有绿色点，绘制它们
% if ~isempty(greenPoints)
%     scatter3(greenPoints(:, 1), greenPoints(:, 2), greenPoints(:, 3), 10, 'g', 'filled');
%     hold on;
% end
% 
% % 设置坐标轴标签
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% 
% % 设置图形的标题
% title('3D Point Cloud Visualization');
% 
% % 显示图例（如果数据不为空）
% if ~isempty(blackPoints) && ~isempty(greenPoints)
%     legend('CubePoints = 0', 'CubePoints = 1');
% elseif ~isempty(blackPoints)
%     legend('CubePoints = 0');
% elseif ~isempty(greenPoints)
%     legend('CubePoints = 1');
% end
% 
% % 释放 hold，允许后续图形覆盖
% hold off;
% 
% % 设置图形的视角
% view(3);

%%剔除离群点后
% 假设 CubePoints 已经在之前的代码中计算出来了

% 提取绿色点云
greenPoints = CubePoints(CubePoints(:, 5) == 1, :);

% 如果存在绿色点，调整作图区域
if ~isempty(greenPoints)
    % 计算绿色点的边界范围
    min_x_green = min(greenPoints(:, 1));
    max_x_green = max(greenPoints(:, 1));
    min_y_green = min(greenPoints(:, 2));
    max_y_green = max(greenPoints(:, 2));
    min_z_green = min(greenPoints(:, 3));
    max_z_green = max(greenPoints(:, 3));
    
    % 设置作图区域范围，将作图区域向绿色点靠拢
    xlim([min_x_green, max_x_green]);
    ylim([min_y_green, max_y_green]);
    zlim([min_z_green, max_z_green]);
end

% 提取黑色点云（剔除不在图像范围内的点）
blackPoints = CubePoints(CubePoints(:, 5) == 0, :);

% 创建一个新的图形窗口
figure;
pointSize1=4;
pointSize2=8;
% 如果有黑色点，绘制它们
if ~isempty(blackPoints)
    %scatter3(blackPoints(:, 1), blackPoints(:, 2), blackPoints(:, 3), 10, 'k', 'filled');
    scatter3(blackPoints(:, 1), blackPoints(:, 2), blackPoints(:, 3), pointSize1, 'k', 'filled', 'MarkerFaceAlpha', 0.5);
    hold on;
end

% 绘制绿色点云
%scatter3(greenPoints(:, 1), greenPoints(:, 2), greenPoints(:, 3), 10, 'g', 'filled');
scatter3(greenPoints(:, 1), greenPoints(:, 2), greenPoints(:, 3), pointSize2, 'r', 'filled', 'MarkerFaceAlpha', 1);
hold on;

% 设置坐标轴标签
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
set(gca, 'Visible', 'off'); % 隐藏坐标轴和背景
% % 设置图形的标题
% title('Focused 3D Point Cloud Visualization');
% 
% % 显示图例（如果数据不为空）
% if ~isempty(blackPoints) && ~isempty(greenPoints)
%     legend('CubePoints = 0', 'CubePoints = 1');
% elseif ~isempty(blackPoints)
%     legend('CubePoints = 0');
% elseif ~isempty(greenPoints)
%     legend('CubePoints = 1');
% end
hold on;

% 根据最小点和最大点计算8个顶点的坐标
vertices = [
    min_x_green, min_y_green, min_z_green;  % P1
    max_x_green, min_y_green, min_z_green;  % P2
    max_x_green, max_y_green, min_z_green;  % P3
    min_x_green, max_y_green, min_z_green;  % P4
    min_x_green, min_y_green, max_z_green;  % P5
    max_x_green, min_y_green, max_z_green;  % P6
    max_x_green, max_y_green, max_z_green;  % P7
    min_x_green, max_y_green, max_z_green   % P8
];

% 定义长方体的边连接关系 (每行表示一条边的两个端点索引)
edges = [
    1, 2; 2, 3; 3, 4; 4, 1;  % 底面
    5, 6; 6, 7; 7, 8; 8, 5;  % 顶面
    1, 5; 2, 6; 3, 7; 4, 8   % 竖直边
];

% 绘制长方体的边

hold on;
for i = 1:size(edges, 1)
    % 获取边的两个端点坐标
    pt1 = vertices(edges(i, 1), :);
    pt2 = vertices(edges(i, 2), :);
    
    % 绘制边
    plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)], 'b', 'LineWidth', 2);
end

% 释放 hold，允许后续图形覆盖
hold off;

% 设置图形的视角
view(3);
