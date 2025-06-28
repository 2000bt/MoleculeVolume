%% 论文图片之算法说明
% clear;clc;close all
% strFile = 'H:\MATLAB\20180116\bin\Final\batch3\cat6\cat6.dst';
% % strFile = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_density1.cub'
% [ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
% % strFile1 = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap.dst'
% load LUT;
% [ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
% dStartX = vStart(1);
% dStartY = vStart(2);
% dStartZ = vStart(3);
tic
dSlice = step(1);
% dSlice=0.8;
iLen = length(vZ);
vLayer = zeros(iLen, 1);
FontSize = 30;
FontWeight = 'bold';
for i = 1 : iLen
    vLayer(i) = round((vZ(i) - dStartZ) / dSlice);
end
dS = 0;
iOffset =  min(vLayer);
iLayer = max(vLayer) - min(vLayer) + 1; 
dVol = 0;
% mVol = zeros(57, 2);
% iCountFig = 0;
% i == 7 || i == 13 || i == 38 || i == 45 || i == 46 || i == 54
%i == 7 || i == 13 || i == 21 || i == 28 || i == 30 || i == 32
lengthl=zeros(iLayer,1);
for i = 1 : iLayer
%     if(i == 5 ||  i == 13 || i == 38 || i == 45 || i == 46 || i == 50)
%     if(i == 4)
        iTemp = iOffset + i - 1;
        vIdx = find(iTemp == vLayer);
        %原预处理方式失效，直接匹配z轴值
        
%         vIdx1=find((vZ(vIdx)-a)<0.001);
%         vIdx=vIdx(vIdx1);
        vXTemp = vX(vIdx);
        vYTemp = vY(vIdx);
%          vZTemp = vZ(vIdx);
%         iTemp1 = length(vIdx);
%         for j = 1 : iTemp1
%             a=iTemp*dSlice+dStartZ;
%             dEr = abs(vZTemp(j) - a);
%             if(dEr>0.05)
%                 vLayer(vIdx(j)) = 0;
%                 vIdx(j) = 0;
%             end
%         end
%         vIdx(all(vIdx == 0, 2), :) = [];
        iTemp1 = length(vIdx);
        for j = 1 : iTemp1
            dTimeX1 = (vXTemp(j) - dStartX) / dSlice;
            dTimeY1 = (vYTemp(j) - dStartY) / dSlice;
            dErX = abs(dTimeX1 - round(dTimeX1));
            dErY = abs(dTimeY1 - round(dTimeY1));
            if(dErX < 0.01 && dErY < 0.01 )
                vLayer(vIdx(j)) = 0;
                vIdx(j) = 0;
            end
        end
        vIdx(all(vIdx == 0, 2), :) = [];
        if(length(vIdx) < 2)
            dS = dS + 0;
            continue;
        end
        lengthl(i,1)=length(vIdx);
%         figure(i);
%         scatter3(vX(vIdx),vY(vIdx),vZ(vIdx),'filled');
%         iLen = length(vIdx);
%         vUsed = zeros(iLen, 1);
%         dXStart = min(vX(vIdx));
%         dXStart = round(dXStart) - 1;
%         dXEnd = max(vX(vIdx));
%         dXEnd = round(dXEnd) + 1;
%         dYStart = min(vY(vIdx));
%         dYStart = round(dYStart) - 1;
%         dYEnd = max(vY(vIdx));
%         dYEnd = round(dYEnd) + 1;
% %         
%         figure(i)
%         axes2 = axes('Parent', figure(i), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
% %             scatter(vX(vIdx), vY(vIdx), 90,'k.');
%         box(axes2, 'on');
%         set(axes2, 'xtick', []);
%         set(axes2, 'ytick', []);
%         set(axes2, 'xlim', [dXStart, dXEnd]);
%         set(axes2, 'ylim', [dYStart , dYEnd]);
%         set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%         set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%         xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%         ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%         set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%         hold on;
%         scatter(vX(vIdx), vY(vIdx), 'k.');
%             [dS] = Func_TwoDirectionSearch(vX(vIdx), vY(vIdx), dSlice);
%             [dS] = Func_Unicursal(vX(vIdx), vY(vIdx), dSlice);
%         [dS, mTwoClose, ] = Func_Unicursal_V2(vX(vIdx), vY(vIdx), dSlice);
        [dS, mTwoClose, ] = Func_Unicursal_R(vX(vIdx), vY(vIdx), dSlice);
%       [dOutlier, dLstd] =  Func_TwoDirectionSearch_PSR_V2( vX(vIdx), vY(vIdx), dSlice )
%         [iCorrect, dS] = Func_TwoDirectionSearch_PSR( vX(vIdx), vY(vIdx), dSlice );
%         str = sprintf('L%d.emf', i);
%         saveas(gcf,['C:\Users\J.Zhang\Desktop\论文图片\Cat6\锦的算法_Y\',str]);
%     end
    dS
   dVol = dVol + dS * dSlice;
end
toc