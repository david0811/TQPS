import numpy as np
import math
import argparse

# range function to include floats
def my_range(start, end, step):
    while start <= end:
        yield start
        start += step

# returns singular values in descending order as numpy array
def sing_vals(y, delta_R, delta_L, v, M0):
    x = (4*math.pi*y*v*v)/M0
    M = np.array([[0.0,      delta_L,            0.0,                0.0],
                  [0.0,      M0+x/2.0,           x/2.0,              x/math.sqrt(2.0)],
                  [0.0,      x/2.0,              M0+x/2.0,           x/math.sqrt(2.0)],
                  [delta_R,  x/math.sqrt(2.0),   x/math.sqrt(2.0),   M0+x]])  
    return(np.linalg.svd(M, full_matrices=True, compute_uv=False))

parser = argparse.ArgumentParser(description='Top quark partner mass predictor')
parser.add_argument("-m", "--mass", default=10000.0, type=float)
parser.add_argument("-w", "--window", default=10.0, type=float)
parser.add_argument("-y", "--ystep", default=1.0, type=float)
parser.add_argument("-e", "--equal", action="store_true")
parser.add_argument("-dm", "--deltamax", default=100000.0, type=float)
parser.add_argument("-ds", "--deltastep", default=100.0, type=float)
args = parser.parse_args()

# FIXED PARAMETERS
v = 246.0    # weak scale
Mt = 173.0   # top mass

# VARIABLE PARAMETERS
M0 = args.mass               # composite mass scale
window = args.window         # sets allowed range around Mt
y_step = args.ystep          # percentage y step
delta_max = M0               # delta max
delta_step = args.deltastep  # absolute delta step  

# output file looks as follows
# COL1  COL2  COL3  COL4   COL5     COL6     COL7
# ...singular values....  delta_L  delta_R    y
if args.equal:
  f = open("./data/m" + str(int(M0)) + "w" + str(int(window)) + "ds" + 
            str(int(delta_step)) + "LeRy" + str(int(100.0/y_step)) + "dm" 
              + str(int(delta_max)) + ".dat", 'w')
else:
  f = open("./data/m" + str(int(M0)) + "w" + str(int(window)) + "ds" + 
            str(int(delta_step)) + "LneRy" + str(int(100.0/y_step)) + "dm" 
              + str(int(delta_max)) + ".dat", 'w')

# run through parameter space and print results
for i in my_range(0.0, 1.0, y_step/100.0):
    y = i*(4*math.pi)
    for delta_R in my_range(0, delta_max, delta_step):
      if args.equal:
        s = sing_vals(y, delta_R, delta_R, v, M0)
        if s[3] >= Mt-window and s[3] <= Mt+window:
          for i in range(len(s)):
            f.write(str(s[i]) + " ")
          f.write(str(delta_R) + " " + str(delta_R) + " " + str(y))
          f.write("\n")
      else:
        for delta_L in my_range(0.5*delta_R, 1.5*delta_R, delta_step):
          s = sing_vals(y, delta_R, delta_L, v, M0)
          if s[3] >= Mt-window and s[3] <= Mt+window:
            for i in range(len(s)):
              f.write(str(s[i]) + " ")
            f.write(str(delta_L) + " " + str(delta_R) + " " + str(y))
            f.write("\n")

f.close()