import sys

# total arguments
n = len(sys.argv)
if n != 3 :
    print('Usage: Myscript  filename columnname')
    exit(0)

file_report = sys.argv[1]
col_name = sys.argv[2]

f = open(file_report)
list_col = [ col for col in f.readline().split(',')]
list_col = [ col.strip() for col in list_col]

if not col_name in list_col :
    print('Not valid column name')
    exit(0)

col_index = list_col.index(col_name)

list_val = [aa.split(',') for aa in f.readlines()]
list_val = [ [aa.strip() for aa in listv ] for listv in list_val]

list_out = sorted(list_val, key=lambda x: x[col_index], reverse=True)

for listv in list_out :
    out = ','.join(listv)
    print(out)


