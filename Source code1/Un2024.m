clear;clc;close all
FontSize = 22;
FontWeight = 'bold';
strFile1 = 'H:\matlab2019a\bin\molecule_data\空间电子效应\宁利超1\A\density1.cub';
strFile = 'H:\matlab2019a\bin\molecule_data\空间电子效应\宁利超1\B\density1.cub';
[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
[ Atom_info1, AtomNum1, ~, CubePoints1, step_num1, step1, vStart1 ] = Func_GetCubePoints( strFile1 );
load LUT;
cAtomRadius = Func_LoadAtomRadius( 'Acce3.txt' );

[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT );
[ vX1, vY1, vZ1, iCloudLength1, iFaceLength1, vFace1 ] = Func_ContourV2( CubePoints1, step_num1( 1 ), step_num1( 2 ), step_num1( 3 ), LUT );
dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
for i = 1 : AtomNum
iLenTemp = size(cAtomRadius);%这个意思是在所有原子找
for j = 1 : iLenTemp
if(Atom_info(i, 1) == cAtomRadius{ j, 3 })
Atom_info(i, 5) = cAtomRadius{ j, 2 };
break
end
end
end
for i = 1 : AtomNum1
iLenTemp = size(cAtomRadius);
for j = 1 : iLenTemp
if(Atom_info1(i, 1) == cAtomRadius{ j, 3 })
Atom_info1(i, 5) = cAtomRadius{ j, 2 };
break
end
end
end
vX=vX+10;

figure;
hold on;
% % view(180,0);
% % view(3);
Surface1.faces = vFace1;
Surface1.vertices = [vX1,vY1,vZ1];
S=Surface1;
hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
Surface2.faces = vFace;
% Surface2.vertices = [vX2,vY2,vZ2];
Surface2.vertices = [vX,vY,vZ];
S=Surface2; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]);
set(h,'EdgeColor',[0.2196,0.3490,0.5373])
hold off;
[dVol,cross]= test3(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1);
