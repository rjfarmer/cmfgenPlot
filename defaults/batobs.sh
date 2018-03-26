#!/bin/csh

limit stacksize unlimited

setenv PROG_CMF_OBS   $cmfdist/exe/cmf_flux.exe

# ***********************************************************************
# Perform soft links so Atomic data files can be accessed.
# ***********************************************************************

../batch.sh assign

# ln -sf c2die_tst.dat                             DIEC2
#ln -sf $atomic/CARB/II/14jul98/c2doubdie.dat     DIEC2

ln -sf $atomic/misc/strk_list_lemke_3jan01.dat   FULL_STRK_LIST
ln -sf $atomic/misc/lemke_hi.dat                 LEMKE_HI
ln -sf $atomic/misc/hei_ir_strk.dat              HeI_IR_STRK
ln -sf $atomic/misc/ds_strk.dat                  DS_STRK
ln -sf $atomic/misc/bs_hhe.dat                   BS_HHE
ln -sf $atomic/misc/REVISED_LAMBDAS_9apr08       REVISED_LAMBDAS

# ***********************************************************************
# Copy file across with main settings.
# ***********************************************************************

cp -f CMF_FLUX_PARAM_INIT CMF_FLUX_PARAM


# ***********************************************************************

# Start the job, fist getting the machine name.
# We first do a full spectrum calculations

rm -f batobs.log
rm -f error.log

#
$PROG_CMF_OBS  >>& 'batobs.log'  << END  
../RVTJ            [RVTJ]
XXX            [MASS]
F               [ONLY_OBS_LINES]
END
#

# Clean up the directory structure, removing all
#uneccessary files.
#
mv -f OBSFRAME     obs_fin_10
mv -f HYDRO        hydro_fin_10
mv -f MEANOPAC     meanopac_fin
mv -f TIMING       full_timing
mv -f J_COMP       J_COMP_full
#
#rmlinks
rm -f ES_J_CONV
rm -f TRANS_INFO
rm -f fort.*

#
#*******************************************************************
#
# We will now compute the observed spectrum for Vturb=5.0 km/s
#
rm -f CMF_FLUX_PARAM
#
sed -e "s/10.0D0       \[VTURB_FIX\]/5.0D0        \[VTURB_FIX\]/g" \
    -e "s/10.0D0       \[VTURB_MIN\]/5.0D0        \[VTURB_MIN\]/g" \
    -e "s/F            \[USE_FIXED_J\]/T            \[USE_FIXED_J\]/g" \
CMF_FLUX_PARAM_INIT >  CMF_FLUX_PARAM 

$PROG_CMF_OBS  >>& 'batobs.log'  << END  
../RVTJ            [RVTJ]
XXX            [MASS]
F               [ONLY_OBS_LINES]
END

#
mv -f OBSFRAME     obs_fin_5
mv -f HYDRO        hydro_fin_5
rm -f TRANS_INFO
rm -f J_COMP
rm -f MEANOPAC
rm -f TIMING
rm -f EWDATA
rm -f fort.*
#
#*******************************************************************
#
# We will now compute the observed spectrum for Vturb=15.0 km/s
#
rm -f CMF_FLUX_PARAM
#
sed -e "s/15.0D0       \[VTURB_FIX\]/15.0D0        \[VTURB_FIX\]/g" \
    -e "s/15.0D0       \[VTURB_MIN\]/15.0D0        \[VTURB_MIN\]/g" \
    -e "s/F            \[USE_FIXED_J\]/T            \[USE_FIXED_J\]/g" \
CMF_FLUX_PARAM_INIT >  CMF_FLUX_PARAM 

$PROG_CMF_OBS  >>& 'batobs.log'  << END  
../RVTJ            [RVTJ]
XXX            [MASS]
F               [ONLY_OBS_LINES]
END
#
echo "Program finished on:" >> 'batobs.log'
date >> 'batobs.log'

#
mv -f OBSFRAME     obs_fin_15
mv -f HYDRO        hydro_fin_15
rm -f TRANS_INFO
rm -f J_COMP
rm -f MEANOPAC
rm -f TIMING
rm -f EWDATA
rm -f fort.*

mv -f EDDFACTOR  EDDFACTOR_10
mv -f EDDFACTOR_INFO EDDFACTOR_INFO_10

#
#*******************************************************************
#
# Now we will compute the continuum. We first need to edit the CMF
# param file.
#
rm -f CMF_FLUX_PARAM
#
sed -e "s/2            \[NUM_ES\]/1            \[NUM_ES\]/g" \
    -e "s/F            \[DO_SOB_LINES\]/F            \[DO_SOB_LINES\]/g" \
    -e "s/BLANK        \[GLOBAL_LINE\]/SOB          \[GLOBAL_LINE\]/g" \
CMF_FLUX_PARAM_INIT >  CMF_FLUX_PARAM 

$PROG_CMF_OBS  >>& 'batobs.log'  << END  
../RVTJ            [RVTJ]
XXX             [MASS]
F               [ONLY_OBS_LINES]
END

#
# Clean up the directory structure, removing all
#uneccessary files.
#
mv -f OBSFRAME     obs_cont
mv -f TIMING       cont_timing
mv -f EWDATA       ewdata_fin
mv -f HYDRO        hydro_cont
#
#rmlinks
find -type l -delete
rm -f EDDFACTOR
rm -f ES_J_CONV
rm -f EDDFACTOR_INFO
rm -f ES_J_CONV_INFO
rm -f TRANS_INFO
rm -f J_COMP
rm -f MEANOPAC
#rm -f HYDRO
#rm -f fort.*
#
#  $NEXT_JOB &
