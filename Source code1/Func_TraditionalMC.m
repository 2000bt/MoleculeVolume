function [  X, Y, Z ] = Func_TraditionalMC( CubePoints, step_num1, step_num2, step_num3, LUT )
    iCloudLength = 0;
    iFaceLength = 0;
    Cub_num = step_num2 * step_num3;
    a = step_num1 * step_num2 * step_num3;
    for i = 1 : step_num1 
        if (i == step_num1)
            continue;
        end
        for j = 1 : step_num2
            if(j == step_num2)
                continue;
            end
            for k = 1 : step_num3
                if( k == step_num3)
                    continue;
                end
                num_3 = k + step_num3 * (j - 1) + step_num2 * step_num3 * (i -1);
                num_2 = num_3 + step_num3;
                num_7 = num_3 + Cub_num;
                num_6 = num_3 + Cub_num + step_num3;
                num_0 = num_3 + 1;
                num_1 = num_3 + step_num3 + 1;
                num_4 = num_3 + Cub_num + 1;
                num_5 = num_3 + Cub_num + step_num3 + 1;
                count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
                if (count ~= 8 && count ~= 0)
                    index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
                    ePoints = LUT(index + 1, :);
                    count1 = 1;
                    while(ePoints(1, count1) ~= -1)
                        count1 = count1 + 1;
                    end
                    Triangle_num = (count1 - 1) / 3;
                    iFaceLength = iFaceLength + Triangle_num;
                    iCloudLength = iCloudLength + (count1 - 1);
                end
            end
        end
    end
    X = zeros(iCloudLength, 1);
    Y = zeros(iCloudLength, 1);
    Z = zeros(iCloudLength, 1);
    vFace = zeros(iFaceLength, 3);
    iCloudCount = 0; 
    for i = 1 : step_num1 
        if (i == step_num1)
            continue;
        end
        for j = 1 : step_num2
            if(j == step_num2)
                continue;
            end
            for k = 1 : step_num3
                if( k == step_num3)
                    continue;
                end
                num_3 = k + step_num3 * (j - 1) + step_num2 * step_num3 * (i -1);
                num_2 = num_3 + step_num3;
                num_7 = num_3 + Cub_num;
                num_6 = num_3 + Cub_num + step_num3;
                num_0 = num_3 + 1;
                num_1 = num_3 + step_num3 + 1;
                num_4 = num_3 + Cub_num + 1;
                num_5 = num_3 + Cub_num + step_num3 + 1;
                count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
                if (count ~= 8 && count ~= 0)
                    index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
                    ePoints = LUT(index + 1, :);
                    count1 = 1;
                    while(ePoints(1, count1) ~= -1)
                        count1 = count1 + 1;
                    end
                    for m = 1 : count1 - 1
                        iCloudCount = iCloudCount + 1;
                        switch ePoints(1, m)
                            case 0
                                X(iCloudCount) = CubePoints(num_0,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_0,2) + CubePoints(num_1,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_1,:), 2 );
                                Z(iCloudCount) = CubePoints(num_0,3) ;
                            case 1
                                X(iCloudCount) = CubePoints(num_1,1) ;
                                Y(iCloudCount) = CubePoints(num_1,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_1,3) + CubePoints(num_2,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_2,:), 3 );
                            case 2
                                X(iCloudCount) = CubePoints(num_2,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_2,2) + CubePoints(num_3,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_3,:), 2 );
                                Z(iCloudCount) = CubePoints(num_2,3) ;
                            case 3
                                X(iCloudCount) = CubePoints(num_3,1) ;
                                Y(iCloudCount) = CubePoints(num_3,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_3,3) + CubePoints(num_0,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_0,:), 3 );
                            case 4
                                X(iCloudCount) = CubePoints(num_4,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_4,2) + CubePoints(num_5,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_4,:), CubePoints(num_5,:), 2 );
                                Z(iCloudCount) = CubePoints(num_4,3) ;
                            case 5
                                X(iCloudCount) = CubePoints(num_5,1) ;
                                Y(iCloudCount) = CubePoints(num_5,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_5,3) + CubePoints(num_6,3))/2;
                                Z(iCloudCount) = Func_get_coor( CubePoints(num_5,:), CubePoints(num_6,:), 3 );
                            case 6
                                X(iCloudCount) = CubePoints(num_6,1) ;
                                % Triangle_coordinates(m, 2) = (CubePoints(num_6,2) + CubePoints(num_7,2))/2;
                                Y(iCloudCount) = Func_get_coor( CubePoints(num_6,:), CubePoints(num_7,:), 2 );
                                Z(iCloudCount) = CubePoints(num_6,3) ;
                            case 7
                                X(iCloudCount) = CubePoints(num_7,1) ;
                                Y(iCloudCount) = CubePoints(num_7,2) ;
                                % Triangle_coordinates(m, 3) = (CubePoints(num_7,3) + CubePoints(num_4,3))/2;
                                Z(iCloudCount) =  Func_get_coor( CubePoints(num_7,:), CubePoints(num_4,:), 3 );
                            case 8
                                % Triangle_coordinates(m, 1) = (CubePoints(num_0,1) + CubePoints(num_4,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_4,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_0,2);
                                Z(iCloudCount) = CubePoints(num_0,3);
                            case 9
                                % Triangle_coordinates(m, 1) = (CubePoints(num_1,1) + CubePoints(num_5,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_5,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_1,2);
                                Z(iCloudCount) = CubePoints(num_1,3);
                            case 10
                                % Triangle_coordinates(m, 1) = (CubePoints(num_2,1) + CubePoints(num_6,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_6,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_2,2);
                                Z(iCloudCount) = CubePoints(num_2,3);
                            case 11
                                % Triangle_coordinates(m, 1) = (CubePoints(num_3,1) + CubePoints(num_7,1))/2 ;
                                X(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_7,:), 1 ) ;
                                Y(iCloudCount) = CubePoints(num_3,2);
                                Z(iCloudCount) = CubePoints(num_3,3);
                        end                    
                    end
                end  
            end
        end
    end

