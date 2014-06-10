function roc = cv_roc(yCV, y_pred)
    %%Calculate the ROC curve for Cross Validation
    
    [X, Y] = perfcurve(yCV, y_pred, 't');
    roc = trapz(X, Y);
end