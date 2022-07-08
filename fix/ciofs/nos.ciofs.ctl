# control files for CIOFS, which is read in by shell script 

export DBASE_MET_NOW=NAM
export DBASE_MET_FOR=NAM
export DBASE_WL_NOW=ETSS
export DBASE_WL_FOR=ETSS
export DBASE_TS_NOW=RTOFS
export DBASE_TS_FOR=RTOFS

export OCEAN_MODEL=ROMS
export LEN_FORECAST=48
export IGRD_MET=0
export IGRD_OBC=2
 export BASE_DATE=2016010100
export TIME_START=2016010100
export MINLON=-157.0
export MINLAT=56.0
export MAXLON=-148.0 
export MAXLAT=62.0
export THETA_S=4.5d0                     
export THETA_B=0.91d0                    
export TCLINE=10.0d0
export NVTRANS=1
export NVSTR=1
export SCALE_HFLUX=1.0 
export CREATE_TIDEFORCING=1
########################################################
##  static input file name, do not include path name
########################################################
export GRIDFILE=nos.ciofs.romsgrid.nc
export HC_FILE_OBC=nos.ciofs.HC.nc 
export HC_FILE_OFS=nos.ciofs.roms.tides.nc 
export RIVER_CTL_FILE=nos.ciofs.river.ctl
export RIVER_CLIM_FILE=nos.ofs.river.clim.usgs.nc
export OBC_CTL_FILE=nos.ciofs.obc.ctl
export OBC_CLIM_FILE=nos.ofs.clim.WOA05.nc
export STA_OUT_CTL=nos.ciofs.stations.in
export RUNTIME_CTL=nos.ciofs.roms.in
export VARINFOFILE_ROMS=nos.ofs.roms.varinfo.dat
export HC_FILE_NWLON=nos.ofs.HC_NWLON.nc
export VGRID_CTL=nos.ciofs.vgrid.in
########################################################
# parameters for ROMS RUN
#########################################################
export IM=724
export JM=1044
export KBm=30
export DELT_MODEL=4
export NDTFAST=10
export NRST=21600
export NSTA=360
export NFLT=3600
export NHIS=3600
export NQCK=0
export NDEFQCK=0
export NAVG=3600
export RDRG=0.0d0
export RDRG2=0.0d0
export Zob=0.01d0
export TNU2=" 3.0d0  3.0d0                    ! m2/s"
export VISC2=10.0d0
export VISC4=0.0d0
export AKT_BAK="1.0d-6 1.0d-6 !m2/s"                   
export AKV_BAK="1.0d-5   !m2/s"                         
export AKK_BAK="5.0d-6   !m2/s"                        
export AKP_BAK="5.0d-6   !m2/s "                       
export DCRIT="0.30d0     !m"                 
export DSTART=151.0d0
export TIDE_START=0.0d0
export N_PROC=60
#export NTILE_I=24
#export NTILE_J=32
#export TOTAL_TASKS=768
export NTILE_I=24
export NTILE_J=34
export TOTAL_TASKS=$(($NTILE_I*$NTILE_J))
#export NTILE_I=10
#export NTILE_J=32
#export TOTAL_TASKS=320
export BIO_MODULE=0
# #############################################################
# GLOSSARY
# #############################################################
# GRIDFILE    :ocean model grid netCDF file including lon, lat, depth, etc.
# DBASE       :Name of NCEP atmospheric operational products, e.g. NAM, GFS, RTMA, NDFD, etc.
# DBASE_MET_NOW : Data source Name of NCEP atmospheric operational products for Nowcast run.
# DBASE_MET_FOR : Data source Name of NCEP atmospheric operational products for Forecast run.
# DBASE_WL_NOW  : Data source Name of water level open boundary conditions for Nowcast run.
# DBASE_WL_FOR  : Data source Name of water level open boundary conditions for Forecast run.
# DBASE_TS_NOW  : Data source Name of T & S open boundary conditions for Nowcast run.
# DBASE_TS_FOR  : Data source Name of T & S open boundary conditions for Forecast run.
# OCEAN_MODEL :Name of Hydrodynamic Ocean Model, e.g. ROMS, FVCOM, SELFE, etc.
# LEN_FORECAST:Forecast length of OFS forecast cycle.
# IGRD_MET    :spatial interpolation method for atmospheric forcing fields
#           =0:on native grid of NCEP products with wind rotated to earth coordinates
#	    =1:on ocean model grid (rotated to local coordinates) interpolated using remesh routine.
#	    =2:on ocean model grid (rotated to local coordinates) interpolated using bicubic routine.
#	    =3:on ocean model grid (rotated to local coordinates) interpolated using bilinear routine.
#           =4:on ocean model grid (rotated to local coordinates) interpolated using nature neighbors routine.
# IGRD_OBC    :spatial interpolation method for ocean open boundary forcing fields
# BASE_DATE   :base date for the OFS time system, e.g. YYYYMMDDHH (2008010100)
# TIME_START  :forecast start time/current time, e.g. 2008110600
# MINLON      :longitude of lower left/southwest corner to cover the OFS domain
# MINLAT      :latitude of lower left /southwest corner to cover the OFS domain
# MAXLON      :longitude of upper right/northeast corner to cover the OFS domain
# MAXLAT      :latitude of  upper right/northeast corner to cover the OFS domain
# THETA_S     :S-coordinate surface control parameter, [0 < theta_s < 20].
# THETA_B     :S-coordinate bottom  control parameter, [0 < theta_b < 1].
# TCLINE      :Width (m) of surface or bottom boundary layer in which
#             :higher vertical resolution is required during stretching.
# SCALE_HFLUX :scaling factor (fraction) of surface heat flux (net short-wave and downward
#              long-wave radiation). if =1.0, no adjustment to atmospheric products.  
# CREATE_TIDEFORCING : > 0, generate tidal forcing file
# HC_FILE_ADCIRC     : ADCIRC EC2001 harmonic constant file 
# HC_FILE_ROMS     : Tidal forcing file of ROMS (contains tide constituents of WL, ubar, and vbar) 
# EL_HC_CORRECTION   : > 0, correction elevation harmonics with user provided data
# FILE_EL_HC_CORRECTION : file name contains elevation harmonics for correction                
# RIVER_CTL_FILE  : File name contains river attributes (Xpos, Epos, Flag, River name,etc.)
# OBC_CTL_FILE  : Control file name for generating open boundary conditions (WL, T and S).
# IM          :GRID Number of I-direction RHO-points, it is xi_rho for ROMS
# JM          :GRID Number of J-direction RHO-points, it is eta_rho for ROMS
# DELT_ROMS   :Time-Step size in seconds.  If 3D configuration, DT is the
#              size of baroclinic time-step.  If only 2D configuration, DT
#              is the size of the barotropic time-step.
#  NDTFAST     Number of barotropic time-steps between each baroclinic time
#              step. If only 2D configuration, NDTFAST should be unity since
#              there is not need to splitting time-stepping.
# KBm         :Number of vertical levels at temperature points of OFS
#  NRST        Number of time-steps between writing of re-start fields.
#
#  NSTA        Number of time-steps between writing data into stations file.
#              Station data is written at all levels.
#
#  NFLT        Number of time-steps between writing data into floats file.
#  NHIS        Number of time-steps between writing fields into history file.
#
#  RDRG2       Quadratic bottom drag coefficient.
#
#  Zob         Bottom roughness (m).
#  AKT_BAK     Background vertical mixing coefficient (m2/s) for active
#              (NAT) and inert (NPT) tracer variables.
#  AKV_BAK     Background vertical mixing coefficient (m2/s) for momentum.
#
#  AKK_BAK     Background vertical mixing coefficient (m2/s) for turbulent
#              kinetic energy.
#
#  AKP_BAK     Background vertical mixing coefficient (m2/s) for turbulent
#              generic statistical field, "psi".
#
#  TKENU2      Lateral, harmonic, constant, mixing coefficient (m2/s) for
#              turbulent closure variables.
#
#  TKENU4      Lateral, biharmonic, constant mixing coefficient (m4/s) for
#              turbulent closure variables.
#  DCRIT       Minimum depth (m) for wetting and drying.
#  DSTART      Time stamp assigned to model initialization (days).  Usually
#              a Calendar linear coordinate, like modified Julian Day.  For
#              Example:
#  TIDE_START  Reference time origin for tidal forcing (days). This is the
#              time used when processing input tidal model data. It is needed
#              in routine "set_tides" to compute the correct phase lag with
#              respect ROMS/TOMS initialization time.
# N_PROC       Number of computer processors to run parallel ocean model
# TOTAL_TASKS  Total tasks to be run
#  NTILE_I     Number of domain partitions in the I-direction (XI-coordinate).
#              It must be equal or greater than one.
#
#  NTILE_J     Number of domain partitions in the J-direction (ETA-coordinate).
#              It must be equal or greater than one.
