% dwt_wavelet.m
% For every heartbeat segment, compute db2 4-level DWT and return coefficients
% Usage: Xw = compute_wavelet_coeffs(segment)
function Xw = compute_wavelet_coeffs(segment)
    % segment : vector
    % Xw : struct with fields D1..D4 and A4 (approx)
    wname = 'db2';
    L = 4; % levels
    % Perform multilevel decomposition
    [C, Ls] = wavedec(segment, L, wname); %#ok<ASGLU>
    % extract detail coeffs from level 1..4 and approximation A4
    D1 = detcoef(C, Ls, 1);
    D2 = detcoef(C, Ls, 2);
    D3 = detcoef(C, Ls, 3);
    D4 = detcoef(C, Ls, 4);
    A4 = appcoef(C, Ls, wname, 4);
    Xw = struct('D1',D1,'D2',D2,'D3',D3,'D4',D4,'A4',A4);
end
