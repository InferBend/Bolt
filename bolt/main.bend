from fileParser/csvParser import (read_csv, write_csv)
from ./utils/types/String import (string_equal, String/splitToList)

def main():
  path = "./sample.csv"
  return read_csv(path)