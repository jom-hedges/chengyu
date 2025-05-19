import gleam/dynamic
import sqlight

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let cat_decoder = dynamic.tuple2(dynamic.string, dynamic.string)

  let create_table_sql = """
    create table chengyu (
      id integer primary key autoincrement,
      zh_def text,
      en_def text
    );
  """
  let assert Ok(Nil) = sqlight.exec(create_table_sql, conn)

  let insert_sql = """
    insert into chengyu (zh_def, en_def) values
      ('心积吃不了热豆腐', 'needs translate'),
      ('知心和一', 'needs translate'),
      ('扮猪吃老虎', 'needs translate'),
      ('求知若渴', 'needs translate');
  """
  let assert Ok(Nil) = sqlight.exec(insert_sql, conn)

  // Example: Query the data back
  let query_sql = "select zh_def, en_def from chengyu;"
  let assert Ok(rows) = sqlight.query(query_sql, conn, cat_decoder)
  rows
  |> list.each(fn(row) {
    case row {
      #(zh, en) -> dynamic.debug("Chengyu: {zh} | English: {en}")
    }
  })
}
