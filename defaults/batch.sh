#!/bin/tcsh
#
#**********************************************************************
#   Define directories (CAPITAL LETTERS)
#**********************************************************************
#
# HOME is disk
# MODEL is model directory
# ATOMIC is atomic data directory
#

setenv CMFGEN_PROG   $cmfdist/exe/cmfgen_dev.exe

#
#***********************************************************************
#    Atomic data soft links. All other shell commands should be
#    place after these links. These links are model dependent. Ther
#    are required by CMFGEN, CMF_FLUX, and DISPGEN
#
#    When N_F=N_S, no F_TO_S link is needed.
#***********************************************************************

#*****************************************************************************
# Generic
# -------
 #*****************************************************************************

 ln -sf  $ATOMIC/misc/two_phot_data.dat                     TWO_PHOT_DATA
 ln -sf  $ATOMIC/misc/xray_phot_fits.dat                    XRAY_PHOT_FITS
 ln -sf  $ATOMIC/misc/rs_xray_fluxes_sol.dat                 RS_XRAY_FLUXES
 ln -sf  $ATOMIC/HYD/I/5dec96/hyd_l_data.dat                HYD_L_DATA
 ln -sf  $ATOMIC/HYD/I/5dec96/gbf_n_data.dat                GBF_N_DATA

#*****************************************************************************
#    Hydrogen
#   ----------
#*****************************************************************************
#
 ln -sf  $ATOMIC/HYD/I/5dec96/hiphot.dat                   PHOTHI_A
 ln -sf  $ATOMIC/HYD/I/5dec96/hi_osc.dat                   HI_F_OSCDAT
 ln -sf  $ATOMIC/HYD/I/5dec96/hi_f_to_s_15.dat             HI_F_TO_S
 ln -sf  $ATOMIC/HYD/I/5dec96/hicol.tlusty                 HI_COL_DATA

#*****************************************************************************
#    Helium
#   --------
#*****************************************************************************
 ln -sf  $ATOMIC/HE/II/5dec96/he2phot.dat                  PHOTHe2_A
 ln -sf  $ATOMIC/HE/II/5dec96/he2_osc.dat                  He2_F_OSCDAT
 ln -sf  $ATOMIC/HE/II/5dec96/he2_f_to_s_22.dat            He2_F_TO_S
 ln -sf  $ATOMIC/HE/II/5dec96/he2col.dat                   He2_COL_DATA
#
 ln -sf  $ATOMIC/HE/I/5dec96/heiphot_a7.dat                PHOTHeI_A
 ln -sf  $ATOMIC/HE/I/5dec96/heioscdat_a7.dat              HeI_F_OSCDAT
 ln -sf  $ATOMIC/HE/I/5dec96/hei_f_to_s_a7_ext.dat            HeI_F_TO_S
 ln -sf  $ATOMIC/HE/I/5dec96/heicol.dat                    HeI_COL_DATA

#*****************************************************************************
#    Carbon
#   --------
#*****************************************************************************

 ln -sf  $ATOMIC/CARB/II/tst/phot_sm_100.dat            PHOTC2_A
 ln -sf  $ATOMIC/CARB/II/tst/phot_data_B.dat            PHOTC2_B
 ln -sf  $ATOMIC/CARB/II/tst/c2osc_rev.dat              C2_F_OSCDAT
 ln -sf  $ATOMIC/CARB/II/tst/c2col.dat                  C2_COL_DATA
 ln -sf  $ATOMIC/CARB/II/tst/f_to_s_104.dat             C2_F_TO_S
 ln -sf  $ATOMIC/CARB/II/tst/c2_auto.dat                C2_AUTO_DATA

 ln -sf  $ATOMIC/CARB/III/23dec04/ciiiphot_sm_a_500.dat      PHOTCIII_A
 ln -sf  $ATOMIC/CARB/III/23dec04/ciiiphot_sm_b_500.dat      PHOTCIII_B
 ln -sf  $ATOMIC/CARB/III/23dec04/ciiiosc_st_split_big.dat   CIII_F_OSCDAT
 ln -sf  $ATOMIC/CARB/III/23dec04/ciii_f_to_s_split_big.dat  CIII_F_TO_S
 ln -sf  $ATOMIC/CARB/III/23dec04/ciiicol.dat                CIII_COL_DATA
 ln -sf  $ATOMIC/CARB/III/23dec04/dieciii_ic.dat             DIECIII

 ln -sf  $ATOMIC/CARB/IV/5dec96/civphot_a12.dat            PHOTCIV_A
 ln -sf  $ATOMIC/CARB/IV/5dec96/civosc_a12_split.dat       CIV_F_OSCDAT
 ln -sf  $ATOMIC/CARB/IV/5dec96/civ_f_to_s_split.dat       CIV_F_TO_S
 ln -sf  $ATOMIC/CARB/IV/5dec96/civcol.dat                 CIV_COL_DATA

#*****************************************************************************
#    Nitrogen
#   ----------
#*****************************************************************************

 ln -sf  $ATOMIC/NIT/II/23jan06/phot_nosm_A                PHOTN2_A
 ln -sf  $ATOMIC/NIT/II/23jan06/phot_sm_B                  PHOTN2_B
 ln -sf  $ATOMIC/NIT/II/23jan06/fin_osc                    N2_F_OSCDAT
 ln -sf  $ATOMIC/NIT/II/23jan06/n2col.dat                  N2_COL_DATA
 ln -sf  $ATOMIC/NIT/II/23jan06/f_to_s_ls                  N2_F_TO_S

 ln -sf  $ATOMIC/NIT/III/20jun01/phot_sm_3000.dat          PHOTNIII_A
 ln -sf  $ATOMIC/NIT/III/20jun01/phot_data_B.dat           PHOTNIII_B
 ln -sf  $ATOMIC/NIT/III/20jun01/niiiosc_rev.dat           NIII_F_OSCDAT
 ln -sf  $ATOMIC/NIT/III/20jun01/niiicol.dat               NIII_COL_DATA
 ln -sf  $ATOMIC/NIT/III/20jun01/f_to_s_ls_231.dat         NIII_F_TO_S

 ln -sf  $ATOMIC/NIT/IV/22sep05/PHOTNIV_A                  PHOTNIV_A
 ln -sf  $ATOMIC/NIT/IV/22sep05/PHOTNIV_B                  PHOTNIV_B
 ln -sf  $ATOMIC/NIT/IV/22sep05/nivosc                     NIV_F_OSCDAT
 ln -sf  $ATOMIC/NIT/IV/22sep05/f_to_s_ls                  NIV_F_TO_S
 ln -sf  $ATOMIC/NIT/IV/22sep05/nivcol                     NIV_COL_DATA
 ln -sf  $ATOMIC/NIT/IV/22sep05/nivdie                     DIENIV

 ln -sf  $ATOMIC/NIT/V/5dec96/nvphot_a12.dat               PHOTNV_A
 ln -sf  $ATOMIC/NIT/V/5dec96/nvosc_a12_split.dat          NV_F_OSCDAT
 ln -sf  $ATOMIC/NIT/V/5dec96/nv_f_to_s_split_sm.dat       NV_F_TO_S
 ln -sf  $ATOMIC/NIT/V/5dec96/nvcol.dat                    NV_COL_DATA

#*****************************************************************************
#    Oxygen
#   --------
#*****************************************************************************

 ln -sf  $ATOMIC/OXY/II/23mar05/o2osc_fin.dat              O2_F_OSCDAT
 ln -sf  $ATOMIC/OXY/II/23mar05/f_to_s_137.dat             O2_F_TO_S
 ln -sf  $ATOMIC/OXY/II/23mar05/phot_sm_0                  PHOTO2_A
 ln -sf  $ATOMIC/OXY/II/23mar05/o2col.dat                  O2_COL_DATA

 ln -sf  $ATOMIC/OXY/III/15mar08/oiiiosc                   OIII_F_OSCDAT
 ln -sf  $ATOMIC/OXY/III/15mar08/phot_sm_0                 PHOTOIII_A
 ln -sf  $ATOMIC/OXY/III/15mar08/f_to_s_165                OIII_F_TO_S
 ln -sf  $ATOMIC/OXY/III/15mar08/col_data.dat              OIII_COL_DATA

 ln -sf  $ATOMIC/OXY/IV/19nov07/phot_sm_50_A               PHOTOIV_A
 ln -sf  $ATOMIC/OXY/IV/19nov07/phot_sm_50_B               PHOTOIV_B
 ln -sf  $ATOMIC/OXY/IV/19nov07/fin_osc                    OIV_F_OSCDAT
 ln -sf  $ATOMIC/OXY/IV/19nov07/f_to_s_220                 OIV_F_TO_S
 ln -sf  $ATOMIC/OXY/IV/19nov07/col_oiv                    OIV_COL_DATA

 ln -sf  $ATOMIC/OXY/V/5dec96/ovphot_a.dat                 PHOTOV_A
 ln -sf  $ATOMIC/OXY/V/5dec96/ovphot_b.dat                 PHOTOV_B
 ln -sf  $ATOMIC/OXY/V/5dec96/ovosc_ns_split.dat           OV_F_OSCDAT
 ln -sf  $ATOMIC/OXY/V/5dec96/ov_f_to_s_split_ext.dat      OV_F_TO_S
 ln -sf  $ATOMIC/OXY/V/5dec96/ovcol.dat                    OV_COL_DATA
 ln -sf  $ATOMIC/OXY/V/5dec96/ovdie.dat                    DIEOV
#
 ln -sf  $ATOMIC/OXY/VI/5dec96/osixphot_a12.dat            PHOTOSIX_A
 ln -sf  $ATOMIC/OXY/VI/5dec96/osixosc_a12_split.dat       OSIX_F_OSCDAT
 ln -sf  $ATOMIC/OXY/VI/5dec96/osix_f_to_s_split.dat       OSIX_F_TO_S
 ln -sf  $ATOMIC/OXY/VI/5dec96/osixcol.dat                 OSIX_COL_DATA

#*****************************************************************************
# Neon
# ----
#*****************************************************************************

 ln -sf  $ATOMIC/NEON/II/1dec99/phot_sm_3000.dat           PHOTNe2_A
 ln -sf  $ATOMIC/NEON/II/1dec99/fin_osc.dat                Ne2_F_OSCDAT
 ln -sf  $ATOMIC/NEON/II/1dec99/f_to_s_42.dat              Ne2_F_TO_S
 ln -sf  $ATOMIC/NEON/II/1dec99/col_data.dat               Ne2_COL_DATA

 ln -sf  $ATOMIC/NEON/III/19nov07/phot_nosm                PHOTNeIII_A
 ln -sf  $ATOMIC/NEON/III/19nov07/fin_osc                  NeIII_F_OSCDAT
 ln -sf  $ATOMIC/NEON/III/19nov07/f_to_s_57                NeIII_F_TO_S
 ln -sf  $ATOMIC/NEON/III/19nov07/col_neiii                NeIII_COL_DATA

 ln -sf  $ATOMIC/NEON/IV/1dec99/phot_sm_3000.dat           PHOTNeIV_A
 ln -sf  $ATOMIC/NEON/IV/1dec99/fin_osc.dat                NeIV_F_OSCDAT
 ln -sf  $ATOMIC/NEON/IV/1dec99/f_to_s_45.dat              NeIV_F_TO_S
 ln -sf  $ATOMIC/NEON/IV/1dec99/col_data.dat               NeIV_COL_DATA

 ln -sf  $ATOMIC/NEON/V/20jun01/phot_sm_3000.dat             PHOTNeV_A
 ln -sf  $ATOMIC/NEON/V/20jun01/nevosc_rev.dat               NeV_F_OSCDAT
 ln -sf  $ATOMIC/NEON/V/20jun01/f_to_s_60.dat                NeV_F_TO_S
 ln -sf  $ATOMIC/NEON/V/20jun01/col_data.dat                 NeV_COL_DATA

 ln -sf  $ATOMIC/NEON/VI/20jun01/phot_sm_3000.dat           PHOTNeSIX_A
 ln -sf  $ATOMIC/NEON/VI/20jun01/neviosc_rev.dat            NeSIX_F_OSCDAT
 ln -sf  $ATOMIC/NEON/VI/20jun01/f_to_s_43.dat              NeSIX_F_TO_S
 ln -sf  $ATOMIC/NEON/VI/20jun01/col_data.dat               NeSIX_COL_DATA

 ln -sf  $ATOMIC/NEON/VII/20jun01/phot_sm_3000.dat          PHOTNeSEV_A
 ln -sf  $ATOMIC/NEON/VII/20jun01/neviiosc_rev.dat          NeSEV_F_OSCDAT
 ln -sf  $ATOMIC/NEON/VII/20jun01/f_to_s_46.dat             NeSEV_F_TO_S
 ln -sf  $ATOMIC/NEON/VII/20jun01/col_data.dat              NeSEV_COL_DATA

 ln -sf  $ATOMIC/NEON/VIII/20jun01/phot_sm_3000.dat         PHOTNeVIII_A
 ln -sf  $ATOMIC/NEON/VIII/20jun01/neviiiosc_rev.dat        NeVIII_F_OSCDAT
 ln -sf  $ATOMIC/NEON/VIII/20jun01/f_to_s_29.dat            NeVIII_F_TO_S
 ln -sf  $ATOMIC/NEON/VIII/20jun01/col_guess.dat            NeVIII_COL_DATA



#*****************************************************************************
# Sodium
#--------
#*****************************************************************************
 ln -sf $ATOMIC/NA/I/5aug97/nai_osc_split.dat     NaI_F_OSCDAT
 ln -sf $ATOMIC/NA/I/5aug97/nai_phot_a.dat        PHOTNaI_A
 ln -sf $ATOMIC/NA/I/5aug97/col_guess.dat         NaI_COL_DATA
 ln -sf $ATOMIC/NA/I/5aug97/nai_f_to_s_sm.dat     NaI_F_TO_S

 ln -sf  $ATOMIC/NA/II/15feb01/phot_data.dat              PHOTNa2_A
 ln -sf  $ATOMIC/NA/II/15feb01/na2_osc.dat                Na2_F_OSCDAT
 ln -sf  $ATOMIC/NA/II/15feb01/f_to_s_ls_21.dat           Na2_F_TO_S
 ln -sf  $ATOMIC/NA/II/15feb01/col_guess.dat              Na2_COL_DATA

 ln -sf  $ATOMIC/NA/III/15feb01/phot_sm_3000.dat          PHOTNaIII_A
 ln -sf  $ATOMIC/NA/III/15feb01/naiiiosc_rev.dat          NaIII_F_OSCDAT
 ln -sf  $ATOMIC/NA/III/15feb01/f_to_s_26.dat             NaIII_F_TO_S
 ln -sf  $ATOMIC/NA/III/15feb01/col_guess.dat             NaIII_COL_DATA
#
 ln -sf  $ATOMIC/NA/IV/15feb01/phot_sm_3000.dat           PHOTNaIV_A
 ln -sf  $ATOMIC/NA/IV/15feb01/naivosc_rev.dat            NaIV_F_OSCDAT
 ln -sf  $ATOMIC/NA/IV/15feb01/f_to_s_41.dat              NaIV_F_TO_S
 ln -sf  $ATOMIC/NA/IV/15feb01/col_data.dat               NaIV_COL_DATA
#
 ln -sf  $ATOMIC/NA/V/20jun01/phot_data.dat               PHOTNaV_A
 ln -sf  $ATOMIC/NA/V/20jun01/pvosc_rev.dat               NaV_F_OSCDAT
 ln -sf  $ATOMIC/NA/V/20jun01/f_to_s_16.dat               NaV_F_TO_S
 ln -sf  $ATOMIC/NA/V/20jun01/col_guess.dat               NAV_COL_DATA
#
 ln -sf  $ATOMIC/NA/VI/20jun01/phot_op.dat                PHOTNaSIX_A
 ln -sf  $ATOMIC/NA/VI/20jun01/osc_op.dat                 NaSIX_F_OSCDAT
 ln -sf  $ATOMIC/NA/VI/20jun01/f_to_s_25.dat              NaSIX_F_TO_S
 ln -sf  $ATOMIC/NA/VI/20jun01/col_guess.dat             NaSIX_COL_DATA

#*****************************************************************************
# Magnesium
#-----------
#*****************************************************************************
ln -sf $ATOMIC/MG/I/5aug97/mgi_osc_split.dat     MgI_F_OSCDAT
ln -sf $ATOMIC/MG/I/5aug97/mgi_phot_a.dat        PHOTMgI_A
ln -sf $ATOMIC/MG/I/5aug97/mgicol.dat            MgI_COL_DATA
ln -sf $ATOMIC/MG/I/5aug97/mgi_f_to_s_sm.dat     MgI_F_TO_S
#
ln -sf $ATOMIC/MG/II/5aug97/mg2_osc_split.dat    Mg2_F_OSCDAT
ln -sf $ATOMIC/MG/II/5aug97/mg2_phot_a.dat       PHOTMg2_A
ln -sf $ATOMIC/MG/II/5aug97/mg2col.dat           Mg2_COL_DATA
ln -sf $ATOMIC/MG/II/5aug97/mg2_f_to_s_sm.dat    Mg2_F_TO_S
#
#*****************************************************************************
#   Aluminium
#   --------
#*****************************************************************************
ln -sf $ATOMIC/AL/II/5aug97/al2_osc_split.dat    Al2_F_OSCDAT
ln -sf $ATOMIC/AL/II/5aug97/al2_phot_a.dat       PHOTAl2_A
ln -sf $ATOMIC/AL/II/5aug97/al2col.dat           Al2_COL_DATA
ln -sf $ATOMIC/AL/II/5aug97/al2_f_to_s_sm.dat    Al2_F_TO_S

ln -sf  $ATOMIC/AL/III/5aug97/aliii_phot_a.dat            PHOTAlIII_A
ln -sf  $ATOMIC/AL/III/5aug97/aliii_osc_split.dat         AlIII_F_OSCDAT
ln -sf  $ATOMIC/AL/III/5aug97/aliii_f_to_s_sm.dat         AlIII_F_TO_S
ln -sf  $ATOMIC/AL/III/5aug97/col_guess.dat               AlIII_COL_DATA

#*****************************************************************************
#    Silicon
#   --------
#*****************************************************************************

 ln -sf  $ATOMIC/SIL/III/5dec96b/phot_op.dat               PHOTSkIII_A
 ln -sf  $ATOMIC/SIL/III/5dec96b/osc_op_split_rev.dat      SkIII_F_OSCDAT
 ln -sf  $ATOMIC/SIL/III/5dec96b/f_to_s_split.dat          SkIII_F_TO_S
 ln -sf  $ATOMIC/SIL/III/5dec96b/col_data                  SkIII_COL_DATA

 ln -sf  $ATOMIC/SIL/IV/5dec96/phot_op.dat                 PHOTSkIV_A
 ln -sf  $ATOMIC/SIL/IV/5dec96/osc_op_split.dat            SkIV_F_OSCDAT
 ln -sf  $ATOMIC/SIL/IV/5dec96/f_to_s_split.dat            SkIV_F_TO_S
 ln -sf  $ATOMIC/SIL/IV/5dec96/col_guess.dat               SkIV_COL_DATA

#*****************************************************************************
# Phosphorous 
# -------
#*****************************************************************************
 ln -sf  $ATOMIC/PHOS/III/15feb01/phot_data.dat             PHOTPIII_A
 ln -sf  $ATOMIC/PHOS/III/15feb01/osc_op.dat                PIII_F_OSCDAT
 ln -sf  $ATOMIC/PHOS/III/15feb01/f_to_s_36.dat             PIII_F_TO_S
 ln -sf  $ATOMIC/PHOS/III/15feb01/col_guess.dat             PIII_COL_DATA
#
 ln -sf  $ATOMIC/PHOS/IV/15feb01/phot_data_a.dat            PHOTPIV_A
 ln -sf  $ATOMIC/PHOS/IV/15feb01/phot_data_b.dat            PHOTPIV_B
 ln -sf  $ATOMIC/PHOS/IV/15feb01/pivosc_rev.dat             PIV_F_OSCDAT
 ln -sf  $ATOMIC/PHOS/IV/15feb01/f_to_s_36.dat              PIV_F_TO_S
 ln -sf  $ATOMIC/PHOS/IV/15feb01/col_guess.dat              PIV_COL_DATA
#
 ln -sf  $ATOMIC/PHOS/V/15feb01/phot_data.dat               PHOTPV_A
 ln -sf  $ATOMIC/PHOS/V/15feb01/pvosc_rev.dat               PV_F_OSCDAT
 ln -sf  $ATOMIC/PHOS/V/15feb01/f_to_s_16.dat               PV_F_TO_S
 ln -sf  $ATOMIC/PHOS/V/15feb01/col_guess.dat               PV_COL_DATA
#
 ln -sf  $ATOMIC/PHOS/VI/15feb01/phot_op.dat                PHOTPSIX_A
 ln -sf  $ATOMIC/PHOS/VI/15feb01/osc_op.dat                 PSIX_F_OSCDAT
 ln -sf  $ATOMIC/PHOS/VI/15feb01/f_to_s_25.dat              PSIX_F_TO_S
 ln -sf  $ATOMIC/PHOS/VI/15feb01/col_guess.dat              PSIX_COL_DATA

#*****************************************************************************
# Sulpher
# -------
#*****************************************************************************

 ln -sf  $ATOMIC/SUL/III/19nov07/phot_nosm                PHOTSIII_A
 ln -sf  $ATOMIC/SUL/III/19nov07/siiiosc_fin              SIII_F_OSCDAT
 ln -sf  $ATOMIC/SUL/III/19nov07/f_to_s_127               SIII_F_TO_S
 ln -sf  $ATOMIC/SUL/III/19nov07/col_siii                 SIII_COL_DATA

 ln -sf  $ATOMIC/SUL/IV/19nov07/phot_nosm                 PHOTSIV_A
 ln -sf  $ATOMIC/SUL/IV/19nov07/sivosc_fin                SIV_F_OSCDAT
 ln -sf  $ATOMIC/SUL/IV/19nov07/f_to_s_69                 SIV_F_TO_S
 ln -sf  $ATOMIC/SUL/IV/19nov07/col_siv                   SIV_COL_DATA

 ln -sf  $ATOMIC/SUL/V/3oct00/phot_sm_3000.dat            PHOTSV_A
 ln -sf  $ATOMIC/SUL/V/3oct00/svosc_fin.dat               SV_F_OSCDAT
 ln -sf  $ATOMIC/SUL/V/3oct00/f_to_s_50.dat               SV_F_TO_S
 ln -sf  $ATOMIC/SUL/V/3oct00/col_sv.dat                  SV_COL_DATA

 ln -sf  $ATOMIC/SUL/VI/3oct00/phot_sm_3000.dat           PHOTSSIX_A
 ln -sf  $ATOMIC/SUL/VI/3oct00/sviosc_fin.dat             SSIX_F_OSCDAT
 ln -sf  $ATOMIC/SUL/VI/3oct00/f_to_s_33.dat              SSIX_F_TO_S
 ln -sf  $ATOMIC/SUL/VI/3oct00/col_guess.dat              SSIX_COL_DATA

#*****************************************************************************
# Chlorine
# --------
#*****************************************************************************

 ln -sf  $ATOMIC/CHL/IV/15feb01/phot_data.dat              PHOTClIV_A
 ln -sf  $ATOMIC/CHL/IV/15feb01/f_to_s_58.dat              ClIV_F_TO_S
 ln -sf  $ATOMIC/CHL/IV/15feb01/clivosc_fin.dat            ClIV_F_OSCDAT
 ln -sf  $ATOMIC/CHL/IV/15feb01/col_data.dat               ClIV_COL_DATA

 ln -sf  $ATOMIC/CHL/V/15feb01/phot_data.dat               PHOTClV_A
 ln -sf  $ATOMIC/CHL/V/15feb01/f_to_s_41.dat               ClV_F_TO_S
 ln -sf  $ATOMIC/CHL/V/15feb01/clvosc_fin.dat              ClV_F_OSCDAT
 ln -sf  $ATOMIC/CHL/V/15feb01/col_data.dat                ClV_COL_DATA

 ln -sf  $ATOMIC/CHL/VI/15feb01/phot_data.dat              PHOTClSIX_A
 ln -sf  $ATOMIC/CHL/VI/15feb01/f_to_s_32.dat              ClSIX_F_TO_S
 ln -sf  $ATOMIC/CHL/VI/15feb01/clviosc_rev.dat            ClSIX_F_OSCDAT
 ln -sf  $ATOMIC/CHL/VI/15feb01/col_guess.dat              ClSIX_COL_DATA

 ln -sf  $ATOMIC/CHL/VII/15feb01/phot_data.dat             PHOTClSEV_A
 ln -sf  $ATOMIC/CHL/VII/15feb01/f_to_s_42.dat             ClSEV_F_TO_S
 ln -sf  $ATOMIC/CHL/VII/15feb01/clviiosc_rev.dat          ClSEV_F_OSCDAT
 ln -sf  $ATOMIC/CHL/VII/15feb01/col_guess.dat             ClSEV_COL_DATA

#*****************************************************************************
# Argon
# -----
#*****************************************************************************

 ln -sf  $ATOMIC/ARG/III/19nov07/phot_nosm                 PHOTArIII_A
 ln -sf  $ATOMIC/ARG/III/19nov07/fin_osc                   ArIII_F_OSCDAT
 ln -sf  $ATOMIC/ARG/III/19nov07/f_to_s_32                 ArIII_F_TO_S
 ln -sf  $ATOMIC/ARG/III/19nov07/col_ariii                 ArIII_COL_DATA

 ln -sf  $ATOMIC/ARG/IV/1dec99/phot_sm_3000.dat            PHOTArIV_A
 ln -sf  $ATOMIC/ARG/IV/1dec99/fin_osc.dat                 ArIV_F_OSCDAT
 ln -sf  $ATOMIC/ARG/IV/1dec99/f_to_s_50.dat               ArIV_F_TO_S
 ln -sf  $ATOMIC/ARG/IV/1dec99/col_data.dat                ArIV_COL_DATA

 ln -sf  $ATOMIC/ARG/V/1dec99/phot_sm_3000.dat             PHOTArV_A
 ln -sf  $ATOMIC/ARG/V/1dec99/arvosc_rev.dat               ArV_F_OSCDAT
 ln -sf  $ATOMIC/ARG/V/1dec99/f_to_s_64.dat                ArV_F_TO_S
 ln -sf  $ATOMIC/ARG/V/1dec99/col_data.dat                 ArV_COL_DATA

 ln -sf  $ATOMIC/ARG/VI/15feb01/phot_sm_3000.dat           PHOTArSIX_A
 ln -sf  $ATOMIC/ARG/VI/15feb01/arviosc_rev.dat            ArSIX_F_OSCDAT
 ln -sf  $ATOMIC/ARG/VI/15feb01/f_to_s_30.dat              ArSIX_F_TO_S
 ln -sf  $ATOMIC/ARG/VI/15feb01/col_data.dat               ArSIX_COL_DATA

 ln -sf  $ATOMIC/ARG/VII/15feb01/phot_sm_3000.dat          PHOTArSEV_A
 ln -sf  $ATOMIC/ARG/VII/15feb01/arviiosc_rev.dat          ArSEV_F_OSCDAT
 ln -sf  $ATOMIC/ARG/VII/15feb01/f_to_s_46.dat             ArSEV_F_TO_S
 ln -sf  $ATOMIC/ARG/VII/15feb01/col_data.dat              ArSEV_COL_DATA

 ln -sf  $ATOMIC/ARG/VIII/15feb01/phot_sm_3000.dat         PHOTArVIII_A
 ln -sf  $ATOMIC/ARG/VIII/15feb01/arviiiosc_rev.dat        ArVIII_F_OSCDAT
 ln -sf  $ATOMIC/ARG/VIII/15feb01/f_to_s_33.dat            ArVIII_F_TO_S
 ln -sf  $ATOMIC/ARG/VIII/15feb01/col_guess.dat            ArVIII_COL_DATA

#*****************************************************************************
# Potasium
# -------
#*****************************************************************************

 ln -sf  $ATOMIC/POT/III/15feb01/phot_data.dat              PHOTKIII_A
 ln -sf  $ATOMIC/POT/III/15feb01/kiiiosc_rev.dat            KIII_F_OSCDAT
 ln -sf  $ATOMIC/POT/III/15feb01/f_to_s_ls_20.dat           KIII_F_TO_S
 ln -sf  $ATOMIC/POT/III/15feb01/col_guess.dat              KIII_COL_DATA
#
 ln -sf  $ATOMIC/POT/IV/15feb01/phot_data.dat               PHOTKIV_A
 ln -sf  $ATOMIC/POT/IV/15feb01/fin_osc.dat                 KIV_F_OSCDAT
 ln -sf  $ATOMIC/POT/IV/15feb01/f_to_s_40.dat               KIV_F_TO_S
 ln -sf  $ATOMIC/POT/IV/15feb01/col_data.dat                KIV_COL_DATA
#
 ln -sf  $ATOMIC/POT/V/15feb01/phot_data.dat                PHOTKV_A
 ln -sf  $ATOMIC/POT/V/15feb01/fin_osc.dat                  KV_F_OSCDAT
 ln -sf  $ATOMIC/POT/V/15feb01/f_to_s_36.dat                KV_F_TO_S
 ln -sf  $ATOMIC/POT/V/15feb01/col_data.dat                 KV_COL_DATA

 ln -sf  $ATOMIC/POT/VI/15feb01/phot_data.dat               PHOTKSIX_A
 ln -sf  $ATOMIC/POT/VI/15feb01/kviosc_rev.dat              KSIX_F_OSCDAT
 ln -sf  $ATOMIC/POT/VI/15feb01/f_to_s_54.dat               KSIX_F_TO_S
 ln -sf  $ATOMIC/POT/VI/15feb01/col_guess.dat               KSIX_COL_DATA

 ln -sf  $ATOMIC/POT/VII/15feb01/phot_smooth.dat            PHOTKSEV_A
 ln -sf  $ATOMIC/POT/VII/15feb01/osc_op_sp.dat              KSEV_F_OSCDAT
 ln -sf  $ATOMIC/POT/VII/15feb01/f_to_s.dat                 KSEV_F_TO_S
 ln -sf  $ATOMIC/POT/VII/15feb01/col_guess.dat              KSEV_COL_DATA

#*****************************************************************************
# Calcium
# -------
#*****************************************************************************

 ln -sf  $ATOMIC/CA/III/10apr99/phot_smooth.dat            PHOTCaIII_A
 ln -sf  $ATOMIC/CA/III/10apr99/osc_op_sp.dat              CaIII_F_OSCDAT
 ln -sf  $ATOMIC/CA/III/10apr99/f_to_s.dat                 CaIII_F_TO_S
 ln -sf  $ATOMIC/CA/III/10apr99/col_guess.dat              CaIII_COL_DATA
#
 ln -sf  $ATOMIC/CA/IV/10apr99/phot_smooth.dat             PHOTCaIV_A
 ln -sf  $ATOMIC/CA/IV/10apr99/osc_op_sp.dat               CaIV_F_OSCDAT
 ln -sf  $ATOMIC/CA/IV/10apr99/f_to_s.dat                  CaIV_F_TO_S
 ln -sf  $ATOMIC/CA/IV/10apr99/col_guess.dat               CaIV_COL_DATA
#
 ln -sf  $ATOMIC/CA/V/10apr99/phot_smooth.dat              PHOTCaV_A
 ln -sf  $ATOMIC/CA/V/10apr99/osc_op_sp.dat                CaV_F_OSCDAT
 ln -sf  $ATOMIC/CA/V/10apr99/f_to_s.dat                   CaV_F_TO_S
 ln -sf  $ATOMIC/CA/V/10apr99/col_guess.dat                CaV_COL_DATA

 ln -sf  $ATOMIC/CA/VI/10apr99/phot_smooth.dat             PHOTCaSIX_A
 ln -sf  $ATOMIC/CA/VI/10apr99/osc_op_sp.dat               CaSIX_F_OSCDAT
 ln -sf  $ATOMIC/CA/VI/10apr99/f_to_s_58.dat               CaSIX_F_TO_S
 ln -sf  $ATOMIC/CA/VI/10apr99/col_guess.dat               CaSIX_COL_DATA

 ln -sf  $ATOMIC/CA/VII/10apr99/phot_smooth.dat            PHOTCaSEV_A
 ln -sf  $ATOMIC/CA/VII/10apr99/osc_op_sp.dat              CaSEV_F_OSCDAT
 ln -sf  $ATOMIC/CA/VII/10apr99/f_to_s.dat                 CaSEV_F_TO_S
 ln -sf  $ATOMIC/CA/VII/10apr99/col_guess.dat              CaSEV_COL_DATA

#*****************************************************************************
# Chromium
# --------
#*****************************************************************************

 ln -sf  $ATOMIC/CHRO/IV/18oct00/phot_data.dat              PHOTCrIV_A
 ln -sf  $ATOMIC/CHRO/IV/18oct00/f_to_s_48.dat              CrIV_F_TO_S
 ln -sf  $ATOMIC/CHRO/IV/18oct00/criv_osc.dat               CrIV_F_OSCDAT
 ln -sf  $ATOMIC/CHRO/IV/18oct00/col_guess.dat              CrIV_COL_DATA

 ln -sf  $ATOMIC/CHRO/V/18oct00/phot_data.dat               PHOTCrV_A
 ln -sf  $ATOMIC/CHRO/V/18oct00/f_to_s_51.dat               CrV_F_TO_S
 ln -sf  $ATOMIC/CHRO/V/18oct00/crv_osc.dat                 CrV_F_OSCDAT
 ln -sf  $ATOMIC/CHRO/V/18oct00/col_guess.dat               CrV_COL_DATA

 ln -sf  $ATOMIC/CHRO/VI/18oct00/phot_data.dat              PHOTCrSIX_A
 ln -sf  $ATOMIC/CHRO/VI/18oct00/f_to_s_30.dat              CrSIX_F_TO_S
 ln -sf  $ATOMIC/CHRO/VI/18oct00/crvi_osc.dat               CrSIX_F_OSCDAT
 ln -sf  $ATOMIC/CHRO/VI/18oct00/col_guess.dat              CrSIX_COL_DATA

#*****************************************************************************
# Maganese
# --------
#*****************************************************************************

 ln -sf  $ATOMIC/MAN/III/18oct00/phot_data.dat              PHOTMnIII_A
 ln -sf  $ATOMIC/MAN/III/18oct00/mniii_osc.dat              MnIII_F_OSCDAT
 ln -sf  $ATOMIC/MAN/III/18oct00/f_to_s.dat                 MnIII_F_TO_S
 ln -sf  $ATOMIC/MAN/III/18oct00/col_guess.dat              MnIII_COL_DATA
#
 ln -sf  $ATOMIC/MAN/IV/18oct00/phot_data.dat               PHOTMnIV_A
 ln -sf  $ATOMIC/MAN/IV/18oct00/mniv_osc.dat                MnIV_F_OSCDAT
 ln -sf  $ATOMIC/MAN/IV/18oct00/f_to_s_47.dat               MnIV_F_TO_S
 ln -sf  $ATOMIC/MAN/IV/18oct00/col_guess.dat               MnIV_COL_DATA
#
 ln -sf  $ATOMIC/MAN/V/18oct00/phot_data.dat                PHOTMnV_A
 ln -sf  $ATOMIC/MAN/V/18oct00/mnv_osc.dat                  MnV_F_OSCDAT
 ln -sf  $ATOMIC/MAN/V/18oct00/f_to_s_36.dat                MnV_F_TO_S
 ln -sf  $ATOMIC/MAN/V/18oct00/col_guess.dat                MnV_COL_DATA

 ln -sf  $ATOMIC/MAN/VI/18oct00/phot_data.dat               PHOTMnSIX_A
 ln -sf  $ATOMIC/MAN/VI/18oct00/mnvi_osc.dat                MnSIX_F_OSCDAT
 ln -sf  $ATOMIC/MAN/VI/18oct00/f_to_s_41.dat               MnSIX_F_TO_S
 ln -sf  $ATOMIC/MAN/VI/18oct00/col_guess.dat               MnSIX_COL_DATA

 ln -sf  $ATOMIC/MAN/VII/18oct00/phot_smooth.dat            PHOTMnSEV_A
 ln -sf  $ATOMIC/MAN/VII/18oct00/osc_op_sp.dat              MnSEV_F_OSCDAT
 ln -sf  $ATOMIC/MAN/VII/18oct00/f_to_s.dat                 MnSEV_F_TO_S
 ln -sf  $ATOMIC/MAN/VII/18oct00/col_guess.dat              MnSEV_COL_DATA

#*****************************************************************************
#  Iron
#  ----
#*****************************************************************************

 ln -sf  $ATOMIC/FE/III/7feb05/phot_sm_3000.dat             PHOTFeIII_A
 ln -sf  $ATOMIC/FE/III/7feb05/FeIII_OSC                    FeIII_F_OSCDAT
 ln -sf  $ATOMIC/FE/III/7feb05/f_to_s_105                   FeIII_F_TO_S
 ln -sf  $ATOMIC/FE/III/7feb05/col_data.dat                 FeIII_COL_DATA

 ln -sf  $ATOMIC/FE/IV/18oct00/phot_sm_3000.dat             PHOTFeIV_A
 ln -sf  $ATOMIC/FE/IV/18oct00/f_to_s_100.dat               FeIV_F_TO_S
 ln -sf  $ATOMIC/FE/IV/18oct00/feiv_osc_rev.dat             FeIV_F_OSCDAT
 ln -sf  $ATOMIC/FE/IV/18oct00/col_data.dat                 FeIV_COL_DATA

 ln -sf  $ATOMIC/FE/V/18oct00/phot_sm_3000.dat              PHOTFeV_A
 ln -sf  $ATOMIC/FE/V/18oct00/f_to_s_139.dat                FeV_F_TO_S
 ln -sf  $ATOMIC/FE/V/18oct00/fev_osc.dat                   FeV_F_OSCDAT
 ln -sf  $ATOMIC/FE/V/18oct00/col_guess.dat                 FeV_COL_DATA

 ln -sf  $ATOMIC/FE/VI/18oct00/phot_sm_3000.dat             PHOTFeSIX_A
 ln -sf  $ATOMIC/FE/VI/18oct00/fevi_osc.dat                 FeSIX_F_OSCDAT
 ln -sf  $ATOMIC/FE/VI/18oct00/f_to_s_67.dat                FeSIX_F_TO_S
 ln -sf  $ATOMIC/FE/VI/18oct00/col_guess.dat                FeSIX_COL_DATA

 ln -sf  $ATOMIC/FE/VII/18oct00/phot_sm_3000.dat            PHOTFeSEV_A
 ln -sf  $ATOMIC/FE/VII/18oct00/f_to_s_69.dat               FeSEV_F_TO_S
 ln -sf  $ATOMIC/FE/VII/18oct00/fevii_osc.dat               FeSEV_F_OSCDAT
 ln -sf  $ATOMIC/FE/VII/18oct00/col_guess.dat               FeSEV_COL_DATA

#*****************************************************************************
#  Nickel 
#  ------
#*****************************************************************************

 ln -sf $ATOMIC/NICK/III/18oct00/nkiii_osc.dat              NkIII_F_OSCDAT
 ln -sf $ATOMIC/NICK/III/18oct00/f_to_s_47.dat              NkIII_F_TO_S
 ln -sf $ATOMIC/NICK/III/18oct00/phot_data.dat              PHOTNkIII_A
 ln -sf $ATOMIC/NICK/III/18oct00/col_guess.dat              NkIII_COL_DATA

 ln -sf  $ATOMIC/NICK/IV/18oct00/phot_data.dat                PHOTNkIV_A
 ln -sf  $ATOMIC/NICK/IV/18oct00/f_to_s_116.dat               NkIV_F_TO_S
 ln -sf  $ATOMIC/NICK/IV/18oct00/nkiv_osc.dat                 NkIV_F_OSCDAT
 ln -sf  $ATOMIC/NICK/IV/18oct00/col_guess.dat                NkIV_COL_DATA

 ln -sf  $ATOMIC/NICK/V/18oct00/phot_data.dat                 PHOTNkV_A
 ln -sf  $ATOMIC/NICK/V/18oct00/f_to_s_152.dat                NkV_F_TO_S
 ln -sf  $ATOMIC/NICK/V/18oct00/nkv_osc.dat                   NkV_F_OSCDAT
 ln -sf  $ATOMIC/NICK/V/18oct00/col_guess.dat                 NkV_COL_DATA

 ln -sf  $ATOMIC/NICK/VI/18oct00/phot_data.dat                PHOTNkSIX_A
 ln -sf  $ATOMIC/NICK/VI/18oct00/f_to_s_62.dat               NkSIX_F_TO_S
 ln -sf  $ATOMIC/NICK/VI/18oct00/nkvi_osc.dat                 NkSIX_F_OSCDAT
 ln -sf  $ATOMIC/NICK/VI/18oct00/col_guess.dat                NkSIX_COL_DATA

 ln -sf  $ATOMIC/NICK/VII/18oct00/phot_data.dat               PHOTNkSEV_A
 ln -sf  $ATOMIC/NICK/VII/18oct00/f_to_s_61.dat               NkSEV_F_TO_S
 ln -sf  $ATOMIC/NICK/VII/18oct00/nkvii_osc.dat               NkSEV_F_OSCDAT
 ln -sf  $ATOMIC/NICK/VII/18oct00/col_guess.dat               NkSEV_COL_DATA

 ln -sf  $ATOMIC/NICK/VIII/11jun01/phot_data.dat              PHOTNkVIII_A
 ln -sf  $ATOMIC/NICK/VIII/11jun01/f_to_s_48.dat              NkVIII_F_TO_S
 ln -sf  $ATOMIC/NICK/VIII/11jun01/nkviii_osc.dat             NkVIII_F_OSCDAT
 ln -sf  $ATOMIC/NICK/VIII/11jun01/col_guess.dat              NkVIII_COL_DATA

 ln -sf  $ATOMIC/NICK/IX/11jun01/phot_data.dat                PHOTNkIX_A
 ln -sf  $ATOMIC/NICK/IX/11jun01/f_to_s_48.dat                NkIX_F_TO_S
 ln -sf  $ATOMIC/NICK/IX/11jun01/nkix_osc.dat                 NkIX_F_OSCDAT
 ln -sf  $ATOMIC/NICK/IX/11jun01/col_guess.dat                NkIX_COL_DATA

 ln -sf  He2_IN                 T_IN
#*****************************************************************************
#
# END OF ATOMIC DATA SOFT LINKS
#
#*****************************************************************************

#If we pass a paremeter to the BATCH file, we assume that we just want to
#ln -sf  data files. In this case we exit. 

if ( $1 == '') then

else
    echo "Data files assigned"
    exit
endif

#
#***********************************************************************
#    Input files: Only needed is different from defaults
#***********************************************************************

# ln -sf  vadat.dat                                  VADAT
# ln -sf  input.dat                                  IN_ITS
# ln -sf  cfdat_in.dat                               CFDAT

#***********************************************************************
#    Departure coeficient input files. T_IN is required for a new
#    model with GRID=FALSE. Other links not needed unless diferent
#    from default.
#***********************************************************************



#
#***********************************************************************
#    Output files: If disk space is at a preimu, these two files might
#     be better stored on an alternative disk.
#***********************************************************************

#ln -sf /usr/limey/jdh/BAMAT            BAMAT
#ln -sf /usr/limey/jdh/BAION            BAION

#***********************************************************************
#***********************************************************************
#    Run program
#***********************************************************************
#***********************************************************************

#Putting time stamp etc on program

rm -f batch.log

$CMFGEN_PROG  >>& 'batch.log'
