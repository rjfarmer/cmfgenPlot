import cmfgen as cmf
import os
import shutil
import glob

#Run new cmfgen model

FOLDER="./"
config_file='config.run'

with open(config_file,'r') as f:
    MESA_LOGS=f.readline().strip()
    MESA_MODEL=int(f.readline().strip())
    OGRID=f.readline().strip()
    CMFGENSRC=os.path.expandvars(f.readline().strip())

FOLDLTE=os.path.join(FOLDER,"lte")
FOLDHYDRO=os.path.join(FOLDER,"hydro_dir")


def mkdir(folder):
    try:
        os.mkdir(folder)
    except FileExistsError:
        pass
    
# Copy old model
for i in ["batch.sh","IN_ITS","VADAT","MODEL_SPEC"]:
    shutil.copyfile(os.path.join(OGRID,i),os.path.join(FOLDER,i))

for i in glob.glob(os.path.join(OGRID,"*OUT")):
    shutil.copyfile(i,os.path.join(FOLDER,os.path.basename(i).replace("_OUT","_IN")))


cmf.vadat_mesa(filein=os.path.join(FOLDER,"VADAT"),log_fold=MESA_LOGS,model=MESA_MODEL)

#lte work
mkdir(FOLDLTE)

cmf.lte_mesa(filein=os.path.join(FOLDER,"VADAT_MESA"),model=MESA_MODEL,tau=20.0,log_fold=MESA_LOGS)
shutil.copyfile(os.path.join(FOLDER,"VADAT_LTE_MESA"),os.path.join(FOLDLTE,"VADAT"))

cmf.lte_model_spec(filein=os.path.join(FOLDER,"MODEL_SPEC"))
shutil.copyfile(os.path.join(FOLDER,"MODEL_SPEC_lte"),os.path.join(FOLDLTE,"MODEL_SPEC"))

cmf.lte_grid_params(os.path.join(FOLDLTE,"GRID_PARAMS"))

# Run lte
shutil.copyfile("batch.sh",os.path.join(FOLDLTE,"batch.sh"))

os.chdir(FOLDLTE)
cmf.run_lte(CMFGENSRC)
os.chdir(os.path.pardir)


#Hydro
mkdir(FOLDHYDRO)
shutil.copyfile(os.path.join(FOLDLTE,"ROSSELAND_LTE_TAB"),os.path.join(FOLDHYDRO,"ROSSELAND_LTE_TAB"))
cmf.hydro_mesa(log_fold=MESA_LOGS,model=MESA_MODEL,tau=20.0)
shutil.copyfile("HYDRO_PARAMS_MESA",os.path.join(FOLDHYDRO,"HYDRO_PARAMS_MESA"))

os.cwd(FOLDHYDRO)
cmf.run_hydro(CMFGENSRC)
os.chdir(os.path.pardir)

#Setup for cmfgen
shutil.copyfile(os.path.join(FOLDHYDRO,"ROSSELAND_LTE_TAB"),"ROSSELAND_LTE_TAB")
shutil.copyfile(os.path.join(FOLDHYDRO,"RVSIG_COL_NEW"),"RVSIG_COL")


cmf.update_vadat_after_hydro()
shutil.copyfile(os.path.join(OGRID,"GREY_SCL_FACOUT"),"GREY_SCL_FAC_IN")
#needs error checking
# Test options
cmf.run_cmfgen(CMFGENSRC)


cmf.update_after_test()
#needs error checking
#Full run
cmf.run_cmfgen(CMFGENSRC)


