FREEfitCV.default <-
function(y, x, bins=NULL, groups=NULL, z=NULL, n.cv=10, verbose=TRUE, ...){
  if (is.matrix(y)) {
    if (is.null(bins)) {
      bins <- 1:ncol(y)
    }
  	if (ncol(y) != length(bins)) {
  	  stop("response data y should have the same number of columns as there are bins",
  	       call.=FALSE)
  	}
  	if (!is.null(nrow(x))) {
  	  if (nrow(y) != nrow(x)) {
  	    stop("response and predictor data should have one row for each site", call.=FALSE)
  	  }
  	}
    if (!is.null(z)) {
      warning("matrix z is only used for scalar models", call.=FALSE)
    }
    n.obs <- nrow(y)
    observed <- NULL
    predicted <- NULL
  	if (is.null(groups)) {
      cv.out <- FREEsplineCV(n.cv=n.cv, y=y, x=x, groups=groups, w=bins, ...)
  	} else {
  	  if (is.matrix(groups) | is.integer(groups) | is.numeric(groups)) {
  	    if (is.integer(groups)) {
  	      groups <- as.matrix(groups)
  	    }
  	    if (is.numeric(groups)) {
  	      warning("a numeric vector has been provided for groups; make sure that this vector is assigning each row of the response to a cluster", call.=FALSE)
  	      groups <- as.matrix(groups)
  	    }
  	    if (nrow(groups) != nrow(y)) {
  	      stop("response and groups should have the same number of rows", call.=FALSE)
  	    }
  	    groups <- apply(groups, 2, function(x) as.integer(as.factor(x)))
  	    cv.out <- FREEsplineCV(n.cv=n.cv, y=y, x=x, groups=groups, w=bins, ...)
  	  } else {
  	    stop("the groups variable needs to be a matrix or integer/numeric vector", call.=FALSE)
  	  }
  	}
  } else {
    if (is.numeric(y)) {
      if (is.null(bins)) {
        bins <- 1:ncol(x)
      }
      if (!is.matrix(x)) {
        stop("the predictor data should be a matrix with one row for each site", call.=FALSE)
      }
      if (length(y) != nrow(x)) {
        stop("response and predictor data should have one row/observation for each site",
             call.=FALSE)
      }
      if (is.matrix(z) | is.numeric(z) | is.integer(z)) {
        if (is.numeric(z) | is.integer(z)) {
          z <- matrix(z, ncol=1)
        }
        if (nrow(z) != nrow(x)) {
          stop("response and predictor data should have one row/observation for each site", call.=FALSE)
        }
      } else {
          stop("scalar predictors z must be either a matrix or a numeric or integer vector", call.=FALSE)
      }
      if (is.matrix(groups) | is.integer(groups) | is.numeric(groups)) {
        if (is.integer(groups)) {
          groups <- as.matrix(groups)
        }
        if (is.numeric(groups)) {
          warning("a numeric vector has been provided for groups; make sure that this vector is assigning each row of the response to a cluster", call.=FALSE)
          groups <- as.matrix(groups)
        }
        if (nrow(groups) != length(y)) {
          stop("response and groups should have the same number of rows", call.=FALSE)
        }
        groups <- apply(groups, 2, function(x) as.integer(as.factor(x)))
        cv.out <- FREEscalarCV(n.cv=n.cv, y=y, x=x, z=z, groups=groups, bins=bins, ...)
      } else {
        stop("the groups variable needs to be a matrix or integer/numeric vector", call.=FALSE)
      }
    } else {
      stop("model response must be a numeric vector (scalar response model) or a matrix (function response model)", call.=FALSE)
    }
  }
  observed <- cv.out$observed
  predicted <- cv.out$predicted
  cv.cor <- cor(c(observed), c(predicted))
  cv.r2 <- cv.cor * cv.cor
  CVout <- list(observed=observed, predicted=predicted, cv.r2=cv.r2)
  class(CVout) <- "FREEfitCV"
  CVout
}