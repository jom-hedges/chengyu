import app/router
import app/web
import gleam/erlang/process
import mist
import sqlight
import wisp
import wisp_mist

pub const data_directory = "tmp/data"

pub fn main() {
  wisp.configure_logger()
  let secret_key_base = wisp.random_string(64)

  use db <- sqlight.with_connection("data_directory")
  
  let context = web.Context(db: db)

  let assert Ok(_) =
    web_service
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http
  
  process.sleep_forever()
}

fn web_service(_request) {
  let body = bytes_builder.from_string("Hello, Chengyu")
  Response(200, [], mist.Bytes(body))
}
