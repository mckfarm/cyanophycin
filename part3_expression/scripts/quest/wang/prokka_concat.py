'''
Cyanophycin Gao Han 2021 analysis
concats all tsvs from prokka to one file
'''

### edit these lines for each new batch ###

# path to reports
reports_in_path = "/projects/b1052/mckenna/cyanophycin/wang2021/prokka/*/"
# parent folder of sequences path
reports_out_path = "/projects/b1052/mckenna/cyanophycin/wang2021/prokka"
###

import glob
import os
import csv
import pandas as pd

in_reports = glob.glob(os.path.join(reports_in_path, "*.tsv")) # file path to reports
out_summary = os.path.join(reports_out_path, "ann_allmags.csv") # file path to output summary


# summarizing reports
data = [] # empty list to append dfs to

for i in in_reports:
    in_data = pd.read_csv(i, header=0, sep="\t")
    in_data["bin"] = os.path.basename(i)
    data.append(in_data)

big_data = pd.concat(data, ignore_index=True) # concat all tsvs
big_data.to_csv(out_summary, index=False) # save to csv
