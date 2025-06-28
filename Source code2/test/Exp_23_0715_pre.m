%直接切割三角面，一个分子
clc;
close all;
clear all;
tic
FontSize = 22;
FontWeight = 'bold';
% strFile = 'H:\MATLAB\20180116\bin\Final\batch3\cat6\cat6.dst';
strFile="H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_density1.cub";
[Atom_info,AtomNum,ElecCloudDenNum, CubePoints, step_num, step, vStart]=Func_GetCubePoints(strFile);
load LUT;
[vX,vY,vZ,iCloudLength, iFaceLength, vFace]=Func_ContourV2(CubePoints,step_num(1),step_num(2),step_num(3),LUT);
dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
dSlice  = step(1);
% dSlice=0.8;
%iLen = length(vZ);
% vLayer = zeros(iLen, 1);
% for i = 1 : iLen
%     vLayer(i) = round((vZ(i) - dStartZ) / dSlice);
% end
%vIdx = find(vLayer > 40);
% vIdx1 = find(vZ(vIdx) >= 4.025);
% vIdx = vIdx(vIdx1);
% vIdx1 = find(vZ(vIdx) <= 4.28);
% vIdx = vIdx(vIdx1);
% scatter3(vX(vIdx), vY(vIdx), vZ(vIdx), 'filled')
% vUsed = zeros(iLen, 1);
% vUsed(vIdx) = 1;

%%%生成三角面片的线矩阵
vFaceline=zeros(iFaceLength*3,2);
vFaceline(1:iFaceLength,1)=vFace(1:iFaceLength,1);
vFaceline(1:iFaceLength,2)=vFace(1:iFaceLength,2);
vFaceline(iFaceLength+1:iFaceLength*2,1)=vFace(1:iFaceLength,2);
vFaceline(iFaceLength+1:iFaceLength*2,2)=vFace(1:iFaceLength,3);
vFaceline(iFaceLength*2+1:iFaceLength*3,1)=vFace(1:iFaceLength,1);
vFaceline(iFaceLength*2+1:iFaceLength*3,2)=vFace(1:iFaceLength,3);
vFaceline=sort(vFaceline,2);
vFaceline=unique(vFaceline,'row','stable');

FacelineLen=length(vFaceline);
%Direction_Vec=zeros(FacelineLen,3);
vLayer=zeros(FacelineLen,1);
vintersectionX=zeros(FacelineLen,1);
vintersectionY=zeros(FacelineLen,1);
vintersectionZ=zeros(FacelineLen,1);

%vFaceLayernum=zeros(iFaceLength,1);
%a=zeros(iFaceLength,1);
%b=zeros(iFaceLength,1);

for i = 1:FacelineLen
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
          dX1 = vX(vFaceline(i, 1));
          dY1 = vY(vFaceline(i, 1));
          dZ1 = vZ(vFaceline(i, 1));
          dX2 = vX(vFaceline(i, 2));
          dY2 = vY(vFaceline(i, 2));
          dZ2 = vZ(vFaceline(i, 2));
          a=max(dZ1,dZ2);
          b=min(dZ1,dZ2);
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          index=round((a-dStartZ)/dSlice);
          index1=round((b-dStartZ)/dSlice);
          c=index*dSlice+dStartZ;
          if(a==b||((a-c)*(b-c)>0))
              vLayer(i)=-1;
              vintersectionX(i)=-199999;
              vintersectionY(i)=-199999;
              vintersectionZ(i)=-199999;
          else
              vLayer(i)=index;
              vintersectionX(i)=Func_ComputeOrg(index,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
              vintersectionY(i)=Func_ComputeOrg(index,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
              vintersectionZ(i)=c;

          end   
end
%vIdx=find(vintersection(:,1)~=-199999);

%iOffset =  min(vLayer);
%iLayer = max(vLayer) - min(vLayer) + 1; 
%判断三角面片分别哪个切距中

%切割
Lay_max=max(vLayer);
vLayer(vLayer == -1)=Inf;
iOffset=min(vLayer);
iLayer=Lay_max-min(vLayer)+1;

dS=0;
dVol=0;
% for j =1:iLayer
%     figure(j);
%     iTemp=iOffset+j-1;
%     vIdx=find(vLayer==iTemp);
%     scatter(vintersectionX(vIdx),vintersectionY(vIdx),'filled');
% end
% iLen=length(vZ);
% vUsed = zeros(iLen, 1);

% for i = 1 : iLayer
% %     if(i == 5 ||  i == 13 || i == 38 || i == 45 || i == 46 || i == 50)
%     if(i == 13)
%         iTempl = iOffset + i - 1;
%         vIdx = find(iTempl == vLayer);
% %         iTemp = length(vIdx);
%         figure(i);
%         scatter3(vintersectionX(vIdx),vintersectionY(vIdx),vintersectionZ(vIdx),'filled');
%     end
% end
figure;
for j = 31:iLayer
%     iCountTemp = 0;
    iTemp = iOffset + j - 1;
    vIdxTemp = find(vLayer == iTemp );%每层点的位置
    if(length(vIdxTemp) < 3)
        dS = dS + 0;
        vIdxTemp
        iTemp
        continue;
    end
       hold on;
%     figure(j)
    scatter3(vintersectionX(vIdxTemp),vintersectionY(vIdxTemp),vintersectionZ(vIdxTemp),'r','filled');
    dXStart = min(vintersectionX(vIdxTemp));
    dXStart = round(dXStart) - 1;
    dXEnd = max(vintersectionX(vIdxTemp));
    dXEnd = round(dXEnd) + 1;
    dYStart = min(vintersectionY(vIdxTemp));
    dYStart = round(dYStart) - 1;
    dYEnd = max(vintersectionY(vIdxTemp));
    dYEnd = round(dYEnd) + 1;
%     figure(i)
    axes2 = axes('Parent', figure(j), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
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
 
%     figure(j)
%       [dS] = Func_Unicursal(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
    
% [dS, ~, mLine] = Func_Unicursal_V2(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
%         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         figure(i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
%         figure(2 * i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%    
%     dS
%    dVol = dVol + dS * dSlice;
end


toc
