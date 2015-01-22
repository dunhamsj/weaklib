SUBROUTINE e_p_eos( brydns, t_mev, ye, pe, ee, se, ue, yeplus, rel )
!-----------------------------------------------------------------------
!
!    File:         e_p_eos
!    Module:       e_p_eos
!    Type:         Subprogram
!    Author:       S. W. Bruenn, Dept of Physics, FAU,
!                  Boca Raton, FL 33431-0991
!
!    Date:         7/17/04
!
!    Purpose:
!	 To compute the electron-positron contribution to the equation of state,
!	  given rho, t, and ye. The electron chemical potential is iterated until
!     the appropriate Fermi-Dirac integrals, or approximations thereof, for
!     the electron - positron number converge to the electron positron number
!     given by rho*ye/mb.
!    This subroutine is similar to lectron except that variables are
!     passed throught the calling statement rather than common.
!
!    Variables that must be passed through common:
!        none
!
!    Subprograms called:
!        glaquad
!
!    Input arguments:
!  brydns :  density (baryons/fm**3)
!  t_mev  :  temperature [MeV]
!  ye     :  Y_e^- - Y_e^+  (ye)
!
!    Output arguments:
!  pe     : electron-positron pressure [dynes cm^{-2}]
!  ee     : electron-positron energy [ergs cm^{-3}]
!  se     : electron-positron entropy
!  ue     : electron chemical potential [MeV]
!  yeplus : positron fraction
!  rel    : relativity parameter
!
!    Include files:
!  wlKindModule
!  wlExtNumericalModule
!  wlExtPhysicalConstantsModule
!
!-----------------------------------------------------------------------

USE wlKindModule, ONLY: double => dp
USE wlExtNumericalModule, ONLY: zero, third, half, pi
USE wlExtPhysicalConstantsModule, ONLY: hbarc, me, rmu, cm3fm3

IMPLICIT NONE
SAVE

!-----------------------------------------------------------------------
!        Input variables
!-----------------------------------------------------------------------

REAL(KIND=double), INTENT(in)      :: brydns         ! density (number of baryons fm^{-3})
REAL(KIND=double), INTENT(in)      :: t_mev          ! temperature [MeV]
REAL(KIND=double), INTENT(in)      :: ye             ! electron fraction

!-----------------------------------------------------------------------
!        Input variables
!-----------------------------------------------------------------------

REAL(KIND=double), INTENT(out)     :: pe            ! electron-positron pressure [dynes cm^{-2}]
REAL(KIND=double), INTENT(out)     :: ee            ! electron-positron energy [ergs cm^{-3}]
REAL(KIND=double), INTENT(out)     :: se            ! electron-positron entropy
REAL(KIND=double), INTENT(out)     :: ue            ! electron chemical potential [MeV]
REAL(KIND=double), INTENT(out)     :: yeplus        ! positron fraction
REAL(KIND=double), INTENT(out)     :: rel           ! relativity parameter

!-----------------------------------------------------------------------
!        Local variables
!-----------------------------------------------------------------------

LOGICAL                            :: first = .true.
LOGICAL                            :: non_rel        ! nonrelativistic flag
LOGICAL                            :: approx
LOGICAL                            :: Sommerfeld
LOGICAL                            :: Failure

INTEGER                            :: i              ! summation index
INTEGER                            :: j              ! summation index
INTEGER                            :: it             ! iteration index
INTEGER                            :: l              ! iteration index
INTEGER, PARAMETER                 :: nlag = 48      ! number of points of Gauss-Laguerre quadrature
INTEGER, PARAMETER                 :: ncnvge = 30    ! number of iterations

REAL(KIND=double), DIMENSION(nlag) :: xa             ! points of Gauss-Lagendre quadrature
REAL(KIND=double), DIMENSION(nlag) :: wt0            ! unscaled weights of Gauss-Lagendre quadrature
REAL(KIND=double), DIMENSION(nlag) :: wta            ! weights of Gauss-Lagendre quadrature
REAL(KIND=double), DIMENSION(nlag) :: fn_a           ! electron occupation number
REAL(KIND=double), DIMENSION(nlag) :: fp_a           ! positron occupation number

REAL(KIND=double), PARAMETER       :: eps1 = 1.d-4   ! tolerance
REAL(KIND=double), PARAMETER       :: eps2 = 1.d-6   ! tolerance
REAL(KIND=double), PARAMETER       :: beta_max = 2.d0  ! high temperature approximation criterion
REAL(KIND=double), PARAMETER       :: relmin = 1.2d0
REAL(KIND=double), PARAMETER       :: etabet = 2.d0
REAL(KIND=double), PARAMETER       :: tthird = 2.d0/3.d0
REAL(KIND=double)                  :: pi2            ! pi^{2}
REAL(KIND=double)                  :: pi4            ! pi^{4}

REAL(KIND=double)                  :: const          ! coef used in the high temperature approx
REAL(KIND=double)                  :: cnstnr         ! coef for the nr expression for n(electron) - n(positron)
REAL(KIND=double)                  :: coef_e_fermi_nr ! coef for nr electron Fermi energy
REAL(KIND=double)                  :: rmuec          ! coef for nr, nondegenerate electron chemical potential

REAL(KIND=double)                  :: e_fermi_nr     ! nonrelativistic Fermi energy

REAL(KIND=double)                  :: ne_x_coef      ! ne x coefficient, ye * ne_x_coef = integral for ne sans coefficient
REAL(KIND=double)                  :: beta           ! me c^{2}/kT
REAL(KIND=double)                  :: beta2          ! beta^{2}
REAL(KIND=double)                  :: etae           ! ( electron chemical potential - mec2 )/kT  
REAL(KIND=double)                  :: wwchk          ! ne_x_coef calculated by Gause-Leguerre integration
REAL(KIND=double)                  :: deriv          ! d(ne_x_coef)/d(etae)
REAL(KIND=double)                  :: tol            ! tolerance
REAL(KIND=double)                  :: tolp           ! tolerance
REAL(KIND=double)                  :: fact           ! integrand

REAL(KIND=double)                  :: pfc            ! Fermi momentum * c
REAL(KIND=double)                  :: rb2            ! pi^{2}/beta^{2}
REAL(KIND=double)                  :: xans           ! (pfc/me)^{3}
REAL(KIND=double)                  :: xx             ! pfc/me
REAL(KIND=double)                  :: dxx            ! correction to xx
REAL(KIND=double)                  :: dxxp           ! correction to xx
REAL(KIND=double)                  :: ped            ! pe/brydns
REAL(KIND=double)                  :: deta           ! change in eta
REAL(KIND=double)                  :: detap          ! change in eta
REAL(KIND=double)                  :: ek             ! electron kinetic energy/baryon [MeV]
REAL(KIND=double)                  :: etad           ! degenerate approximation for eta
REAL(KIND=double)                  :: rmuend         ! nondegenerate approximation for eta * t_mev
REAL(KIND=double)                  :: etand          ! nondegenerate approximation for eta
REAL(KIND=double)                  :: rintrp         ! interpolant between etad and etand
REAL(KIND=double)                  :: yans           ! nonrelativistic Sommerfeld variable
REAL(KIND=double)                  :: y              ! nonrelativistic Sommerfeld variable
REAL(KIND=double)                  :: dy             ! change in y
REAL(KIND=double)                  :: dyp            ! change in y

!-----------------------------------------------------------------------
!        Formats
!-----------------------------------------------------------------------

 1001 FORMAT (' Convergence failure in electron relativistic Sommerfeld in e_p_eos')
 1003 FORMAT (' rho=',es11.3,' tmev=',es11.3,' ye=',es11.3)
 1005 FORMAT (' tol=',es11.3,' xx=',es11.3,' xans**third=',es11.3, &
& ' ffn(xx)=',es11.3,' xans=',es11.3)
 2001 FORMAT (' Convergence failure in electron nonrelativistic Gauss-Laguerre integration in e_p_eos')
 2003 FORMAT (' rho=',es11.3,' tmev=',es11.3,' ye=',es11.3)
 2005 FORMAT (' etae=',es11.3,' deta=',es11.3,' tol=',es11.3,' ne_x_coef*yebc=',es11.3,' wwchk=',es11.3)
 3001 FORMAT (' Convergence failure in electron nonrelativistic Sommerfeld in e_p_eos')
 3003 FORMAT (' rho=',es11.3,' tmev=',es11.3,' ye=',es11.3)
 3005 FORMAT (' tol=',es11.3,' y=',es11.3,' yans**(tthird)=',es11.3)

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!  Initialize
!-----------------------------------------------------------------------

IF ( first ) THEN

!-----------------------------------------------------------------------
!  Get quadrature points and weights
!-----------------------------------------------------------------------

  first         = .false.
  CALL glaquad(nlag, xa, wt0, nlag)
  DO i = 1,nlag
    wta(i) = fexp(xa(i)) * wt0(i)
  END DO

!-----------------------------------------------------------------------
!  Initialize coefficients
!-----------------------------------------------------------------------

  pi2           = pi * pi
  pi4           = pi2 * pi2
  const         = hbarc**3 * pi**2
  cnstnr        = hbarc**3 * 3.d0 * pi2/DSQRT( 2.d0 * me**3 )
  coef_e_fermi_nr = ( hbarc**2/( 2.d0 * me ) ) * ( 3.d0 * pi2 )**tthird
  rmuec         = 0.5d0 * ( 2.d0 * pi * hbarc**2/me )**1.5d0

END IF ! first

!-----------------------------------------------------------------------
!  Relativistic or Nonrelativistic?
!   e_fermi_nr:     nonrelativistic Fermi energy.
!
!  Perform nonrelativistic calculation if
!   e_fermi_nr/mec2   < 0.01
!  and
!   tbck      < 0.01
!-----------------------------------------------------------------------

e_fermi_nr       = coef_e_fermi_nr * ( brydns * ye )**tthird
non_rel          = .false.
IF ( e_fermi_nr < 0.01 * me  .and.  t_mev < 0.01 * me ) non_rel = .true.

IF ( .not. non_rel ) THEN

!-----------------------------------------------------------------------
!
!                    \\\\\ RELATIVISTIC CASE /////
!
!-----------------------------------------------------------------------

  ne_x_coef     = brydns * const/t_mev**3
  pfc           = hbarc * ( 3.d0 * pi2 * brydns * ye )**third
  beta          = me/t_mev
  beta2         = beta * beta
  etae          = zero

!-----------------------------------------------------------------------
!  The high temperature approximation is tried if
!   beta < 2/3
!  or
!   beta < 2  and  etae > 2*beta
!  It is used if
!   rel = 3*pressure/( kinetic energy density ) > relmin = 1.2
!-----------------------------------------------------------------------

  approx        = ( beta <= beta_max )
  IF ( approx ) THEN
    etae        = cube( 1.5d0 * ( ne_x_coef * ye ), DMAX1( pi2 * third - 0.5d0 * beta2, zero ) )
    approx      = ( beta <= tthird ) .or. ( etae > etabet * beta )

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!        High-Temperature Approximation
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

    IF ( approx ) THEN
      ped       = ( t_mev/ne_x_coef ) * third * ( g3( etae * etae ) - 1.5d0 * beta2 * g1( etae * etae ) )
      pe        = brydns * ped
      se        = ( 4.d0/t_mev ) * ped - ye * etae + beta2 * g1( etae * etae )/ne_x_coef
      ee        = t_mev * ( se + ye * etae ) - ped
      yeplus    = 2.0d0 * fexp(-etae) * ( 1.0d0 - fexp(-etae)/8.0d0 )/ne_x_coef

      rel       = 3.0d0 * ped/( ee - me * ( ye + 2.0d0 * yeplus ) )
      approx = ( rel <= relmin )

    END IF ! beta < beta_max
  END IF ! beta < tthird  .or.  etae > etabet*beta

  IF ( approx ) THEN
    ue          = etae * t_mev
    RETURN! Computation of e-p eos by high T approx was successful
  END IF ! approx

!-----------------------------------------------------------------------
!  If high-temperature approximation is inappropriate, then
!   guess etae. (Note that etae computed by the high-temperature
!   approximation gives a lower limit.)
!
!  Redo calculation with Sommerfeld approximation if
!   etae - beta > 35.
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!        Relativistic Gauss-Laguerre Integration
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

  etae  = cube( 1.5d0 * ( ne_x_coef * ye ) , DMAX1( pi2 * third - 0.5d0 * beta2, zero) )

!-----------------------------------------------------------------------
!  Iterate on etae until wwchk = ne_x_coef*yebck
!-----------------------------------------------------------------------

  tolp          = zero
  Failure       = .false.

  DO it = 1,ncnvge
    wwchk       = zero
    deriv       = zero

!-----------------------------------------------------------------------
!  Gauss-Laguerre
!-----------------------------------------------------------------------

    DO j = 1,nlag
      fact      = wta(j) * DSQRT( xa(j) * ( xa(j) + 2.0d0 * beta ) ) * ( xa(j) + beta )                          ! *
      fn_a(j)   = 1.0d0/( 1.0d0 + fexp( xa(j) + beta - etae ) )
      fp_a(j)   = 1.0d0/( 1.0d0 + fexp( xa(j) + beta + etae ) )
      wwchk     = wwchk + fact * ( fn_a(j) - fp_a(j) )
      deriv     = deriv + fact * ( fn_a(j)*( 1.d0 - fn_a(j) ) + fp_a(j) * ( 1.d0 - fp_a(j) ) )
    END DO ! j = 1,nlag

!-----------------------------------------------------------------------
!  Check convergence and compute correction
!-----------------------------------------------------------------------

    IF ( wwchk <= zero ) THEN
      Failure   = .true.
      EXIT
    END IF ! wwchk <= zero

    tol         = DLOG( wwchk/( ne_x_coef * ye ) )
    IF ( DABS(tol) <= eps1 ) EXIT
    deriv       =   deriv/wwchk

!-----------------------------------------------------------------------
!  Tricks to avoid oscillations and help assure convergence
!-----------------------------------------------------------------------

    IF ( tol * tolp >= zero ) THEN
      deta      = - tol/deriv
    ELSE
      deta      = detap *tol / ( tolp - tol )
    END IF ! tol * tolp >= zero

    IF ( DABS(deta) <= eps2 * DABS(etae) ) EXIT

    IF ( etae + deta <= zero ) deta = deta/10.d0
    etae        = etae + deta

    IF ( etae <= zero ) etae = DABS(deta)
    tolp        = tol
    detap       = deta

    IF ( it == ncnvge ) Failure  = .true.

  END DO ! it = 1,ncnvge

  IF ( .not. Failure  .and.  ( etae < 35.d0  .or.  pfc/me < 10.d0 ) ) THEN

!-----------------------------------------------------------------------
!  Convergence success? Compute the rest of the eos functions.
!
!   ee:     electron energy/baryon (including rest mass) [MeV]
!   pe:     electron pressure (MeV/fm**3)
!   se:     electron entropy/baryon (dimensionless)
!   yeplus: positron fraction (exact here)
!   rel:    relativistic parameter
!-----------------------------------------------------------------------

    pe          = zero
    ee          = zero
    se          = zero
    yeplus      = zero

    DO j = 1,nlag                              ! *   Gauss
      fact      = wta(j) * DSQRT( xa(j) * ( xa(j) + 2.0d0 * beta ) )
      pe        = pe + fact * ( fn_a(j) + fp_a(j) ) * xa(j) * ( xa(j) + 2.0d0 * beta )
      ee        = ee + fact * ( fn_a(j) + fp_a(j) ) * ( xa(j) + beta )**2
      yeplus    = yeplus + fact * fp_a(j) * ( xa(j) + beta )
    END DO ! j = 1,nlag

    yeplus      = yeplus/ne_x_coef
    ue          = etae * t_mev
    pe          = ( t_mev/ne_x_coef ) * brydns * third * pe
    ee          = ( t_mev/ne_x_coef ) * ee
    se          = ( ee + pe/brydns )/t_mev - ye * etae
    rel         = 3.0d0 * pe/brydns/( ee - me * ( ye + 2.0d0 * yeplus ) )
    RETURN

  END IF ! .not. Failure  .and.  etae < 35.d0

!-----------------------------------------------------------------------
!  Convergence failure or etae > 35, use the Sommerfeld
!   approximation
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!        Relativistic Sommerfeld Approximation
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

  rb2           = pi2/beta2
  xans          = ( pfc/me )**3
  xx            = pfc/me
  dxxp          = zero

!-----------------------------------------------------------------------
!  Iterate on xx until ffn(xx) = xans
!-----------------------------------------------------------------------

  Failure       = .false.
  DO l = 1,50
    tol         = ( ffn(xx) - xans )/xans
    IF ( DABS(tol) <= 1.d-7 ) EXIT
    dxx         = -tol * xans/dfndx(xx)
    IF( dxx * dxxp < zero ) dxx = dxx/2.d0
    dxxp        = dxx
    xx          = xx + dxx
    IF ( l == 50 ) Failure = .true.
  END DO ! l = 1,50

!-----------------------------------------------------------------------
!  Convergence success? Compute the rest of the eos functions.
!
!   ee:     electron energy/baryon (including rest mass) [MeV]
!   ek:     electron kinetic energy/baryon [MeV]
!   pe:     electron pressure (MeV/fm**3)
!   se:     electron entropy/baryon (dimensionless)
!   yeplus: positron fraction = 0
!   rel:    relativistic parameter
!-----------------------------------------------------------------------

  IF ( .not. Failure ) THEN

    pe          = me**4 / ( 24.d0 * pi2 * hbarc**3 ) * ( f(xx) + 4.d0 * rb2 * xx * DSQRT( 1.d0 + xx * xx ) &
&               + 7.d0/15.d0 * rb2 * rb2 * DSQRT( 1.d0 + xx * xx ) * ( 2.d0 * xx * xx - 1.d0 )/xx**3 )
    ek          = me**4 / ( 24.d0 * pi2 * hbarc**3 ) * ( gg(xx) + 4.d0 * rb2 &
&               * ( DSQRT( 1.d0 + xx * xx ) * ( 3.d0 * xx * xx + 1.d0 )/xx - ( 2.d0 * xx * xx + 1.d0 )/xx ) )
    ee          = ek/brydns + ye * me
    ue          = me * DSQRT( 1.d0 + xx * xx )
    se          = ( ee + pe/brydns - ue * ye )/t_mev
    rel         = 3.d0 * pe/ek
    yeplus      = zero

    RETURN

  END IF ! .not. Failure

!-----------------------------------------------------------------------
!  Convergence failure? Write memo to unit 6 and continue
!-----------------------------------------------------------------------

  WRITE (*,1001)
  WRITE (*,1003) brydns * rmu/cm3fm3, t_mev, ye
  WRITE (*,1005) tol, xx, xans**third, ffn(xx), xans
  STOP

END IF ! .not. non_rel

IF ( non_rel ) THEN

!-----------------------------------------------------------------------
!
!                   \\\\\ NONRELATIVISTIC CASE /////
!
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!  Guess etae by interpolating between its degenerate and
!   nondegenerate value.
!
!  Use nonrelativistic Sommerfeld approximation if e_fermi_nr/kt > 35
!-----------------------------------------------------------------------
 
  tolp          = zero
  e_fermi_nr    = coef_e_fermi_nr * ( brydns * ye )**( tthird )
  etad          = e_fermi_nr/t_mev

  Sommerfeld    = .false.
  IF ( e_fermi_nr/t_mev > 35 ) Sommerfeld = .true.

  IF ( .not. Sommerfeld ) THEN

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!        Nonrelativistic Gauss-Laguerre Integration
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!  Guess etae by interpolating between its degenerate and
!   nondegenerate value.
!-----------------------------------------------------------------------

    rmuend      = t_mev * DLOG( brydns * ye * rmuec/t_mev**1.5 )
    etand       = rmuend/t_mev
    rintrp      = etad/( 1.d0 + etad )
    etae        = etand + rintrp * ( etad - etand )
    ne_x_coef          = cnstnr * brydns * ye/t_mev**1.5

!-----------------------------------------------------------------------
!  Iterate on etae until wwchk = ne_x_coef
!-----------------------------------------------------------------------

    Failure     = .false.
    DO it = 1,ncnvge
      wwchk     = zero
      deriv     = zero
      DO j = 1,nlag
        fact    = wta(j) * DSQRT( xa(j) )
        fn_a(j) = 1.0d0/( 1.0d0 + fexp( xa(j) - etae ) )
        wwchk   = wwchk + fact * fn_a(j)
        deriv   = deriv + fact * ( fn_a(j) * ( 1.0d0 - fn_a(j) ) )
      END DO

!-----------------------------------------------------------------------
!  Check convergence and compute correction
!-----------------------------------------------------------------------

      tol       = DLOG( wwchk/ne_x_coef )
      IF ( DABS(tol) <= eps1 ) EXIT
      deriv     = deriv/wwchk

!-----------------------------------------------------------------------
!  Tricks to avoid oscillations and help assure convergence
!-----------------------------------------------------------------------

      IF ( tol * tolp >= zero ) THEN
        deta    = - tol/deriv
      ELSE
        deta    = detap * tol/( tolp - tol )
      END IF

      IF( DABS(deta) <= eps2 * DABS(etae) ) EXIT
      etae      = etae + deta
      tolp      = tol
      detap     = deta
      IF ( it == ncnvge ) Failure = .true.
    END DO ! iteration

!-----------------------------------------------------------------------
!  Convergence failure? Write memo to unit 6 and continue
!-----------------------------------------------------------------------

    IF ( Failure ) THEN
      WRITE (6,2001)
      WRITE (6,2003) brydns * rmu/cm3fm3, t_mev, ye
      WRITE (6,2005) etae,deta,tol,ne_x_coef*ye,wwchk
    END IF ! Failure
    
    IF ( .not. Failure ) THEN

!-----------------------------------------------------------------------
!  Convergence success? Compute the rest of the eos functions.
!
!   ee:     electron energy/baryon (including rest mass) [MeV]
!   ek:     electron kinetic energy/baryon [MeV]
!   pe:     electron pressure (MeV fm^{-3})
!   se:     electron entropy/baryon (dimensionless)
!   yeplus: positron fraction = 0
!   rel:    relativistic parameter = 0
!-----------------------------------------------------------------------

      pe        = zero
      ek        = zero
      se        = zero
      DO j = 1,nlag
        fact    = wta(j) * xa(j)**1.5
        ek      = ek + fact * fn_a(j)
      END DO
      ue        = etae * t_mev + me
      ek        = ek * t_mev * ye/ne_x_coef
      ee        = ek + ye * me
      pe        = 2.d0 * ek * brydns/3.d0
      se        = ( ee + pe/brydns )/t_mev - ye * ue/t_mev
      yeplus    = zero
      rel       = zero
      RETURN

    END IF ! .not. Failure

  END IF ! .not. Sommerfeld

  IF ( Sommerfeld  .or.  Failure ) THEN

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!        Nonrelativistic Sommerfeld Approximation
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------

    yans        = 3.d0 * pi2 * brydns * ye * ( hbarc**2/( 2.d0 * me * t_mev ) )**1.5
    y           = yans**(tthird)
    dyp         = zero

!-----------------------------------------------------------------------
!  Iterate on y until ffnr(y) = yans
!-----------------------------------------------------------------------

    Failure     = .false.
    DO l = 1,50
      tol       = ( ffnr(y) - yans )/yans
      IF ( DABS(tol) <= 1.d-7 ) EXIT
      dy        = -tol * yans/dfnrdy(y)
      IF ( dy * dyp < zero ) dy = dy/2.d0
      dyp       = dy
      y         = y + dy
      IF ( l == 50 ) Failure = .true.
    END DO

!-----------------------------------------------------------------------
!  Convergence failure? Write memo to unit 6 and continue
!-----------------------------------------------------------------------

    IF ( Failure ) THEN
      WRITE (*,3001)
      WRITE (*,3003) brydns * rmu/cm3fm3, t_mev, ye
      WRITE (*,3005) tol,y,yans**(tthird)
    END IF ! Failure
    
    IF ( .not. Failure ) THEN

!-----------------------------------------------------------------------
!  Convergence success? Compute the rest of the eos functions.
!
!   ee:     electron energy/baryon (including rest mass) [MeV]
!   ek:     electron kinetic energy/baryon [MeV]
!   pe:     electron pressure (MeV fm^{-3})
!   se:     electron entropy/baryon (dimensionless)
!   yeplus: positron fraction = 0
!   rel:    relativistic parameter = 0
!-----------------------------------------------------------------------

      pe        = 2.d0 * t_mev * pnr(y)/( 15.d0 * pi2 ) * ( 2.d0 * me * t_mev/( hbarc**2 ) )**1.5d0
      ek        = 1.5d0 * pe
      ee        = ek/brydns + ye * me
      ue        = y * t_mev + me
      se        = ( ee + pe/brydns - ue * ye )/t_mev
      yeplus    = zero
      rel       = zero

    END IF ! .not. Failure
  END IF ! Sommerfeld  .or.  Failure
END IF ! non_rel

RETURN

CONTAINS

REAL (KIND=double) FUNCTION sq(aa,bb)
REAL (KIND=double) :: aa, bb
sq              = DSQRT( aa * aa + bb * bb * bb )
END FUNCTION sq

REAL (KIND=double) FUNCTION cube(aa,bb)
REAL (KIND=double) :: aa, bb
cube            = ( sq(aa,bb) + aa )**third - ( DMAX1(sq(aa,bb) - aa , zero ) )**third
END FUNCTION cube

REAL (KIND=double) FUNCTION g1(x2)
REAL (KIND=double) :: x2
g1              = half * x2 + 1.644934067d0
END FUNCTION g1

REAL (KIND=double) FUNCTION g3(x2)
REAL (KIND=double) :: x2
g3              = 11.36439395 + x2 * ( 4.9934802201d0 + 0.25d0 * x2 )
END FUNCTION g3

REAL (KIND=double) FUNCTION fexp(xx)
REAL (KIND=double) :: xx
REAL (KIND=double), PARAMETER :: expmax = 300.d0
fexp            = DEXP( DMIN1( expmax, DMAX1( - expmax, xx ) ) )
END FUNCTION fexp

REAL (KIND=double) FUNCTION ffn(xx)
REAL (KIND=double) :: xx
ffn             = xx**3 * ( 1.d0 + pi2/beta2 * (2.d0 * xx * xx + 1.d0 )/( 2.d0 * xx**4 ) &
&               + 7.d0/40.d0 * ( pi2/beta2 )**2/xx**8)
END FUNCTION ffn

REAL (KIND=double) FUNCTION dfndx(xx)
REAL (KIND=double) :: xx
dfndx           = 3.d0 * ffn(xx)/xx + pi2/beta2 * ( 2.d0 - 4.d0 * (2.d0 * xx * xx + 1.d0 )/xx**2)
END FUNCTION dfndx

REAL (KIND=double) FUNCTION ffnr(yy)
REAL (KIND=double) :: yy
ffnr            = yy**1.5d0 * (1.d0 + pi2/(8.d0 * yy**2 ) + 7.d0 * pi4/( 640.d0 * yy**4 ) )
END FUNCTION ffnr

REAL (KIND=double) FUNCTION dfnrdy(yy)
REAL (KIND=double) :: yy
dfnrdy          = DSQRT(yy) * ( 1.d0 - pi2/( 24.d0 * yy**2 ) - 7.d0 * pi4/( 384.d0 * yy**4 ) )
END FUNCTION dfnrdy

REAL (KIND=double) FUNCTION pnr(yy)
REAL (KIND=double) :: yy
pnr             = yy**2.5d0 * ( 1.d0 + 5.d0 * pi2/( 8.d0 * yy**2 ) - 7.d0 * pi4/( 384.d0 * yy**4 ) )
END FUNCTION pnr

REAL (KIND=double) FUNCTION f(xx)
REAL (KIND=double) :: xx
f               = xx * ( 2.d0 * xx * xx - 3.d0 ) * DSQRT( xx * xx + 1.d0 ) &
&               + 3.d0 * DLOG( xx + DSQRT( 1.d0 + xx * xx ) )
END FUNCTION f

REAL (KIND=double) FUNCTION gg(xx)
REAL (KIND=double) :: xx
gg              = 8.d0 * xx**3 * ( DSQRT( xx * xx + 1.d0 ) -1.d0 ) - f(xx)
END FUNCTION gg

END SUBROUTINE e_p_eos
