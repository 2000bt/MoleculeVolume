function[dVol,cross]= test3_plot(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1)
% close all
% tic
% for iii=1:6
% FontSize = 30;
% FontWeight = 'bold';

%估计大概有多少层以及起始以及最终层
% dSlice=step1(1);
dSlice=(step(1)+step1(1))/2;               
% dSlice=(step(1)+step1(1))/3.5;
% dSlice=0.2885;
% dStartZ = vStart1(3)-14;
if vStart(3)>min(min(vZ),min(vZ1))
    dStartZ=min(min(vZ),min(vZ1))-dSlice;
else
    dStartZ=vStart(3);
end
% dStartZ=min(min(vZ),min(vZ1))-2*dSlice;
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

%通过三个按分层序号排列的XYZ坐标矩阵
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%预计每层有几个数据
vLayer=zeros(Max_Layer,1);
vLayer1=zeros(Max_Layer1,1);
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
          if(a==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          b=min(dZ1,dZ2);
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      vLayer(k,1)= vLayer(k,1)+1;
                   elseif((a==c)&&((is_used(aux)==0)))
                      vLayer(k,1)= vLayer(k,1)+1;
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
matX=zeros(len,Max_Layer);
matY=zeros(len,Max_Layer);
matZ=zeros(len,Max_Layer);

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
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                   elseif((a==c)&&((is_used1(aux)==0)))
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                      is_used1(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end


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

is_used2=false(length(vZ1),1);
is_used3=false(length(vZ1),1);
for i = 1:FacelineLen1
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
%           dX1 = vX(vFaceline1(i, 1));
%           dY1 = vY(vFaceline1(i, 1));
          dZ1 = vZ1(vFaceline1(i, 1));
%           dX2 = vX(vFaceline1(i, 2));
%           dY2 = vY(vFaceline1(i, 2));
          dZ2 = vZ1(vFaceline1(i, 2));
          a=max(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline1(i, 1);
          else
              aux=vFaceline1(i, 2);
          end
          b=min(dZ1,dZ2);
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      vLayer1(k,1)= vLayer1(k,1)+1;
                   elseif((a==c)&&((is_used2(aux)==0)))
                      vLayer1(k,1)= vLayer1(k,1)+1;
                      is_used2(aux)=true;
                   else
                       continue;
                   end
              end
                      
          end
end
%%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer1);
matX1=zeros(len,Max_Layer1);
matY1=zeros(len,Max_Layer1);
matZ1=zeros(len,Max_Layer1);

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
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ1(vLayer1(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer1(k,1)= vLayer1(k,1)-1;
                   elseif((a==c)&&((is_used3(aux)==0)))
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ1(vLayer1(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer1(k,1)= vLayer1(k,1)-1;
                      is_used3(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end
% 


dVol=0;

iOffset11=max(iOffset,iOffset1);
iLayer11=min(Max_Layer,Max_Layer1)-iOffset11+1;
% dS_a=[];
% figure;
% hold on;
% axis off;
% 
%%
% FontSize = 22;  % 设置所需的字体大小
% FontWeight = 'bold';  % 设置所需的字体粗细


cross=zeros(iLayer11,2);
% figure;
% hold on;
 for j = 1:iLayer11
% for j = 7
% if j==7||j==6||j==8||j==9
% if j==8
%     continue;

    iTemp = iOffset11 + j - 1;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
%     vXtemp = round(vXtemp(vXtemp ~= 0),2);
     vYtemp=matY(:,iTemp);
    vYtemp=vYtemp(vYtemp~=0);
%     vYtemp = round(vYtemp(vYtemp ~= 0), 2);
    vXtemp1=matX1(:,iTemp);
    vXtemp1=vXtemp1(vXtemp1~=0);
%     vXtemp1 = round(vXtemp1(vXtemp1 ~= 0), 2);
     vYtemp1=matY1(:,iTemp);
    vYtemp1=vYtemp1(vYtemp1~=0);
%     vYtemp1 = round(vYtemp1(vYtemp1 ~= 0), 2);
    if(length(vXtemp)<=2)
%         iTemp
%         continue;
%     dXStart = min(vXtemp1);
%     dXStart = round(dXStart) - 1;
%     dXEnd = max(vXtemp1);
%     dXEnd = round(dXEnd) + 1;
%     dYStart = min(vYtemp1);
%     dYStart = round(dYStart) - 1;
%     dYEnd = max(vYtemp1);
%     dYEnd = round(dYEnd) + 1;
%     figure(j);
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
%     scatter(vXtemp1,vYtemp1,20,'filled','b');
%   vZtemp1=matZ1(:,iTemp);
%     vZtemp1=vZtemp1(vZtemp1~=0);
%     scatter3(vXtemp1,vYtemp1,vZtemp1,20,'filled','r');
%     saveFolder = 'F:\AAALLL\paper_fig'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('%s.jpg', datestr(now, 'yyyymmdd_HHMMSS')); % 按照日期和时间规则命名
% 
% % 使用 saveas 函数保存图形
% saveas(gcf, fullfile(saveFolder, fileName), 'jpg');
% hold off;
% % 关闭图形绘制
% close(gcf);
    continue;
    end
%     vXtemp=unique(vXtemp,'row','stable');
   
    vZtemp=matZ(:,iTemp);
    vZtemp=vZtemp(vZtemp~=0);
    
    
    if(length(vXtemp1)<=2)
%         iTemp
%         j
%         continue;
%     dXStart = min(vXtemp);
%     dXStart = round(dXStart) - 1;
%     dXEnd = max(vXtemp);
%     dXEnd = round(dXEnd) + 1;
%     dYStart = min(vYtemp);
%     dYStart = round(dYStart) - 1;
%     dYEnd = max(vYtemp);
%     dYEnd = round(dYEnd) + 1;
%     figure(j);
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
%     scatter3(vXtemp,vYtemp,vZtemp,20,'filled','r');
%     saveFolder = 'F:\AAALLL\paper_fig'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('%s.jpg', datestr(now, 'yyyymmdd_HHMMSS')); % 按照日期和时间规则命名
% 
% % 使用 saveas 函数保存图形
% saveas(gcf, fullfile(saveFolder, fileName),'jpg');
% hold off;
% % 关闭图形绘制
% close(gcf);
    continue;
    end
    vXY=[vXtemp,vYtemp];
    vXY1=[vXtemp1,vYtemp1];
    vXY=unique(vXY,'row','stable');
    vXY1=unique(vXY1,'row','stable');
    vZtemp1=matZ1(:,iTemp);
    vZtemp1=vZtemp1(vZtemp1~=0);
%     figure(iTemp);
%     hold on;
% %     scatter3(vXtemp,vYtemp,vZtemp,20,[0.8235,0.1255,0.1529],'filled');
%     scatter3(vXtemp1,vYtemp1,vZtemp1,20,[0.2196,0.3490,0.5373],'filled');

%     a=min(vXtemp);
%     b=min(vXtemp1);
%     dXStart = min(a,b);
%     dXStart = round(dXStart) - 1;
%      a=max(vXtemp);
%     b=max(vXtemp1);
%     dXEnd = max(a,b);
%     dXEnd = round(dXEnd) + 1;
%      a=min(vYtemp);
%     b=min(vYtemp1);
%     dYStart = min(a,b);
%     dYStart = round(dYStart) - 1;
%      a=max(vYtemp);
%     b=max(vYtemp1);
%     dYEnd = max(a,b);
%     dYEnd = round(dYEnd) + 1;
%     figure(j);
% %     hold on;
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
% %       figure;
%     hold on;
%    scatter(vXtemp,vYtemp,15,[0.8235,0.1255,0.1529],'filled');
%    scatter(vXtemp1,vYtemp1,15,[0.2196,0.3490,0.5373],'filled');
%    [mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_4(vXtemp, vYtemp, dSlice,[0.8235,0.1255,0.1529]); 
%    [mLine1,iCountContour1,vContourPoint1,LineFlag1] = Func_Unicursal_4(vXtemp1, vYtemp1, step1(1),[0.2196,0.3490,0.5373]);  
%    saveFolder = 'F:\AAALLL\paper_fig'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('%s_%d.emf', datestr(now, 'yyyymmdd_HHMMSS'),j); % 按照日期和时间规则命名
%    print(fullfile(saveFolder, fileName), '-dmeta', '-r600','-painters');
% % 使用 saveas 函数保存图形
% saveas(gcf, fullfile(saveFolder, fileName), 'jpg');
% 
% % 关闭图形绘制
% close(gcf);
%       hold off;   
% % 设置X轴标签的字体大小和字体粗细
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight);
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight);
% set(gca, 'FontSize', FontSize);
%    [mLine,iCountContour,vContourPoint] = Func_Unicursal_3(vXtemp, vYtemp, dSlice,'r'); 
%    [mLine1,iCountContour1,vContourPoint1] = Func_Unicursal_3(vXtemp1, vYtemp1, dSlice,'b');
%     [dS]=Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice,step1);

     [dS]=Func_Find_interp(vXY(:,1),vXY(:,2),vXY1(:,1),vXY1(:,2),j,dSlice,step1);

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
%    dS=abs(dS);
%    dS1(j,1)=abs(dS);

   cross(j,:)=[dS,iTemp*dSlice+dStartZ];
   dVol = dVol + dS * dSlice;

%    dS_a(end+1)=dS;
 end
% axis off;
% axis image;
% view(179,13);
end
% 
% timeTotal = toc;
% 
% timeAve = timeTotal/iii;
%%
% %画全部被切片后的图
% figure;
% for j = 1:iLayer
% % for j = 18:18
%     iTemp = iOffset + j - 1;
% %     if iTemp>16
% %         break;
% %     end
%     vXtemp=matX(:,iTemp);
%     vXtemp=vXtemp(vXtemp~=0);
%     vYtemp=matY(:,iTemp);
%     vYtemp=vYtemp(vYtemp~=0);
% %     vXtemp1=matX1(:,iTemp);
% %     vXtemp1=vXtemp1(vXtemp1~=0);
% %     vYtemp1=matY1(:,iTemp);
% %     vYtemp1=vYtemp1(vYtemp1~=0);
% %     
% %     figure;
%     hold on;
% %     if(length(vXtemp)<=2)
% %        vZtemp1=ones(size(vXtemp1))*(iTemp*dSlice+dStartZ);
% %         hold on;
% % %         scatter3(vXtemp1,vYtemp1,vZtemp1,20,'filled','b');
% % %         scatter3(vXtemp1,vYtemp1,vZtemp1,10,[0,0,0.50196],'filled');
% % %         hold off;
% %     continue;
% %     end
% %     vXtemp=unique(vXtemp,'row','stable');
%    
% %     vZtemp=matZ(:,iTemp);
% %     vZtemp=vZtemp(vZtemp~=0);
%     
%     
% %     if(length(vXtemp1)<=2)
% %         vZtemp=ones(size(vXtemp))*(iTemp*dSlice+dStartZ);
% %         hold on;
% % %        scatter3(vXtemp,vYtemp,vZtemp,10,[0.74,0.12,0.12],'filled');
% %         scatter3(vXtemp,vYtemp,vZtemp,20,'filled','r');
% % %         hold off;
% %     continue;
% %     end
%      vZtemp=ones(size(vXtemp))*(iTemp*dSlice+dStartZ);
%      vZtemp1=ones(size(vXtemp1))*(iTemp*dSlice+dStartZ);
% %       figure;
%       hold on;
% %       scatter3(vXtemp,vYtemp,vZtemp,10,[0.74,0.12,0.12],'filled');
% %       scatter3(vXtemp1,vYtemp1,vZtemp1,10,[0,0,0.50196],'filled');
% %      scatter3(vXtemp1,vYtemp1,vZtemp1,20,'filled','b');
%     scatter3(vXtemp,vYtemp,vZtemp,40,[0.8235,0.1255,0.1529],'filled');
% %       hold off;
% %     [dS]=Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice);
% %    dS=abs(dS);
% %    dS1(j,1)=abs(dS);
% %    dVol = dVol + dS * dSlice;
% %    dS_a(end+1)=dS;
% end
% hold off;
% % axis image;
% view(174,13);
% axis off;
% figure;
% hold on;
% for j = 1:iLayer1
% % for j = 18:18
% iTemp = iOffset1 + j - 1;
% % if iTemp<=16
% %     continue;
% % end
%     
%     vXtemp1=matX1(:,iTemp);
%     vXtemp1=vXtemp1(vXtemp1~=0);
%     vYtemp1=matY1(:,iTemp);
%     vYtemp1=vYtemp1(vYtemp1~=0);
%     if length(vXtemp1)<2
%         continue;
%     end
%     dXStart = min(vXtemp1);
%     dXStart = round(dXStart) - 1;
%     dXEnd = max(vXtemp1);
%     dXEnd = round(dXEnd) + 1;
%     dYStart = min(vYtemp1);
%     dYStart = round(dYStart) - 1;
%     dYEnd = max(vYtemp1);
%     dYEnd = round(dYEnd) + 1;
%     figure(j);
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
%     
%    scatter(vXtemp1,vYtemp1,20,[0.2196,0.3490,0.5373],'filled')
%    
%    saveFolder = 'F:\AAALLL\paper_fig'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('%s_%d.emf', datestr(now, 'yyyymmdd_HHMMSS'),j); % 按照日期和时间规则命名
% 
% % 使用 saveas 函数保存图形
% % saveas(gcf, fullfile(saveFolder, fileName), 'meta');
% print(fullfile(saveFolder, fileName), '-dmeta', '-r600','-painters');
% % close(gcf);
%  hold off;  
% %      vZtemp1=ones(size(vXtemp1))*(iTemp*dSlice+dStartZ);
% %       figure;
% %          scatter3(vXtemp1,vYtemp1,vZtemp1,15,[0.2196,0.3490,0.5373],'filled');
% %     scatter3(vXtemp,vYtemp,vZtemp,10,[0.74,0.12,0.12],'filled');
% 
% 
% %       hold off;
% %     [dS]=Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice);
% %    dS=abs(dS);
% %    dS1(j,1)=abs(dS);
% %    dVol = dVol + dS * dSlice;
% %    dS_a(end+1)=dS;
% end
% view(174, 13);
% axis image;
% axis off;


% 
% end