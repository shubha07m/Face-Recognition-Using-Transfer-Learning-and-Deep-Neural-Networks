function [cos_sim] = mysimcos_func(x, y)
    
    sumprod = sum(x.*y);
    sumx2 = sqrt(sum(x.^2));
    sumy2 = sqrt(sum(y.^2));
    cos_sim = sumprod/(sumx2.*sumy2);

end