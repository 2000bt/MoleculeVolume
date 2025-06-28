%% 小论文画图
% iLen = length(CubePoints);
% vX1 = CubePoints(1 : 20 : iLen, 1);
% vY1 = CubePoints(1 : 20 : iLen, 2);
% vZ1 = CubePoints(1 : 20 : iLen, 3);
% scatter31 = scatter3(vX, vY, vZ, 'filled')
% scatter31.MarkerFaceAlpha = 0.7;
% scatter31.MarkerEdgeAlpha = 0.3;
% scatter31.SizeData = 3;

%% 分子Sc_ap的顶部两层图及其连线
clear;clc;close all
strFile = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_density1.cub';
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
strFile1 = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_ESP1.cub';
[ ~, ~,~, CubePoints1, ~, ~, ~] = Func_GetCubePoints( strFile1 );
load LUT;
[  vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
% scatter3(vX, vY, vZ, 'filled')
dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
dSlice = step(1);
iLen = length(vZ);
vLayer = zeros(iLen, 1);
for i = 1 : iLen
    vLayer(i) = round((vZ(i) - dStartZ) / dSlice);
end
vIdx = find(vLayer > 45);
vIdx1 = find(vZ(vIdx) >= 4.025);
vIdx = vIdx(vIdx1);
% vIdx1 = find(vZ(vIdx) <= 4.28);
% vIdx = vIdx(vIdx1);
scatter3(vX(vIdx), vY(vIdx), vZ(vIdx), 'filled')

vUsed = zeros(iLen, 1);
vUsed(vIdx) = 1;

for i = 1 : iFaceLength
    if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
        hold on;
        X1 = vX(vFace(i, 1));
        Y1 = vY(vFace(i, 1));
        Z1 = vZ(vFace(i, 1));
        X2 = vX(vFace(i, 2));
        Y2 = vY(vFace(i, 2));
        Z2 = vZ(vFace(i, 2));
        X3 = vX(vFace(i, 3));
        Y3 = vY(vFace(i, 3));
        Z3 = vZ(vFace(i, 3));
        line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 2, 'Color', [0.5, 0.5, 0.5] );
        line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 2, 'Color', [0.5, 0.5, 0.5] );
        line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 2, 'Color', [0.5, 0.5, 0.5] );
    end
end
%%
hold on;
%定义长方形的顶点坐标
a=min(vX(vIdx))-0.4;
b=min(vY(vIdx))-0.4;

x = [a, a+3.5, a+3.5, a-0, a]; % x 坐标
y = [b, b-0, b+3.5, b+3.5, b]; % y 坐标
z = [4.3, 4.3, 4.3, 4.3, 4.3]; % z 坐标
% 使用 plot3 函数绘制虚线长方形
plot3(x, y, z, '--', 'LineWidth', 2); % 设置线宽度为 2，线条样式为虚线
 xlabel('X/Bohr');
ylabel('Y/Bohr');
zlabel('Z/Bohr');
% axis off;
hold off;
% hold on
% vIdx = find(CubePoints(:, 4) > 0.001);
% vX1 = CubePoints(vIdx, 1);
% vY1 = CubePoints(vIdx, 2);
% vZ1 = CubePoints(vIdx, 3);
% vIdx = find(vZ1 >= 4.025);
% scatter3(vX1(vIdx), vY1(vIdx), vZ1(vIdx), 'r','filled')