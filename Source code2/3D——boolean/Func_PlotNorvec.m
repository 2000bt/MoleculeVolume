function [N,flags]=Func_PlotNorvec(Points_tri,N_orgin,if_compara)
    flags=false;
    N=zeros(1,4);
%     patch(Points_tri(:,1),Points_tri(:,2),Points_tri(:,3),'b','EdgeColor', 'k', 'FaceAlpha', 0.5);
%计算法向量看方向
    V1V2 = Points_tri(2,:) - Points_tri(1,:);  % 边P1P2
    V1V3 =  Points_tri(3,:) -  Points_tri(1,:);  % 边P1P3

    % 计算法向量（叉积）
    N(1,1:3) = cross(V1V2, V1V3);
%     centroid = (Points_tri(1,:)  + Points_tri(2,:)  + Points_tri(3,:) ) / 3;
if(if_compara)
    if(sign(N_orgin) ~= sign(N(1,3)))
        flags=true;
    end
end
 % 计算每个三角形的边向量 V1V2 和 V1V3
%     V1V2 = V2 - V1;  % 从 V1 到 V2 的向量
%     V1V3 = V3 - V1;  % 从 V1 到 V3 的向量

    % 计算叉积的每个分量
    cross_x = V1V2(:, 2).*V1V3(:, 3) - V1V2(:, 3).*V1V3(:, 2);  % X 分量
    cross_y = V1V2(:, 3).*V1V3(:, 1) - V1V2(:, 1).*V1V3(:, 3);  % Y 分量
    cross_z = V1V2(:, 1).*V1V3(:, 2) - V1V2(:, 2).*V1V3(:, 1);  % Z 分量

    % 计算叉积的模长
    N(1,4) = sqrt(cross_x.^2 + cross_y.^2 + cross_z.^2);


% 绘制法向量（从三角形中心向外）
% quiver3(centroid(1), centroid(2), centroid(3), N(1), N(2), N(3), 0.5, 'r', 'LineWidth', 2,'MaxHeadSize', 0.5);

end