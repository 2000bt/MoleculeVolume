% a=[-6,0;-2,5;0,-1;4,4;6,1];
% b=[-6,0;-1,-4;5,-2;6,1];
% dS=0;
% dS1=0;
% figure;
% hold on;
% for i=1:length(a)-1
%    scatter(a(i,1),a(i,2),'r');
%    dS=dS+0.5*(a(i,1)*a(i+1,2)-a(i,2)*a(i+1,1));
% end
% dS=dS+0.5*(a(5,1)*a(1,2)-a(5,2)*a(1,1));
% for j=1:length(b)-1
% %     scatter(b(j,1),b(j,2),'b');
%     dS1=dS1+0.5*(b(j,1)*b(j+1,2)-b(j,2)*b(j+1,1));
% end
% dS1=dS1+0.5*(b(4,1)*b(1,2)-b(4,2)*b(1,1));
% hold off;
% 
% 
% % %     while ~isempty(segment1)
% % %         % 在每次迭代中更新 segment1
% % %         len_s=length(segment1);
% % %         if len_s==1
% % %             dS=dS+abs(0.5*(point_x*start_y-start_x*point_y));
% % %             plot([point_x,start_x],[point_y,start_y],'r');
% % %         end
% % %         for i=1:length(segment1)
% % %             if (([segment1(i).start_x] == point_x) && ([segment1(i).start_y] == point_y))
% % %                 dS=dS+0.5*(point_x*segment1(i).end_y-segment1(i).end_x*point_y);
% % %                 plot([point_x,segment1(i).end_x],[point_y,segment1(i).end_y],'r');
% % %                 point_x = segment1(i).end_x;
% % %                 point_y = segment1(i).end_y;
% % %                 segment1(i)=[];
% % % %                 idx_other(i) = [];
% % %                 break;
% % %             end
% % %             if (([segment1(i).end_x] == point_x) && ([segment1(i).end_y] == point_y))
% % %                 dS=dS+0.5*(point_x*segment1(i).start_y-segment1(i).start_x*point_y);
% % %                 plot([point_x,segment1(i).start_x],[point_y,segment1(i).start_y],'r');
% % %                 point_x = segment1(i).start_x;
% % %                 point_y = segment1(i).start_y;
% % %                 segment1(i)=[];
% % % %                 idx_other(i) = [];
% % %                 break;
% % %             end
% % %             
% % %         end
% % %  
% % %         % 移除已经使用的线段
% % %        
% % %     end
% % end
% 
% 
%  %线段重叠,已经排过序
% %                 if(Line_1x(1)==Line_1x(2))
% %                     [S_1,I1]=sort(Line_1y);
% %                     [S_2,I2]=sort(Line_2y);
% %                     S_3=Line_1x(I1);
% %                     S_4=Line_2x(I2);
% %                     turn=1;
% %                 else
% %                     [S_1,I1]=sort(Line_1x);
% %                     [S_2,I2]=sort(Line_2x);
% %                     S_3=Line_1y(I1);
% %                     S_4=Line_2y(I2);
% %                 end
% %                 P(1,1)=S_1(1);
% %                 P(1,2)=S_3(1);
% %                 P(2,1)=S_1(2);
% %                 P(2,2)=S_3(2);
%                 if(S_1(1)<S_2(1))
%                     P(1,1)=S_2(1);
%                     P(1,2)=S_4(1);
%                 end
%                 if(S_1(2)>S_2(2))
%                     P(2,1)=S_2(2);
%                     P(2,2)=S_4(2);
%                 end
%                 if(P(1,1)==P(2,1))
%                     P(2,:)=[];
%                 end
% %                 if(turn==1)
% %                    temp=P(:,1);
% %                    P(:,1)=P(:,2);
% %                    P(:,2)=temp;
% %                 end
% 
% 
% elseif((Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)==0)
%          if(Cross_P1==0)&&(Cross_P2==0)
%              sortline={};
%              result1=sort(line_1x(1),line_1y(1),line_2x(1),line_2y(1));
%              result2=sort(line_1x(2),line_1y(2),line_2x(2),line_2y(2));
%              switch result1
%                  case 0
%                      sortline{end+1}=0;
%                  case 1
%                      sortline{end+1}=[line_1x(1),line_1y(1)];
%                      sortline{end+1}=[line_2x(1),line_2y(1)];
%                  case 2
%                      sortline{end+1}=[line_2x(1),line_2y(1)];
%                      sortline{end+1}=[line_1x(1),line_1y(1)];
%                  
%              end
%              switch result2
%                  case 0  
%                      sortline{end+1}=0;
%                  case 1
%                      sortline{end+1}=[line_1x(2),line_1y(2)];
%                      sortline{end+1}=[line_2x(2),line_2y(2)];
%                  case 2
%                      sortline{end+1}=[line_2x(2),line_2y(2)];
%                      sortline{end+1}=[line_1x(2),line_1y(2)]; 
%              end
%              
%              if size(sortline,1)==2 %重合
%                  Flag=4;
%                  P(1,1)=Line_1x(1);
%                  P(1,2)=Line_1y(1);
%                  P(2,1)=Line_1x(2);
%                  P(2,2)=Line_1y(2); 
%              elseif size(sortline,1)==3 %共一个端点
%                
%                  
%              elseif isequal(sortline{2}(:),sortline{3}(:))
%                  %交于线段一个端点 
%                  return;
%              end
% %              if Line_1x(1)== Line_2x(1)&& Line_1y(1)== Line_2y(1) %AC相同
% %                  
% %              elseif Line_1x(1)<Line_2x(1) 
% %              else
% %              end
%              if Line_1x(1)== Line_2x(1)  %AC相同
%                  
%              elseif Line_1x(1)<Line_2x(1)
%              else
%              end
%                 P(1,1)=Line_1x(1);
%                 P(1,2)=Line_1y(1);
%                 P(2,1)=Line_1x(2);
%                 P(2,2)=Line_1y(2);
%                 if  Line_1x(1)< Line_2x(1) &&  Line_1x(2)> Line_2x(2)
%                      P(1,1)=Line_2x(1);
%                      P(1,2)=Line_2y(1);
%                      P(2,1)=Line_2x(2);
%                      P(2,2)=Line_2y(2);
%                      Flag=7;    
%                 elseif  Line_1x(2)> Line_2x(2)
%                      P(2,1)=Line_2x(2);
%                      P(2,2)=Line_2y(2);
%                      Flag=8;
%                 elseif Line_1x(1)< Line_2x(1)
%                      P(1,1)=Line_2x(1);
%                      P(1,2)=Line_2y(1);
%                      Flag=9;
%                 else
%                      Flag=6;
%                 end
%                 if(P(1,1)==P(2,1)&& P(1,2)==P(2,2) )
%                     Flag=0;
%                     P(:)=[];
%                 end
%          else
%              %交于端点忽略不计
%              return;
%          end
%     else
%         return;
%     end
% end
% 
%     function result=sort(line_1x,line_1y,line_2x,line_2y)
%         if line_1x>line_2x
%             result = 1;
%         elseif line_2x>line_1x
%             result= 2;
%         elseif ~isequal([line_1x,line_1y],[line_2x,line_2y])
%            if line_1y>line_2y
%               result = 1;
%            else
%               result = 2;
%            end
%         else
%             result= 0
%         end
%             
%     end
% 
%         
% end
%     
% 

%  if events(k,1)==events(vIdx,1)
%                 slope1=Inf;
%             else
%                 slope1=(events(vIdx,2)-events(k,2))/(events(vIdx,1)-events(k,1));
%             end
%             if events(k+1,1)==events(vIdx1,1)
%                 slope2=Inf;
%             else
%                 slope2=(events(vIdx1,2)-events(k+1,2))/(events(vIdx1,1)-events(k+1,1));
%             end
            %通过斜率判断比较保险
%            if (~isinf(slope1))&&(~isinf(slope2)) 
%                 if slope2<slope1
%                     events([k,k+1],:)=events([k+1,k],:);
%                 end 
%            else isinf(slope1) && isinf(slope2)
%                 if(events(vIdx,2)>events(vIdx1,2))
%                     events([k,k+1],:)=events([k+1,k],:);
%                 end 
%             end
            %如果直接比较终点位置可能出问题，因为长度会影响
%             if(events(vIdx,2)>events(vIdx1,2))
%                 events([k,k+1],:)=events([k+1,k],:);
%             end 
% 
% 
slope=slope_com(2,2,2,1);
slope1=slope_com(2,1,2,1);
slope1>slope
function slope = slope_com(x1,x2,y1,y2)
            if x1==x2
                slope=Inf;
            else
                slope=(y2-y1)/(x2-x1);
            end
    end
