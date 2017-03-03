%plannersprob_income_MWEM.m
%Ian M. Schmutte
%2016 5 October
%schmutte@uga.edu
%
%From code archive for Abowd and Schmutte (2016) "Revisiting the Economics of Privacy: Population Statistics and Privacy as Public Goods"


try;
%parameters
	n = 242977154; %Estimate of the 2015 US population age 18+ and not in institutionalized group quarters based on ACS. For details, see $A/data/raw/population_estimates in this archive.
	chi = 800; %size of sample space. 1000 quantiles of the income distribution.
	k = 320400; %size of the set of allowable queries. constructed here as the number of possible choices of two points in the histogram to allow "less than or equal to" and "greater than" queries
    %see code for ACS model.

	SWF_alpha_int = .7; %intercept for another level set of the SWF
	sum_p = 2;
	ybar = 9;
	cov_y_gamma = 0.0154; %from analysis of CNSS. See text for details.
	cov_y_eta = 0.076;    %from analysis of CNSS. See text for details.

	T_star_const = (n/(10*log(k)))^(2/3)*log(chi)^(1/3);


%find solution and maximized welfare function. 
    b = 1/3;
	R = (1+cov_y_gamma)/(1+cov_y_eta);
	PPF_const = 3*(((10*log(k)*log(chi))/n)^(b)); %from solving MWEM iteration count at optimal T
	epsilon_best = (b*PPF_const/R)^(1/(b+1))
	alpha_best = PPF_const/(epsilon_best^b)
	I_best = 1-alpha_best
	format long
	T_best = T_star_const*epsilon_best^(2/3);
	fprintf('T_best=%d',T_best)
	

	welfare_best = n*(-sum_p+ybar-epsilon_best*(1+cov_y_gamma)+I_best*(1+cov_y_eta));
	welfare = n*(ybar-sum_p+(SWF_alpha_int/(1+cov_y_eta)));
	% welfare = n*(ybar-sum_p-(SWF_alpha_int/(1+cov_y_eta)));

%Calculate welfare loss from a 25 percent increase in alpha
	epsilon_dev = epsilon_best*0.5
	alpha_dev = PPF_const/(epsilon_dev^b)
	I_dev = 1-alpha_dev
	T_dev = T_star_const*epsilon_dev^(2/3)
	% alpha_dev = (alpha_best*1.25)
	% epsilon_dev = (PPF_const/alpha_dev)^(1/b)
	welfare_dev = n*(-sum_p+ybar-epsilon_dev*(1+cov_y_gamma)+I_dev*(1+cov_y_eta));

	welfare_change_avg = (welfare_dev - welfare_best)/n


%plotting
	epsilon_min=0.001; epsilon_max = 10; gridsize = 1000;
	stepsize = (epsilon_max-epsilon_min)/(gridsize-1);
	epsilon = (epsilon_min:stepsize:epsilon_max);
	T = T_star_const*epsilon.^(2/3);
	% plot(T)


	%PPF
	acc1 = PPF_const./(epsilon.^(b));
	I_1 = 1-acc1;
	%SWF
	I_2 = (welfare/n + sum_p - ybar+ epsilon*(1+cov_y_gamma))/(1+cov_y_eta);
	%SWF_best
	I_opt = (welfare_best/n + sum_p - ybar + epsilon*(1+cov_y_gamma))/(1+cov_y_eta);
	%Expansion Path
	expansion_path = -(1/b)*R*epsilon+1;

	figure(1);
	hold on;
	plot(epsilon,I_1,'-k','LineWidth',2);
	plot(epsilon,I_2,':k','LineWidth',2);
	plot(epsilon,I_opt,'--k','LineWidth',2);
	plot(epsilon_best, I_best, 'ko','MarkerSize',12);
	plot(epsilon,expansion_path,'-.k');
	legend('PPF','SWF_{0}','SWF_{1}','Optimum','Expansion')
	% annot = sprintf('$\\epsilon^{*}=%0.3f$\n$I^{*}=%0.3f$\n$W^{*}=%2.3f$', epsilon_best,I_best,welfare_best/n);
	% text('Interpreter','latex','Position',[epsilon_best-0.5 alpha_best-0.001],'String',annot,'EdgeColor','black');
		xlabel('Privacy Loss (\epsilon)','fontsize',12);ylabel('Accuracy (I)','fontsize',12);
	%	set(gca,'XDir','Reverse','YDir','Reverse') %if you want to make it `look like' a max problem
	%	title('Social Welfare Maximization');
	axis manual;
	xlim manual;
	ylim manual;
	xlim([0 1]);
	ylim([0 1]);
	axis square;
	set(gca,'FontSize',12);
	print('-f1','-deps','plannersprob_health');
	print('-f1','-djpeg','plannersprob_health');
	hold off;
clear all;
catch err; 
    err.message
    err.cause
    err.stack
   exit(1);
end
exit;