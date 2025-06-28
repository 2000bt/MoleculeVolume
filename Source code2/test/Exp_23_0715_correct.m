tic
dS=0;
dVol=0;
% for j =1:iLayer
%     figure(j);
%     iTemp=iOffset+j-1;
%     vIdx=find(vLayer==iTemp);
%     scatter(vintersectionX(vIdx),vintersectionY(vIdx),'filled');
% end
iLen=length(vZ);
vUsed = zeros(iLen, 1);
vIdx1= find((vZ>=13.8));
vIdx2 = find(vZ(vIdx1) <= (14.8));
vIdx1 = vIdx1(vIdx2);
% vIdx2=find(vX(vIdx1)>=(-0.29))
% vIdx1 = vIdx1(vIdx2);
% vIdx2=find(vX(vIdx1)<=(7.019))
% vIdx1 = vIdx1(vIdx2);
% vIdx2=find(vY(vIdx1)>=(-12.804))
% vIdx1 = vIdx1(vIdx2);
% vIdx2=find(vY(vIdx1)>=(-7.4278))
% vIdx1 = vIdx1(vIdx2);

vUsed(vIdx1) = 1;
for i = 1 : iLayer
%     if(i == 5 ||  i == 13 || i == 38 || i == 45 || i == 46 || i == 50)
    if(i ==56||i ==57)
        
        iTemp = iOffset + i - 1;
%         aa=iTempl*dSlice+dStartZ;
         vXtemp=matX(:,iTemp);
        vXtemp=vXtemp(vXtemp~=0);
        if(length(vXtemp)<=2)
    %         iTemp
            continue;
        end
    %     vXtemp=unique(vXtemp,'row','stable');
        vYtemp=matY(:,iTemp);
        vYtemp=vYtemp(vYtemp~=0);
        vZtemp=matZ(:,iTemp);
        vZtemp=vZtemp(vZtemp~=0);
%         iTemp = length(vIdx);
%         figure(i);
        hold on;
        scatter3(vXtemp,vYtemp,vZtemp,'filled');
         for j = 1 : iFaceLength
            if(1 == vUsed(vFace(j, 1))|| 1 == vUsed(vFace(j, 2))|| 1 == vUsed(vFace(j, 3)))
                hold on;
                X1 = vX(vFace(j, 1));
                Y1 = vY(vFace(j, 1));
                Z1 = vZ(vFace(j, 1));
                X2 = vX(vFace(j, 2));
                Y2 = vY(vFace(j, 2));
                Z2 = vZ(vFace(j, 2));
                X3 = vX(vFace(j, 3));
                Y3 = vY(vFace(j, 3));
                Z3 = vZ(vFace(j, 3));
                scatter3(X1,Y1,Z1);
                scatter3(X2,Y2,Z2);
                scatter3(X3,Y3,Z3);
                line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 1, 'Color', [0.5,0.5,0.5] );
                line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 1, 'Color', [0.5,0.5,0.5] );
                line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 1, 'Color', [0.5,0.5,0.5] );
            end
        end
    end
end
% for j = 1:iLayer
%     iCountTemp = 0;
%     iTemp = iOffset + j - 1;
%     vIdxTemp = find(vLayer == iTemp );%每层点的位置
%     if(length(vIdxTemp) < 3)
%         dS = dS + 0;
%         vIdxTemp
%         iTemp
%         continue;
%     end
%    % figure(j)
%     %scatter(vintersectionX(vIdxTemp),vintersectionY(vIdxTemp));
%     dXStart = min(vintersectionX(vIdxTemp));
%     dXStart = round(dXStart) - 1;
%     dXEnd = max(vintersectionX(vIdxTemp));
%     dXEnd = round(dXEnd) + 1;
%     dYStart = min(vintersectionY(vIdxTemp));
%     dYStart = round(dYStart) - 1;
%     dYEnd = max(vintersectionY(vIdxTemp));
%     dYEnd = round(dYEnd) + 1;
% %     figure(i)
%     axes2 = axes('Parent', figure(j), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
%     figure(j)
% %       [dS] = Func_Unicursal(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
%     [dS, ~, mLine] = Func_Unicursal_R(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
% %         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% % %         figure(2 * i)
% %         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
% %         figure(i)
% %         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
% %         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
% %         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%    
%     dS
%    dVol = dVol + dS * dSlice;
% end


toc
