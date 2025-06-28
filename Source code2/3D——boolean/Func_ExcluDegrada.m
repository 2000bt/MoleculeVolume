function [Surface1]=Func_ExcluDegrada(Surface)
% 设置容差值
    epsilon = 1e-6;

    % 获取所有三角形的顶点坐标
    V1 = Surface.vertices(Surface.faces(:, 1), :);  % 顶点 1
    V2 = Surface.vertices(Surface.faces(:, 2), :);  % 顶点 2
    V3 = Surface.vertices(Surface.faces(:, 3), :);  % 顶点 3

    % 计算每个三角形的边向量 V1V2 和 V1V3
    V1V2 = V2 - V1;  % 从 V1 到 V2 的向量
    V1V3 = V3 - V1;  % 从 V1 到 V3 的向量

    % 计算叉积的每个分量
    cross_x = V1V2(:, 2).*V1V3(:, 3) - V1V2(:, 3).*V1V3(:, 2);  % X 分量
    cross_y = V1V2(:, 3).*V1V3(:, 1) - V1V2(:, 1).*V1V3(:, 3);  % Y 分量
    cross_z = V1V2(:, 1).*V1V3(:, 2) - V1V2(:, 2).*V1V3(:, 1);  % Z 分量

    % 计算叉积的模长
    cross_norm = sqrt(cross_x.^2 + cross_y.^2 + cross_z.^2);

    % 判断哪些三角形是退化的 (模长小于 epsilon)
    valid_faces = cross_norm >= epsilon;
%     num=size(Surface.faces,1)-size(valid_faces,1);
    % 删除退化的三角形
    Surface.faces = Surface.faces(valid_faces, :);
    Surface1=Surface;
end