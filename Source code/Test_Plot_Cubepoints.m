strFile='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.cub';
strFile1='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\B\B1.dst';
% tic;
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile );
% [ Atom_info1,AtomNum1, ElecCloudDenNum1, CubePoints1, step_num1, step1, org_coor1 ] = Func_GetCubePoints( strFile1 );
% 筛选出第五列为 1 的行（即要绘制的点云）
selected_points = CubePoints(CubePoints(:, 5) == 1, 1:3);

% % 绘制点云
% figure;
% scatter3(selected_points(:, 1), selected_points(:, 2), selected_points(:, 3), 'b.');
% title('点云绘图（第五列为1）');
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% grid on;

% 绘制点云
figure;
scatter3(selected_points(:, 1), selected_points(:, 2), selected_points(:, 3), 10, 'b.', 'MarkerEdgeAlpha', 1);
set(gca, 'Color', 'w');        % 设置背景为纯白
axis off;                      % 关闭坐标轴
set(gcf, 'Color', 'w');        % 设置图窗背景为纯白