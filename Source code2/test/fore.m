clear;clc;close all
tic
strFile = 'H:\MATLAB\20180116\bin\Final\batch3\cat6\cat6.dst';
% strFile = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_density1.cub'
%strFile = '
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
% strFile1 = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap.dst'
load LUT;
b = step_num( 1 ) * step_num( 2 ) * step_num( 3 );
for i=1:b
    if(CubePoints( i, 5 )==1)
        hold on;
        scatter3(CubePoints( i, 1 ),CubePoints( i, 2 ),CubePoints( i, 3 ),'filled');
    end
end
% [ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
% dStartX = vStart(1);
% dStartY = vStart(2);
% dStartZ = vStart(3);
%  toc
% a=-9.6373;
% index=floor((a+17.177)/0.5026)
% 
% vintersectionX1=Func_ComputeOrg(index,-17.177,0.5026,4.506,4.506,-9.637,-10.14)
% vintersectionY1=Func_ComputeOrg(index,-17.177,0.5026,12.6,12.37,-9.637,-10.14)
% vintersectionZ1=index*0.5026-17.177
