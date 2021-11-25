function tf = rpr_fk(q, draw)
    if (nargin < 2)
        draw = true;
    end

    dh_params = load_data('../../dh_params.txt');
    dh_params(1, 4) = dh_params(1, 4) + q(1);
    dh_params(2, 3) = dh_params(2, 3) + q(2);
    dh_params(3, 4) = dh_params(3, 4) + q(3);
    
    num_of_frames = size(dh_params, 1);
    tform = dh_params_to_tform(dh_params);
    
    base_frame = eye(4);
    frames = zeros(4, 4, 1 + num_of_frames);
    h = eye(4);
    frames(:, :, 1) = base_frame;
    for idx = 1 : num_of_frames
        h = h * tform(:, :, idx);
        frames(:, :, idx + 1) = h * base_frame;
    end
    
    tf = frames(:, :, end);
    
    if (draw)
        figure();
        draw_robot(frames);
        draw_axis(frames);
    end
end

