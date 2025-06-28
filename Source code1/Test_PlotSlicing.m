close all;
clear;
clc;
strFile='C:\Users\����\Desktop\GraStuCor\EecMolCloud\С����\zl���ճ�\Molecule\������1\A\A1.dst';
strFile1='C:\Users\����\Desktop\GraStuCor\EecMolCloud\С����\zl���ճ�\Molecule\������1\B\B1.dst';

tic;
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, org_coor ] = Func_GetCubePoints( strFile );
[ Atom_info1,AtomNum1, ElecCloudDenNum1, CubePoints1, step_num1, step1, org_coor1 ] = Func_GetCubePoints( strFile1 );
load LUT.mat
time1=toc;
fprintf('�����1ִ��ʱ��: %f ��\n', time1);


step_num_1=step_num(1);
step_num_2=step_num(2);
step_num_3=step_num(3);
step_num1_1=step_num1(1);
step_num1_2=step_num1(2);
step_num1_3=step_num1(3);

tic;
[vX,vY,vZ,vFace]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num_1, step_num_2, step_num_3, LUT);
[vX1,vY1,vZ1,vFace1]=Func_GetAllBoundaries_And_Interpolation(CubePoints1, step_num1_1, step_num1_2, step_num1_3, LUT);
vX1=vX1+10; 
time2=toc;
fprintf('�����2ִ��ʱ��: %f ��\n', time2);




% tic;
% [vX,vY,vZ,iCloudLength,iFaceLength,vFace ] = Func_ContourV2( CubePoints, step_num_1, step_num_2, step_num_3, LUT  );
% [vX1,vY1,vZ1,iCloudLength1,iFaceLength1,vFace1 ] = Func_ContourV2( CubePoints1, step_num1_1, step_num1_2, step_num1_3, LUT  );
% vX1=vX1+10;
% time2=toc;
% fprintf('�����2ִ��ʱ��: %f ��\n', time2);



vStart1=org_coor1;
  
[unique_points,new_Face,indices]=Func_UniquePoints(vX, vY, vZ,vFace);
[unique_points1,new_Face1,indices1]=Func_UniquePoints(vX1, vY1, vZ1,vFace1);
vFace=new_Face;
vX=unique_points(:,1);
vY=unique_points(:,2);
vZ=unique_points(:,3);

vFace1=new_Face1;
vX1=unique_points1(:,1);
vY1=unique_points1(:,2);
vZ1=unique_points1(:,3);

iFaceLength=size(vFace,1);
iFaceLength1=size(vFace1,1);
tic;
[vXtemp,vYtemp,vXtemp1,vYtemp1]=Func_PlotSlicing(vX1, vY1, vZ1, iFaceLength1, vFace1,step1,vStart1,vX, vY, vZ, iFaceLength, vFace,step);
time3=toc;
fprintf('�����3ִ��ʱ��: %f ��\n', time3);
