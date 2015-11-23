PROGRAM wlDependentVariablesTest
 
  USE wlDependentVariablesModule
  USE HDF5
  USE wlThermoStateModule
  USE wlEquationOfStateTableModule
  USE wlIOModuleHDF, ONLY: InitializeHDF, OpenFileHDF, OpenGroupHDF,         &
                           WriteDependentVariablesHDF, CloseGroupHDF,        & 
                           ReadDependentVariablesHDF, CloseFileHDF,          &
                           FinalizeHDF, ReadDimensionsHDF,                   &
                           ReadDependentVariablesHDF, ReadNumberVariablesHDF
  implicit none

  INTEGER :: i
  INTEGER, DIMENSION(3) :: nPoints
  INTEGER, DIMENSION(3) :: nPoints2
  INTEGER :: nVariables
  INTEGER :: nVariables2
  INTEGER :: j
  TYPE(DependentVariablesType) :: DV
  TYPE(DependentVariablesType) :: DV2
  INTEGER(HID_T) :: file_id
  INTEGER(HID_T) :: group_id

print*,"1"

  nPoints = (/10,10,10/)
  nVariables = 13
  CALL AllocateDependentVariables( DV, nPoints , nVariables )

  DV % nPoints(1:3) = nPoints(1:3)
  DV % nVariables = nVariables

print*,"2"

  DV % Names(1:13) = (/'Pressure                        ', &
                       'Entropy Per Baryon              ', &
                       'Internal Energy Density         ', &
                       'Electron Chemical Potential     ', &
                       'Proton Chemical Potential       ', &
                       'Neutron Chemical Potential      ', &
                       'Proton Mass Fraction            ', &
                       'Neutron Mass Fraction           ', &
                       'Alpha Mass Fraction             ', &
                       'Heavy Mass Fraction             ', &
                       'Heavy Charge Number             ', &
                       'Heavy Mass Number               ', &
                       'Heavy Binding Energy            '/)               

  DV % Units(1:13) = (/'Dynes per cm^2                  ', &
                       'k_b per baryon                  ', &
                       'erg per gram                    ', &
                       'MeV                             ', &
                       'MeV                             ', &
                       'MeV                             ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       'MeV                             '/)

print*,"3"

  DO i = 1, SIZE( DV % Variables )
    WRITE (*,*) SHAPE( DV % Variables(i) % Values )
  END DO

  DO i = 1, SIZE( DV % Variables )
    DV % Variables(i) % Values = i 
  END DO

print*,"4"

  CALL InitializeHDF( )
  CALL OpenFileHDF( "DependentVariablesFile.h5", .true., file_id )
  CALL OpenGroupHDF( "DependentVariables", .true., file_id, group_id )
  CALL WriteDependentVariablesHDF( DV, group_id )
  CALL CloseGroupHDF( group_id )
  CALL CloseFileHDF( file_id )
  CALL DeAllocateDependentVariables( DV )

print*,"5"

  CALL OpenFileHDF( "DependentVariablesFile.h5", .false., file_id )
  CALL OpenGroupHDF( "DependentVariables", .false., file_id, group_id )
  CALL ReadDimensionsHDF( nPoints2, group_id )
  CALL ReadNumberVariablesHDF( nVariables2, group_id )
  CALL AllocateDependentVariables( DV2, nPoints2, nVariables2 )

print*, "6"

  DV2 % nPoints(1:3) = nPoints2(1:3)
  DV2 % nVariables = nVariables2
  DV2 % Units(1:13) = (/'Dynes per cm^2                  ', &
                       'k_b per baryon                  ', &
                       'erg per gram                    ', &
                       'MeV                             ', &
                       'MeV                             ', &
                       'MeV                             ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       '                                ', &
                       'MeV                             '/)
  CALL ReadDependentVariablesHDF( DV2, file_id )
  !CALL ReadDimensionsHDF( nPoints2, group_id )


  !CALL ReadDependentVariablesHDF( DV2, group_id )
  !CALL CloseGroupHDF( group_id )
  CALL CloseFileHDF( file_id )

  DO j = 1,12
    WRITE(*,*)
    WRITE(*,*) TRIM( DV2 % Names(j) ) , j
    WRITE(*,*)
    WRITE(*,*) DV2 % Variables(j) % Values(:,:,:)
    WRITE(*,*)
  END DO

  CALL DeAllocateDependentVariables( DV2 )

  CALL FinalizeHDF( )
 
END PROGRAM wlDependentVariablesTest