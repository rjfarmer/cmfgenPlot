import numpy as np
import matplotlib.pyplot as plt
import subprocess
import os
import collections
import stat

#Constants cmfgen uses:
SPEED_OF_LIGHT        =2.99792458E+10 	#Exact cm/s
ELECTRON_VOLT         =1.60217733E-12      #ergs
GRAVITATIONAL_CONSTANT=6.67259E-08		#cm^3/gm/s
PLANCKS_CONSTANT      =6.626075E-27	#erg sec
ATOMIC_MASS_UNIT      =1.660540E-24	#gm
ELECTRON_MASS         =9.109389E-28	#gm
BOLTZMANN_CONSTANT    =1.380658E-16	#erg/K
STEFAN_BOLTZ          =5.670400E-05	#ergs/cm^2/K^4
RYDBERG_INF     =109737.31534E0		#/cm
RYDBERG_HYDROGEN=109677.6E0		#/cm
RYDBERG_HELIUM  =109722.3E0		#/cm
RYDBERG_CARBON  =109732.3E0		#/cm
RYDBERG_NITROGEN=109733.0E0		#/cm
RYDBERG_OXYGEN  =109733.5E0		#/cm
MASS_SUN=1.989E+33  			#gm
RAD_SUN =6.9599E+10			#cm (changed 7-Jan-2008)
LUM_SUN =3.826E+33				#erg/s
TEFF_SUN=5770.0E0				#K
ASTRONOMICAL_UNIT=1.49597892E+13		#cm
PARSEC           =3.0856E+18       	#cm
JANSKY           =1.0E-23			#ergs/cm^2/s/Hz
PI=3.141592653589793238462643E0
FUN_PI=3.141592653589793238462643E0
SECS_IN_YEAR=31557600.0E0     		#365.25*24*60*60

def cmfgenplot_src():
    return os.path.dirname(os.path.realpath(__file__))
    
def cmfgen_defaults():
    return os.path.join(cmfgenplot_src(),'defaults')


def read_input(filename):
    out=collections.OrderedDict()
    try:
        with open(filename,'r') as f:
            l=f.readlines()
        for i in l:
            x=i.strip()
            if len(x):
                comment=''
                if '!' in x:
                    comment='!'+x.split('!')[-1]
                y=x.split()
                value=y[0]
                name=y[1]
                out[name]={'value':value,'comment':comment}
    except FileNotFoundError:
        pass

    return out

def readLineArray(f):
    x=[]
    while True:
        #Mark start of line
        l=f.readline().strip().split()
        if len(l):
            tmp=[]
            for j in l:
                if 'E' in j:
                    tmp.append(float(j))
                else:
                    tmp.append(float(j.replace('-','E-')))
            x.extend(tmp)
        else:
            break

    return np.array(x)



def skipLines(f,n):
    for i in range(n):
        _=f.readline()

def cleanup():
    cmd = 'find . -not -name "config.run" -not -name "submit-obs.sh" -not -name "slurm*" -delete'
    subprocess.run([cmd],shell=True)

def write_input(filename,data):
    with open(filename,'w') as f:
        for k,v in data.items():
            print('{0: <20}'.format(v['value']),'{0: <20}'.format(k),v['comment'],file=f)

def read_corr_sum(filename='CORRECTION_SUM'):
    return np.genfromtxt(filename,skip_header=5,names=['depth','100','10','1','0p1','0p01','0p001','0p0001'],dtype=None)

def get_value(name,data):
    n='['+name+']'
    return data[n]['value']

def set_value(name,data,value,comment=None):
    n = '['+name+']'
    present = n in data
    if not present:
        data[n] = {}

    data[n]['value'] = value

    if not present:
        if comment is None:
            data[n]['comment'] = '! Newly added in data'
        else:
            data[n]['comment'] = comment

def set_value_file(name,value,filename):
    data=read_input(filename)
    set_value(name,data,value)
    write_input(filename)


def get_val_file(name,filename):
    data=read_input(filename)
    return get_value(name,data)

def get_vals_file(names,filename):
    data=read_input(filename)
    out={}
    for i in names:
        out[i]=get_value(i,data)
    return out

def safe_mdot(m,ind):
    return np.maximum(10**m.hist.log_abs_mdot[ind][0],10**-12)

def check_corr_sum(filename='CORRECTION_SUM'):
    corr=read_corr_sum(filename)
    cols=['100','10','1','0p1','0p01','0p001','0p0001']
    s=np.zeros(np.size(cols))
    for idx,i in enumerate(cols):
        s[idx]=np.count_nonzero(corr[i])

    ind=np.argwhere(s>0)[0][0]
    print("Biggest corr is ",cols[ind].replace('p','.'),' is ',int(s[ind]))


def read_hydro(filename='HYDRO',model_spec='MODEL_SPEC'):
    num_depths=get_val_file('ND',model_spec)
    out=np.genfromtxt(filename,skip_header=1,max_rows=int(num_depths),names=['R','V','Error','VdVdR','dPdR/ROH','g_TOT','g_RAD','g_ELEC','Gamma','Depth'])

    #TODO: work out rest of the file
    return out

def check_hydro(filename='HYDRO',model_spec='MODEL_SPEC',vel=10.0,err=4.0):
    hydro=read_hydro(filename,model_spec)
    ind=[hydro['V']<vel]

    if np.all(hydro['Error'][ind]<err):
        print("Hydro Success")
    else:
        raise RuntimeError("Hydro Fail max error is " +str(np.max(hydro['Error'][ind]))+" err is "+str(err))


def read_obsflux(filename='OBSFLUX',model_spec='MODEL_SPEC'):
    con_freq=[]
    flux=[]
    num_depths=int(get_val_file('ND',model_spec))
    with open(filename,'r') as f:
        #skip first four lines
        skipLines(f,4)
        con_freq=readLineArray(f)

        skipLines(f,3)
        flux=readLineArray(f)

        output={}
        loc=f.tell()
        while True:
            l=f.readline().strip()
            if len(l):
                if ":" in l:
                    f.seek(loc)
                    break

                if l[0].isalpha():
                    header=l
                    skipLines(f,1)
                    data=readLineArray(f)
                    output[header]=data
                    loc=f.tell()
        extras=[]
        lines=f.readlines()
        for i in lines:
            i=i.strip()
            if len(i):
                j=i.split(':')
                extras.append([j[0],j[1].split()])

    return con_freq,flux,output,extras

def check_obsflux(filename='OBSFLUX',model_spec='MODEL_SPEC'):
    x=read_obsflux(filename,model_spec)
    x=x[-1][-2][1][1]
    print("OBSFLUX xray is ",x, " should ~1d-7")

def plot_spectrum(filename='OBSFLUX',model_spec='MODEL_SPEC'):
    x=read_obsflux(filename,model_spec)
    freq=x[0]
    jank=x[1]

    wave=(SPEED_OF_LIGHT/(freq*10**15))*10**9 #nm

    fig=plt.figure(figsize=(12,12))
    ax=fig.add_subplot(111)
    ax.plot(np.log10(wave),np.log10(jank))
    ax.set_xlabel('log10 wave/nm')
    ax.set_ylabel('log10 Jy')
    plt.show()



def check_mod_sum(filename='MOD_SUM',vadat='VADAT'):
    #TODO make a read_mod_sum

    with open(filename,'r') as f:
        l=f.readlines()

    initial = get_vals_file(['TEFF','LOGG'],vadat)

    teff=[]
    for i in l:
        if 'Teff' in i:
            teff.append(i)

    t=teff[-1].split()
    teff=''
    logg=''
    for i in t:
        if 'Teff' in i:
            teff=float(i.split('=')[-1])
        if i.startswith('g='):
            logg=float(i.split('=')[-1])

    print('MOD_SUM started with Teff,logg ',float(initial['TEFF'])*10**4,initial['LOGG'])
    print('ended with Teff,logg ',teff,logg)


def read_rvtj(filename='RVTJ'):
    model_info=OrderedDict()
    with open(filename,'r') as f:
        _=f.readline()
        _=f.readline()
        _=f.readline()

        l=f.readline()
        model_info['nd']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['nc']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['np']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['ncf']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['mdot']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['lum']=l.split(':')[-1].strip()
        l=f.readline()
        model_info['h/he']=l.split(':')[-1].strip()

        _=f.readline()
        _=f.readline()

        for i in range(int(model_info['nc'])):
            h=f.readline().strip()
            model_info[h]=[]
            print(h)
            for j in range(int(model_info['nd'])//8+1):
                model_info[h].extend([float(k) for k in f.readline().strip().split()])

    return model_info

def vadat_mesa(filein='VADAT',log_fold='LOGS/',model=1,tau=2.0/3.0,save=True):
    import mesaPlot as mp

    oldv=read_input(filein)

    m=mp.MESA()
    m.log_fold=log_fold
    m.loadHistory()
    m.loadProfile(num=model)
    ind_hist=(m.hist.model_number==m.prof.model_number)

    ind_prof=np.argmin(np.abs(m.prof.tau-tau))

    set_value('VINF',oldv,1.5*m.hist.surf_escape_v[ind_hist][0]/(100.0*1000.0))
    set_value('MDOT',oldv,safe_mdot(m,ind_hist))
    set_value('LSTAR',oldv,10**m.hist.log_L[ind_hist][0])
    set_value('MASS',oldv,m.hist.star_mass[ind_hist][0])
    set_value('TEFF',oldv,10**(m.prof.logT[ind_prof]-4))
    set_value('LOGG',oldv,m.prof.log_g[ind_prof])
    set_value('RSTAR',oldv,(10**m.hist.log_R[ind_hist][0])*6.9598)
    set_value('RMAX',oldv,200.0)


    ind2=np.zeros(np.size(m.prof.tau),dtype='bool')
    ind2[:ind_prof+1]=True
    mesa_iso=['h1','he4','c12','o16','n14','si28','s32','fe56']
    cmfgen_iso=['HYD/X','HE/X','CARB/X','OXY/X','NIT/X','SIL/X','IRON/X']
    abun=[]
    dm=np.abs(np.ediff1d(m.prof.mass,to_end=[0]))
    for i in mesa_iso:
        abun.append(np.dot(dm[ind2],m.prof.data[i][ind2]))

    set_value('PHOS/X',oldv,-10**-15) # Cant be zero
    set_value('LIN_INT',oldv,'F')
    set_value('DO_CL',oldv,'F')

    #Normalise
    abunSum=np.sum(abun)
    for i,j in zip(cmfgen_iso,abun):
        set_value(i,oldv,-j/abunSum)

    if save:
        write_input('VADAT_MESA',oldv)
    return oldv

def hydro_mesa(filein='',log_fold='LOGS/',model=1,tau=2.0/3.0,save=True):
    import mesaPlot as mp

    oldv=read_input(filein)

    m=mp.MESA()
    m.log_fold=log_fold
    m.loadHistory()
    m.loadProfile(num=model)
    ind_hist=(m.hist.model_number==m.prof.model_number)

    ind_prof=np.argmin(np.abs(m.prof.tau-tau))
    rr=10**m.prof.logR[ind_prof]*6.96
    set_value('REF_R',oldv,rr)
    set_value('CON_R',oldv,rr+5.0)
    set_value('RSTAR',oldv,rr-5.0)
    set_value('VINF',oldv,1.5*m.hist.surf_escape_v[ind_hist][0]/(100.0*1000.0))
    set_value('MDOT',oldv,safe_mdot(m,ind_hist))
    set_value('TEFF',oldv,10**(m.prof.logT[ind_prof]-4))
    set_value('LOG_G',oldv,m.prof.log_g[ind_prof])

    set_value('OB_P1',oldv,200)
    set_value('BETA',oldv,1.0)
    set_value('MU_ATOM',oldv,m.prof.abar[ind_prof])
    set_value('OLD_MOD',oldv,'F')
    set_value('OLD_V',oldv,'F')
    set_value('WIND_PRES',oldv,'T')
    set_value('MAX_R',oldv,50.0)
    set_value('ATOM_DEN',oldv,10**8)
    set_value('CON_V',oldv,10.0)

    if save:
        write_input('HYDRO_PARAMS_MESA',oldv)
    return oldv


def lte_mesa(filein='VADAT_MESA',log_fold='LOGS/',model=1,tau=2.0/3.0,save=True):
    import mesaPlot as mp

    oldv=vadat_mesa(filein,log_fold,model,tau)

    m=mp.MESA()
    m.log_fold=log_fold
    m.loadHistory()
    m.loadProfile(num=model)
    ind_hist=(m.hist.model_number==m.prof.model_number)

    ind_prof=np.argmin(np.abs(m.prof.tau-tau))

    set_value('DO_CL',oldv,'F')
    set_value('LIN_INT',oldv,'F')
    set_value('T_INIT_TAU',oldv,'1.5')

    if save:
        write_input('VADAT_LTE_MESA',oldv)
    return oldv


def lte_model_spec(filein='MODEL_SPEC',save=True):
    old=read_input(filein)
    set_value("ND",old,925)
    set_value("NP",old,940)
    set_value("NC",old,15)

    if save:
        write_input('MODEL_SPEC_lte',old)
    return old

def lte_grid_params(fileout="GRID_PARAMS"):
    with open(fileout,'w') as f:
        print("25  37                !# of T values; # of Electron density values",file=f)
        print("1.0 25.0              !Tmin, Tmax (10^4K)",file=f)
        print("1.0E+06 1.0E+18       !Log(Ne_min), Log(Ne_max)",file=f)



def freq2wave(freq):
    return SPEED_OF_LIGHT/(freq*10**15)

def freq2A(freq):
    return freq2wave(freq)*10**10

def freq2nm(freq):
    return freq2wave(freq)*10**9

def plot_obs(filename='obs_fin_5',model_spec='MODEL_SPEC',
            trans=False,transition_filename="../TRANS_INFO",
            norm_cont=False,file_cont='obs_cont'):
    x=read_obs_fin(filename)
    freq=x[0]
    jank=x[1]
    wave=freq2A(freq) #A

    fig=plt.figure(figsize=(12,12))
    ax=fig.add_subplot(111)

    if norm_cont:
        cont=read_obs_fin(file_cont)
        waveCont=freq2A(cont[0])
        contInterp=np.interp(wave,waveCont,cont[1])
        jank=jank/contInterp

    ax.plot(np.log10(wave),np.log10(jank))

    if trans:
        plot_trans(filename=transition_filename,fig=fig,ax=ax)

    ax.set_xlabel('log10 A')
    ax.set_ylabel('log10 Jy')
    ax.set_ylim(-10.0,5.0)
    plt.show()

def read_obs_fin(filename='obs_fin_5'):
    # Output in the obs folder
    con_freq=[]
    flux=[]
    with open(filename,'r') as f:
        #skip first four lines
        skipLines(f,4)
        con_freq=readLineArray(f)

        skipLines(f,3)
        flux=readLineArray(f)

    return con_freq,flux

def read_trans(filename='../TRANS_INFO'):
    return np.genfromtxt(filename,skip_header=5,names=['i','nl','nup','nu','lam','v','trans'],dtype=None)

def plot_trans(filename="../TRANS_INFO",fig=None,ax=None):
    if fig is None or ax is None:
        raise ValueError("Must pass fig and ax instance")

    t=read_trans(filename)

    for i in np.linspace(0,np.size(t)-1,100):
        ax.axvline(x=np.log10(t[int(i)]['lam']),linestyle='--',color='grey',alpha=0.8)

def read_rosseland_lte(filename="ROSSELAND_LTE_TAB"):
    return np.genfromtxt(filename,skip_header=7,names=["T","rho","pop","ne","chi_ross","chi_es","kap_ross"])

def compare_2_vadat(vadat1,vadat2):
    v1 = read_input(vadat1)
    v2 = read_input(vadat2)

    for i in v1:
        found=False
        for j in v2:
            if i['name'] == j['name']:
                found=True
            if i['value'] != j['value']:
                print(i['name'],i['value'],j['value'])
        if not found:
            print("No match ",i['name'])

def run_batch(link_only=False):
    filename="./batch.sh"
    make_exectuable(filename)
    args=[filename]

    if link_only:
        args.append('aaa')

    subprocess.run(args,shell=True)


def run_lte(cmfgensrc):
    binary=os.path.join(cmfgensrc,'exe','main_lte.exe')
    run_batch(True)
    safe_rm("ltebat.log")
    safe_rm("OUTLTE")
    safe_rm("OUTGEN")
    subprocess.run([binary],shell=True)

    #Check for nans
    if 'NaN' in open('ROSSELAND_LTE_TAB').read():
        raise ValueError("NaNs in ROSSELAND_LTE_TAB")

def safe_rm(filename):
    if os.path.isfile(filename):
        os.remove(filename)

def make_exectuable(filename):
    os.chmod(filename,stat.S_IRUSR|stat.S_IWUSR|stat.S_IXUSR)


def run_hydro(cmfgensrc):
    binary=os.path.join(cmfgensrc,'exe','wind_hyd.exe')
    proc = subprocess.Popen([binary],stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE,universal_newlines=True)
    out,err = proc.communicate(input="{}\n{}\n{}\n{}\n".format("","e","90","100"))


def run_cmfgen(cmfgensrc):
    binary=os.path.join(cmfgensrc,'exe','cmfgen_dev.exe')
    run_batch(True)
    safe_rm("OUTGEN")
    #needs error checking
    result = subprocess.run([binary],stderr=subprocess.STDOUT,stdout=subprocess.PIPE)
    result = result.stdout.decode('utf-8')
    with open('batch.log','w') as f:
        print(result,file=f)

    if 'Error' in result or 'Traceback' in result:
        raise RuntimeError("CMFGEN failed")


def read_rvsig(filein="RVSIG_COL",header=19):
    lines=[]
    with open(filein,'r') as f:
        for i in range(header):
            lines.append(f.readline())

    data=np.genfromtxt(filein,skip_header=header,names=True,comments="!")

    return lines,data

def extract_rvsig(filein):
    l,d=read_rvsig(filein)

    rstar=float(l[7].split()[-1])
    rmax=float(l[15].split()[-1])
    nd=int(l[-2].split()[0])

    return rstar,rmax,nd

def update_vadat_after_hydro(vadat="VADAT",rvsig="RVSIG_COL",inits="IN_ITS",model_spec="MODEL_SPEC"):

    rstar,rmax,nd=extract_rvsig(rvsig)

    vdata=read_input(vadat)
    set_value('RSTAR',vdata,rstar)
    set_value('RMAX',vdata,rmax)
    write_input(vadat,vdata)

    its=read_input(inits)
    set_value('NUM_ITS',its,1)
    set_value('DO_LAM_IT',its,'T')
    set_value('DO_T_AUTO',its,'T')
    write_input(inits,its)

    ms=read_input(model_spec)
    set_value('ND',ms,nd)
    set_value('NP',ms,nd+15)
    write_input(model_spec,ms)

def update_after_test(inits="IN_ITS",hydro="HYDRO_DEFAULTS"):
    its=read_input(inits)
    set_value('NUM_ITS',its,100)
    set_value('DO_LAM_IT',its,'T')
    set_value('DO_T_AUTO',its,'T')
    write_input(inits,its)

    hy=read_input(hydro)
    set_value('N_ITS',hy,5)
    set_value('STRT_ITS',hy,12)
    set_value('FREQ_ITS',hy,10)
    set_value('MAX_R',hy,100)
    write_input(hydro,hy)
    safe_rm("OUTGEN")

def clean_iterations(cmfgensrc=''):
    binary=os.path.join(cmfgensrc,'exe','rewrite_scr.exe')
    proc = subprocess.Popen([binary],stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE,universal_newlines=True)
    out,err = proc.communicate(input="{}\n{}\n".format("1",""))
    binary=os.path.join(cmfgensrc,'com','mvscr.sh')
    subprocess.run([binary],shell=True)

def check_cmfgen():
    print(check_corr_sum())
    print(check_mod_sum())
    print(check_obsflux())
    print(check_hydro())

def check_outgen(outgen="OUTGEN",end=5):
    with open(outgen,'r') as f:
        lines=f.readlines()

    for i in lines[-end:-1]:
        if 'Error ' in i:
            print(i)
            raise RuntimeError("Error in OUTGEN")
    print("OUTGEN is clean")

def run_spectra(vadat='../VADAT'):
    filename="./batobs.sh"
    make_exectuable(filename)
    
    #Fix masses
    v = read_input(vadat)
    mass = get_value('MASS',v)
    with open(filename,'r') as f:
        l=f.readlines()
    l=[i.replace('XXX',mass) for i in l]
    with open(filename,'w') as f:
        for i in l:
            f.write(i)
    
    subprocess.run([filename],shell=True)

def mkdir(folder):
    try:
        os.mkdir(folder)
    except FileExistsError:
        pass
