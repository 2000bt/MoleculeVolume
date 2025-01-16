% %可视化三角等值面
% tic;
% FontSize = 22;
% FontWeight = 'bold';
% strFile = 'D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.dst';
% strFile1 = 'D:\GraStuCor\EleMolCloud\Molecule\宁利超1\B\B1.dst';
% [ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
% [ Atom_info1, AtomNum1, ~, CubePoints1, step_num1, step1, vStart1 ] = Func_GetCubePoints( strFile1 );
% 
% load LUT;
% 
% [X,Y,Z,vFace]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num(1), step_num(2), step_num(3), LUT);
% [X1,Y1,Z1,vFace1]=Func_GetAllBoundaries_And_Interpolation(CubePoints1, step_num1(1), step_num1(2), step_num1(3), LUT);
% X1=X1+10;
% elapsedTime = toc;
% disp(['代码运行时间: ', num2str(elapsedTime), ' 秒']);
% % 绘制三角形表面
% trisurf(vFace, X, Y, Z, 'FaceColor', 'red', 'EdgeColor', 'black');
% hold on; % 保持当前图形，以便在同一图中添加下一个表面
% trisurf(vFace1, X1, Y1, Z1, 'FaceColor', 'blue', 'EdgeColor', 'black');
% 
% % 设置图形的视角
% hold off; % 关闭保持
% axis equal;
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('3D Triangle Surface');
% legend('Surface 1', 'Surface 2'); % 添加图例








%%单个表面
% 可视化三角等值面
tic;  % 计时开始
FontSize = 22;
FontWeight = 'bold';

% 文件路径
strFile = 'D:\GraStuCor\EleMolCloud\Molecule\宁利超1\B\B1.dst';

% 获取数据
[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints(strFile);

% 加载查找表
load LUT;

% 计算边界和插值
[X,Y,Z,vFace] = Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num(1), step_num(2), step_num(3), LUT);

% 计算并输出代码运行时间
elapsedTime = toc;
disp(['代码运行时间: ', num2str(elapsedTime), ' 秒']);

% 绘制三角形表面
figure;  % 创建新图形窗口
trisurf(vFace, X, Y, Z, 'FaceColor', 'red', 'EdgeColor', 'black', 'FaceAlpha', 0.5);

% 设置图形的视角和标签
axis equal;
% xlabel('X', 'FontSize', FontSize, 'FontWeight', FontWeight);
% ylabel('Y', 'FontSize', FontSize, 'FontWeight', FontWeight);
% zlabel('Z', 'FontSize', FontSize, 'FontWeight', FontWeight);
% title('3D Triangle Surface', 'FontSize', FontSize, 'FontWeight', FontWeight);
% 隐藏坐标轴和其他图形元素
axis off;  % 关闭坐标轴
set(gca, 'Visible', 'off');  % 隐藏图形框架
set(gcf, 'Color', 'white');  % 设置背景为白色
view(3);  % 确保三维视角
