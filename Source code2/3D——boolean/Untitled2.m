%%
% in=full(inter_face);
% % spy(intersection);
% %%重构边界，还不确定需不需要
% [idxy,idxx]=find(in.');
% %%
% % 提取两个三角形的面片索引
% figure;
% hold on;
% len_idx=length(idxx);
% faces = [
%     1 2 3;   % 第一个三角形（对应 vertices 的第1-3行）
%     4 5 6;   % 第二个三角形（对应 vertices 的第4-6行）
% ];
% colors = [
%     0 0 1;   % 红色（第一个三角形）
%     0 0 1;   % 蓝色（第二个三角形）
% ];
% for pp=1:1
%     tri_faces = [
%     Surface.faces(idxx(pp), :);   % 从 Surface 提取第一个三角形的面片索引
%     Surface1.faces(idxy(pp), :)   % 从 Surface1 提取第一个三角形的面片索引
% ];
% vertices = [
%     Surface.vertices(tri_faces(1, :), :);  % 提取 Surface 对应三角形的顶点
%     Surface1.vertices(tri_faces(2, :), :)  % 提取 Surface1 对应三角形的顶点
% ];
%      patch('Faces', faces, 'Vertices', vertices, ...
%       'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%       'EdgeColor', 'r', 'LineWidth', 1);
% end
% 

% 设置图形显示
% [~,Surf] = SurfaceIntersection(Surface,Surface1);
% S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'k','LineWidth', 2,  'FaceColor', 'r');
% axis equal;
% view(3);
% xlabel('X'); ylabel('Y'); zlabel('Z');
% title('两个空间三角面片');
% grid on;

%%空间三角形快速相交算法求交线
% vFacetemp=vFace(vIdx,:);
% vFacetemp1=vFace(vIdx1,:);
% load tetmesh;
% TR = triangulation(tet,X);
% [Surface4.faces, Surface4.vertices] = freeBoundary(TR);
% 
% TR=triangulation(vFace,vX,vY,vZ);
% [Surface2.faces, Surface2.vertices] = freeBoundary(TR);
% 
% TR1=triangulation(vFace1,vX1,vY1,vZ1);
% [Surface3.faces, Surface3.vertices] = freeBoundary(TR1);

% Surface.vertices = [vX(:), vY(:), vZ(:)];  % 将 vX, vY, vZ 组合成一个矩阵，存储为 Surface.vertices
% Surface.faces = vFace;  
% Surface1.vertices = [vX1(:), vY1(:), vZ1(:)];  % 将 vX, vY, vZ 组合成一个矩阵，存储为 Surface.vertices
% Surface1.faces = vFace1;  

% %%判断面域位置关系-----------非交线环
% faces_front = Surface3.faces(1:len-length_idxx_un, :);  % 前n个面
faces_front1 = Surface4.faces(1:len1-length_idxy_un, :);  % 前n个面
% % 展开faces_front并提取唯一的顶点索引
% vertices_front_indices = unique(faces_front(:));  
vertices_front_indices1 = unique(faces_front1(:));  
% Surface_front.vertices = Surface3.vertices(vertices_front_indices, :);  % 从原vertices提取前n个面的顶点
Surface_front1.vertices = Surface4.vertices(vertices_front_indices1, :); 
% % 更新前n个面的faces索引，使其指向前n个顶点
% [~, new_face_idx] = ismember(faces_front, vertices_front_indices);  % 获取faces中的每个顶点的新索引
[~, new_face_idx1] = ismember(faces_front1, vertices_front_indices1);
% Surface_front.faces = new_face_idx;
Surface_front1.faces = new_face_idx1;
% %     Surface_front.vertices=Surface_front.vertices(2407,:);
% [vIdx_face,iCount]=Func_ExInrelation2(Surface_front.vertices,vX1,vY1,vZ1,vFace1);
[vIdx_face1,iCount1]=Func_ExInrelation2(Surface_front1.vertices,vX,vY,vZ,vFace);

% Step 2: 提取交线环
faces_remaining1 = Surface4.faces(len1-length_idxy_un+1:end, :);  % 剩余的面
vertices_remaining1 = unique(faces_remaining1(:)); 
Surface_remaining.vertices = Surface4.vertices(vertices_remaining1 , :);  % 从原vertices提取前n个面的顶点

%
[~, new_face_idx1] = ismember(faces_remaining1, vertices_remaining1);
Surface_remaining.faces = new_face_idx1;
%交线环以外
% [vIdx_face,iCount]=Func_ExInrelation2(Surface3,vX1,vY1,vZ1,vFace1);

%交线环
% [vIdx_interface,iCount2]=Func_ExInrelation1(Surface3,vX1,vY1,vZ1,vFace1);
%  Surface_remaining.faces=Surface_remaining.faces(456,:);
%  Surface_remaining.vertices=Surface_remaining.vertices(

% figure;
% hold on;
% patch('Faces', Surface_remaining.faces, 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;


% [vIdx_interface2,iCount4]=Func_ExInrelation2(Surface4.vertices,vX,vY,vZ,vFace);
%%对相交部分切割求体积
% %%
% % 非交线环识别在内部的三角形
% matching_rows = false(size(Surface_front.faces, 1), 1);
% % 遍历 faces 的每一行，检查是否包含 vdx 中的任意一个索引
% for i = 1:size(Surface_front.faces, 1)
%     % 检查该行的三个元素是否包含在 vdx 中的任意一个元素
%     if all(ismember(Surface_front.faces(i,:), vIdx_face) ) % 检查 faces(i,:) 的每个元素是否都在 vdx 中
%         matching_rows(i) = true;
%     end
% end
% % 得到 faces 中匹配的行的索引
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_front.faces(matching_indices,:), 'Vertices', Surface_front.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% 
% matching_rows = false(size(Surface_front1.faces, 1), 1);
% % 遍历 faces 的每一行，检查是否包含 vdx 中的任意一个索引
% for i = 1:size(Surface_front1.faces, 1)
%     % 检查该行的三个元素是否包含在 vdx 中的任意一个元素
%     if all(ismember(Surface_front1.faces(i,:), vIdx_face1) ) % 检查 faces(i,:) 的每个元素是否都在 vdx 中
%         matching_rows(i) = true;
%     end
% end
% % 得到 faces 中匹配的行的索引
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_front1.faces(matching_indices,:), 'Vertices', Surface_front1.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% %画非交线环送入识别的所有三角形
% figure;
% hold on;
% patch('Faces', Surface_front.faces, 'Vertices', Surface_front.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% figure;
% hold on;
% patch('Faces', Surface_front1.faces, 'Vertices', Surface_front1.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;

%%
% 画交线环
% for i = 1:size(Surface_remaining.faces, 1)
%     % 检查该行的三个元素是否包含在 vdx 中的任意一个元素
%     if all(ismember(Surface_remaining.faces(i,:), vIdx_interface2) ) % 检查 faces(i,:) 的每个元素是否都在 vdx 中
%         matching_rows(i) = true;
%     end
% end
% % 得到 faces 中匹配的行的索引
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_remaining.faces(matching_indices,:), 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% figure;
% hold on;
% patch('Faces', Surface_remaining.faces(vIdx_interface1,:), 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
%%
clc; clear; close all;

% 细长菱形的四个点坐标
x = [0, 4, 2, 2];  
y = [1, 1, 3, -1];

figure;
subplot(1,2,1);
hold on; axis equal;
title('满足德劳内三角剖分');
tri1 = [1 3 2; 1 4 3]; % 选择正确的对角线
triplot(tri1, x, y, 'b', 'LineWidth', 1.5);
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
draw_circumcircles(tri1, x, y, 'b'); % 绘制外接圆

subplot(1,2,2);
hold on; axis equal;
title('不满足德劳内三角剖分');
tri2 = [1 2 4; 2 3 4]; % 换另一条对角线，使外接圆包含点
triplot(tri2, x, y, 'r', 'LineWidth', 1.5);
plot(x, y, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
draw_circumcircles(tri2, x, y, 'r'); % 绘制外接圆



function draw_circumcircles(tri, x, y, color)
    for k = 1:size(tri,1)
        % 获取三角形三个顶点坐标
        A = [x(tri(k,1)), y(tri(k,1))];
        B = [x(tri(k,2)), y(tri(k,2))];
        C = [x(tri(k,3)), y(tri(k,3))];

        % 计算外接圆圆心和半径
        [xc, yc, R] = circumcircle(A, B, C);

        % 画外接圆
        theta = linspace(0, 2*pi, 100);
        plot(xc + R*cos(theta), yc + R*sin(theta), color, 'LineWidth', 1);
    end
end

function [xc, yc, R] = circumcircle(A, B, C)
    % 计算三角形外接圆的圆心和半径
    D = 2 * (A(1) * (B(2) - C(2)) + B(1) * (C(2) - A(2)) + C(1) * (A(2) - B(2)));

    % 外接圆圆心
    xc = ((A(1)^2 + A(2)^2) * (B(2) - C(2)) + ...
          (B(1)^2 + B(2)^2) * (C(2) - A(2)) + ...
          (C(1)^2 + C(2)^2) * (A(2) - B(2))) / D;
    yc = ((A(1)^2 + A(2)^2) * (C(1) - B(1)) + ...
          (B(1)^2 + B(2)^2) * (A(1) - C(1)) + ...
          (C(1)^2 + C(2)^2) * (B(1) - A(1))) / D;

    % 计算外接圆半径
    R = sqrt((A(1) - xc)^2 + (A(2) - yc)^2);
end
