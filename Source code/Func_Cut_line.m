% function Func_Cut_line(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1, iFaceLength1, vFace1)
tic
[vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);
% FontSize = 30;
% FontWeight = 'bold';
Overlap_para=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
%���ƴ���ж��ٲ��Լ���ʼ�Լ����ղ�


dSlice=0.4443;
% iOffset=round((Overlap_para(6)-dStartZ)/dSlice);
Overlap_para(6)=Overlap_para(6)-dSlice;
Max_Layer=round((Overlap_para(5)-Overlap_para(6))/dSlice);
iLayer=Max_Layer;
% Max_Z=max(vZ);
% Min_Z=min(vZ);
% iOffset=round((Min_Z-dStartZ)/dSlice);
% Max_Layer=round((Max_Z-dStartZ)/dSlice);
% iLayer=Max_Layer-iOffset+1;
vFace_Box=vFace(vIdx,:);
vFace1_Box=vFace1(vIdx1,:);
Len_face=length(vFace_Box);
Len_face1=length(vFace1_Box);

%%%����������Ƭ���߾���
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

%ͨ���������ֲ�������е�XYZ�������
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%Ԥ��ÿ���м�������
vLayer=zeros(iLayer,1);
vLayer1=zeros(iLayer,1);
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
          
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue
          else
              index=round((a-Overlap_para(6))/dSlice);
              index1=round((b-Overlap_para(6))/dSlice);
              for k = index1:index
                  if(k>Max_Layer)
                      continue;
                  else
                   c=k*dSlice+Overlap_para(6);
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
%%%ͬ���ж����Ĳ㣬Ȼ��ͬ�����㽻�����ݣ�����ھ�����
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
          if(a==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue
          else
              index=round((a-Overlap_para(6))/dSlice);
              index1=round((b-Overlap_para(6))/dSlice);
              for k = index1:index
                  if(k>Max_Layer)
                      continue;
                  else
                   c=k*dSlice+Overlap_para(6);
                   if((a-c)*(b-c)<0)
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                   elseif((a==c)&&((is_used1(aux)==0)))
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dY1,dY2,dZ1,dZ2);
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


% dS=0;
% dVol=0;

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
          
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue
          else
              index=round((a-Overlap_para(6))/dSlice);
              index1=round((b-Overlap_para(6))/dSlice);
              for k = index1:index
                  if(k>Max_Layer)
                      continue;
                  else
                   c=k*dSlice+Overlap_para(6);
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
%%%ͬ���ж����Ĳ㣬Ȼ��ͬ�����㽻�����ݣ�����ھ�����
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer1);
matX1=zeros(len,iLayer);
matY1=zeros(len,iLayer);
matZ1=zeros(len,iLayer);

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
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue
          else
              index=round((a-Overlap_para(6))/dSlice);
              index1=round((b-Overlap_para(6))/dSlice);
              for k = index1:index
                  if(k>Max_Layer)
                      continue;
                  else
                   c=k*dSlice+Overlap_para(6);
                   if((a-c)*(b-c)<0)
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dY1,dY2,dZ1,dZ2);
                      matZ1(vLayer1(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer1(k,1)= vLayer1(k,1)-1;
                   elseif((a==c)&&((is_used3(aux)==0)))
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,Overlap_para(6),dSlice,dY1,dY2,dZ1,dZ2);
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

for j = 1:iLayer
%     if(j==1)
       iTemp = j;
%     else
%         iTemp = j - 1;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
    if(length(vXtemp)<=2)
        iTemp
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
    figure(j);
    hold on;
    scatter3(vXtemp,vYtemp,vZtemp,'filled','r');
    scatter3(vXtemp1,vYtemp1,vZtemp1,'filled','b');
%     Func_Find_interp(vXtemp,vYtemp,vXtemp1,vYtemp1,j,dSlice);
%     hold on;
%     Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)]);
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
%    dVol = dVol + dS * dSlice;
end
toc


