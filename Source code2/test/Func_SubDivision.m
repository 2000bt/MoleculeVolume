function [segments,events,count]=Func_SubDivision(segments,events,Flag,temp,temp1,intersection,count)
switch Flag
    case 1
        %正常相交
        %改变segment
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true)];
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        %改变events,两起两终
        old_e=find(events(:,3)==temp);
        old_e1=find(events(:,3)==temp1);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        events=Func_SortEvents(events);
    case 2
        %交于线段1A端点
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true)];
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        
        old_e1=find(events(:,3)==temp1);
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        
    case 3
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        
        old_e=find(events(:,3)==temp);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        %交于线段1B端点
    case 4
        
        %线段共端点
    case 5
        %线段重合
    case 6
        
    case 7
        
    case 8
        
    case 9
        
end