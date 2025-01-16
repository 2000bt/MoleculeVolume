%%¹«×ª-Ðý×ª¾ØÕó
 function [vX, vY, vZ, Atom_info] = Func_Rotate_matrix(X0, Y0, Z0, vX, vY, vZ, Atom_info , a, b, c)
    vX=vX-X0;
    vY=vY-Y0;
    vZ=vZ-Z0;

    Atom_info(:, 2) = Atom_info(:, 2) - X0;
    Atom_info(:, 3) = Atom_info(:, 3) - Y0;
    Atom_info(:, 4) = Atom_info(:, 4) - Z0;
    %%¾²Ì¬Å·À­½Ç
    rotate1=[cosd(b)*cosd(c), (sind(a)*sind(b)*cosd(c)-sind(c)*cosd(a)), (sind(b)*cosd(a)*cosd(c)+sind(a)*sind(c))];
    rotate2=[cosd(b)*sind(c), (cosd(a)*cosd(c) + sind(a)*sind(b)*sind(c)),  (-sind(a)*cosd(c)+sind(c)*sind(b)*cosd(a))];
    rotate3=[-sind(b), sind(a)*cosd(b), cosd(a)*cosd(b)];

    matrix=[vX';vY';vZ'];
    vX=rotate1*matrix;
    vY=rotate2*matrix;
    vZ=rotate3*matrix;

    vX=vX+X0;
    vY=vY+Y0;
    vZ=vZ+Z0;

    matrix1=[Atom_info(:, 2)';Atom_info(:, 3)';Atom_info(:, 4)'];

    vX1=rotate1*matrix1;
    vY1=rotate2*matrix1;
    vZ1=rotate3*matrix1;
    Atom_info(:, 2) = vX1' + X0;
    Atom_info(:, 3) = vY1' + Y0;
    Atom_info(:, 4) = vZ1' + Z0;
end



