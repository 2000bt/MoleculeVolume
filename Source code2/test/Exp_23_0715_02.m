tic
FontSize = 30;
FontWeight = 'bold';
%估计大概有多少层以及起始以及最终层
dSlice=step(1);
% dSlice=0.1;
Max_Z=max(vZ);
Min_Z=min(vZ);
iOffset=round((Min_Z-dStartZ)/dSlice);
Max_Layer=round((Max_Z-dStartZ)/dSlice);
iLayer=Max_Layer-iOffset+1;

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
vLayer1=zeros(Max_Layer,1);
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
          if(a==b)
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = (index1-1):(index+1)
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<=0)
                      vLayer(k,1)= vLayer(k,1)+1;
                   end
              end
                      
          end
end
toc