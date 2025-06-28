function[Overlap_para,match]=Func_para(vX,vY,vZ,vX1,vY1,vZ1)
% A_para(1) = max(vX);
% A_para(2)=  max(vY);
% A_para(3) = max(vZ);
% A_para(4)=  min(vX);
% A_para(5) = min(vY);
% A_para(6) = min(vZ);
% 
% B_para(1) = max(vX1);
% B_para(2)=  max(vY1);
% B_para(3) = max(vZ1);
% B_para(4)=  min(vX1);
% B_para(5) = min(vY1);
% B_para(6) = min(vZ1);

Overlap_para(1)=min(max(vX),max(vX1));%´ó
if Overlap_para(1)==max(vX)
    match(1)=1;
else
    match(1)=2;
end
Overlap_para(2)=max(min(vX),min(vX1));
if Overlap_para(2)==min(vX)
    match(2)=1;
else
    match(2)=2;
end
Overlap_para(3)=min(max(vY),max(vY1));
if Overlap_para(3)==max(vY)
    match(3)=1;
else
    match(3)=2;
end
Overlap_para(4)=max(min(vY),min(vY1));
if Overlap_para(4)==min(vY)
    match(4)=1;
else
    match(4)=2;
end
Overlap_para(5)=min(max(vZ),max(vZ1));
Overlap_para(6)=max(min(vZ),min(vZ1));

