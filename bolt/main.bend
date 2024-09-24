from fileParser/csvParser import read_csv

def main():
  path = "./sample.csv"
  df = read_csv(path)

  return df
