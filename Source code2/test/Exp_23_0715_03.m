tic
vLayer1(:,1)=vLayer(:,1);
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
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = (index1-1):(index+1)
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<=0)
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                   end
              end
                      
          end
end

toc
