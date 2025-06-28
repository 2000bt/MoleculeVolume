function [vdx]=Func_Sphere(vX, vY, vZ, vFace,AtomNum,Atom_info,vX1, vY1, vZ1,vFace1,AtomNum1,Atom_info1)
iCloudLength=size(vX,1);
vWhich = zeros(iCloudLength, 1);
%����Զ�ĵ㣬�õ��뾶��
for i = 1 : iCloudLength
    vTemp = zeros(AtomNum, 1);
    dTemp = 0;
    iTemp = 1;
    for j = 1 : AtomNum
        %��õ����ԭ�ӵľ���
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
    vWhich(i) = iTemp;%ƥ��ԭ��
end


for i = 1 : AtomNum
    flag = 0;
    for j = 1 : AtomNum1
        %����֮��ľ���
        if(((Atom_info(i, 2) - Atom_info1(j, 2))^2 + (Atom_info(i, 3) - Atom_info1(j, 3))^2+(Atom_info(i,4)-Atom_info1(j,4))^2) < (1.1 * 2.2110 * Atom_info(i,5) + 1.1 * 2.2110 * Atom_info1(j,5))^2) %若两球中心的距离小于半径和（这里包围球半径为3倍原子半径）
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