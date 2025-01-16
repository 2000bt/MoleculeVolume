% 假设 X, Y, Z 是 n x 1 的列向量，Face 是 N/3 x 3 的数组
function [unique_points,new_Face,indices]=Func_UniquePoints(X, Y, Z,face)

% 将 X, Y, Z 组合成点集
points = [X, Y, Z];

% 使用 unique 去重，并获取每个原始点的新索引
[unique_points, ~, indices] = unique(points, 'rows');

% 更新 Face 中的索引，使其指向去重后的点集
new_Face = indices(face);

% 提取去重后的 X, Y, Z
% new_X = unique_points(:, 1);
% new_Y = unique_points(:, 2);
% new_Z = unique_points(:, 3);