strFile='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\B\density1.cub';
tic;
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile );
load LUT.mat
time1=toc;
fprintf('代码段1执行时间: %f 秒\n', time1);
step_num1=step_num(1);
step_num2=step_num(2);
step_num3=step_num(3);
tic;
[X,Y,Z,face]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num1, step_num2, step_num3, LUT);
time2=toc;
fprintf('代码段2执行时间: %f 秒\n', time2);

tic;
[unique_points,new_Face,indices]=Func_UniquePoints(X, Y, Z,face);
time3=toc;
fprintf('代码段3执行时间: %f 秒\n', time3);