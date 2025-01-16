strFile='C:\Users\76168\Desktop\GraStuCor\EleMolCloud\Molecule\宁利超1\A\density1.cub';
tic;
[ ~,~,~, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile );
time1=toc;
step_num1=step_num( 1 );
step_num2=step_num( 2 );
step_num3=step_num( 3 );

tic;
[  Seedcube_num ] = Func_Findseedcube( CubePoints, step_num1, step_num2, step_num3 );
time2=toc;

fprintf('代码段1执行时间: %f 秒\n', time1);
fprintf('代码段1执行时间: %f 秒\n', time2);