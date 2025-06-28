function [vX3, vY3, vZ3, Atom_info] = Func_Rotate_Fina(X0, Y0, Z0, vX, vY, vZ,iCloudLength, Atom_info , a, b, c )
vX1 = zeros(iCloudLength, 1);
vY1 = zeros(iCloudLength, 1);
vZ1 = zeros(iCloudLength, 1);

vX2 = zeros(iCloudLength, 1);
vY2 = zeros(iCloudLength, 1);
vZ2 = zeros(iCloudLength, 1);

vX3 = zeros(iCloudLength, 1);
vY3 = zeros(iCloudLength, 1);
vZ3 = zeros(iCloudLength, 1);


%移动到原�?
for i = 1 : iCloudLength
   vX1(i) = vX(i) - X0; 
   vY1(i) = vY(i) - Y0; 
   vZ1(i) = vZ(i) - Z0; 
end
for i = 1 : iCloudLength
    vX2(i) = cosd(b)*cosd(c)*vX1(i) + (sind(a)*sind(b)*cosd(c)-sind(c)*cosd(a))*vY1(i) + (sind(b)*cosd(a)*cosd(c)+sind(a)*sind(c))*vZ1(i);
    vY2(i) = cosd(b)*sind(c)*vX1(i) + (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c))*vY1(i) + (-sind(a)*cosd(c)+sind(c)*sind(b)*cosd(a))*vZ1(i);
    vZ2(i) = -sind(b)*vX1(i) + sind(a)*cosd(b)*vY1(i) + cosd(a)*cosd(b)*vZ1(i);
end
for i = 1 : iCloudLength
   vX3(i) = vX2(i) + X0; 
   vY3(i) = vY2(i) + Y0; 
   vZ3(i) = vZ2(i) + Z0; 
end

Atom_info1(:, 2) = Atom_info(:, 2) - X0;
Atom_info1(:, 3) = Atom_info(:, 3) - Y0;
Atom_info1(:, 4) = Atom_info(:, 4) - Z0;

vX1 = Atom_info1(:, 2);
vY1 = Atom_info1(:, 3);
vZ1 = Atom_info1(:, 4);
iLen = length(vX1);
for i = 1 : iLen
    Atom_info1(i, 2)= cosd(b)*cosd(c)*vX1(i) + (sind(a)*sind(b)*cosd(c)-sind(c)*cosd(a))*vY1(i) + (sind(b)*cosd(a)*cosd(c)+sind(a)*sind(c))*vZ1(i);
    Atom_info1(i, 3) = cosd(b)*sind(c)*vX1(i) + (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c))*vY1(i) + (-sind(a)*cosd(c)+sind(c)*sind(b)*cosd(a))*vZ1(i);
    Atom_info1(i, 4)= -sind(b)*vX1(i) + sind(a)*cosd(b)*vY1(i) + cosd(a)*cosd(b)*vZ1(i);    
end

Atom_info(:, 2) = Atom_info1(:, 2) + X0;
Atom_info(:, 3) = Atom_info1(:, 3) + Y0;
Atom_info(:, 4) = Atom_info1(:, 4) + Z0;


