% function Func_Cut_line(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1, iFaceLength1, vFace1)
% close all
%%像cell中每个矩阵尾部直接递增数据
tic
for iii=1:10
% FontSize = 30;
% FontWeight = 'bold';

%估计大概有多少层以及起始以及最终层
dSlice=step(1);
% dSlice=step(1)+step1(1);
% dSlice=0.2885;
dStartZ = vStart(3);

Max_Z=max(vZ);
Min_Z=min(vZ);
iOffset=round((Min_Z-dStartZ)/dSlice);
Max_Layer=round((Max_Z-dStartZ)/dSlice);
iLayer=Max_Layer-iOffset+1;

Max_Z1=max(vZ1);
Min_Z1=min(vZ1);
iOffset1=round((Min_Z1-dStartZ)/dSlice);
Max_Layer1=round((Max_Z1-dStartZ)/dSlice);
iLayer1=Max_Layer1-iOffset1+1;


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

% 
% matX=zeros(10000,Max_Layer);
% matY=zeros(l0000,Max_Layer);
% matZ=zeros(l0000,Max_Layer);
MatX=cell(1,Max_Layer);
MatY=cell(1,Max_Layer);
% MatZ=cell(1,Max_Layer);
is_used1=false(length(vZ),1);

%预计每层有几个数据

% vLayer=zeros(iLayer11,1);
% vLayer1=zeros(iLayer11,1);

% is_used1=false(length(vZ),1);
% for i = 1:FacelineLen
% %     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
%           %hold on;
% %           dX1 = vX(vFaceline(i, 1));
% %           dY1 = vY(vFaceline(i, 1));
%           dZ1 = vZ(vFaceline(i, 1));
% %           dX2 = vX(vFaceline(i, 2));
% %           dY2 = vY(vFaceline(i, 2));
%           dZ2 = vZ(vFaceline(i, 2));
%           a=max(dZ1,dZ2);
%           if(a==dZ1)
%               aux=vFaceline(i, 1);
%           else
%               aux=vFaceline(i, 2);
%           end
%           b=min(dZ1,dZ2);
%           
%           %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
% %           index=round((a-dStartZ)/dSlice);
% %           index1=round((b-dStartZ)/dSlice);
% %           c=index*dSlice+dStartZ;
%           if(a==b)
%              continue;
%           else
%               index=round((a-dStartZ)/dSlice);
%               index1=round((b-dStartZ)/dSlice);
%               
%               for k = index1:index
%                    c=k*dSlice+dStartZ;
%                    if((a-c)*(b-c)<0)
%                       vLayer(k,1)= vLayer(k,1)+1;
%                    elseif((a==c)&&((is_used(aux)==0)))
%                       vLayer(k,1)= vLayer(k,1)+1;
%                       is_used(aux)=true;
%                    else
%                        continue;
%                    end
%               end
%                       
%           end
% end
%%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
% len=max(vLayer);
% matX=zeros(len,Max_Layer);
% matY=zeros(len,Max_Layer);
% matZ=zeros(len,Max_Layer);

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
          if(a==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
%                       matX{k,1}=[matX{k,1};Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2)];
%                       matY{k,1}=[matY{k,1};Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2)];
%                       matZ{k,1}=[matZ{k,1};c];
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                       MatX=addData(MatX,k,me_re);
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                       MatY=addData(MatY,k,me_re);
%                        MatZ=addData(MatZ,k,c);
                      %cellArray{vLayer(index,1),index}=temp_mat;              
                   elseif((a==c)&&((is_used1(aux)==0)))
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                       MatX=addData(MatX,k,me_re);
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                       MatY=addData(MatY,k,me_re);
%                        MatZ=addData(MatZ,k,c);
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      is_used1(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end

%% 
vFaceline1=zeros(iFaceLength1*3,2);
vFaceline1(1:iFaceLength1,1)=vFace1(1:iFaceLength1,1);
vFaceline1(1:iFaceLength1,2)=vFace1(1:iFaceLength1,2);
vFaceline1(iFaceLength1+1:iFaceLength1*2,1)=vFace1(1:iFaceLength1,2);
vFaceline1(iFaceLength1+1:iFaceLength1*2,2)=vFace1(1:iFaceLength1,3);
vFaceline1(iFaceLength1*2+1:iFaceLength1*3,1)=vFace1(1:iFaceLength1,1);
vFaceline1(iFaceLength1*2+1:iFaceLength1*3,2)=vFace1(1:iFaceLength1,3);
vFaceline1=sort(vFaceline1,2);
vFaceline1=unique(vFaceline1,'row','stable');

FacelineLen1=length(vFaceline1);

MatX1=cell(1,Max_Layer1);
MatY1=cell(1,Max_Layer1);
% MatZ1=cell(1,Max_Layer1);
is_used2=false(length(vZ1),1);
% is_used2=false(length(vZ1),1);
% is_used3=false(length(vZ1),1);
% for i = 1:FacelineLen1
% %     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
%           %hold on;
% %           dX1 = vX(vFaceline1(i, 1));
% %           dY1 = vY(vFaceline1(i, 1));
%           dZ1 = vZ1(vFaceline1(i, 1));
% %           dX2 = vX(vFaceline1(i, 2));
% %           dY2 = vY(vFaceline1(i, 2));
%           dZ2 = vZ1(vFaceline1(i, 2));
%           a=max(dZ1,dZ2);
%           if(a==dZ1)
%               aux=vFaceline1(i, 1);
%           else
%               aux=vFaceline1(i, 2);
%           end
%           b=min(dZ1,dZ2);
%           
%           %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
% %           index=round((a-dStartZ)/dSlice);
% %           index1=round((b-dStartZ)/dSlice);
% %           c=index*dSlice+dStartZ;
%           if(a==b)
%              continue;
%           else
%               index=round((a-dStartZ)/dSlice);
%               index1=round((b-dStartZ)/dSlice);
%               for k = index1:index
%                    c=k*dSlice+dStartZ;
%                    if((a-c)*(b-c)<0)
%                       vLayer1(k,1)= vLayer1(k,1)+1;
%                    elseif((a==c)&&((is_used2(aux)==0)))
%                       vLayer1(k,1)= vLayer1(k,1)+1;
%                       is_used2(aux)=true;
%                    else
%                        continue;
%                    end
%               end
%                       
%           end
% end
% %%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% % vLayer1(:,1)=vLayer(:,1);
% len=max(vLayer1);
% matX1=zeros(len,Max_Layer1);
% matY1=zeros(len,Max_Layer1);
% matZ1=zeros(len,Max_Layer1);
% 
for i = 1:FacelineLen1
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
          dX1 = vX1(vFaceline1(i, 1));
          dY1 = vY1(vFaceline1(i, 1));
          dZ1 = vZ1(vFaceline1(i, 1));
          dX2 = vX1(vFaceline1(i, 2));
          dY2 = vY1(vFaceline1(i, 2));
          dZ2 = vZ1(vFaceline1(i, 2));
          a=max(dZ1,dZ2);
          b=min(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline1(i, 1);
          else
              aux=vFaceline1(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                       MatX1=addData(MatX1,k,me_re);
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                       MatY1=addData(MatY1,k,me_re);
%                        MatZ1=addData(MatZ1,k,c);
                      %cellArray{vLayer(index,1),index}=temp_mat;              
                   elseif((a==c)&&((is_used2(aux)==0)))
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                       MatX1=addData(MatX1,k,me_re);
                       me_re=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                       MatY1=addData(MatY1,k,me_re);
%                        MatZ1=addData(MatZ1,k,c);
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      is_used2(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end
% 




% dS_a=[];
% figure;
% hold on;
% axis off;
% 
%%
% FontSize = 22;  % 设置所需的字体大小
% FontWeight = 'bold';  % 设置所需的字体粗细
Max_Layer11=min(Max_Layer,Max_Layer1);
iLayer11=min(iLayer,iLayer1);
iOffset11=max(iOffset,iOffset1);
dVol=0;
 for j = 1:iLayer11
% for j = 18:18
    iTemp = iOffset11 + j - 1;
    vXtemp=MatX{iTemp}(:);
% %     vXtemp=vXtemp(vXtemp~=0);
    if(length(vXtemp)<=2)
%         iTemp
        continue;
    end
% %     vXtemp=unique(vXtemp,'row','stable');
    vYtemp=MatY{iTemp}(:);
% %     vYtemp=vYtemp(vYtemp~=0);
% %     vZtemp=MatZ{iTemp}(:);
% %     vZtemp=vZtemp(vZtemp~=0);
%     
    vXtemp1=MatX1{iTemp}(:);
% %     vXtemp1=vXtemp1(vXtemp1~=0);
    if(length(vXtemp1)<=2)
%         iTemp
%         j
        continue;
    end
% %     vXtemp=unique(vXtemp,'row','stable');
    vYtemp1=MatY1{iTemp}(:);
%     vYtemp1=vYtemp1(vYtemp1~=0);
%     vZtemp1=MatZ1{iTemp}(:);
%     vZtemp1=vZtemp1(vZtemp1~=0);
%     figure(iTemp);
%     hold on;
%     scatter3(vXtemp,vYtemp,vZtemp,'filled','r');
%     scatter3(vXtemp1,vYtemp1,vZtemp1,'filled','b');
% figure;
% hold on;
%       scatter(vXtemp,vYtemp,30,'filled','r');
%       scatter(vXtemp1,vYtemp1,30,'filled','b');
%      axis image;
%       hold off;
%       
% % 设置X轴标签的字体大小和字体粗细
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight);
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight);
% set(gca, 'FontSize', FontSize);
%    [mLine,iCountContour,vContourPoint] = Func_Unicursal_3(vXtemp, vYtemp, dSlice,'r'); 
%    [mLine1,iCountContour1,vContourPoint1] = Func_Unicursal_3(vXtemp1, vYtemp1, dSlice,'b');
    [dS]=Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice);
%       [dS]=Func_Find_interp(MatX{iTemp}(:),MatY{iTemp}(:),MatX1{iTemp}(:),MatY1{iTemp}(:),j,dSlice);
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
%     [dS, ~, mLine] = Func_Unicursal_R(vXtemp, vYtemp, dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
% %         figure(2 * i)
%         [dS, ~, mLine] = Func_Unicursal_R(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         figure(i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
%         [vX(vIdxTemp), vY(vIdxTemp), mLine] = Func_unicursal_correct(mLine, vX(vIdxTemp), vY(vIdxTemp));
%         figure(2 * i)
%         [~, ~, mLine] = Func_Unicursal_V2(vX(vIdxTemp), vY(vIdxTemp), dSlice);
   dS=abs(dS);
%    dS1(j,1)=abs(dS);
   dVol = dVol + dS * dSlice;
%    dS_a(end+1)=dS;
end
end

timeTotal = toc;

timeAve = timeTotal/iii;
function MatX = addData(MatX, colIndex, additionalData)
    % 获取指定列的数组
    targetCell = MatX{colIndex};

    % 向指定列的数组末尾添加数据
    targetCell = [targetCell; additionalData];

    % 将更新后的数组放回 MatX 的指定列
    MatX{colIndex} = targetCell;
end


