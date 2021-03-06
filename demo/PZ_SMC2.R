rm(list = ls(all.names=TRUE))
unlink(".RData")
try(detach(package:RBi, unload = TRUE), silent = TRUE)
library(RBi, quietly = TRUE)

library('ggplot2', quietly = TRUE)
library('gridExtra', quietly = TRUE)

# the PZ model file is included in RBi and can be found there:
model_file_name <- system.file(package="RBi", "PZ.bi")

# assign model variable
PZ <- bi_model(model_file_name)
# look at the model
PZ

T <- 50

init_parameters <- list(P = 2, Z = 2, mu = 0.5, sigma = 0.3)
# First let's generate a dataset from the model
synthetic_dataset <- bi_generate_dataset(endtime=T, model=PZ,
                                         init = init_parameters)

# Settings
bi_object <- libbi$new(client="sample", model=PZ, sampler = "smc2")
print(bi_object)

# Once happy with the settings, launch bi.
bi_object$run(add_options = list("end-time" = T, noutputs = T, nsamples = 128, nparticles = 128, nthreads = 1), verbose = TRUE, obs = synthetic_dataset, init = init_parameters, stdoutput_file_name = tempfile(pattern="smc2output", fileext=".txt"))
# It can be a good idea to look at the result file
bi_file_summary(bi_object$result$output_file_name)
# Have a look at the posterior distribution
logweight <- bi_read(bi_object, "logweight")$value
weight <- log2normw(logweight)
mu <- bi_read(bi_object, "mu")$value
g1 <- qplot(x = mu, y = ..density.., weight = weight, geom = "histogram") + xlab(expression(mu))
sigma <- bi_read(bi_object, "sigma")$value
g2 <- qplot(x = sigma, y = ..density.., weight = weight, geom = "histogram") + xlab(expression(sigma))
grid.arrange(g1, g2)

## or plot using RBi.helpers
##
## library('RBi.helpers')

## ## plot filtered trajectories
## plot(bi_object)

## ## other plots
## p <- plot(bi_object, densities = "histogram")
## p$densities

## reproduce plot from above

## p_mu <- plot(bi_object, densities = "histogram", params = "mu")
## p_sigma <- plot(bi_object, densities = "histogram", params = "sigma")

## g1 <- p_mu$densities + xlab(expression(mu)) + theme(strip.background = element_blank(), strip.text = element_blank())
## g2 <- p_sigma$densities + xlab(expression(sigma)) + theme(strip.background = element_blank(), strip.text = element_blank())

## grid.arrange(g1, g2)
