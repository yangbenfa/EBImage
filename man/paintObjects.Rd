\name{paintObjects}

\alias{paintObjects}

\title{Mark objects in images}

\description{
  Higlight objects in images by outlining and/or painting them.
}

\usage{
paintObjects(x, tgt, opac=c(1, 1), col=c('red', NA), thick=FALSE, closed=FALSE)
}

\arguments{
   \item{x}{An \code{Image} object in \code{Grayscale} color mode or an
    array containing object masks. Object masks are sets of pixels
    with the same unique integer value.}
    
  \item{tgt}{An \code{Image} object or an array, containing the
    intensity values of the objects.}

  \item{opac}{A numeric vector of two opacity values for drawing object
    boundaries and object bodies. Opacity ranges from 0 to 1, with 0
    being fully transparent and 1 fully opaque.}

  \item{col}{A character vector of two R colors for drawing object
    boundaries and object bodies. By default, object boundaries are
    painted in \code{red} while object bodies are not painted.}
    
  \item{thick}{A logical indicating whether to use thick boundary contours. Default is \code{FALSE}.}
  
  \item{closed}{A logical indicating whether object contours should be closed along image edges or remain open.}
}

\value{
  An \code{Image} object or an array, containing the painted version of \code{tgt}.
}

\seealso{
  \code{\link{bwlabel}}, \code{\link{watershed}}, \code{\link{computeFeatures}}, \code{\link{colorLabels}}
}

\examples{
  ## load images
  nuc = readImage(system.file('images', 'nuclei.tif', package='EBImage'))
  cel = readImage(system.file('images', 'cells.tif', package='EBImage'))
  img = rgbImage(green=cel, blue=nuc)
  display(img, title='Cells')

  ## segment nuclei
  nmask = thresh(nuc, 10, 10, 0.05)
  nmask = opening(nmask, makeBrush(5, shape='disc'))
  nmask = fillHull(nmask)
  nmask = bwlabel(nmask)
  display(normalize(nmask), title='Cell nuclei mask')

  ## segment cells, using propagate and nuclei as 'seeds'
  ctmask = opening(cel>0.1, makeBrush(5, shape='disc'))
  cmask = propagate(cel, nmask, ctmask)
  display(normalize(cmask), title='Cell mask')

  ## using paintObjects to highlight objects
  res = paintObjects(cmask, img, col='#ff00ff')
  res = paintObjects(nmask, res, col='#ffff00')
  display(res, title='Segmented cells')
}

\author{
  Oleg Sklyar, \email{osklyar@ebi.ac.uk}, 2006-2007
  Andrzej Oles, \email{andrzej.oles@embl.de}, 2015
}
