MODULE B85
!-----------------------------------------------------------------------
!
!    File:         B85.90
!    Module:       B85
!    Type:         Module w/ Functions
!    Author:       R. Chu, Dept. Phys. & Astronomy
!                  U. Tennesee, Knoxville
!
!    Created:      3/31/16
!    WeakLib ver:  
!
!    Purpose:
!      Provides the function need considering the physics in Bruenn 85
!
!   
!
!    CONTAINS:
!    
!
!    Modules used:
!       
!-----------------------------------------------------------------------
  USE wlKindModule, ONLY: dp
  USE wlExtPhysicalConstantsModule, ONLY: &
    kMeV, therm1, therm2, dmnp, me, mbG


  implicit none
   
  PUBLIC totalECapEm

CONTAINS
!========================Function=============================

  PURE REAL(dp) FUNCTION &
    totalECapEm( energy, rho, T, Z, A, chem_e, chem_n, chem_p, xheavy, xn, xp )

    REAL(dp), INTENT(in) :: energy, rho, T, Z, A, chem_e, chem_n, chem_p, &
                            xheavy, xn, xp

    REAL(dp) :: TMeV, n, qpri, nhn, npz, etapn, jnucleon, jnuclear, midFe, &
                            diffrac, difchem, midE

    TMeV = T * kmev                 ! kmev = 8.61733d-11 [MeV K^{-1}]
    N    = A - Z
    qpri = chem_n - chem_p + 3.0_dp ! [MeV] 3MeV: energy of the 1f5/2 level

    if(n.le.34.0)               nhn = 6.0_dp
    if(n.gt.34.0.and.n.le.40.0) nhn = 40.0_dp - N
    if(n.gt.40.0)               nhn = 0.0_dp

    if(z.le.20.0)               npz = 0.0
    if(z.gt.20.0.and.z.le.28.0) npz = z - 20.0
    if(z.gt.28.0)               npz = 8.0
    
    diffrac = xn - xp

 !   difchem = EXP( (chem_n - chem_p) / TMeV ) - 1.0_dp
     difchem = chem_n - chem_p
    etapn = rho * ( xn - xp ) / ( mbG * ( EXP( (chem_n-chem_p)/TMeV ) - 1.0_dp ) )

    midFe = 1.0_dp / ( EXP( (energy+dmnp-chem_e) / TMeV ) + 1.0_dp )
    midE = (energy+dmnp)**2 &
                 * SQRT( 1.0_dp - ( me / (energy+dmnp) )**2 )
!    jnucleon = therm1 * etapn * midE * midFe
    jnucleon = therm1 * etapn * (energy+dmnp)**2 &
                 * SQRT( 1.0_dp - ( me / (energy+dmnp) )**2 ) &
                 / ( EXP( (energy+dmnp-chem_e) / TMeV ) + 1.0_dp )

    jnuclear = therm2 * rho * xheavy * npz * nhn * (energy+qpri)**2 &
                 * SQRT( 1.0_dp - ( me / (energy+qpri) )**2 ) &
                 / ( mbG * a * ( EXP( (energy+qpri-chem_e) / TMeV ) + 1_dp ) )

    totalECapEm = jnucleon + jnuclear
 !    totalECapEm = midE!midFe!etapn

    RETURN
  END FUNCTION totalECapEm

END MODULE B85