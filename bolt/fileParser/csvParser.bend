from ../utils/types/String import (string_equal, String/splitToList)
from ../utils/types/List import List/append

def read_csv/aux(fd, content):
  with IO:
    bytes <- IO/FS/read_line(fd)
    txt = String/decode_utf8(bytes)
    if(string_equal(txt, "\0") == 0):
      row = String/splitToList(txt, ',', [])
      content = List/append(content, row)
      return read_csv/aux(fd, content)
    else:
      return content

def read_csv(path):
  content = []
  with IO:
    fd <- IO/done_on_err(IO/FS/open(path, "r"))
    return read_csv/aux(fd, [])