import numpy as np

def read_input(filename):
    with open(filename,'r') as f:
        l=f.readlines()
        
    out=[]
    for i in l:
        x=i.strip()
        if len(x):
            comment=''
            if '!' in x:
                comment='!'+x.split('!')[-1]
            y=x.split()
            value=y[0]
            name=y[1]
            out.append({'name':name,'value':value,'comment':comment})
    return out
    
    
def write_input(filename,data):
    with open(filename,'w') as f:
        for i in data:
            print('{0: <20}'.format(i['value']),'{0: <20}'.format(i['name']),i['comment'],file=f)

def read_corr_sum(filename='CORRECTION_SUM'):
    out=np.genfromtxt(filename,skip_header=5,names=['depth','100','10','1','0p1','0p01','0p001','0p0001'],dtype=None)
    return out

def get_value(name,data):
    n='['+name+']'
    for i in data:
        if i['name'] == n:
            return i['value']
            
def set_value(name,data,value):
    n='['+name+']'
    for i in data:
        if i['name'] == n:
            i['value'] = value

def get_val_file(name,filename):
    data=read_input(filename)
    return get_value(name,data)
    
def get_vals_file(names,filename):
    data=read_input(filename)
    out={}
    for i in names:
        out[i]=get_value(i,data)
    return out
    
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
        print("Hydro Fail max value is ",np.max(hydro['V'][ind]))
    
    
def read_obsflux(filename='OBSFLUX',model_spec='MODEL_SPEC'):
    con_freq=[]
    flux=[]
    num_depths=int(get_val_file('ND',model_spec))
    with open(filename,'r') as f:
        #skip two lines
        for i in range(2):
            _=f.readline()
        t=f.readline()
        num_points=int(t.split()[-2])
        for i in range(num_points//8+2):
            con_freq.extend([float(j) for j in f.readline().strip().split()])
        con_freq=np.array(con_freq)
        
        #skip four lines
        for i in range(4):
            _=f.readline()
        for i in range(num_points//10+2):
            flux.extend([float(j) for j in f.readline().strip().split()])
        flux=np.array(flux)
        
        output=[]
        for i in range(8):
            for j in range(2):
                _=f.readline()
            header=f.readline().strip()
            data=[]
            for j in range(num_depths//10+2):
                tmp=[]
                #Handle 3 digit exponents
                line=f.readline().strip().split()
                for j in line:
                    if 'E' in j:
                        tmp.append(float(j))
                    else:
                        tmp.append(float(j.replace('-','E-')))
                data.extend(tmp)
            output.extend([header,data])
            
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
    sol=299792458.0 #m/s
    wave=(sol/(freq*10**15))*10**9 #nm
    
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
    
    print('MOD_SUM started with Teff,logg ',initial['TEFF'],initial['LOGG'])
    print('ended with Teff,logg ',teff,logg)    
    
        
def read_rvtj(filename='RVTJ'):
    model_info={}
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

def vadat_mesa(vadat='VADAT',log_fold='LOGS/',model=1,tau=20.0):
    import mesaPlot as mp
    
    oldv=read_input(vadat)
    
    m=mp.MESA()
    m.log_fold=log_fold
    m.loadHistory()
    m.loadProfile(num=model)
    ind_hist=(m.hist.model_number==model)
    ind_prof=np.argmin(np.abs(m.prof.tau-tau))
    
    set_value('VINF',oldv,1.5*m.hist.surf_escape_v[ind_hist][0]/(100.0*1000.0))
    set_value('MDOT',oldv,10**m.hist.log_abs_mdot[ind_hist][0])
    set_value('LSTAR',oldv,10**m.hist.log_L[ind_hist][0])
    set_value('MASS',oldv,m.hist.star_mass[ind_hist][0])
    set_value('TEFF',oldv,10**m.prof.logT[ind_prof])
    set_value('LOGG',oldv,10**m.prof.log_g[ind_prof])
    set_value('RSTAR',oldv,(10**m.hist.log_R[ind_hist][0])*6.9598)
    set_value('RMAX',oldv,(10**m.hist.log_R[ind_hist][0])*6.9598*1.1) #TODO: Check what rmax means
    
    #TODO: Set abundances
    write_input('VADAT_MESA',oldv)
    return oldv

