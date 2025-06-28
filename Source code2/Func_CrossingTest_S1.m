%%运用跨立实验判断线段是否相交
%%快速排斥实验
%改变——相交于端点pass,根据条件判断是否重合
function[segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count)
% Line_2x=[0;0];
% Line_2y=[0;2];
% Line_1x=[-3;3];
% Line_1y=[0;2];


Flag=0;

new=0;    
Line_2x=[segments(temp1).start_x,segments(temp1).end_x];
Line_2y=[segments(temp1).start_y,segments(temp1).end_y];
Line_1x=[segments(temp).start_x,segments(temp).end_x];
Line_1y=[segments(temp).start_y,segments(temp).end_y];
% P=[];
if((max(Line_2x)<min(Line_1x))||(max(Line_1x)<min(Line_2x))||(max(Line_2y)<min(Line_1y))||(max(Line_1y)<min(Line_2y)))
    return;
else
    %%第二阶段
    Cross_P1=Func_CrossProduct(Line_1x(1)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(1)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P2=Func_CrossProduct(Line_1x(2)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(2)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P3=Func_CrossProduct(Line_2x(1)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(1)-Line_1y(1),Line_1y(2)-Line_1y(1));
    Cross_P4=Func_CrossProduct(Line_2x(2)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(2)-Line_1y(1),Line_1y(2)-Line_1y(1));
    if((Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)<0)
        
        %算交点
%         Flag=1;
%        scatter(segments(temp1).start_x,segments(temp1).start_y);
%         scatter(segments(temp1).end_x,segments(temp1).end_y);
%          scatter(segments(temp).start_x,segments(temp).start_y);
%           scatter(segments(temp).end_x,segments(temp).end_y);
%           plot(Line_2x,Line_2y,'r');
%          plot(Line_1x,Line_1y,'k');
        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        k=are123/are124;
        intersection(1)=(Line_2x(1)+k*Line_2x(2))/(1+k);
        intersection(2)=(Line_2y(1)+k*Line_2y(2))/(1+k);
%         intersection(1)=round(intersection(1),4);
%         intersection(2)=round(intersection(2),4);
        
%         if intersection(1)>min(segments(temp).end_x,segments(temp1).end_x)
%             intersection(1)=min(segments(temp).end_x,segments(temp1).end_x);
%         elseif intersection(1)<max(segments(temp).start_x,segments(temp1).start_x)
%             intersection(1)=max(segments(temp).start_x,segments(temp1).start_x);
%         end
%         if intersection(2)>min(segments(temp).end_y,segments(temp1).end_y)
%             intersection(2)=min(segments(temp).end_y,segments(temp1).end_y);
%         elseif intersection(2)<max(segments(temp).start_y,segments(temp1).start_y)
%             intersection(2)=max(segments(temp).start_y,segments(temp1).start_y);
%         end
        
%         if intersection(1)== segments(temp).end_x && intersection(2)>segments(temp).end_y
%             segments=[segments;Segment(segments(temp).end_x,segments(temp).end_y,intersection(1),intersection(2),segments(temp).poly,false,true,-1)];
%             segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
%             segments(temp).end_x=intersection(1);
%             segments(temp).end_y=intersection(2);
%             segments(temp1).end_x=intersection(1);
%             segments(temp1).end_y=intersection(2);
%             %改变events,两起两终
%             old_e=find(events(:,3)==temp);
%             old_e1=find(events(:,3)==temp1);
%             events(old_e,3)=count;
%             events(old_e,4)=-1;
%             events=[events;intersection(1),intersection(2),temp,-2];
%             events=[events;intersection(1),intersection(2),temp1,-2];
%             events=[events;intersection(1),intersection(2),count,-2];
%             count=count+1;
%             events(old_e1,3)=count;
%             events=[events;intersection(1),intersection(2),count,-1];
%             count=count+1;
%             events=Func_SortEvents(events);
%             return;
%         elseif intersection(1)== segments(temp1).end_x && intersection(2)>segments(temp1).end_y
%             segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
%             segments=[segments;Segment(segments(temp1).end_x,segments(temp1).end_y,intersection(1),intersection(2),segments(temp1).poly,false,true,-1)];
%             segments(temp).end_x=intersection(1);
%             segments(temp).end_y=intersection(2);
%             segments(temp1).end_x=intersection(1);
%             segments(temp1).end_y=intersection(2);
%             %改变events,两起两终
%             old_e=find(events(:,3)==temp);
%             old_e1=find(events(:,3)==temp1);
%             events(old_e,3)=count;
%             
%             events=[events;intersection(1),intersection(2),temp,-2];
%             events=[events;intersection(1),intersection(2),temp1,-2];
%             events=[events;intersection(1),intersection(2),count,-1];
%             count=count+1;
%             events(old_e1,3)=count;
%             events(old_e1,4)=-1;
%             events=[events;intersection(1),intersection(2),count,-2];
%             count=count+1;
%             events=Func_SortEvents(events);
%             return;
%         end
        
%         if intersection(1)== segments(temp).end_x && intersection(2)== segments(temp).end_y
%             return;
%         elseif intersection(1)== segments(temp1).end_x && intersection(2)== segments(temp1).end_y
%             return;
%         elseif intersection(1)== segments(temp).start_x && intersection(2)== segments(temp).start_y
%             return;
%         elseif intersection(1)== segments(temp1).start_x && intersection(2)== segments(temp1).start_y
%             return;
%         end
        
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
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
%         new=1;
        events=Func_SortEvents(events,2);
%         scatter(intersection(1),intersection(2));
       
%         old_e=find(events(:,3)==temp);
%         old_e1=find(events(:,3)==temp1);
%         events(old_e,3)=count;
%        
%         events=[events;intersection(1),intersection(2),temp,-2];
%         events=[events;intersection(1),intersection(2),temp1,-2];
%        
        
        
%         if intersection(1)<segments(temp).end_x
%             segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
%             events=[events;intersection(1),intersection(2),count,-1];
%         else
%             segments=[segments;Segment(segments(temp).end_x,segments(temp).end_y,intersection(1),intersection(2),segments(temp).poly,false,true,-1)];
%             events(old_e,4)=-1;
%             events=[events;intersection(1),intersection(2),count,-2];
%         end
%         count=count+1;
%         events(old_e1,3)=count;
% 
%         if intersection(1)<segments(temp1).end_x
%             segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
%             events=[events;intersection(1),intersection(2),count,-1];
%         else
%             segments=[segments;Segment(segments(temp1).end_x,segments(temp1).end_y,intersection(1),intersection(2),segments(temp1).poly,false,true,-1)];
%             events(old_e1,4)=-1;
%             events=[events;intersection(1),intersection(2),count,-2];
%         end 
%         segments(temp).end_x=intersection(1);
%         segments(temp).end_y=intersection(2);
%         segments(temp1).end_x=intersection(1);
%         segments(temp1).end_y=intersection(2);
%         %改变events,两起两终
%          count=count+1;
%          events=Func_SortEvents(events);
%         if segments(temp1).poly == segments(temp).poly
%             Flag=2;   
%             return;
%         end
        return;
    elseif (Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)<0
        
        %交于第一条线段端点 
        are134=Func_abs_area(Line_1x(1),Line_1y(1),Line_2x(1),Line_2y(1),Line_2x(2),Line_2y(2));
%         are234=Func_abs_area(Line_1x(2),Line_1y(2),Line_2x(1),Line_2y(1),Line_2x(2),Line_2y(2));
%         Flag=2;
       %A
        if are134 == 0
            intersection=[Line_1x(1),Line_1y(1)];
        %B
        else
             intersection=[Line_1x(2),Line_1y(2)];
        end
         %交于线段1A端点
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true,-1)];
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        
        old_e1=find(events(:,3)==temp1);
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
%         new=1;
        events=Func_SortEvents(events,1); 
        count=count+1;
        return;
    elseif (Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)==0
%          if segments(temp1).poly == segments(temp).poly
%             Flag=2;
%                    
%             return;
%         end
    %交于一条线段上
        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
%         are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        %C
%         Flag=3;
        if are123 == 0
             intersection=[Line_2x(1),Line_2y(1)];
        %D
        else
             intersection=[Line_2x(2),Line_2y(2)];
        end     
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true,-1)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        
        old_e=find(events(:,3)==temp);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),count,-1];
%         new=1;
        events=Func_SortEvents(events,1); 
        count=count+1;
        return;
    elseif((Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)==0)
         if(Cross_P1==0)&&(Cross_P2==0)
             sortline={};
             
             result1=sort_line(segments(temp).start_x,segments(temp).start_y,segments(temp1).start_x,segments(temp1).start_y);
             result2=sort_line(segments(temp).end_x,segments(temp).end_y,segments(temp1).end_x,segments(temp1).end_y);
            
             switch result1
                 case 0
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1;
             end
             switch result2
                 case 0  
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1; 
             end
             
             if size(sortline,2)==2 %重合

                 Flag=1;
                 return;
             elseif size(sortline,2)==3 %共一个端点
%                  
                 if sortline{1}==0
                     %共AC

                     segments=[segments;Segment(segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true,-1)];
                     segments(sortline{3}).end_x=segments(sortline{2}).end_x;
                     segments(sortline{3}).end_y=segments(sortline{2}).end_y;
                     
                     %改变events
                    old_e=find(events(:,3)==sortline{3});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,sortline{3},-2];   
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,count,-1]; 
                    count=count+1;
                    events=Func_SortEvents(events,new); 
                    Flag=1;
                    return;
                 else
                     %共BD,从左向右细分
                     
                     segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{1}).poly,false,true,-1)];
                     segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                     segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                     
                     %改变events
                    old_e=find(events(:,3)==sortline{1});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,sortline{1},-2];   
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,count,-1];

                    count=count+1;
                    events=Func_SortEvents(events,new);
                     
                    
                    return;
                 end
                 
                 
             elseif  segments(sortline{2}).start_x ==segments(sortline{3}).end_x && segments(sortline{2}).start_y==segments(sortline{3}).end_y
%                     if segments(temp1).poly == segments(temp).poly
%                         Flag=2;
%                         return;
%                     end
                 %交于线段一个端点 
                 return;
             else 
                 %部分重合
                 
                 if sortline{1}==sortline{3}
%                      if(segments(temp).inOut==segments(temp1).inOut)
%                          segments(sortline{2}).non_con=1;
%                      else
%                         segments(sortline{2}).non_con=0;
%                      end
                     old_e=find(events(:,3)==sortline{1});
                     old_e1=find(events(:,3)==sortline{2});
                     events(old_e,3)=sortline{2};
                     events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                     events(old_e1,3)=count;
                     events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
                     count=count+1;
                     events=Func_SortEvents(events,new);
%                       segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true,false)];
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true,-1)];
                      segments(sortline{2}).end_x=segments(sortline{3}).end_x;
                      segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                  
                  
                        
                        return;
                 else
                     %包含
%                        segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true)];
%                       if(segments(temp).inOut==segments(temp1).inOut)
%                          segments(sortline{2}).non_con=1;
%                       else
%                          segments(sortline{2}).non_con=0;
%                       end
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true,-1)];
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
%                       segments(sortline{2}).end_x=segments(sortline{3}).end_x;
%                       segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                     %有重合
                        old_e=find(events(:,3)==sortline{4});
%                         old_e1=find(events(:,3)==sortline{2});
                        events(old_e,3)=count;
                        events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                        events=[events; segments(sortline{3}).end_x, segments(sortline{3}).end_y,count,-1];
                        count=count+1;
%                         events(old_e1,3)=count;
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,sortline{2},-2];
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
%                         count=count+1;
                        events=Func_SortEvents(events,new);
                        return;
                 end

             end
%            
         else
%              if segments(temp1).poly == segments(temp).poly
%                 Flag=2;
%                 return;
%              end
             %交于端点忽略不计
             return;
         end
    else
        return;
    end
end

   
end
    



