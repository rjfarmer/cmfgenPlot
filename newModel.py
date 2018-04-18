import cmfgen as cmf
import os
import shutil
import glob

# Run new cmfgen model

FOLDER = "./"
config_file = 'config.run'

with open(config_file, 'r') as f:
    MESA_LOGS = f.readline().strip()
    MESA_MODEL = int(f.readline().strip())
    RUN_SETUP=bool(f.readline().strip())
    RUN_LTE=bool(f.readline().strip())
    RUN_HYDRO=bool(f.readline().strip())
    RUN_CMFGEN=bool(f.readline().strip())
    RUN_SPECTRA=bool(f.readline().strip())
    
CMFGENSRC = os.path.expandvars("$cmfdist")
OGRID = cmf.cmfgen_defaults()

FOLDLTE = os.path.join(FOLDER,"lte")
FOLDHYDRO = os.path.join(FOLDER,"hydro_dir")
FOLDSPECTRA = os.path.join(FOLDER,"obs")

if RUN_SETUP:
    print("RUN_SETUP")
    # Copy old model
    for i in ["batch.sh","IN_ITS","VADAT","MODEL_SPEC","GAMMAS_IN","He2_IN","HYDRO_DEFAULTS"]:
        shutil.copyfile(os.path.join(OGRID,i),os.path.join(FOLDER,i))
    
    for i in glob.glob(os.path.join(OGRID,"*OUT")):
        if i.endswith("_OUT"):
            shutil.copyfile(i,os.path.join(FOLDER,os.path.basename(i).replace("_OUT","_IN")))
        else:
            shutil.copyfile(i,os.path.join(FOLDER,os.path.basename(i).replace("OUT","_IN")))
    

    cmf.vadat_mesa(filein=os.path.join(FOLDER,"VADAT"),log_fold=MESA_LOGS,model=MESA_MODEL)

if RUN_LTE:
    print("RUN_LTE")
    #lte work
    cmf.mkdir(FOLDLTE)
    
    cmf.lte_mesa(filein=os.path.join(FOLDER,"VADAT_MESA"),model=MESA_MODEL,log_fold=MESA_LOGS)
    shutil.copyfile(os.path.join(FOLDER,"VADAT_LTE_MESA"),os.path.join(FOLDLTE,"VADAT"))
    
    cmf.lte_model_spec(filein=os.path.join(FOLDER,"MODEL_SPEC"))
    shutil.copyfile(os.path.join(FOLDER,"MODEL_SPEC_lte"),os.path.join(FOLDLTE,"MODEL_SPEC"))
    
    cmf.lte_grid_params(os.path.join(FOLDLTE,"GRID_PARAMS"))
    
    # Run lte
    shutil.copyfile("batch.sh",os.path.join(FOLDLTE,"batch.sh"))
    
    os.chdir(FOLDLTE)
    cmf.run_lte(CMFGENSRC)
    os.chdir('../')

if RUN_HYDRO:
    print("RUN_HYDRO")
    #Hydro
    cmf.mkdir(FOLDHYDRO)
    shutil.copyfile(os.path.join(FOLDLTE,"ROSSELAND_LTE_TAB"),os.path.join(FOLDHYDRO,"ROSSELAND_LTE_TAB"))
    cmf.hydro_mesa(log_fold=MESA_LOGS,model=MESA_MODEL)
    shutil.copyfile("HYDRO_PARAMS_MESA",os.path.join(FOLDHYDRO,"HYDRO_PARAMS"))
    
    os.chdir(FOLDHYDRO)
    cmf.run_hydro(CMFGENSRC)
    os.chdir('../')

if RUN_CMFGEN:
    print("RUN_CMFGEN")
    #Setup for cmfgen
    shutil.copyfile(os.path.join(FOLDHYDRO,"ROSSELAND_LTE_TAB"),"ROSSELAND_LTE_TAB")
    shutil.copyfile(os.path.join(FOLDHYDRO,"RVSIG_COL_NEW"),"RVSIG_COL")
    
    shutil.copyfile("VADAT_LTE_MESA","VADAT")
    cmf.update_vadat_after_hydro()
    shutil.copyfile(os.path.join(OGRID,"GREY_SCL_FACOUT"),"GREY_SCL_FAC_IN")
    #needs error checking
    # Test options
    cmf.run_cmfgen(CMFGENSRC)
    cmf.check_outgen()
    
    cmf.update_after_test()
    #needs error checking
    #Full run
    cmf.run_cmfgen(CMFGENSRC)
    cmf.check_cmfgen()
    cmf.check_outgen()
    
    cmf.clean_iterations(CMFGENSRC)
    
if RUN_SPECTRA:
    print("RUN_SPECTRA")
    cmf.mkdir(FOLDSPECTRA)
    os.chdir(FOLDSPECTRA)
    shutil.copyfile(os.path.join(OGRID,'batobs.sh'),'batobs.sh')
    shutil.copyfile(os.path.join(OGRID,'CMF_FLUX_PARAM_INIT'),'CMF_FLUX_PARAM_INIT')
    cmf.run_spectra()
