import gleam/dynamic
import sqlight

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let cat_decoder = dynamic.tuple2(dynamic.string, dynamic.string)

  let sql = "
    create table chengyu (zh-def text, en-def text);

    insert into chengyu (zh-def, en-def) values

    ('心积吃不了热豆腐', 'needs translate'),
    ('知心和一', 'needs translate')，
    ('扮猪吃老虎', 'needs translate')，
    ('求知若渴', 'needs translate')
    "
  let assert Ok(Nil) = sqlight.exec(sql, conn)
}
