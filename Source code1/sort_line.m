 function result=sort_line(line_1x,line_1y,line_2x,line_2y)
        if line_1x>line_2x
            result = 1;
        elseif line_2x>line_1x
            result= 2;
        elseif ~isequal([line_1x,line_1y],[line_2x,line_2y])
           if line_1y>line_2y
              result = 1;
           else
              result = 2;
           end
        else
            result= 0;
        end
    end     