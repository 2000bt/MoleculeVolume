function [vdx]=Func_Sphere(vX, vY, vZ, vFace,AtomNum,Atom_info,vX1, vY1, vZ1,vFace1,AtomNum1,Atom_info1)
iCloudLength=size(vX,1);
vWhich = zeros(iCloudLength, 1);
%找最远的点，得到半径？
for i = 1 : iCloudLength
    vTemp = zeros(AtomNum, 1);
    dTemp = 0;
    iTemp = 1;
    for j = 1 : AtomNum
        %算该点距离原子的距离
        vTemp(j) = (vX(i) - Atom_info(j, 2))^2 + (vY(i) - Atom_info(j, 3))^2 + (vZ(i) - Atom_info(j, 4))^2;
        if( 1 == j )
            dTemp = vTemp(1);
            continue;
        else
            if( dTemp > vTemp(j))
                dTemp = vTemp(j);
                iTemp = j;
            end
        end
    end
    vWhich(i) = iTemp;%匹配原子
end


for i = 1 : AtomNum
    flag = 0;
    for j = 1 : AtomNum1
        %球心之间的距离
        if(((Atom_info(i, 2) - Atom_info1(j, 2))^2 + (Atom_info(i, 3) - Atom_info1(j, 3))^2+(Atom_info(i,4)-Atom_info1(j,4))^2) < (1.1 * 2.2110 * Atom_info(i,5) + 1.1 * 2.2110 * Atom_info1(j,5))^2) %鑻ヤ袱鐞冧腑蹇冪殑璺濈灏忎簬鍗婂緞鍜岋紙杩欓噷鍖呭洿鐞冨崐寰勪负3鍊嶅師瀛愬崐寰勶級
            flag = 1;
        end          
    end
    if ( 0 == flag ) 
        vIdx = find(i == vWhich);
        vWhich(vIdx) = 0;
    end
end
vdx=find(vWhich>0);

end