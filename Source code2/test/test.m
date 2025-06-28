tic
dS=0;
dVol=0;

lengthll=zeros(iLayer,1);
for j = 1:iLayer
    iTemp = iOffset + j - 1;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
    if(length(vXtemp)<=2)
%         iTemp
        continue;
    end
%     vXtemp=unique(vXtemp,'row','stable');
    vYtemp=matY(:,iTemp);
    vYtemp=vYtemp(vYtemp~=0);
   lengthll(j,1)=length(vYtemp);
%     figure(j);
%     scatter(vXtemp,vYtemp,'filled');

%     dXStart = min(vXtemp);
%     dXStart = round(dXStart) - 1
%     dXEnd = max(vXtemp);
%     dXEnd = round(dXEnd) + 1
%     dYStart = min(vYtemp);
%     dYStart = round(dYStart) - 1
%     dYEnd = max(vYtemp);
%     dYEnd = round(dYEnd) + 1
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

%  
%   
% %       [dS] = Func_Unicursal(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
    [dS, ~, mLine] = Func_Unicursal_R(vXtemp, vYtemp, dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
%         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         figure(i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
%         figure(2 * i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
   
%     dS
   dVol = dVol + dS * dSlice;
end
toc