function total_volume=Func_ComputeVolume(Surface)
% 初始化体积
total_volume = 0;

% 获取每个三角形的顶点坐标
for i = 1:size(Surface.faces, 1)
    % 获取当前三角形的三个顶点
    V1 = Surface.vertices(Surface.faces(i, 1), :);
    V2 = Surface.vertices(Surface.faces(i, 2), :);
    V3 = Surface.vertices(Surface.faces(i, 3), :);
    
    % 计算向量 V1V2 和 V1V3
    V1V2 = V2 - V1;
    V1V3 = V3 - V1;
    
    % 计算叉积
    cross_product = cross(V1V2, V1V3);
    
    % 计算体积贡献
    volume_contribution = dot(V1, cross_product) / 6;
    
    % 累加体积
    total_volume = total_volume + volume_contribution;
end

% 显示总的体积
disp(['网格的体积为: ', num2str(total_volume)]);

end
