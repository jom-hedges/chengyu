import gleam/dynamic
import sqlight
import mist
import gleam/erlang/process
import gleam/bytes_builder
import gleam/http/response.{Response}

pub main() {
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

// MODEL -----------------------------------------------


// UPDATE ----------------------------------------------


// VIEW ------------------------------------------------
