function[Flag]=Func_already(intersection,intersections)
eps=0.00001;
for i=1:length(intersections)
    if(abs(intersection(1)-intersections(i,1))<eps && abs(intersection(2)-intersections(i,2))<eps)
        Flag=1;
    end
end
