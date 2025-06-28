function [vX3, vY3, vZ3] = Func_Rotate_zl(X0, Y0, Z0, vX, vY, vZ, a, b, c)
    % 平移点到原点
    vX1 = vX - X0;
    vY1 = vY - Y0;
    vZ1 = vZ - Z0;

    % 绕原点旋转
    vX2 = cosd(b)*cosd(c)*vX1 + (sind(a)*sind(b)*cosd(c) - sind(c)*cosd(a))*vY1 + (sind(b)*cosd(a)*cosd(c) + sind(a)*sind(c))*vZ1;
    vY2 = cosd(b)*sind(c)*vX1 + (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c))*vY1 + (-sind(a)*cosd(c) + sind(c)*sind(b)*cosd(a))*vZ1;
    vZ2 = -sind(b)*vX1 + sind(a)*cosd(b)*vY1 + cosd(a)*cosd(b)*vZ1;

    % 平移回原坐标系
    vX3 = vX2 + X0;
    vY3 = vY2 + Y0;
    vZ3 = vZ2 + Z0;
end