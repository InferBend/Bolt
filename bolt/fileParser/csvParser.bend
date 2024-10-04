from ../utils/types/String import (string_equal, String/splitToList, String/concat)
from ../utils/types/List import (List/append, List/join)

def convert_string_csv_to_df/aux(rows, content):
  match rows:
    case List/Cons:
      row = String/splitToList(rows.head, ',', [])
      new_content = List/append(content, row)
      return convert_string_csv_to_df/aux(rows.tail, new_content)
    case List/Nil:
      return content

def convert_string_csv_to_df(str_data):
  rows = String/splitToList(str_data, '\n', [])
  return convert_string_csv_to_df/aux(rows, [])

def read_csv(path):
  with IO:
    bytes <- IO/FS/read_file(path)
    txt = String/decode_utf8(bytes)

    return convert_string_csv_to_df(txt)

def convert_df_to_string(df, new_string, delimiter):
  match df:
    case List/Cons:
      new_string = String/concat(new_string, List/join(df.head, delimiter))
      return convert_df_to_string(df.tail, String/concat(new_string, "\n"), delimiter)
    case List/Nil:
      return new_string


def write_csv(df, path):
  with IO:
    bytes = convert_df_to_string(df, "", ",")
    result <- IO/FS/write_file(path, bytes)

    return result