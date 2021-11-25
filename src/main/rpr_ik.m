function q = rpr_ik(tform, draw)
    if (nargin < 2)
        draw = false;
    end
    epsilon = 0.00000001;
    
    pos = tform(1 : 3, 4);
    q1 = -atan2(pos(1), pos(2));
    
    temp = rpr_fk([q1, 0, 0], false);
    rotm = tform(1 : 3, 1 : 3)' * temp(1 : 3, 1 : 3);
    
    if (sign(rotm(1, 1)) < 0)
        q1 = q1 + pi;
        
        temp = rpr_fk([q1, 0, 0], false);
        rotm = tform(1 : 3, 1 : 3)' * temp(1 : 3, 1 : 3);
    end    
    q3 = atan2(rotm(2, 3), rotm(3, 3));
    if (abs(q3) < epsilon)
        q3 = abs(q3);
    end
    
    temp = rpr_fk([q1, 0, q3], false);
    pos = temp(1 : 3, 1 : 3)' * (pos - temp(1 : 3, 4));
    q2 = sign(pos(2)) * (sign(q3) - abs(sign(q3)) + 1) * norm(pos);
    
    temp = rpr_fk([q1, q2, q3], false);
    if (det(tform(1 : 3, 1 : 3) - temp(1 : 3, 1 : 3)) > epsilon || ...
        norm(tform(1 : 3, 4) - temp(1 : 3, 4)) > epsilon)
        q = [];
    else
        q = [q1, q2, q3];
        if (draw == true)
            rpr_fk(q, draw);
        end
    end 
end
