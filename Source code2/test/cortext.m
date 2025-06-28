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
tic
FontSize = 22;
FontWeight = 'bold';
strFile = 'H:\MATLAB\20180116\bin\Final\batch3\cat6\cat6.dst';
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
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
iOffset=min(vLayer);
iLayer=max(vLayer)-min(vLayer)+1;
% vIdx = find(vLayer == 45);
% % vIdx1 = find(vZ(vIdx) >= 4.025);
% % vIdx = vIdx(vIdx1);
% % vIdx1 = find(vZ(vIdx) <= 4.28);
% % vIdx = vIdx(vIdx1);
% scatter3(vX(vIdx), vY(vIdx), vZ(vIdx), 'filled');
% vIdx1 = find(vLayer == 44);
% hold on;
% scatter3(vX(vIdx1), vY(vIdx1), vZ(vIdx1), 'filled');
% vUsed = zeros(iLen, 1);
% vUsed1 = zeros(iLen, 1);
% vUsed(vIdx) = 1;
% vUsed1(vIdx1) = 1;
% for i = 1 : iFaceLength
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
%         hold on;
%         X1 = vX(vFace(i, 1));
%         Y1 = vY(vFace(i, 1));
%         Z1 = vZ(vFace(i, 1));
%         X2 = vX(vFace(i, 2));
%         Y2 = vY(vFace(i, 2));
%         Z2 = vZ(vFace(i, 2));
%         X3 = vX(vFace(i, 3));
%         Y3 = vY(vFace(i, 3));
%         Z3 = vZ(vFace(i, 3));
%         line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5] );
%         line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5] );
%         line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5] );
%     end
%     if(1 == vUsed1(vFace(i, 1))&&1 == vUsed1(vFace(i, 2))&& 1 == vUsed1(vFace(i, 3)))
%         hold on;
%         X1 = vX(vFace(i, 1));
%         Y1 = vY(vFace(i, 1));
%         Z1 = vZ(vFace(i, 1));
%         X2 = vX(vFace(i, 2));
%         Y2 = vY(vFace(i, 2));
%         Z2 = vZ(vFace(i, 2));
%         X3 = vX(vFace(i, 3));
%         Y3 = vY(vFace(i, 3));
%         Z3 = vZ(vFace(i, 3));
%         line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 1, 'Color', [0,1,0]);
%         line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 1, 'Color', [0,1,0] );
%         line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 1, 'Color', [0,1,0] );
%     end
% end
dS=0;
dVol=0;
for i = 1 : iLayer
    iCountTemp = 0;
    iTemp = iOffset + i - 1;
    vIdxTemp = find(iTemp == vLayer);%每层点的位置
    if(iCountTemp == length(vIdxTemp))
        continue;
    end
    vIdxTemp(all(vIdxTemp == 0, 2), :) = [];
    if(length(vIdxTemp) < 2)
        dS = dS + 0;
        continue;
    end
%     scatter(vX(vIdxTemp), vY(vIdxTemp), 90,'k.');
    dXStart = min(vX(vIdxTemp));
    dXStart = round(dXStart) - 1;
    dXEnd = max(vX(vIdxTemp));
    dXEnd = round(dXEnd) + 1;
    dYStart = min(vY(vIdxTemp));
    dYStart = round(dYStart) - 1;
    dYEnd = max(vY(vIdxTemp));
    dYEnd = round(dYEnd) + 1;
%     figure(i)
    axes2 = axes('Parent', figure(i), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
    box(axes2, 'on');
    set(axes2, 'xtick', []);
    set(axes2, 'ytick', []);
    set(axes2, 'xlim', [dXStart, dXEnd]);
    set(axes2, 'ylim', [dYStart , dYEnd]);
    set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
    set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
    xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
    ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
    set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
    hold on;
    
    figure(i)
    [dS, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
%         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
   
%         figure(i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
%         figure(2 * i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
   
    dS
    dVol = dVol + dS * dSlice;
end


% hold on
% vIdx = find(CubePoints(:, 4) > 0.001);
% vX1 = CubePoints(vIdx, 1);
% vY1 = CubePoints(vIdx, 2);
% vZ1 = CubePoints(vIdx, 3);
% vIdx = find(vZ1 >= 4.025);
%scatter3(vX1(vIdx), vY1(vIdx), vZ1(vIdx), 'r','filled')
toc