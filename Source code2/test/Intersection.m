classdef Intersection
    properties
        x
        y
        segment1_num
        segment2_num
    end
    
    methods
        function obj = Intersection(x, y, segment1_num, segment2_num)
            obj.x = x;
            obj.y = y;
            obj.segment1_num = segment1_num;
            obj.segment2_num = segment2_num;
        end
    end
end