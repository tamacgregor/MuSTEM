#
# This Makefile was initially generated by Code::Blocks IDE.

#Switch for Gfortran and PGIFortran (for GPU) compilation
Compiler = PGIFortran
#Compiler = GFortran

#Precision (double or single)
precision = single
# precision = double

#CUDA version
CUDA_VER = 9.1

#PGI compiler install directory
PGIDIR = /opt/pgi/linux86-64
PGIIDIR = -I$(PGIDIR)/18.10/include -I$(PGIDIR)/2018/include \
          -I$(PGIDIR)/2018/cuda/$(CUDA_VER)/include
PGILIBS = -L$(PGIDIR)/18.10/lib -L$(PGIDIR)/2018/lib \
          -L$(PGIDIR)/2018/cuda/$(CUDA_VER)/lib64 -lcuda -lcudafor -lcufft \
					-lcusparse -lcudart -lfftw3 -lfftw3f

#FFTW lib and directories
FFTWdir = /usr/local
FFTWIDIR = -I$(FFTWdir)/include
FFTWLIBS = -L$(FFTWdir)/lib/

SRCS_f90d1 = \
m_multislice.f90 \
m_string.f90 \
m_tilt.f90 \
m_user_input.f90 \
m_crystallography.f90 \
MS_utilities.f90 \
mod_global_variables.f90 \
m_electron.f90 \
fftw_wrapper.f90 \
mod_output.f90 \
muSTEM.f90 \
quadpack.f90 \
m_absorption.f90 \
s_absorptive_stem.f90 \
m_lens.f90 \
s_absorptive_tem.f90 \
m_numerical_tools.f90 \
s_qep_stem.f90 \
m_potential.f90 \
s_qep_tem.f90 \
m_precision.f90\
mod_Hn0.f90
ifeq ($(Compiler),PGIFortran)
	SRCS_f90d1 += \
	mod_cuda_array_library.f90 \
	mod_cuda_potential.f90 \
	mod_cufft.f90 \
	mod_cuda_ms.f90 \
	mod_cuda_setup.f90
endif

#Extra dependencies required for GPU code
ifeq ($(Compiler),PGIFortran)
	CUDA_dependencies = \
	mod_cuda_ms.o \
	mod_cuda_array_library.o \
	mod_cuda_potential.o \
	mod_cuda_setup.o \
	mod_cufft.o
else
	CUDA_dependencies =
endif

OBJS_f90d1 = $(subst .f90,.o, $(SRCS_f90d1))

SRC_DIR_f90d1 = Source/
OBJS_DIR = obj/Release/Source/
MOD_DIR = obj/Release/mod/
EXE_DIR = Executables/

EXE = muSTEM

#Choose compiler
PGIFC = pgfortran
PGILD = pgfortran
FC = gfortran
LD = gfortran

CFLAGS = -cpp -D$(precision)_precision -DGCC  -O3

PGICFLAGS  = -DGPU -ta=tesla:ccall -ta=tesla:cuda$(CUDA_VER)
PGICFLAGS += -Mcuda=cuda$(CUDA_VER) -Mcudalib=cufft -module $(MOD_DIR) -mp -fast
PGILFLAGS  = -Mcuda=cuda$(CUDA_VER) -ta=tesla:cuda$(CUDA_VER)   -ta=tesla:ccall
PGILFLAGS += -Bstatic_pgi -pgf90libs -Mcuda=cuda$(CUDA_VER) -Mcudalib=cufft
GCFLAGS = -fopenmp -J$(OBJS_DIR)
GLFLAGS = -s -fopenmp -lfftw3 -lfftw3f

VPATH = $(SRC_DIR_f90d1):$(OBJS_DIR)
OBJS = $(addprefix $(OBJS_DIR), $(OBJS_f90d1))



all : $(EXE)

$(EXE) : $(OBJS_f90d1)
ifeq ($(Compiler),PGIFortran)
	@mkdir -p $(EXE_DIR)
	$(PGILD) -o $(EXE_DIR)$(EXE) $(OBJS) $(LFLAGS) $(PGILFLAGS) $(PGILIBS)
else
	@mkdir -p $(EXE_DIR)
	$(LD) -o $(EXE_DIR)$(EXE) $(OBJS) $(LFLAGS) $(GLFLAGS) $(FFTWLIBS)
endif

$(OBJS_f90d1):
ifeq ($(Compiler),PGIFortran)
	@mkdir -p $(OBJS_DIR)
	@mkdir -p $(MOD_DIR)
	$(PGIFC) $(CFLAGS) $(PGICFLAGS) $(PGIIDIR) -c $(SRC_DIR_f90d1)$(@:.o=.f90) -o $(OBJS_DIR)$@
else
	@mkdir -p $(OBJS_DIR)
	$(FC) $(CFLAGS) $(GCFLAGS) -c $(FFTWIDIR) $(SRC_DIR_f90d1)$(@:.o=.f90) -o $(OBJS_DIR)$@

endif

clean :
	rm -f $(MOD_DIR)*.*
	rm -f $(OBJS_DIR)*.*
	rm -f $(EXE_DIR)$(EXE)





# Dependencies of files
m_multislice.o: \
    m_multislice.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_crystallography.o \
    m_numerical_tools.o \
    m_precision.o \
    m_string.o \
    m_user_input.o \
    mod_output.o
m_string.o: \
    m_string.f90 \
    m_precision.o
m_tilt.o: \
    m_tilt.f90 \
    mod_global_variables.o \
    m_crystallography.o \
    m_precision.o \
    m_string.o \
    m_user_input.o
m_user_input.o: \
    m_user_input.f90 \
    m_precision.o \
    m_string.o
m_crystallography.o: \
    m_crystallography.f90 \
    mod_global_variables.o \
    m_precision.o
MS_utilities.o: \
    MS_utilities.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_crystallography.o \
    m_electron.o \
    m_lens.o \
    m_multislice.o \
    m_potential.o \
    m_precision.o \
    m_string.o \
    m_user_input.o \
    mod_output.o
mod_global_variables.o: \
    mod_global_variables.f90 \
    m_precision.o
m_electron.o: \
    m_electron.f90 \
    m_precision.o
fftw_wrapper.o: \
    fftw_wrapper.f90
mod_output.o: \
    mod_output.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_precision.o \
    m_string.o \
    m_user_input.o
muSTEM.o: \
    muSTEM.f90 \
    mod_Hn0.o \
    mod_global_variables.o \
    m_absorption.o \
    m_electron.o \
    m_lens.o \
    m_multislice.o \
    m_potential.o \
    m_string.o \
    m_tilt.o \
    m_user_input.o \
    mod_output.o \
    $(CUDA_dependencies)
quadpack.o: \
    quadpack.f90
m_absorption.o: \
    m_absorption.f90 \
    mod_global_variables.o \
    m_crystallography.o \
    m_electron.o \
    m_numerical_tools.o \
    m_precision.o \
    m_string.o \
    m_user_input.o \
    mod_output.o \
    quadpack.o
s_absorptive_stem.o: \
    s_absorptive_stem.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_absorption.o \
    m_crystallography.o \
    m_lens.o \
    m_multislice.o \
    m_potential.o \
    m_precision.o \
    m_string.o \
    m_tilt.o \
    mod_output.o \
		$(CUDA_dependencies)
m_lens.o: \
    m_lens.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_crystallography.o \
    m_multislice.o \
    m_precision.o \
    m_string.o \
    m_user_input.o \
    mod_output.o
s_absorptive_tem.o: \
    s_absorptive_tem.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_absorption.o \
    m_lens.o \
    m_multislice.o \
    m_potential.o \
    m_precision.o \
    m_string.o \
    m_tilt.o \
    m_user_input.o \
    mod_output.o \
		mod_Hn0.o \
		$(CUDA_dependencies)
m_numerical_tools.o: \
    m_numerical_tools.f90 \
    m_precision.o
s_qep_stem.o: \
    s_qep_stem.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_crystallography.o \
    m_lens.o \
    m_multislice.o \
    m_numerical_tools.o \
    m_potential.o \
    m_precision.o \
    m_string.o \
    m_tilt.o \
    m_user_input.o \
    mod_output.o \
    mod_Hn0.o \
    $(CUDA_dependencies)
m_potential.o: \
    m_potential.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_absorption.o \
    m_crystallography.o \
    m_electron.o \
    m_multislice.o \
    m_numerical_tools.o \
    m_precision.o \
    m_string.o \
    m_user_input.o \
    mod_output.o \
    $(CUDA_dependencies)
s_qep_tem.o: \
    s_qep_tem.f90 \
    fftw_wrapper.o \
    mod_global_variables.o \
    m_lens.o \
    m_multislice.o \
    m_numerical_tools.o \
    m_potential.o \
    m_precision.o \
    m_string.o \
    m_tilt.o \
    mod_output.o \
    mod_Hn0.o \
    $(CUDA_dependencies)
m_precision.o: \
    m_precision.f90
mod_Hn0.o: \
    mod_Hn0.f90 \
    mod_global_variables.o \
    m_precision.o \
    m_user_input.o \
    m_lens.o
mod_cuda_potential.o: \
		mod_cuda_potential.f90 \
		mod_global_variables.o \
		mod_cuda_array_library.o \
		mod_cufft.o \
		m_precision.o
mod_cuda_array_library.o: \
		mod_cuda_array_library.f90 \
		m_precision.o
mod_cufft.o: \
		mod_cufft.f90
mod_cuda_setup.o: \
		mod_cuda_setup.f90
mod_cuda_ms.o: \
		mod_cuda_ms.f90 \
		mod_global_variables.o \
		mod_cuda_array_library.o \
		mod_cufft.o \
    m_precision.o
