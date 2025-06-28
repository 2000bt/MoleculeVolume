%
% %直接先AABB获得公共部分
% close all;
% % [vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);
[Overlap_para,match]=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
%组成补全矩形
rec_vertex=[0,0;0,1;1,1;1,0];
    startt=[Overlap_para(2),Overlap_para(4)];
    finall=[Overlap_para(1),Overlap_para(3)];
    Size=finall-startt;             %方向向量
    vertex=repmat(startt,4,1)+rec_vertex.*repmat(Size,4,1);
    vertex1=vertex;
    vertex1(end+1,:)=vertex(1,:);
    %判断是否要补全
    vertex_match(1)=match(2)+match(4);
    vertex_match(4)=match(1)+match(4);
    vertex_match(3)=match(1)+match(3);
    vertex_match(2)=match(2)+match(3);
% rect = [0, 0; 4, 0; 4, 3; 0, 3]; % 这里假设矩形是一个 4x2 的矩阵，每行代表一个顶点的坐标

% %%%然后依据公共部分的坐标进行切割
% Func_Cut_line(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1, iFaceLength1, vFace1);
%%
%用AABB包围盒筛三角面
[vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);

% %%
% tic
%画出来
figure;
hold on;
Surface1.faces = vFace(vIdx,:);
% Surface1.faces=vFace;
Surface1.vertices = [vX,vY,vZ];
S=Surface1; hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'none');
set(hh, 'EdgeColor', [0.5,0,0]); % 设置边的颜色为蓝色

Surface1.faces = vFace1(vIdx1,:);
Surface1.vertices = [vX1,vY1,vZ1];
S=Surface1; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.1, 'FaceColor', 'b');
set(h, 'EdgeColor', 'b'); % 设置边的颜色为蓝色
Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)],'k');
Func_plot_cuboid([max(vX),max(vY),max(vZ)],[min(vX),min(vY),min(vZ)],'r');
Func_plot_cuboid([max(vX1),max(vY1),max(vZ1)],[min(vX1),min(vY1),min(vZ1)],'b');
% 
% 
% vFace_1=vFace(vIdx,:);
% vFace_2=vFace1(vIdx1,:);
% iFacel=length(vFace_1);
% iFacel1=length(vFace_2);
% mNormal=zeros(iFacel,3);
% mNormal1=zeros(iFacel1,3);
% for i = 1 : iFacel
%    dX1 = vX(vFace_1(i, 1));
%    dX2 = vX(vFace_1(i, 2));
%    dX3 = vX(vFace_1(i, 3));
%    
%    dY1 = vY(vFace_1(i, 1));
%    dY2 = vY(vFace_1(i, 2));
%    dY3 = vY(vFace_1(i, 3));
%    
%    dZ1 = vZ(vFace_1(i, 1));
%    dZ2 = vZ(vFace_1(i, 2));
%    dZ3 = vZ(vFace_1(i, 3));
%    
%    dX4 = (dX1 + dX2 + dX3) / 3;
%    dY4 = (dY1 + dY2 + dY3) / 3;
%    dZ4 = (dZ1 + dZ2 + dZ3) / 3;
% %    换个cross
% %   AB=[dX2,dY2,dZ2]-[dX1,dY1,dZ1];
% %   AC=[dX3,dY3,dZ3]-[dX1,dY1,dZ1];
% %   mNormal(i,:)=cross(AB,AC);
%    mNormal(i, 1) = (dY2 - dY1) * (dZ3 - dZ1) - (dZ2 - dZ1) * (dY3 - dY1);
%    mNormal(i, 2) = (dZ2 - dZ1) * (dX3 - dX1) - (dX2 - dX1) * (dZ3 - dZ1);
%    mNormal(i, 3) = (dX2 - dX1) * (dY3 - dY1) - (dY2 - dY1) * (dX3 - dX1);
% %    mNormal(i, 4) = 0 - (mNormal(i, 1) * dX1 + mNormal(i, 2) * dY1 + mNormal(i, 3) * dZ1);
%    h = quiver3(dX4, dY4, dZ4, mNormal(i, 1), mNormal(i, 2), mNormal(i, 3),'k');
%    set(h,'maxheadsize',1);
% end
% % for i = 1 : iFacel1
% %    dX1 = vX1(vFace_2(i, 1));
% %    dX2 = vX1(vFace_2(i, 2));
% %    dX3 = vX1(vFace_2(i, 3));
% %    
% %    dY1 = vY1(vFace_2(i, 1));
% %    dY2 = vY1(vFace_2(i, 2));
% %    dY3 = vY1(vFace_2(i, 3));
% %    
% %    dZ1 = vZ1(vFace_2(i, 1));
% %    dZ2 = vZ1(vFace_2(i, 2));
% %    dZ3 = vZ1(vFace_2(i, 3));
% %    
% %    dX4 = (dX1 + dX2 + dX3) / 3;
% %    dY4 = (dY1 + dY2 + dY3) / 3;
% %    dZ4 = (dZ1 + dZ2 + dZ3) / 3;
% %    mNormal1(i, 1) = (dY2 - dY1) * (dZ3 - dZ1) - (dZ2 - dZ1) * (dY3 - dY1);
% %    mNormal1(i, 2) = (dZ2 - dZ1) * (dX3 - dX1) - (dX2 - dX1) * (dZ3 - dZ1);
% %    mNormal1(i, 3) = (dX2 - dX1) * (dY3 - dY1) - (dY2 - dY1) * (dX3 - dX1);
% %    mNormal1(i, 4) = 0 - (mNormal1(i, 1) * dX1 + mNormal1(i, 2) * dY1 + mNormal1(i, 3) * dZ1);
% %    h = quiver3(dX4, dY4, dZ4, mNormal1(i, 1), mNormal1(i, 2), mNormal1(i, 3), 'LineWidth', 2);
% %    set(h,'maxheadsize',2);
% % end
hold off;
axis image;
% toc
%%
%开始切割
% [vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);
% FontSize = 30;
% FontWeight = 'bold';
% Overlap_para=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
%估计大概有多少层以及起始以及最终层


dSlice=step(1);
dStartZ = vStart(3);
% iOffset=round((Overlap_para(6)-dStartZ)/dSlice);
% Overlap_para(6)=Overlap_para(6)-dSlice;
% Max_Layer=round((Overlap_para(5)-Overlap_para(6))/dSlice);
% iLayer=Max_Layer;
iOffset=round((Overlap_para(6)-dStartZ)/dSlice);
Max_Layer=round((Overlap_para(5)-dStartZ)/dSlice);
iLayer=Max_Layer-iOffset+1;

vFace_Box=vFace(vIdx,:);
vFace1_Box=vFace1(vIdx1,:);
Len_face=length(vFace_Box);
Len_face1=length(vFace1_Box);

%%%生成三角面片的线矩阵
vFaceline=zeros(Len_face*3,2);
vFaceline(1:Len_face,1)=vFace_Box(1:Len_face,1);
vFaceline(1:Len_face,2)=vFace_Box(1:Len_face,2);
vFaceline(Len_face+1:Len_face*2,1)=vFace_Box(1:Len_face,2);
vFaceline(Len_face+1:Len_face*2,2)=vFace_Box(1:Len_face,3);
vFaceline(Len_face*2+1:Len_face*3,1)=vFace_Box(1:Len_face,1);
vFaceline(Len_face*2+1:Len_face*3,2)=vFace_Box(1:Len_face,3);
vFaceline=sort(vFaceline,2);
vFaceline=unique(vFaceline,'row','stable');

FacelineLen=length(vFaceline);

%通过三个按分层序号排列的XYZ坐标矩阵
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%预计每层有几个数据
vLayer=zeros(Max_Layer,1);
vLayer1=zeros(Max_Layer,1);
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
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                  if(k>Max_Layer || k<iOffset)
                      continue;
                  else
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
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                  if(k>Max_Layer||k<iOffset)
                      continue;
                  else
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
                  end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end


dS=0;
dVol=0;

vFaceline1=zeros(Len_face1*3,2);
vFaceline1(1:Len_face1,1)=vFace1_Box(1:Len_face1,1);
vFaceline1(1:Len_face1,2)=vFace1_Box(1:Len_face1,2);
vFaceline1(Len_face1+1:Len_face1*2,1)=vFace1_Box(1:Len_face1,2);
vFaceline1(Len_face1+1:Len_face1*2,2)=vFace1_Box(1:Len_face1,3);
vFaceline1(Len_face1*2+1:Len_face1*3,1)=vFace1_Box(1:Len_face1,1);
vFaceline1(Len_face1*2+1:Len_face1*3,2)=vFace1_Box(1:Len_face1,3);
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
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                  if(k>Max_Layer||k<iOffset)
                      continue;
                  else
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
end
%%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer1);
matX1=zeros(len,Max_Layer);
matY1=zeros(len,Max_Layer);
matZ1=zeros(len,Max_Layer);

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
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                  if(k>Max_Layer||k<iOffset)
                      continue;
                  else
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
                  end
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end
% 
% figure;

    %%
dVol=0;
% for j = 3:3
for j = 19:iLayer
%     if(j==1)
    iTemp = j+iOffset-1;
%     else
%         iTemp = j - 1;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
    if(length(vXtemp)<=2)
        j
        continue;
    end
%     vXtemp=unique(vXtemp,'row','stable');
    vYtemp=matY(:,iTemp);
    vYtemp=vYtemp(vYtemp~=0);
    vZtemp=matZ(:,iTemp);
    vZtemp=vZtemp(vZtemp~=0);
    
    vXtemp1=matX1(:,iTemp);
    vXtemp1=vXtemp1(vXtemp1~=0);
    if(length(vXtemp1)<=2)
        iTemp
        continue;
    end
%     vXtemp=unique(vXtemp,'row','stable');
    vYtemp1=matY1(:,iTemp);
    vYtemp1=vYtemp1(vYtemp1~=0);
    vZtemp1=matZ1(:,iTemp);
    vZtemp1=vZtemp1(vZtemp1~=0);
    figure;
    hold on;
    scatter3(vXtemp,vYtemp,vZtemp,'filled','r');
    scatter3(vXtemp1,vYtemp1,vZtemp1,'filled','b');
%     Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice);
    hold off;
     Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)],'k');
    [dS]=Func_Find_interp1(vXtemp,vYtemp,vXtemp1,vYtemp1,dSlice,step1(1),vertex,vertex_match);
%     


   
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
   
%     dS
   dVol = dVol + dS * dSlice;
end