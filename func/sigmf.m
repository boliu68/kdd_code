function y = sigmf(x, params)

    if nargin ~= 2
        error('Two arguments are required by the sigmoidal MF.');
    elseif length(params) < 2
        error('The sigmoidal MF needs at least two parameters.');
    end

    a = params(1); c = params(2);
    y = 1./(1 + exp(-a*(x-c)));

end