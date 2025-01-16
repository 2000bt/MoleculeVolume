tic
clear;clc;close all
FontSize = 22;
FontWeight = 'bold';
% strFile = 'H:\matlab2019a\bin\batch4\Sc_Ketone1\Sc_Ketone1.dst';
% strFile1 = 'H:\matlab2019a\bin\batch4\Sc_itr\Sc_itr.dst';
% strFile = 'H:\matlab2019a\bin\batch1\Sc_Ketone6\Sc_Ketone6.dst';
% strFile1 = 'H:\matlab2019a\bin\batch1\Sc_ap\Sc_ap.dst';
% strFile = 'H:\matlab2019a\bin\batch3\cat6\cat6.dst';
% strFile1 = 'H:\matlab2019a\bin\batch3\subr2\subr2.dst';
strFile1 = 'D:\GraStuCor\EleMolCloud\Molecule\宁利超1\A\A1.dst';
strFile = 'D:\GraStuCor\EleMolCloud\Molecule\宁利超1\B\B1.dst';
% 
% strFile1 = 'F:\AAALLL\Data12.06\nlc2\A\density1.cub';
% strFile = 'F:\AAALLL\Data12.06\nlc2\B\density1.cub';

[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
[ Atom_info1, AtomNum1, ~, CubePoints1, step_num1, step1, vStart1 ] = Func_GetCubePoints( strFile1 );
load LUT;
cAtomRadius = Func_LoadAtomRadius( 'Acce3.txt' );

[X,Y,Z,face]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num1, step_num2, step_num3, LUT);
[X,Y,Z,face]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num1, step_num2, step_num3, LUT);

dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
% for i = 1 : AtomNum
%     iLenTemp = size(cAtomRadius);%这个意思是在所有原子找
%     for j = 1 : iLenTemp
%         if(Atom_info(i, 1) == cAtomRadius{ j, 3 })
%             Atom_info(i, 5) = cAtomRadius{ j, 2 };
%             break
%         end
%     end
% end
% 
% for i = 1 : AtomNum1
%     iLenTemp = size(cAtomRadius);
%     for j = 1 : iLenTemp
%         if(Atom_info1(i, 1) == cAtomRadius{ j, 3 })
%             Atom_info1(i, 5) = cAtomRadius{ j, 2 };
%             break
%         end
%     end
% end
vX=vX+10;
%%
%移到可以碰撞的位置,ketone1  z11
% vY1 = vY1 - 14;
% Atom_info1(:, 3) = Atom_info1(:, 3) - 14;
% 
% vX1 = vX1 - 5;
% Atom_info1(:, 2) = Atom_info1(:, 2) - 5;
% vZ1 = vZ1 - 11;
% Atom_info1(:, 4) = Atom_info1(:, 4) -11;
%cat6
% vX1 = vX1 - 20;
% Atom_info1(:, 2) = Atom_info1(:, 2) - 20;
% vY1 = vY1 - 20;
% Atom_info1(:, 3) = Atom_info1(:, 3) - 20;
% vX1 = vX1 - 10;
% Atom_info1(:, 2) = Atom_info1(:, 2) - 10;
%%Ketone6
% vY1 = vY1 - 13;
% Atom_info1(:, 3) = Atom_info1(:, 3) - 13;
% 
% vX1 = vX1 + 10;
% vY1 = vY1 + 10;
% Atom_info1(:, 2) = Atom_info1(:, 2) + 10;
% Atom_info1(:, 3) = Atom_info1(:, 3) + 10;

% figure;
% hold on;
% scatter3(vX,vY,vZ,'b','.');
% hold off;
% axis image;
% axis off;

% % scatter3(vX1,vY1,vZ1,'b','.');
% % hold off;
% % axis image;
% % axis off;
%%
% result=cell(111,2);
% a=1;
% for b = 1:3
%     for c = 0 : 10 : 360
% % for b = 0
% %     for c = 0
%     if b==1
%         [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(Atom_info(1,2), Atom_info(1,3), Atom_info(1,4), vX1, vY1, vZ1,iCloudLength1, Atom_info1, c,0, 0 );
%     elseif b==2
%         [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(Atom_info(1,2), Atom_info(1,3), Atom_info(1,4), vX1, vY1, vZ1,iCloudLength1, Atom_info1, 0,c, 0 );
%     else
%        [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(Atom_info(1,2), Atom_info(1,3), Atom_info(1,4), vX1, vY1, vZ1,iCloudLength1, Atom_info1, 0,0, c ); 
%     end
%     toc
% figure;
% hold on;
% % % % view(180,0);
% % % % view(3);
% Surface1.faces = vFace;
% Surface1.vertices = [vX,vY,vZ];
% S=Surface1;
% hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
% % % % hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.8);
% % % % % S=Surface1; hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'none' );
% % % % set(hh, 'EdgeColor', [0.74,0.12,0.12]); %red0.8745,0.4784,0.3686
% % % %     set(hh,'EdgeColor',[0.9647,0.4353,0.4118]);
% % % % %     set(hh,'EdgeColor',[0.8745,0.4784,0.3686]);
% set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
% % set(hh,'EdgeColor',[0.2196,0.3490,0.5373]);
% % % Func_plot_cuboid([min(vX),min(vY),min(vZ)],[max(vX),max(vY),max(vZ)],[0.8235,0.1255,0.1529]);
% % % 
% % axis off;
% % axis image;
% % hold off;
% % % hh.EdgeColor = 'none';   % 消除网格线
% % % %%透视投影
% % % camproj('perspective');   % 透视投影
% % % % 光照
% % % l1 = light;
% % % l1.Position = [160 400 80];
% % % l1.Style = 'local';
% % % l1.Color = [0 0.8 0.8];
% % % l2 = light;
% % % l2.Position = [.5 -1 .4];
% % % l2.Color = [0.8 0.8 0];
% % % % 材质
% % % hh.FaceColor = [1,0.98039,0.98039];
% % % hh.FaceLighting = 'gouraud';
% % % hh.AmbientStrength = 0.3;
% % % hh.DiffuseStrength = 0.6; 
% % % hh.BackFaceLighting = 'lit';
% % % hh.SpecularStrength = 1;
% % % hh.SpecularColorReflectance = 1;
% % % hh.SpecularExponent = 7;
% % 
% % % set(hh,'EdgeColor','r');
% % % set(hh, 'LineWidth', 0.51); 
% % % shading interp
% % axis off;
% 
% % axis image;
% % % axis off; % hold off; % %% % figure; % hold on; 
% % % for
% % % iii=1:1000 % % scatter3(vX(iii),vY(iii),vZ(iii),'b','.'); %
% % % plot3(vX(iii),vY(iii),vZ(iii),'b.','MarkerSize',15); % end % %%
% % figure;
% Surface1.faces = vFace1;
% Surface1.vertices = [vX2,vY2,vZ2];
% % % Surface1.vertices = [vX1,vY1,vZ1];
% S=Surface1; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]);
% % % % % S=Surface1; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'none');
% % % % % set(h, 'EdgeColor',[0.24,0.25,0.36]); % 设置边的颜色为蓝色
% % % % % set(h, 'EdgeColor', [0,0,0.50196]); % 设置边的颜色为蓝色[0.2353,0.2510,0.3569]
% % % % % set(h,'EdgeColor',[0.0549,0.3765,0.4196]);
% % % % set(h,'EdgeColor',[0.2353,0.2510,0.3569]);
% set(h,'EdgeColor',[0.2196,0.3490,0.5373]);
% set(h,'EdgeColor',[0.8235,0.1255,0.1529]);
% % % % set(h,'EdgeColor','b');
% % % % set(h, 'LineWidth', 0.51);   % 设置边的粗细为 2
% % % % % % % Func_plot_cuboid([min(vX),min(vY),min(vZ)],[max(vX),max(vY),max(vZ)],[1,0,0]);
%Func_plot_cuboid([min(vX2),min(vY2),min(vZ2)],[max(vX2),max(vY2),max(vZ2)],[0.2196,0.3490,0.5373]);
% % % % % view(0, 0);
% % % % axis image;
% view(0,0);
% view(180,0);
% view(-145, 30);
% % view(-7,88);
% axis off;
% axis image;
% hold off;
figure;
        hold on;
        % % view(180,0);
        % % view(3);
        Surface1.faces = vFace1;
        Surface1.vertices = [vX1,vY1,vZ1];
        S=Surface1;
        hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
        set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
        
        Surface2.faces = vFace;
%         Surface2.vertices = [vX2,vY2,vZ2];
        Surface2.vertices = [vX,vY,vZ];
        S=Surface2; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]);
        set(h,'EdgeColor',[0.2196,0.3490,0.5373])
        hold off;
% figure;
% vUsed = zeros(length(vZ), 1);
% vUsed(1:500,:) = 1;
% % idx=[];
% % idxx=[];
% % idxy=[];
% % idxz=[];
% for i = 1 : iFaceLength
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
% %         idx(end+1,:)=i;
% %         idxx(end+1,:)=vFace(i, 1);
% %         idxy(end+1,:)=vFace(i, 2);
% %         idxz(end+1,:)=vFace(i, 3);
%         hold on;
%         X1 = vX(vFace(i, 1));
%         Y1 = vY(vFace(i, 1));
%         Z1 = vZ(vFace(i, 1));
%         X2 = vX(vFace(i, 2));
%         Y2 = vY(vFace(i, 2));
%         Z2 = vZ(vFace(i, 2));
%         X3 = vX(vFace(i, 3));
%         Y3 = vY(vFace(i, 3));
%         Z3 = vZ(vFace(i, 3));
%         line( [ X1; X2 ], [ Y1; Y2 ], [ Z1; Z2 ], 'LineWidth', 2, 'Color', [0.5,0,0] );
%         line( [ X2; X3 ], [ Y2; Y3 ], [ Z2; Z3 ], 'LineWidth', 2, 'Color', [0.5,0,0]);
%         line( [ X3; X1 ], [ Y3; Y1 ], [ Z3; Z1 ], 'LineWidth', 2, 'Color', [0.5,0,0] );
%     end
% end
% % figure;
% % hold on;
% % Surface1.faces = vFace(idx);
% % Surface1.vertices = [vX,vY,vZ];
% % S=Surface1; hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.90196,0.90196,0.98039]);
% % 
% % set(hh, 'EdgeColor', [0.5,0,0]); % 设置边的颜色为蓝色
% axis image;
% axis off;
% hold off;
% 

% Func_plot_cuboid([Overlap_para(1),Overlap_para(3),Overlap_para(5)],[Overlap_para(2),Overlap_para(4),Overlap_para(6)]);
% angle3 = 90;
% myzRotate = [1 0 0; 0 cos(angle3*pi/180) -sin(angle3*pi/180); 0 sin(angle3*pi/180) cos(angle3*pi/180)];
% mCat_Points = [vX1, vY1, vZ1];
% mCat_Points = (myzRotate * mCat_Points')';
% vX2=mCat_Points(:,1);
% vY2=mCat_Points(:,2);
% vZ2=mCat_Points(:,3);
% 
% angle_x = 60; % 角度（度数）
% angle_x_rad = angle_x * pi / 180; % 将角度转换为弧度
% 
% myxRotate = [1 0 0; 0 cos(angle_x_rad) -sin(angle_x_rad); 0 sin(angle_x_rad) cos(angle_x_rad)];
% mCat_Points1 = [vX1, vY1, vZ1];
% mCat_Points1 = (myxRotate * mCat_Points1')';
% vX3=mCat_Points1(:,1);
% vY3=mCat_Points1(:,2);
% vZ3=mCat_Points1(:,3);
% %%
% %平移加旋转90（z轴）
% figure;
% scatter31 = scatter3( vX, vY, vZ, 'r.',  '.' );
% scatter31.MarkerFaceAlpha = 0.15;
% scatter31.MarkerEdgeAlpha = 0.15;
% scatter31.SizeData = 30;
% hold on 
% % Func_DrawCuboid( max(vX), min(vX), max(vY), min(vY), max(vZ), min(vZ) )
% scatter32 = scatter3( vX2, vY2, vZ2, 'b.',  '.' );
% scatter32.MarkerFaceAlpha = 0.12;
% scatter32.MarkerEdgeAlpha = 0.12;
% scatter32.SizeData = 20;
% % axis off;
% axis image;
% %%
% %平移加旋转90（z轴）
% figure;
% scatter31 = scatter3( vX, vY, vZ, 'r.',  '.' );
% scatter31.MarkerFaceAlpha = 0.15;
% scatter31.MarkerEdgeAlpha = 0.15;
% scatter31.SizeData = 30;
% hold on 
% % Func_DrawCuboid( max(vX), min(vX), max(vY), min(vY), max(vZ), min(vZ) )
% scatter32 = scatter3( vX1, vY1, vZ1, 'b.',  '.' );
% scatter32.MarkerFaceAlpha = 0.12;
% scatter32.MarkerEdgeAlpha = 0.12;
% scatter32.SizeData = 20;
% % axis off;
% axis image;
% %%
% %平移加旋转90（z轴）
% figure;
% scatter31 = scatter3( vX, vY, vZ, 'r.',  '.' );
% scatter31.MarkerFaceAlpha = 0.15;
% scatter31.MarkerEdgeAlpha = 0.15;
% scatter31.SizeData = 30;
% hold on 
% % Func_DrawCuboid( max(vX), min(vX), max(vY), min(vY), max(vZ), min(vZ) )
% scatter32 = scatter3( vX3, vY3, vZ3, 'b.',  '.' );
% scatter32.MarkerFaceAlpha = 0.12;
% scatter32.MarkerEdgeAlpha = 0.12;
% scatter32.SizeData = 20;
% % axis off;
% axis image;
%%
% iLen = length(vX1);
% iFace = length(vFace1);
% % % 
% dir='F:\AAALLL\ply\';
% if b==1
%     dir1='itrz11x';
% elseif b==2
%     dir1='itrz11y';
% else
%     dir1='itrz11z';
% end
% filename=strcat(dir,dir1,num2str(c),'.ply');
% fid = fopen(filename, 'wt');
% fprintf(fid,'ply\n');
% fprintf(fid,'format ascii 1.0\n');
% fprintf(fid,'comment generated by ply_writer\n');
% fprintf(fid,'element vertex %d\n', iLen);
% fprintf(fid,'property float x\n');
% fprintf(fid,'property float y\n');
% fprintf(fid,'property float z\n');
% fprintf(fid,'element face %d\n', iFace);
% fprintf(fid,'property list uchar int vertex_indices\n');
% fprintf(fid,'end_header\n');
% for i = 1 : iLen
%     fprintf(fid, '%8.6f %8.6f %8.6f\n', vX2(i),  vY2(i),  vZ2(i));
% end
% for i = 1 : iFace
%     fprintf(fid,'%d %d %d %d\n', 3, vFace1(i, 1)-1, vFace1(i, 2) - 1, vFace1(i, 3) - 1);
% end
% fclose(fid);
% 
% dVol=0;
% cross=[];

% 
    [dVol,cross]= test3(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1);
% 
%     result{a,1}=dVol;
%     result{a,2}=cross;
%     a=a+1;
%     end
% end
% toc
% %%
% iLen = length(vX);
% iFace = length(vFace);
% % % 
% fid = fopen('F:\AAALLL\ply\Sc_Ketone1.ply', 'wt');
% fprintf(fid,'ply\n');
% fprintf(fid,'format ascii 1.0\n');
% fprintf(fid,'comment generated by ply_writer\n');
% fprintf(fid,'element vertex %d\n', iLen);
% fprintf(fid,'property float x\n');
% fprintf(fid,'property float y\n');
% fprintf(fid,'property float z\n');
% fprintf(fid,'element face %d\n', iFace);
% fprintf(fid,'property list uchar int vertex_indices\n');
% fprintf(fid,'end_header\n');
% for i = 1 : iLen
%     fprintf(fid, '%8.6f %8.6f %8.6f\n', vX(i),  vY(i),  vZ(i));
% end
% for i = 1 : iFace
%     fprintf(fid,'%d %d %d %d\n', 3, vFace(i, 1)-1, vFace(i, 2) - 1, vFace(i, 3) - 1);
% end
% fclose(fid);
% % % %% 两个文件to ply
% % % iLen = length(vX) + length(vX1);
% % % iFace = length(vFace) + length(vFace1);
% % % vFace1 = vFace1 + length(vX);
% % % mPoints = [vX, vY, vZ; vX1, vY1, vZ1];
% % % mFaces = [vFace;vFace1];
% % % 
% % % fid = fopen('H:\matlab2019a\bin\LFT\hebing.ply', 'wt');
% % % fprintf(fid,'ply\n');
% % % fprintf(fid,'format ascii 1.0\n');
% % % fprintf(fid,'comment generated by ply_writer\n');
% % % fprintf(fid,'element vertex %d\n', iLen );
% % % fprintf(fid,'property float x\n');
% % % fprintf(fid,'property float y\n');
% % % fprintf(fid,'property float z\n');
% % % fprintf(fid,'element face %d\n', iFace );
% % % fprintf(fid,'property list uchar int vertex_indices\n');
% % % fprintf(fid,'end_header\n');
% % % for i = 1 : iLen
% % %     fprintf(fid, '%8.6f %8.6f %8.6f\n', mPoints(i, 1)-1,  mPoints(i, 2)-1,  mPoints(i, 3)-1);
% % % end
% % % for i = 1 : iFace
% % %     fprintf(fid,'%d %d %d %d\n', 3, mFaces(i , 1)-1, mFaces(i , 2)-1, mFaces(i, 3)-1);
% % % end
% % % fclose(fid);
% % % Overlap_para=Func_para(vX,vY,vZ,vX1,vY1,vZ1)
% %%
% figure;
% hold on;
% box on;
% x=0:10:60;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
%  b=dev(1:7,1).*100; %a数据y值
%  a=dev1(1:7,1).*100; %b数据y值
%  c=dev2(1:7,1).*100;
% %  b=dev(8:14,1).*100; %a数据y值
% %  a=dev1(8:14,1).*100; %b数据y值
% %  c=dev2(8:14,1).*100;
% %  b=dev(15:21,1).*100; %a数据y值
% %  a=dev1(15:21,1).*100; %b数据y值
% %  c=dev2(15:21,1).*100;
% plot(x,a,'-o',...
%     'Color',[0.3020,0.5216,0.7412],...
%     'LineWidth',2.5,...
%     'MarkerSize',8);
% 
% plot(x,b,'-s',...
%     'Color',[0.9686,0.5647,0.2392],...
%     'LineWidth',2.5,...
%     'MarkerSize',8);
% 
% plot(x,c,'-*',...
%     'Color',[0.3490,0.6627,0.3529],...
%     'LineWidth',2.5,...
%     'MarkerSize',8);
% axis([-5,65,0,0.75])  %确定x轴与y轴框图大小
% % 
% set(gca,'XTick',[0:10:60],'FontSize', 14) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:0.1:0.75],'FontSize', 14) %y轴范围0-700，间隔100
% legend('Experiment 1','Experiment 2','Experiment 3','FontSize', 13);   %右上角标注
% % axis image;
% xlabel('Rotating angle (degree)','FontSize', 14)  %x轴坐标描述
% ylabel('Volume relative error/%','FontSize', 14) %y轴坐标描述
% % 显示每个数据点的数据值
% offset=0.01;
% for i = 1:length(x)
%     text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
%     if i==2|| i==4
%          text(x(i), b(i)+offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
%          text(x(i), c(i)-offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
%     elseif i==7||i==5
%          text(x(i), b(i)- 2*offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
%          text(x(i), c(i)+ offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
%     elseif i==3
%         text(x(i), b(i)+2*offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i), sprintf('%.4f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
%         text(x(i), c(i)+offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
%     elseif i==6
%         text(x(i), b(i)+offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i), sprintf('%.4f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
%         text(x(i)+4, c(i), sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize', 10);
%    
%     else
%         text(x(i), b(i)+offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i), sprintf('%.4f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
%         text(x(i), c(i)+offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
%     end
%     
% end
% % for i = 1:length(x)
% %     if  i==3
% %          text(x(i), b(i)-0.001, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %          text(x(i)+2, a(i)+ 2*offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %          text(x(i)+1, c(i), sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     elseif i==4
% %         text(x(i), b(i)+ offset/2, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), c(i)+ offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     elseif i==5
% %           text(x(i), b(i)-offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %           text(x(i)+4, a(i), sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize', 10);
% %           text(x(i)-1.5, c(i)+2*offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     elseif i==6
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i)+1, c(i)-2* offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %     else
% %         
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), c(i)+ offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     end
% %     
% % end
% % for i = 1:length(x)
% %     if  i==3
% %          text(x(i), b(i)-offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %          text(x(i)+2, a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %          text(x(i), c(i)+offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     elseif i==4
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), c(i)- offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %     elseif i==5
% %           text(x(i), b(i)-offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %           text(x(i), a(i)+offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %           text(x(i)-1.5, c(i)+offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     elseif i==6
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), c(i)- offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %     elseif i==7
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)- offset/2, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top','FontSize', 10);
% %         text(x(i), c(i)+ offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %   
% %     else
% %         text(x(i), b(i)+ offset, sprintf('%.3f', b(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), a(i)+ offset, sprintf('%.3f', a(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %         text(x(i), c(i)+ offset, sprintf('%.3f', c(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize', 10);
% %     end
% %     
% % end
% % % 
% % % set( gcf,'PaperSize',[29.7 21.0], 'PaperPosition',[0 0 29.7 21.0])
% % % %% 
% % % % 创建窗口
% % % f = figure('position',[200,200,500,500],'color','w');
% % % %%定义坐标区
% % % ax = axes;
% % % ax.XLim = [1 201];
% % % ax.YLim = [1 201];
% % % ax.ZLim = [-53.4 160];
% % % %%相机视角
% % % view(3);
% % % %%生成曲面
% % % s = surface(160*membrane(1,100));
% % % s.EdgeColor = 'none';   % 消除网格线
% % % %%透视投影
% % % camproj('perspective');   % 透视投影
% % % %%光照
% % % l1 = light;
% % % l1.Position = [160 400 80];
% % % l1.Style = 'local';
% % % l1.Color = [0 0.8 0.8];
% % % l2 = light;
% % % l2.Position = [.5 -1 .4];
% % % l2.Color = [0.8 0.8 0];
% % % %% 材质
% % % s.FaceColor = [0.9 0.2 0.2];
% % % s.FaceLighting = 'gouraud';
% % % s.AmbientStrength = 0.3;
% % % s.DiffuseStrength = 0.6; 
% % % s.BackFaceLighting = 'lit';
% % % s.SpecularStrength = 1;
% % % s.SpecularColorReflectance = 1;
% % % s.SpecularExponent = 7;
% % % %% 清理背景
% % % axis off
% % % f.Color = 'none';
% % % 
% % % 
% % 
% % % print -dpdf test1.pdf