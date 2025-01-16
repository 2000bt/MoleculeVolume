function [code0]=Func_Getcode(point_1,vertex)
    code0=0;
    if point_1(1)<=vertex(1,1)
            code0=code0+1;
    elseif point_1(1)>=vertex(3,1)
            code0=code0+2;
    end
    
    if point_1(2)<=vertex(1,2)
        code0=code0+4;
    elseif point_1(2)>=vertex(3,2)
        code0=code0+8; 
    end
end