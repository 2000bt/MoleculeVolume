% faces = [
%     1 2 3;
%     2 3 4;
%     5 6 7;
%     3 2 4;
%     8 9 10
% ];
% 
% vdx = [2; 3; 4];
% 
% % 初始化一个逻辑数组来记录匹配的行
% matching_rows = false(size(faces, 1), 1);
% 
% % 遍历 faces 的每一行，检查每个元素是否都包含在 vdx 中
% for i = 1:size(faces, 1)
%     % 检查该行的三个元素是否全部都包含在 vdx 中
%     if all(ismember(faces(i,:), vdx))  % 检查 faces(i,:) 的每个元素是否都在 vdx 中
%         matching_rows(i) = true;
%     end
% end
% 
% % 得到 faces 中匹配的行的索引
% matching_indices = find(matching_rows);
% 
% % 提取出这些匹配的行
% matching_faces = faces(matching_indices, :);
% 
% % 显示结果
% disp(matching_faces);
% faces_front = Surface4.faces(1:len1-length_idxy_un, :);  % 前n个面
% vertices_front_indices = unique(faces_front(:));  % 前n个面的唯一顶点
% vertices_front = Surface4.vertices(vertices_front_idx, :);
% colors = [
%     0 1 0;   % 红色（第一个三角形）
% ];
% %%
% Surface5=Surface3;
% Surface6=Surface4;
% figure;
% hold on;
% S=Surface5; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% S=Surface6; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'r');
% 
%%
resultRows = [];
for i = 1:size(Surface4.faces, 1)
    if any(Surface4.faces(i, :) == 789) && any(Surface4.faces(i, :) == 790)
        resultRows = [resultRows; i];  % 记录符合条件的行索引
    end
end
%%
cross_prod = @(a,b) [... 
  a(:,2).*b(:,3) - a(:,3).*b(:,2), ...
  a(:,3).*b(:,1) - a(:,1).*b(:,3), ...
  a(:,1).*b(:,2) - a(:,2).*b(:,1)];
% dot_prod = @(a,b) a(:,1).*b(:,1) + a(:,2).*b(:,2) + a(:,3).*b(:,3);
% normalize = @(V) bsxfun(@rdivide, V, sqrt(sum(V.^2, 2)));

V1 = [vX1(vFace1(:,1)),vY1(vFace1(:,1)),vZ1(vFace1(:,1))];
V2 = [vX1(vFace1(:,2)),vY1(vFace1(:,2)),vZ1(vFace1(:,2))];
V3 = [vX1(vFace1(:,3)),vY1(vFace1(:,3)),vZ1(vFace1(:,3))];
normal = cross_prod(V2-V1,V3-V1); % array size nFace1 x 3
% for i = 1:size(normal, 1)
%     if normal(i, 3) < 0  % 如果 nz 为负
%         normal(i, :) = -normal(i, :);  % 反转法向量方向
%     end
% end
% nx = normal(:,1);
% ny = normal(:,2);
% nz = normal(:,3);
% clear normal;
%%
a=10;
b=5;
[a,b]=deal(b,a);