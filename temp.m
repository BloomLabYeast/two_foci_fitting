files = dir('*GFP-1.tif');
dist_nm_array = zeros([numel(files), 1]);
for n = 1:numel(files)
    filename = files(n).name;
    gfp = readTiffStack(filename);
    % HARD CODED VARIABLES
    wavelength_nm = 510; %gfp emission
    na = 1.4; %diana scope objective
    pixel_size_nm = 64*2; %binned
    start_sigma_fold = 2;
    max_sigma_fold = 4;
    int_fold = 10;
    [fitresult, gof] = fit_gauss_2d_2term_bg( ...
        gfp, ...
        wavelength_nm, ...
        na, ...
        pixel_size_nm, ...
        start_sigma_fold, ...
        max_sigma_fold, ...
        int_fold ...
        );
    coeff_values = coeffvalues(fitresult);
    mu1_x = coeff_values(4);
    mu1_y = coeff_values(5);
    mu2_x = coeff_values(6);
    mu2_y = coeff_values(7);
    % 2D Euclidean distance calulation
    dist = sqrt((mu1_x - mu2_x)^2 + (mu1_y - mu2_y)^2);
    dist_nm = dist * pixel_size_nm;
    dist_nm_array(n) = dist_nm;
end