function[vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1)
%用AABB包围盒筛除部分三角面片
tic
Overlap_para=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
vWhich=ones(iFaceLength,1);
vWhich1=ones(iFaceLength1,1);
dx1=(Overlap_para(1)-Overlap_para(2))/2;
dy1=(Overlap_para(3)-Overlap_para(4))/2;
dz1=(Overlap_para(5)-Overlap_para(6))/2;
hx1=dx1+Overlap_para(2);
hy1=dy1+Overlap_para(4);
hz1=dz1+Overlap_para(6);
% rect=[Overlap_para(1),Overlap_para(3);Overlap_para(2),Overlap_para(3);Overlap_para(2),Overlap_para(4);Overlap_para(1),Overlap_para(4)];
for i=1:iFaceLength
    X1 = vX(vFace(i, 1));
    Y1 = vY(vFace(i, 1));
    Z1 = vZ(vFace(i, 1));
    X2 = vX(vFace(i, 2));
    Y2 = vY(vFace(i, 2));
    Z2 = vZ(vFace(i, 2));
    X3 = vX(vFace(i, 3));
    Y3 = vY(vFace(i, 3));
    Z3 = vZ(vFace(i, 3));
    X_min=min([X1,X2,X3]);
    Y_min=min([Y1,Y2,Y3]);
    Z_min=min([Z1,Z2,Z3]);
    X_max=max([X1,X2,X3]);
    Y_max=max([Y1,Y2,Y3]);
    Z_max=max([Z1,Z2,Z3]);
    
%     if(((X_min>Overlap_para(1))||(Y_min>Overlap_para(3))||(Z_min>Overlap_para(5)))||((X_max<Overlap_para(2))||(Y_max<Overlap_para(4))||(Z_max<Overlap_para(6))))
%         vWhich(i)=0;
%         continue;
%     end
    
    dx=(X_max-X_min)/2;
    dy=(Y_max-Y_min)/2;
    dz=(Z_max-Z_min)/2;
    if(abs(X_min+dx-hx1)>(dx+dx1))
        vWhich(i)=0;
        continue;
    elseif(abs(Y_min+dy-hy1)>(dy+dy1))
        vWhich(i)=0;
        continue;
    elseif(abs(Z_min+dz-hz1)>(dz+dz1))
        vWhich(i)=0;
        continue;
    else
        continue;
    end
end
for j=1:iFaceLength1
    X1 = vX1(vFace1(j, 1));
    Y1 = vY1(vFace1(j, 1));
    Z1 = vZ1(vFace1(j, 1));
    X2 = vX1(vFace1(j, 2));
    Y2 = vY1(vFace1(j, 2));
    Z2 = vZ1(vFace1(j, 2));
    X3 = vX1(vFace1(j, 3));
    Y3 = vY1(vFace1(j, 3));
    Z3 = vZ1(vFace1(j, 3));
    X_min=min([X1,X2,X3]);
    Y_min=min([Y1,Y2,Y3]);
    Z_min=min([Z1,Z2,Z3]);
    X_max=max([X1,X2,X3]);
    Y_max=max([Y1,Y2,Y3]);
    Z_max=max([Z1,Z2,Z3]);
%     if(((X_min>Overlap_para(1))||(Y_min>Overlap_para(3))||(Z_min>Overlap_para(5)))||((X_max<Overlap_para(2))||(Y_max<Overlap_para(4))||(Z_max<Overlap_para(6))))
%         vWhich1(j)=0;
%         continue;
%     end
    dx=(X_max-X_min)/2;
    dy=(Y_max-Y_min)/2;
    dz=(Z_max-Z_min)/2;
   if(abs(X_min+dx-hx1)>(dx+dx1))
        vWhich1(j)=0;
        continue;
    elseif(abs(Y_min+dy-hy1)>(dy+dy1))
        vWhich1(j)=0;
        continue;
    elseif(abs(Z_min+dz-hz1)>(dz+dz1))
        vWhich1(j)=0;
        continue;
    else
        continue;
    end
end
vIdx=find(vWhich>0);
len=length(vIdx);
% for k=1:len
%     a=vIdx(k);
%     X1 = vX(vFace(a, 1));
%     Y1 = vY(vFace(a, 1));
%     Z1 = vZ(vFace(a, 1));
%     X2 = vX(vFace(a, 2));
%     Y2 = vY(vFace(a, 2));
%     Z2 = vZ(vFace(a, 2));
%     X3 = vX(vFace(a, 3));
%     Y3 = vY(vFace(a, 3));
%     Z3 = vZ(vFace(a, 3));
%     hold on;
%     line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 1, 'Color', [0, 0, 1] );
%     line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 1, 'Color', [0, 0, 1]);
%     line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 1, 'Color', [0, 0, 1] );
% end
vIdx1=find(vWhich1>0);
% len1=length(vIdx1);
% for k1=1:len1
%     a=vIdx1(k1);
%     X1 = vX1(vFace1(a, 1));
%     Y1 = vY1(vFace1(a, 1));
%     Z1 = vZ1(vFace1(a, 1));
%     X2 = vX1(vFace1(a, 2));
%     Y2 = vY1(vFace1(a, 2));
%     Z2 = vZ1(vFace1(a, 2));
%     X3 = vX1(vFace1(a, 3));
%     Y3 = vY1(vFace1(a, 3));
%     Z3 = vZ1(vFace1(a, 3));
%     hold on;
%     line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 1, 'Color', [0, 1, 0] );
%     line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 1, 'Color', [0, 1, 0]);
%     line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 1, 'Color', [0, 1, 0] );
% end
% Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)]);
%pos=[Overlap_para(1)+dx/2,Overlap_para(3)+dy/2,Overlap_para(5)+dz/2,dx,dy,dz,0,0,0];
%showShape('cuboid',pos,'Color','green','Opacity',0.5);
toc