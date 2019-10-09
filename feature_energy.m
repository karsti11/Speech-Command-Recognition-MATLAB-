function E = feature_energy(window)

E = (1/(length(window))) * sum(abs(window.^2));

