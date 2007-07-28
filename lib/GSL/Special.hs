{-# OPTIONS #-}
-----------------------------------------------------------------------------
{- |
Module      :  GSL.Special
Copyright   :  (c) Alberto Ruiz 2006
License     :  GPL-style

Maintainer  :  Alberto Ruiz (aruiz at um dot es)
Stability   :  provisional
Portability :  uses ffi

Wrappers for a few special functions.

<http://www.gnu.org/software/gsl/manual/html_node/Special-Functions.html#Special-Functions>
-}
-----------------------------------------------------------------------------

module GSL.Special (
    module GSL.Special.Airy,
    module GSL.Special.Erf,
    module GSL.Special.Gamma,
    bessel_J0_e,
    exp_e10_e
)
where

import Foreign
import GSL.Special.Internal
import GSL.Special.Gamma
import GSL.Special.Erf
import GSL.Special.Airy

-------------------- simple functions --------------------------

{- | The error function (/gsl_sf_erf/), defined as 2\/ \\sqrt \\pi * \int\_0\^t \\exp -t\^2 dt.

@> erf 1.5
0.9661051464753108@

-}
foreign import ccall "gsl-aux.h gsl_sf_erf" erf :: Double -> Double

{- | The Gaussian probability density function (/gsl_sf_erf_Z/), defined as (1\/\\sqrt\{2\\pi\}) \\exp(-x\^2\/2).

>> erf_Z 1.5
>0.12951759566589172

-}
foreign import ccall "gsl-aux.h gsl_sf_erf_Z" erf_Z :: Double -> Double

-------------------- functions returning sf_result -------------

{- | The regular cylindrical Bessel function of zeroth order, J_0(x). This is
   the example in the GSL manual, returning the value of the function and
   the error term: 

@\> bessel_J0_e 5.0
(-0.1775967713143383,1.9302109579684196e-16)@

-}
bessel_J0_e :: Double -> (Double,Double)
bessel_J0_e x = createSFR "bessel_J0_e" (gsl_sf_bessel_J0_e x)
foreign import ccall "gsl-aux.h gsl_sf_bessel_J0_e" gsl_sf_bessel_J0_e :: Double -> Ptr Double -> IO Int

-------------------- functions returning sf_result_e10 -------------

{- | (From the GSL manual) \"This function computes the exponential \exp(x) using the @gsl_sf_result_e10@ type to return a result with extended range. This function may be useful if the value of \exp(x) would overflow the numeric range of double\". 

For example:

@\> exp_e10_e 30.0
(1.0686474581524432,1.4711818964275088e-14,13)@

@\> exp 30.0
1.0686474581524463e13@

-}
exp_e10_e :: Double -> (Double,Int,Double)
exp_e10_e x = createSFR_E10 "exp_e10_e" (gsl_sf_exp_e10_e x)
foreign import ccall "gsl-aux.h gsl_sf_exp_e10_e" gsl_sf_exp_e10_e :: Double -> Ptr Double -> IO Int
