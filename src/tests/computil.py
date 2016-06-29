import subprocess

CC = 'clang'
CCFLAGS = ['-flto', '-emit-llvm', '-g']

def compile_bitcode(infile, outfile):
    subprocess.check_call([CC] + CCFLAGS + ['-c', infile, '-o', outfile])
