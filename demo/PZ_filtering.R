rm(list = ls(all.names=TRUE))
unlink(".RData")
try(detach(package:bi, unload = TRUE), silent = TRUE)
library(bi, quietly = TRUE)

# Settings
settings <- bi_settings(client = "filter", 
                        config = "filter.conf",
                        path_to_model = "~/workspace/pz")

print(settings)
# Once happy with the settings, launch bi.
bi_result <- bi_libbi(bi_settings=settings, args="--end-time 150 --nparticles 256 --verbose --nthreads 1",
                outputfile = "results/launchPZ_PF.nc")
# It can be a good idea to look at the result file
bi_file_summary(bi_result$outputfile)
# Have a look at the filtering distributions
logw <- bi_read_var(bi_result$outputfile, "logweight")
P <- bi_read_var(bi_result$outputfile, "P")
Z <- bi_read_var(bi_result$outputfile, "Z")

w = apply(X=logw, MARGIN=2, FUN=log2normw)
Pmeans = apply(X = P*w, MARGIN=2, FUN=sum)
Zmeans = apply(X = Z*w, MARGIN=2, FUN=sum)
qplot(x=seq_along(Pmeans), y=Pmeans, geom = "line", col = "P") +
geom_line(aes(y=Zmeans, col = "Z")) + scale_color_discrete(name = "") +
  xlab("time") + ylab("Hidden state")
