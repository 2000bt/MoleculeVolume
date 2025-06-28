%对一个分子用面线切割法
clear;clc;close all
tic
% strFile = 'H:\MATLAB\20180116\bin\Final\batch3\cat6\cat6.dst';
% strFile = 'H:\matlab2019a\bin\batch1\Sc_Ketone6\Sc_Ketone6.dst';
% strFile = 'H:\matlab2019a\bin\batch3\subr2\subr2.dst';
% strFile = 'H:\matlab2019a\bin\batch4\Sc_itr\Sc_itr.dst';
% strFile = 'H:\MATLAB\20180116\bin\Final\batch1\Sc_ap\Sc_ap_density1.cub'
%strFile = '
% strFile = 'H:\matlab2019a\bin\molecule_data\batch1\Sc_ap\Sc_ap.dst';
strFile = 'H:\matlab2019a\bin\molecule_data\batch3\cat6\cat6.dst';
[ Atom_info,AtomNum, ElecCloudDenNum, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );

load LUT;
%%
FontSize = 20;
FontWeight = 'bold';
%%
[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
%估计大概有多少层以及起始以及最终层
%%
dSlice=step(1);
% dSlice=0.5;
% iOffset=round((Overlap_para(5)-dStartZ)/dSlice);
% Max_Layer=round((Overlap_para(6)-dStartZ)/dSlice);
% iLayer=Max_Layer-iOffset+1;
dStartZ = min(vZ);
Max_Z=max(vZ);
% Max_Z=4.3;
Min_Z=min(vZ);
% iOffset=round((Min_Z-dStartZ)/dSlice);
% Max_Layer=round((Max_Z-dStartZ)/dSlice);
% iLayer=Max_Layer-iOffset+1;
iLayer=ceil((Max_Z-Min_Z)/dSlice);
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

%通过三个按分层序号排列的XYZ坐标矩阵
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%预计每层有几个数据
% vLayer=zeros(Max_Layer,1);
vLayer=zeros(iLayer,1);
is_used=false(length(vZ),1);
is_used1=false(length(vZ),1);
for i = 1:FacelineLen
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
%           dX1 = vX(vFaceline(i, 1));
%           dY1 = vY(vFaceline(i, 1));
          dZ1 = vZ(vFaceline(i, 1));
%           dX2 = vX(vFaceline(i, 2));
%           dY2 = vY(vFaceline(i, 2));
          dZ2 = vZ(vFaceline(i, 2));
          a=max(dZ1,dZ2);
         
          b=min(dZ1,dZ2);
          if(b==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      vLayer(k+1,1)= vLayer(k+1,1)+1;
                   elseif((b==c)&&((is_used(aux)==0)))
                      vLayer(k+1,1)= vLayer(k+1,1)+1;
                      is_used(aux)=true;
                   else
                       continue;
                   end
              end
                      
          end
end
%%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer);
matX=zeros(len,iLayer);
matY=zeros(len,iLayer);
matZ=zeros(len,iLayer);

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
          if(b==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      matX(vLayer(k+1,1),k+1)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k+1,1),k+1)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k+1,1),k+1)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k+1,1)= vLayer(k+1,1)-1;
                   elseif((b==c)&&((is_used1(aux)==0)))
                      matX(vLayer(k+1,1),k+1)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k+1,1),k+1)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k+1,1),k+1)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k+1,1)= vLayer(k+1,1)-1;
                      is_used1(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end


dS=0;
dVol=0;
%%
cross=zeros(iLayer,2);
%%
% for j = 1:iLayer
 for j = 10:15
%     iTemp = iOffset + j - 1;
    iTemp=j;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
    if(length(vXtemp)<=2)  
        continue;
    end
%     vXtemp=unique(vXtemp,'row','stable');
    vYtemp=matY(:,iTemp);
    vYtemp=vYtemp(vYtemp~=0);
    vZtemp=matZ(:,iTemp);
    vZtemp=vZtemp(vZtemp~=0);
%     figure(j);
%     scatter(vXtemp,vYtemp,'filled');

    dXStart = min(vXtemp);
    dXStart = round(dXStart) - 1
    dXEnd = max(vXtemp);
    dXEnd = round(dXEnd) + 1
    dYStart = min(vYtemp);
    dYStart = round(dYStart) - 1
    dYEnd = max(vYtemp);
    dYEnd = round(dYEnd) + 1
% %     figure(i)
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
    hold on;
%     scatter(vXtemp,vYtemp,15,[0.8235,0.1255,0.1529],'filled');
%     figure(j)

%  
%   
% %       [dS] = Func_Unicursal(vintersectionX(vIdxTemp), vintersectionY(vIdxTemp), dSlice);
%     [dS, ~, mLine] = Func_Unicursal_R(vXtemp, vYtemp, dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
%         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         figure(i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
%         figure(2 * i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
% %    [dS, ~, mLine] = Func_Unicursal_R(vXtemp,vYtemp, dSlice);
            dS=Func_TwoDirectionSearch(vXtemp,vYtemp, dSlice);
%    dZ = dStartZ +j  * dSlice;
%    cross(j,:)=[dS,dZ];
% %    dS
%    dVol = dVol + dS * dSlice;
end

%%
