%%包围盒筛除一部分
[vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);
tic
%%空间三角形快速相交算法求交线
% vFacetemp=vFace(vIdx,:);
% vFacetemp1=vFace(vIdx1,:);
% load tetmesh;
% TR = triangulation(tet,X);
% [Surface4.faces, Surface4.vertices] = freeBoundary(TR);
% 
% TR=triangulation(vFace,vX,vY,vZ);
% [Surface2.faces, Surface2.vertices] = freeBoundary(TR);
% 
% TR1=triangulation(vFace1,vX1,vY1,vZ1);
% [Surface3.faces, Surface3.vertices] = freeBoundary(TR1);

len=length(vIdx);
Surface=[];
Surface1=[];
for k=0:len-1
    a=vIdx(k+1);
    X1 = vX(vFace(a, 1));
    Y1 = vY(vFace(a, 1));
    Z1 = vZ(vFace(a, 1));
    X2 = vX(vFace(a, 2));
    Y2 = vY(vFace(a, 2));
    Z2 = vZ(vFace(a, 2));
    X3 = vX(vFace(a, 3));
    Y3 = vY(vFace(a, 3));
    Z3 = vZ(vFace(a, 3));
    Surface.vertices(3*k+(1:3),:)=[X1 Y1 Z1;X2 Y2 Z2;X3 Y3 Z3];
    Surface.faces(k+1,:)=3*k+(1:3);
end
len1=length(vIdx1);
for k1=0:len1-1
    a=vIdx1(k1+1);
    X1 = vX1(vFace1(a, 1));
    Y1 = vY1(vFace1(a, 1));
    Z1 = vZ1(vFace1(a, 1));
    X2 = vX1(vFace1(a, 2));
    Y2 = vY1(vFace1(a, 2));
    Z2 = vZ1(vFace1(a, 2));
    X3 = vX1(vFace1(a, 3));
    Y3 = vY1(vFace1(a, 3));
    Z3 = vZ1(vFace1(a, 3));
    Surface1.vertices(3*k1+(1:3),:)=[X1 Y1 Z1;X2 Y2 Z2;X3 Y3 Z3];
    Surface1.faces(k1+1,:)=3*k1+(1:3);
end

hold on;
% S=Surface; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% S=Surface1; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor',[0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'g');
% Overlap_para=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
% Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)]);
% S=Surface4; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'b');
 




[intersection,Surf] = SurfaceIntersection(Surface,Surface1);
S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'r','LineWidth', 2,  'FaceColor', 'r');
toc

%%重构边界，还不确定需不需要


%%判断面域位置关系

%%对相交部分切割求体积