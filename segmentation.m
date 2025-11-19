% segmentation.m
% Segment ECG into heartbeats (0.25s before R, 0.45s after R)
% Usage: segments = segment_ecg(ecg_signal, fs)
function segments = segment_ecg(ecg_signal, fs)
    % Inputs:
    %  - ecg_signal : vector of ECG samples
    %  - fs : sampling frequency (Hz)
    %
    % Output:
    %  - segments : cell array of fixed-length heartbeat segments

    % parameters (from report)
    pre_sec  = 0.25;   % seconds before R-peak
    post_sec = 0.45;   % seconds after R-peak
    pre_samples  = round(pre_sec * fs);
    post_samples = round(post_sec * fs);
    seg_len = pre_samples + post_samples + 1;

    % Basic R peak detection (simple) - replace with your preferred method
    % Using findpeaks on absolute derivative (simple heuristic)
    ecg = ecg_signal(:);
    env = abs(diff(ecg));
    env = [env; 0];
    [pks, locs] = findpeaks(env, 'MinPeakHeight', mean(env)+std(env));

    segments = {};
    idx = 1;
    for i = 1:length(locs)
        center = locs(i);
        start_idx = center - pre_samples;
        end_idx   = center + post_samples;
        if start_idx < 1 || end_idx > length(ecg)
            continue; % skip partial segments at edges
        end
        seg = ecg(start_idx:end_idx);
        % enforce fixed-length
        if length(seg)==seg_len
            segments{idx} = seg;
            idx = idx + 1;
        end
    end

    fprintf('Extracted %d segments (segment length = %d samples)\n', length(segments), seg_len);
end
