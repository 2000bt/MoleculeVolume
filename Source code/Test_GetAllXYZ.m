strFile='D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.dst';
tic;
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile );
load LUT.mat
time1=toc;
fprintf('代码段1执行时间: %f 秒\n', time1);
step_num1=step_num(1);
step_num2=step_num(2);
step_num3=step_num(3);
tic;
[Seedcube_num] = Func_Findseedcube( CubePoints, step_num1, step_num2, step_num3 );
time2=toc;
fprintf('代码段2执行时间: %f 秒\n', time2);
tic;
[VoxelofBoundary2,count2]=Func_GetAllBoundaries(Seedcube_num,CubePoints, step_num1, step_num2, step_num3);
time3=toc; 
fprintf('代码段3执行时间: %f 秒\n', time3);  
tic;
[X,Y,Z,face]=Func_Interpolation(VoxelofBoundary2,count2,CubePoints, step_num1, step_num2, step_num3, LUT);
time4=toc;
fprintf('代码段4执行时间: %f 秒\n', time4);

time5=time2+time3+time4;
fprintf('代码段5执行时间: %f 秒\n', time5);