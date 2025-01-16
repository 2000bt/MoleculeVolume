function newpos = nextpos(pos,results,process)
        newpos=pos+1;
        while newpos<=length(results) && isequal(results(newpos,1:2),results(pos,1:2))
            if(process(newpos))
                newpos=newpos+1;
            end
            return
        end
        newpos=pos-1;
        while(process(newpos))
            newpos=newpos-1;
        end
    end