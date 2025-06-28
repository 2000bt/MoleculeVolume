 strFile1='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.dst';
tic;
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile1 );
time1=toc;
step_num1=step_num(1);
step_num2=step_num(2);
step_num3=step_num(3);
tic;
[Seedcube_num] = Func_Findseedcube( CubePoints, step_num1, step_num2, step_num3 );
time2=toc;
load LUT;
tic;
[X,Y,Z,totalVoxels]=Func_ProcessAllBoundaries(Seedcube_num, CubePoints, step_num1, step_num2, step_num3, LUT);
time3=toc;
fprintf('代码段1执行时间: %f 秒\n', time1);
fprintf('代码段2执行时间: %f 秒\n', time2);
fprintf('代码段3执行时间: %f 秒\n', time3);

% figure; 
% hold on;
% for i = 1:3:length(X)
%     Extract the three vertices of the triangle
%     x_triangle = X(i:i+2);
%     y_triangle = Y(i:i+2);
%     z_triangle = Z(i:i+2);
%     
%     Draw the triangle using patch
%     patch(x_triangle, y_triangle, z_triangle, 'r'); % 'r' is the color red, you can change it
% end
% hold off;
% 
% Set axes labels and title
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('3D Triangles');
% 
% Adjust the view for 3D visualization
% view(3);
% axis equal;
% grid on;