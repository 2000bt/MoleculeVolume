function [vX3, vY3, vZ3, Atom_info] = Func_Rotate(X0, Y0, Z0, vX, vY, vZ,iCloudLength, Atom_info , a, b, c )


vX1 = zeros(iCloudLength, 1);
vY1 = zeros(iCloudLength, 1);
vZ1 = zeros(iCloudLength, 1);

vX2 = zeros(iCloudLength, 1);
vY2 = zeros(iCloudLength, 1);
vZ2 = zeros(iCloudLength, 1);

vX3 = zeros(iCloudLength, 1);
vY3 = zeros(iCloudLength, 1);
vZ3 = zeros(iCloudLength, 1);
% figure;
% hold on;
% Surface1.faces = vFace;
% Surface1.vertices = [vX,vY,vZ];
% S=Surface1;
% hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
% % % hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.8);
% % % % S=Surface1; hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'none' );
% % % set(hh, 'EdgeColor', [0.74,0.12,0.12]); %red0.8745,0.4784,0.3686
% % %     set(hh,'EdgeColor',[0.9647,0.4353,0.4118]);
% % % %     set(hh,'EdgeColor',[0.8745,0.4784,0.3686]);
% set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
% scatter3(X0,Y0,Z0,'.','k',35);


%绉诲姩鍒板師鐐?
for i = 1 : iCloudLength
   vX1(i) = vX(i) - X0; 
   vY1(i) = vY(i) - Y0; 
   vZ1(i) = vZ(i) - Z0; 
end
% Surface1.faces = vFace;
% Surface1.vertices = [vX1,vY1,vZ1];
% S=Surface1;
% hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
% % % % hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.8);
% % % % % S=Surface1; hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', 'none' );
% % % % set(hh, 'EdgeColor', [0.74,0.12,0.12]); %red0.8745,0.4784,0.3686
%  set(hh,'EdgeColor','r');
% % % %     set(hh,'EdgeColor',[0.8745,0.4784,0.3686]);


Atom_info(:, 2) = Atom_info(:, 2) - X0;
Atom_info(:, 3) = Atom_info(:, 3) - Y0;
Atom_info(:, 4) = Atom_info(:, 4) - Z0;

for i = 1 : iCloudLength
    vX2(i) = cosd(b)*cosd(c)*vX1(i) + (sind(a)*sind(b)*cosd(c)-sind(c)*cosd(a))*vY1(i) + (sind(b)*cosd(a)*cosd(c)+sind(a)*sind(c))*vZ1(i);
    vY2(i) = cosd(b)*sind(c)*vX1(i) + (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c))*vY1(i) + (-sind(a)*cosd(c)+sind(c)*sind(b)*cosd(a))*vZ1(i);
    vZ2(i) = -sind(b)*vX1(i) + sind(a)*cosd(b)*vY1(i) + cosd(a)*cosd(b)*vZ1(i);
end
%鎭㈠鍒扮偣
for i = 1 : iCloudLength
   vX3(i) = vX2(i) + X0; 
   vY3(i) = vY2(i) + Y0; 
   vZ3(i) = vZ2(i) + Z0; 
end

vX1 = Atom_info(:, 2)';
vY1 = Atom_info(:, 3)';
vZ1 = Atom_info(:, 4)';
iLen = length(vX1);
%% 此处有误，vXYZ每次计算都会被修改以至于把结果整错了，应当额外设置变量名称
for i = 1 : iLen
    vX1(i) = cosd(b)*cosd(c)*vX1(i) + (sind(a)*sind(b)*cosd(c)-sind(c)*cosd(a))*vY1(i) + (sind(b)*cosd(a)*cosd(c)+sind(a)*sind(c))*vZ1(i);
    vY1(i) = cosd(b)*sind(c)*vX1(i) + (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c))*vY1(i) + (-sind(a)*cosd(c)+sind(c)*sind(b)*cosd(a))*vZ1(i);
    vZ1(i) = -sind(b)*vX1(i) + sind(a)*cosd(b)*vY1(i) + cosd(a)*cosd(b)*vZ1(i);    
end

Atom_info(:, 2) = vX1' + X0;
Atom_info(:, 3) = vY1' + Y0;
Atom_info(:, 4) = vZ1' + Z0;


