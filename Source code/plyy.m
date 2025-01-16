% clear;clc;close all
% FontSize = 22;
% FontWeight = 'bold';
% % strFile = 'H:\matlab2019a\bin\batch3\cat6\cat6.dst';
% strFile = 'H:\matlab2019a\bin\batch3\subr2\subr2.dst';
strFile = 'H:\matlab2019a\bin\batch4\Sc_itr\Sc_itr.dst';
% % strFile = 'H:\matlab2019a\bin\batch1\Sc_Ketone6\Sc_Ketone6.dst';
% strFile = 'H:\matlab2019a\bin\batch1\Sc_ap\Sc_ap.dst';
[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
load LUT;
cAtomRadius = Func_LoadAtomRadius( 'Acce3.txt' );

[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
% %移到可以碰撞的位置  1
% vY = vY - 15;
% Atom_info(:, 3) = Atom_info(:, 3) - 15;
%%Subr2
vX = vX - 20;
Atom_info(:, 2) = Atom_info(:, 2) - 20;
% vY = vY - 13;
% Atom_info(:, 3) = Atom_info(:, 3) - 13;


iLen = length(vX);
iFace = length(vFace);

fid = fopen('C:\Users\J.Zhang\Desktop\Sc_itr2.ply', 'wt');
fprintf(fid,'ply\n');
fprintf(fid,'format ascii 1.0\n');
fprintf(fid,'comment generated by ply_writer\n');
fprintf(fid,'element vertex %d\n', iLen);
fprintf(fid,'property float x\n');
fprintf(fid,'property float y\n');
fprintf(fid,'property float z\n');
fprintf(fid,'element face %d\n', iFace);
fprintf(fid,'property list uchar int vertex_indices\n');
fprintf(fid,'end_header\n');
for i = 1 : iLen
    fprintf(fid, '%8.6f %8.6f %8.6f\n', vX(i) - 1,  vY(i)-1,  vZ(i)-1);
end
for i = 1 : iFace
    fprintf(fid,'%d %d %d %d\n', 3, vFace(i, 1)-1, vFace(i, 2) - 1, vFace(i, 3) - 1);
end
fclose(fid);