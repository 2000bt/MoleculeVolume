function [ vIdx ] = Func_CollisionV3( vX, vY, vZ, iCloudLength, iFaceLength, vFace,Atom_info,AtomNum,vX1, vY1, vZ1, iCloudLength1, iFaceLength1, vFace1,Atom_info1,AtomNum1, dSlice1 )
%%  ���㷨���������ڽ��� 

iCount = 0;
iCount1 = 0;
iCount2 = 0;
mNormal = zeros(iFaceLength1, 4);
%�ҵ��ڶ������Ӹ�������Ƭ���������X/Y/Z���꣬�ټ���������Ƭƽ�淽�̵õ������ĸ������ľ���
for i = 1 : iFaceLength1
   dX1 = vX1(vFace1(i, 1));
   dX2 = vX1(vFace1(i, 2));
   dX3 = vX1(vFace1(i, 3));
   
   dY1 = vY1(vFace1(i, 1));
   dY2 = vY1(vFace1(i, 2));
   dY3 = vY1(vFace1(i, 3));
   
   dZ1 = vZ1(vFace1(i, 1));
   dZ2 = vZ1(vFace1(i, 2));
   dZ3 = vZ1(vFace1(i, 3));
   
   mNormal(i, 1) = (dY2 - dY1) * (dZ3 - dZ1) - (dZ2 - dZ1) * (dY3 - dY1);
   mNormal(i, 2) = (dZ2 - dZ1) * (dX3 - dX1) - (dX2 - dX1) * (dZ3 - dZ1);
   mNormal(i, 3) = (dX2 - dX1) * (dY3 - dY1) - (dY2 - dY1) * (dX3 - dX1);
   mNormal(i, 4) = 0 - (mNormal(i, 1) * dX1 + mNormal(i, 2) * dY1 + mNormal(i, 3) * dZ1);
end
save mNormal mNormal;
%�⼸��������AABB�е�ֵ
vNear = zeros(iCloudLength, 1);
dMaxX = max(vX1);
dMaxY = max(vY1);
dMaxZ = max(vZ1);
dMinX = min(vX1);
dMinY = min(vY1);
dMinZ = min(vZ1);


%%  sphere��Χ��------------------------------------
%�˴�
vWhich = zeros(iCloudLength, 1);
%�Է���һ��ÿ�����ƥ��ԭ�ӣ���������
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
    vWhich(i) = iTemp;%ƥ��ԭ��,�������
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


%--------------------------------------------------------------------------
% tic
%�˴������˱�AABBɸ���ĵ�����ֻҪ����1�����������ڰ�Χ�����ɸ��

for i = 1 : iCloudLength
    if(vX(i) > dMaxX | vX(i) < dMinX | vY(i) > dMaxY | vY(i) < dMinY | vZ(i) > dMaxZ | vZ(i) < dMinZ)
        iCount = iCount + 1;
        continue;
    end

%sphere��Χ��ɸ���ĵ���-----------------------------------
    if (vWhich(i) == 0)
        iCount1 = iCount1 + 1;
        continue;
    end
%---------------------------------------------
    for j = 1 : iFaceLength1
        dX1 = vX(i) - vX1(vFace1(j, 1));
        dY1 = vY(i) - vY1(vFace1(j, 1));
        dX2 = vX1(vFace1(j, 2)) - vX1(vFace1(j, 1));
        dY2 = vY1(vFace1(j, 2)) - vY1(vFace1(j, 1));
        dX3 = vX1(vFace1(j, 3)) - vX1(vFace1(j, 1));
        dY3 = vY1(vFace1(j, 3)) - vY1(vFace1(j, 1));       
        dU = (dX1 * dY3 - dX3 * dY1) / (dX2 * dY3 - dX3 * dY2);
        dV = (dX1 * dY2 - dX2 * dY1) / (dX3 * dY2 - dX2 * dY3);
%         dZ = vZ1(vFace1(j, 1)) + vZ1(vFace1(j, 2)) + vZ1(vFace1(j, 3));
        if(dU > 0 && dV > 0 && dU + dV <= 1 )  %ĳ���ڵڶ������Ƶ�ĳ������Ƭ�ڣ�����Ӧ��ֻ���ҵ���ײ���Ǹ�����Ϊ�˼�����������ҵ����懡�� (vX(i) < dXMax && vX(i) > dXMin) && 
            iCount2 = iCount2 + 1;            
            if(vNear(i) == 0)
                vNear(i) = -1;
            end
%             if(vX(i) * mNormal(j, 1) + vY(i) * mNormal(j, 2) + vZ(i) * mNormal(j, 3) + mNormal(j, 4) > 0)
%                 vNear(i) = 1 * vNear(i);
%             else
%                 vNear(i) = -1 * vNear(i);
%             end
            if(vZ(i) > vZ1(vFace1(j, 3)))
                vNear(i) = -1 * vNear(i);
            end
        end
    end        
end
vIdx = find(vNear > 0);
save vNear vNear;
save vWhich vWhich;
iCount
iCount1
iCount2
